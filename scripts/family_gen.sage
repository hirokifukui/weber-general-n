# family_gen.sage - certificate-family GENERATOR (r10 bin 5). Usage: sage family_gen.sage n l [bkz_max]
# Input (n, l): layer n >= 2, odd prime l. For every irreducible f | x^m + 1 over F_l (m = 2^{n-1})
# it searches the saturation-component lattice L_f = l R_n + Z[x]-span of w = (x^m+1)/f for a
# vector a with small log-vector (1/l) H_n a, and records TWO witnesses per component (best
# height, best trace) in certificates/family/witness_n<n>_l<l>.txt.  It certifies NOTHING:
# every claim in the file is re-derived by the read-only verifier (family_verify.sage).
# Search engine = r5_esc_fast (LLL -> BKZ, top-24 pairwise combos), generalised to all n and
# to components of any degree d (generators w x^i, i < d).  All arithmetic here is floating
# (mpmath dps 40 only to RECORD values); the verifier uses ball arithmetic.
import os
os.environ.setdefault('OPENBLAS_NUM_THREADS','1'); os.environ.setdefault('OMP_NUM_THREADS','1'); os.environ.setdefault('MKL_NUM_THREADS','1')
import mpmath as mp, sys, time, math
mp.mp.dps = 40
n = ZZ(sys.argv[1]); l = ZZ(sys.argv[2]); BKZMAX = ZZ(sys.argv[3]) if len(sys.argv) > 3 else 40
assert n >= 2 and l.is_prime() and l % 2 == 1
m = 2**(n-1); N = 2**n; MOD = 2**(n+2)
th = mp.pi/MOD
lam = [mp.log(abs((2*mp.cos(2*mp.mpf(pow(3, j, MOD))*th)+1)/(2*mp.cos(2*mp.mpf(pow(3, j, MOD))*th)-1))) for j in range(N)]
L_n = mp.sqrt(N)*mp.log(2+mp.sqrt(5)); Lf = float(L_n); lamf = [float(t) for t in lam]
BAR = 33*2**n if n >= 3 else 17*2**n          # KY Thm 2.3 (n>=3) / MO3 Prop 6.6 (n=2)
SC = 10**12; SCf = float(SC)     # embedding scale (selection no longer uses E-norms)
def center(c, ll):
    c %= ll
    return c-ll if c > ll//2 else c
Zx = PolynomialRing(ZZ, 'x'); x = Zx.gen()
F = GF(l); Rp = PolynomialRing(F, 'y'); yy = Rp.gen()
fac = [g for g, e in (yy**m+1).factor()]
assert all(e == 1 for g, e in (yy**m+1).factor())
fac.sort(key=lambda g: [ZZ(c) for c in g.list()])
d_common = fac[0].degree()
assert all(g.degree() == d_common for g in fac)
def ident(g): return ",".join(str(ZZ(c)) for c in g.list())
def measure40(co):
    ys = [sum(mp.mpf(int(co[k]))*lam[(k+j) % N] for k in range(m) if co[k])/l for j in range(N)]
    return sum(t*t for t in ys), sum(mp.e**(2*t) for t in ys)
def exact_ok(co, g):
    gz = sum(ZZ(cc)*x**k for k, cc in enumerate(g.list()))
    ap = sum(co[k]*x**k for k in range(m))
    return (not all(cc % l == 0 for cc in co)) and all(cc % l == 0 for cc in ((gz*ap) % (x**m+1)).coefficients())
