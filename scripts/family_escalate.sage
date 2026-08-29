# family_escalate.sage n l [svp_timeout_s] - ESCALATION for OPEN components of an existing witness file.
# Reads certificates/family/witness_n<n>_l<l>.txt, takes every component whose status is OPEN_*,
# and re-searches it with: BKZ up to block 60, top-40 pairwise + top-12 triple combinations, and
# (RHO side) fpylll exact SVP on the BKZ-reduced basis (time-capped). Writes a NEW file
# certificates/family/witness_n<n>_l<l>_esc.txt containing ONLY the escalated components (same
# line format), so that the verifier can be run on it independently; merging is a separate step.
import os
os.environ.setdefault('OPENBLAS_NUM_THREADS','1'); os.environ.setdefault('OMP_NUM_THREADS','1')
import mpmath as mp, sys, time, math, re, signal
import numpy as np
from fpylll import IntegerMatrix, LLL as fLLL, BKZ as fBKZ, SVP as fSVP
from fpylll.algorithms.bkz2 import BKZReduction
mp.mp.dps = 40
n = ZZ(sys.argv[1]); l = ZZ(sys.argv[2]); SVPT = int(sys.argv[3]) if len(sys.argv) > 3 else 120
m = 2**(n-1); N = 2**n; MOD = 2**(n+2); th = mp.pi/MOD
lam = [mp.log(abs((2*mp.cos(2*mp.mpf(pow(3, j, MOD))*th)+1)/(2*mp.cos(2*mp.mpf(pow(3, j, MOD))*th)-1))) for j in range(N)]
lamf = [float(t) for t in lam]; L_n = mp.sqrt(N)*mp.log(2+mp.sqrt(5)); Lf = float(L_n)
BAR = 33*2**n if n >= 3 else 17*2**n; SC = 10**12
def center(c, ll):
    c %= ll
    return c-ll if c > ll//2 else c
Zx = PolynomialRing(ZZ, 'x'); x = Zx.gen()
F = GF(l); Rp = PolynomialRing(F, 'y'); yy = Rp.gen()
fac = {",".join(str(ZZ(c)) for c in g.list()): g for g, e in (yy**m+1).factor()}
here = os.path.dirname(os.path.abspath(sys.argv[0]))
src = os.path.join(here, '..', 'certificates', 'family', "witness_n%d_l%d.txt" % (n, l))
txt = open(src).read()
opens = [mm.group(1) for mm in re.finditer(r'# status f = ([-0-9,]+) : OPEN', txt)]
print("ESCALATE n=%d l=%d : %d OPEN components" % (n, l, len(opens)))
Lmat = np.array([[lamf[(k+j) % N] for j in range(N)] for k in range(m)], dtype=np.float64)
def measure40(co):
    ys = [sum(mp.mpf(int(co[k]))*lam[(k+j) % N] for k in range(m) if co[k])/l for j in range(N)]
    return sum(t*t for t in ys), sum(mp.e**(2*t) for t in ys)
def exact_ok(co, g):
    gz = sum(ZZ(cc)*x**k for k, cc in enumerate(g.list())); ap = sum(co[k]*x**k for k in range(m))
    return (not all(cc % l == 0 for cc in co)) and all(cc % l == 0 for cc in ((gz*ap) % (x**m+1)).coefficients())
