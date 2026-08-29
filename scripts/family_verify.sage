# family_verify.sage - READ-ONLY verifier for family witness files (r10 bin 5; r11: header fields deg/ncomp/bar_T/L_n are asserted against recomputation, GPT hw 61).
# Usage: sage family_verify.sage <witness file>.   Writes nothing (log via shell redirection).
# Accepts a file only if: n >= 2, l an odd prime; the recomputed factorisation of x^m+1 over F_l is
# squarefree with all factors of degree ord_{2^n}(l); every witness line names a recomputed factor
# by its FULL coefficient sequence; no (f, route) pair appears twice; for each line the exact
# membership f*a = 0 mod (l, x^m+1) holds, a is not in l R_n, some log coordinate is certified
# nonzero, and the route condition holds in ball arithmetic: rho.upper() < 1 (RHO) or
# T.upper() < bar_T (T, bar = 33*2^n for n >= 3, 17*2^n for n = 2); the claimed value must agree
# with the recomputed one to relative 1e-6.  VERDICT EXCLUDED iff every factor has >= 1 CERT line.
# Soundness (STATEMENT_FREEZE_R10 sect 7): EXCLUDED  =>  l does not divide h_n/h_{n-1}, by
# FLAGSHIP_T_ONLY / FLAGSHIP_Q_ONLY with inputs KY Eq.(17), KY Prop 4.1, KY Thm 2.3 / MO3 Prop 6.6,
# MO 2016 Lemma 2.5(1).
import sys, re
PREC = 256
R = RealBallField(PREC)
path = sys.argv[1]
txt = open(path, 'r').read()                           # READ ONLY
hd = re.search(r'n = (\d+) ; l = (\d+) ; m = (\d+) ; deg = (\d+) ; ncomp = (\d+) ; bar_T = (\d+) ; L_n = ([0-9.]+)', txt)
if not hd:
    print("FATAL: header missing or incomplete (n,l,m,deg,ncomp,bar_T,L_n all required; r11 hw 61)"); print("FAMILY VERIFY FAIL"); sys.exit(1)
n, l, m_claim = ZZ(hd.group(1)), ZZ(hd.group(2)), ZZ(hd.group(3))
deg_claim, ncomp_claim, bar_claim, Ln_claim = ZZ(hd.group(4)), ZZ(hd.group(5)), ZZ(hd.group(6)), RR(hd.group(7))
fatal = []
if n < 2: fatal.append("n < 2")
if not l.is_prime() or l % 2 == 0: fatal.append("l not an odd prime")
m = 2**(n-1); N = 2**n; MOD = 2**(n+2)
if m != m_claim: fatal.append("m mismatch")
BAR = 33*2**n if n >= 3 else 17*2**n
if bar_claim != BAR: fatal.append("header bar_T %s != recomputed %s" % (bar_claim, BAR))
if fatal:
    for f_ in fatal: print("FATAL:", f_)
    print("FAMILY VERIFY FAIL"); sys.exit(1)
P = PolynomialRing(GF(l), 'x'); x = P.gen(); Fpol = x**m+1
fac = Fpol.factor()
if not all(e == 1 for _, e in fac): print("FATAL: not squarefree"); print("FAMILY VERIFY FAIL"); sys.exit(1)
dl = Mod(l, 2**n).multiplicative_order()
factors = {}
for g, _ in fac:
    if g.degree() != dl: print("FATAL: factor degree != ord_{2^n}(l)"); print("FAMILY VERIFY FAIL"); sys.exit(1)
    factors[",".join(str(ZZ(c)) for c in g.list())] = g
if deg_claim != dl: print("FATAL: header deg %s != recomputed ord_{2^n}(l) = %s" % (deg_claim, dl)); print("FAMILY VERIFY FAIL"); sys.exit(1)
if ncomp_claim != len(factors): print("FATAL: header ncomp %s != recomputed %s" % (ncomp_claim, len(factors))); print("FAMILY VERIFY FAIL"); sys.exit(1)
print("FACTORIZATION: %d irreducible factors of degree %d over F_%d: OK (header deg/ncomp/bar_T agree)" % (len(factors), dl, l))
# lambda profile, ball arithmetic, from first principles
lam = []
for j in range(N):
    k = power_mod(3, j, MOD)
    Xj = 2*(R(2)*R(pi)*R(k)/R(MOD)).cos()
    lam.append(((Xj+1)/(Xj-1)).abs().log())
L_n = R(N).sqrt()*(2+R(5).sqrt()).log()
if abs(RR(L_n.mid()) - Ln_claim) > 1e-12*RR(L_n.mid()): print("FATAL: header L_n %s != recomputed %s" % (Ln_claim, L_n.mid())); print("FAMILY VERIFY FAIL"); sys.exit(1)
seen = set(); certified = {}; nlines = 0; nfail = 0
for line in txt.splitlines():
    if not line.startswith("f = "): continue
    nlines += 1
    mm = re.match(r'f = ([-0-9,]+) \| route (RHO|T) \| claimed ([-0-9.eE+]+) \| coeffs ([-0-9,]+)\s*$', line)
    if not mm: print("FATAL: malformed line:", line[:80]); nfail += 1; continue
    fid, route, claimed, co = mm.group(1), mm.group(2), RR(mm.group(3)), [ZZ(t) for t in mm.group(4).split(",")]
    if fid not in factors: print("FATAL: unknown factor identifier %s" % fid[:40]); nfail += 1; continue
    if (fid, route) in seen: print("FATAL: duplicate (f, route) %s %s" % (fid[:40], route)); nfail += 1; continue
    seen.add((fid, route))
    if len(co) != m: print("FATAL: witness length %d != %d" % (len(co), m)); nfail += 1; continue
    g = factors[fid]
    mem = ((g*P(co)) % Fpol) == 0
    nz = any(c % l != 0 for c in co)
    y = [sum(R(co[i])*lam[(i+j) % N] for i in range(m) if co[i]) / R(l) for j in range(N)]
    ynz = any(yy.lower() > 0 or yy.upper() < 0 for yy in y)
    if route == "RHO":
        val = (sum(yy*yy for yy in y).sqrt()/L_n); cond = val.upper() < 1
    else:
        val = sum((2*yy).exp() for yy in y); cond = val.upper() < BAR
    agree = abs(RR(val.mid()) - claimed) <= 1e-6*max(1.0, abs(claimed))
    ok = mem and nz and ynz and cond and agree
    print("%s %-3s mem=%s nz=%s ynz=%s cond=%s claim_agree=%s upper=%s  %s" % (fid[:24], route, mem, nz, ynz, cond, agree, val.upper().str(digits=12) if hasattr(val.upper(),'str') else val.upper(), "CERT" if ok else "FAIL"))
    if ok: certified.setdefault(fid, set()).add(route)
    else: nfail += 1
ncov = len([f_ for f_ in factors if f_ in certified])
verdict = "EXCLUDED" if (ncov == len(factors) and nfail == 0 and nlines > 0) else "NOT_EXCLUDED"
print("FAMILY VERIFY n=%d l=%d : %s (components certified %d / %d ; lines %d ; failed lines %d)" % (n, l, verdict, ncov, len(factors), nlines, nfail))
print("FAMILY VERIFY %s" % ("PASS" if verdict == "EXCLUDED" else "FAIL"))