outdir = os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '..', 'certificates', 'family')
os.makedirs(outdir, exist_ok=True)
fn = os.path.join(outdir, "witness_n%d_l%d.txt" % (n, l))
wf = open(fn, "w")
wf.write("# FAMILY WITNESS FILE (generator family_gen.sage r10). n = %d ; l = %d ; m = %d ; deg = %d ; ncomp = %d ; bar_T = %d ; L_n = %s\n" % (n, l, m, d_common, len(fac), BAR, mp.nstr(L_n, 30)))
wf.write("# line: f = c0,...,c_deg (monic, over F_l) | route RHO|T | claimed (rho or T, float) | coeffs a_0..a_{m-1}\n")
t00 = time.time(); npass = 0; status = []
for ci, g in enumerate(fac):
    t0 = time.time()
    w = (yy**m+1)//g
    wz = sum(ZZ(cc)*x**k for k, cc in enumerate(w.list()))
    gens = []
    for j in range(g.degree()):
        c = [ZZ(cc) for cc in ((x**j*wz) % (x**m+1)).list()]; c = c+[0]*(m-len(c))
        gens.append([center(ZZ(cc), l) for cc in c])
    M = matrix(ZZ, [[l if i == j else 0 for j in range(m)] for i in range(m)] + gens).hermite_form(include_zero_rows=False)
    assert M.nrows() == m and abs(M.det()) == l**(m-g.degree())
    emb = [[int(mp.nint(SC*sum(mp.mpf(int(a[k]))*lam[(k+j) % N] for k in range(m) if a[k])/l)) for j in range(N)] for a in (list(M.row(i)) for i in range(m))]
    E = matrix(ZZ, emb)
    B = E.LLL()
    for bs in [24, 40, 56, 72]:
        if bs > BKZMAX or bs > m: break
        B = B.BKZ(block_size=bs)
    # Recover EXACT coefficient vectors of the reduced basis and evaluate Q, T from the
    # coefficients in float64 (the rounded embedding E drifts by up to |u|/SC and must not be
    # used for selection - r10 bin-5 finding: selecting on E-norms lost 2-3 witnesses per prime).
    U = E.solve_left(B)
    CO = [[ZZ(cc) for cc in (U.row(i)*M)] for i in range(B.nrows()) if not B.row(i) == 0]
    CO = [co for co in CO if not all(cc % l == 0 for cc in co)]          # drop l R_n (genuine units)
    import numpy as np
    Lmat = np.array([[lamf[(k+j) % N] for j in range(N)] for k in range(m)], dtype=np.float64)
    A = np.array([[float(cc) for cc in co] for co in CO], dtype=np.float64)
    Y = (A @ Lmat) / float(l)
    Qs = (Y*Y).sum(axis=1); Ts = np.exp(2.0*Y).sum(axis=1)
    order = np.argsort(Qs)
    ib = int(order[0]); bq = float(Qs[ib]); bco = CO[ib]
    it = int(np.argmin(Ts)); bt = float(Ts[it]); btco = CO[it]
    top = [int(i) for i in order[:24]]
    for ii in range(len(top)):
        for jj in range(ii+1, len(top)):
            for sgn in (1, -1):
                yv = Y[top[ii]] + sgn*Y[top[jj]]
                q = float((yv*yv).sum()); t = float(np.exp(2.0*yv).sum())
                if q < bq: bq = q; bco = [CO[top[ii]][k] + sgn*CO[top[jj]][k] for k in range(m)]
                if t < bt: bt = t; btco = [CO[top[ii]][k] + sgn*CO[top[jj]][k] for k in range(m)]
    def coeffs_of(v): return v
    bv, btv = bco, btco
    rho = None; Tb = None; okq = False; okt = False
    for tag, v in (("RHO", bv), ("T", btv)):
        co = coeffs_of(v)
        if all(cc % l == 0 for cc in co): continue
        Q40, T40 = measure40(co)
        ok = exact_ok(co, g)
        if tag == "RHO":
            rho = float(mp.sqrt(Q40))/Lf; okq = ok
            # r10 fix: only PASSING routes are claim lines; non-passing best witnesses go to '# info' (E-material)
            pre = "" if (rho < 1 and ok) else "# info nonpassing "
            wf.write(pre + "f = %s | route RHO | claimed %s | coeffs %s\n" % (ident(g), mp.nstr(mp.sqrt(Q40)/L_n, 20), ",".join(str(cc) for cc in co)))
        else:
            Tb = float(T40); okt = ok
            pre = "" if (Tb < BAR and ok) else "# info nonpassing "
            wf.write(pre + "f = %s | route T | claimed %s | coeffs %s\n" % (ident(g), mp.nstr(T40, 20), ",".join(str(cc) for cc in co)))
    if rho is not None and rho < 1 and okq: st = "PASS_RHO"
    elif Tb is not None and Tb < BAR and okt: st = "PASS_T"
    else:
        near = (rho is not None and rho < 1.1) or (Tb is not None and Tb < 2*BAR)
        st = "OPEN_NEAR" if near else "OPEN_FAR"
    if st.startswith("PASS"): npass += 1
    status.append(st)
    wf.write("# status f = %s : %s (rho %.5f, T %.1f, %.0fs)\n" % (ident(g), st, -1 if rho is None else rho, -1 if Tb is None else Tb, time.time()-t0))
    print("  comp %3d f=%s  rho=%.5f  T=%.1f  %s  %.0fs" % (ci, ident(g)[:40], -1 if rho is None else rho, -1 if Tb is None else Tb, st, time.time()-t0)); sys.stdout.flush()
summ = "EXCLUSION_CANDIDATE" if npass == len(fac) else "INCOMPLETE"
wf.write("# summary n = %d l = %d : %s ; PASS %d / %d ; OPEN_NEAR %d ; OPEN_FAR %d ; %.0fs\n" % (n, l, summ, npass, len(fac), status.count("OPEN_NEAR"), status.count("OPEN_FAR"), time.time()-t00))
wf.close()
print("FAMILY GEN n=%d l=%d : %s ; PASS %d / %d ; OPEN_NEAR %d ; OPEN_FAR %d ; %.0fs" % (n, l, summ, npass, len(fac), status.count("OPEN_NEAR"), status.count("OPEN_FAR"), time.time()-t00))
print("FAMILY GEN DONE n=%d l=%d" % (n, l))