class TO(Exception): pass
def _h(s, f): raise TO()
out = open(src.replace(".txt", "_esc.txt"), "w")
out.write("# FAMILY WITNESS FILE (escalation family_escalate.sage r10). n = %d ; l = %d ; m = %d ; deg = %d ; ncomp = %d ; bar_T = %d ; L_n = %s\n" % (n, l, m, fac[opens[0]].degree() if opens else 0, len(opens), BAR, mp.nstr(L_n, 30)))
out.write("# ESCALATION file: contains ONLY the components listed; a prime-level EXCLUDED verdict needs the merged file.\n")
npass = 0
for fid in opens:
    t0 = time.time(); g = fac[fid]
    w = (yy**m+1)//g; wz = sum(ZZ(cc)*x**k for k, cc in enumerate(w.list()))
    gens = []
    for j in range(g.degree()):
        c = [ZZ(cc) for cc in ((x**j*wz) % (x**m+1)).list()]; c = c+[0]*(m-len(c)); gens.append([center(ZZ(cc), l) for cc in c])
    M = matrix(ZZ, [[l if i == j else 0 for j in range(m)] for i in range(m)] + gens).hermite_form(include_zero_rows=False)
    emb = [[int(mp.nint(SC*sum(mp.mpf(int(a[k]))*lam[(k+j) % N] for k in range(m) if a[k])/l)) for j in range(N)] for a in (list(M.row(i)) for i in range(m))]
    E = matrix(ZZ, emb)
    A_ = IntegerMatrix.from_matrix([[int(v) for v in row] for row in emb])
    fLLL.reduction(A_)
    for bs in [24, 40, 52, 60]:
        if bs > m: break
        BKZReduction(A_)(fBKZ.Param(block_size=bs, strategies=fBKZ.DEFAULT_STRATEGY, max_loops=8, flags=fBKZ.AUTO_ABORT))
    rowsB = [[A_[i, j] for j in range(N)] for i in range(A_.nrows) if any(A_[i, j] for j in range(N))]
    # exact SVP attempt (time capped)
    svp_note = "skipped"
    try:
        signal.signal(signal.SIGALRM, _h); signal.alarm(SVPT)
        v = fSVP.shortest_vector(A_, method="fast")
        signal.alarm(0); rowsB.append([int(t) for t in v]); svp_note = "done"
    except TO:
        svp_note = "timeout %ds" % SVPT
    except Exception as ex:
        signal.alarm(0); svp_note = "error %s" % str(ex)[:40]
    B = matrix(ZZ, rowsB)
    U = E.solve_left(B)
    CO = [[ZZ(cc) for cc in (U.row(i)*M)] for i in range(B.nrows())]
    CO = [co for co in CO if not all(cc % l == 0 for cc in co)]
    A = np.array([[float(cc) for cc in co] for co in CO]); Y = (A @ Lmat)/float(l)
    Qs = (Y*Y).sum(axis=1); Ts = np.exp(2.0*Y).sum(axis=1)
    order = [int(i) for i in np.argsort(Qs)]
    bq = float(Qs[order[0]]); bco = CO[order[0]]; it = int(np.argmin(Ts)); bt = float(Ts[it]); btco = CO[it]
    top = order[:40]
    for ii in range(len(top)):
        for jj in range(ii+1, len(top)):
            for sgn in (1, -1):
                yv = Y[top[ii]] + sgn*Y[top[jj]]; q = float((yv*yv).sum()); t = float(np.exp(2.0*yv).sum())
                if q < bq: bq = q; bco = [CO[top[ii]][k] + sgn*CO[top[jj]][k] for k in range(m)]
                if t < bt: bt = t; btco = [CO[top[ii]][k] + sgn*CO[top[jj]][k] for k in range(m)]
    t3 = order[:12]
    for ii in range(len(t3)):
        for jj in range(ii+1, len(t3)):
            for kk in range(jj+1, len(t3)):
                for s1 in (1, -1):
                    for s2 in (1, -1):
                        yv = Y[t3[ii]] + s1*Y[t3[jj]] + s2*Y[t3[kk]]; q = float((yv*yv).sum()); t = float(np.exp(2.0*yv).sum())
                        if q < bq: bq = q; bco = [CO[t3[ii]][k] + s1*CO[t3[jj]][k] + s2*CO[t3[kk]][k] for k in range(m)]
                        if t < bt: bt = t; btco = [CO[t3[ii]][k] + s1*CO[t3[jj]][k] + s2*CO[t3[kk]][k] for k in range(m)]
    Q40, T40 = measure40(bco); rho = float(mp.sqrt(Q40))/Lf; okq = exact_ok(bco, g)
    Q40t, T40t = measure40(btco); Tb = float(T40t); okt = exact_ok(btco, g)
    out.write(("" if (rho < 1 and okq) else "# info nonpassing ") + "f = %s | route RHO | claimed %s | coeffs %s\n" % (fid, mp.nstr(mp.sqrt(Q40)/L_n, 20), ",".join(str(cc) for cc in bco)))
    out.write(("" if (Tb < BAR and okt) else "# info nonpassing ") + "f = %s | route T | claimed %s | coeffs %s\n" % (fid, mp.nstr(T40t, 20), ",".join(str(cc) for cc in btco)))
    st = "PASS_RHO" if (rho < 1 and okq) else ("PASS_T" if (Tb < BAR and okt) else ("OPEN_NEAR" if (rho < 1.1 or Tb < 2*BAR) else "OPEN_FAR"))
    if st.startswith("PASS"): npass += 1
    out.write("# status f = %s : %s (rho %.5f, T %.1f, svp %s, %.0fs)\n" % (fid, st, rho, Tb, svp_note, time.time()-t0))
    print("  f=%s rho=%.5f T=%.1f %s svp=%s %.0fs" % (fid[:30], rho, Tb, st, svp_note, time.time()-t0)); sys.stdout.flush()
out.write("# summary n = %d l = %d : ESCALATION ; PASS %d / %d escalated components\n" % (n, l, npass, len(opens)))
out.close()
print("FAMILY ESCALATE n=%d l=%d : PASS %d / %d ; DONE" % (n, l, npass, len(opens)))
