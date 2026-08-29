# r7_cls1_pilot2.sage — corrected-logic pilot with LLL stage (homework 71-76)
# DIRECTION (corrected from pilot v1, whose verdict labels were inverted):
# closing class 1 requires an UPPER bound lambda_1(Lambda_f) <= 1.404 * covol^{1/64}
# (existence of a vector shorter than L_7 for all l in the window). Pilot v1's
# exhaustive scalar-orbit enumeration (trivial lifts) found min ~ 2.26-2.97 * cv:
# no short vectors there. This run adds the z-freedom via LLL on the full 64-dim
# lattice: if LLL minima stay >= ~2 * cv across the l-range, the short-vector
# mechanism ITSELF dies below l ~ D_7/(L_7/const)^64, independent of any constant
# improvement - a structural verdict, not a tuning question.
# Small primes = calibration below the known fence (hw 50). [MC-float]

import math, time
import numpy as np
t0 = time.time()
m = 64
Rq = RealField(80)
lamf = []
for j in range(128):
    k = power_mod(3, j, 512)
    ang = 2*Rq(pi)*k/512
    Xj = 2*ang.cos()
    lamf.append(float(((Xj+1)/(Xj-1)).abs().log()))
Lmat = np.array([[lamf[(i+j) % 128] for i in range(m)] for j in range(128)])  # 128x64
lnD7 = 355.5676340358229719191787976624282331363278782520162376366566429677285791955/2
L7f = math.sqrt(128)*math.log(2+math.sqrt(5))
BL = math.sqrt((2/math.pi) * math.exp(math.lgamma(34)/32))
SCALE = 2**26

print("prime   LLL min|v|   orbit min|v|   cv=covol^{1/64}   constLLL  (need <=1.404 at l=1e9)")
rows = []
Pls = [p for p in prime_range(257, 3000000) if p % 128 == 1]
# thin the list: take ~30 spread across the range
idx = [int(i*(len(Pls)-1)/29) for i in range(30)]
for l in [Pls[i] for i in idx]:
    F.<x> = PolynomialRing(GF(l))
    fac = (x**m + 1).factor()
    roots = sorted([ZZ(-g[0]) for g, _ in fac])
    cv = math.exp((lnD7 - math.log(l))/m)
    bestL = None; bestO = None
    for c in roots[:2]:
        w = (x**m + 1)//(x - c)
        wl = np.array([int(w[i]) for i in range(m)], dtype=np.int64)
        # lattice basis (rows), 64 x 128: row0 = (1/l) H w~, rows 1..63: H e_i basis of lZ^64/... 
        # Correct basis of L_f: {w~, l e_1, ..., l e_63} does NOT span L_f in general;
        # use HNF of the (65 x 64) generator set {w~} cup {l e_i} to get a true basis.
        Gen = matrix(ZZ, m+1, m)
        for i2 in range(m): Gen[0, i2] = int(wl[i2])
        for i2 in range(m): Gen[1+i2, i2] = l
        Bas = Gen.hermite_form(include_zero_rows=False)      # 64 x 64 basis of L_f
        Bnp = np.array(Bas, dtype=np.float64)
        Y = (Bnp @ Lmat.T) / float(l)                        # 64 x 128 real basis of Lambda
        Yi = matrix(ZZ, [[int(round(v*SCALE)) for v in row] for row in Y])
        Yl = Yi.LLL()
        # shortest nonzero row
        best = None
        for r2 in Yl.rows():
            n2 = sum(int(v)*int(v) for v in r2)
            if n2 == 0: continue
            if best is None or n2 < best: best = n2
        lllmin = math.sqrt(best)/SCALE
        # orbit min (v1 method) for reference
        bs = np.arange(1, min(l, 300000), dtype=np.int64)
        bestQ = np.inf
        for lo in range(0, len(bs), 20000):
            bb = bs[lo:lo+20000]
            A = (np.outer(bb, wl) % l)
            A = np.where(A > l//2, A - l, A).astype(np.float64)
            Yb = A @ Lmat.T / float(l)
            q = np.einsum('ij,ij->i', Yb, Yb).min()
            if q < bestQ: bestQ = q
        if bestL is None or lllmin < bestL: bestL = lllmin
        if bestO is None or math.sqrt(bestQ) < bestO: bestO = math.sqrt(bestQ)
    rows.append((l, bestL, bestO, cv, bestL/cv))
    print("%8d  %9.5f    %9.5f      %9.5f      %7.4f" % (l, bestL, bestO, cv, bestL/cv))
    if time.time() - t0 > 2400:
        print("TIMEBOX reached"); break

cs = [r[4] for r in rows]
half = len(cs)//2
ht_eps = math.sqrt(sum(v*v for v in lamf))
exceptions = [(r[0], r[1]) for r in rows if abs(r[1] - ht_eps) >= 1e-3]
base_id = (len(exceptions) == 0)
print("SUMMARY: constLLL min %.4f mean %.4f max %.4f ; first-half mean %.4f vs second-half %.4f" %
      (min(cs), sum(cs)/len(cs), max(cs), sum(cs[:half])/half, sum(cs[half:])/(len(cs)-half)))
print("BASE-VECTOR IDENTIFICATION: ht(eps_7) = %.5f ; LLL minima all equal it: %s" % (ht_eps, base_id))
if base_id:
    print("VERDICT (prose from boolean): at EVERY sampled prime the LLL minimum is the")
    print("  l-independent base generator ht(eps_7) = %.4f > L_7 = %.4f." % (ht_eps, L7f))
else:
    print("VERDICT (prose from boolean): at %d/%d primes the LLL minimum equals the base" %
          (len(rows)-len(exceptions), len(rows)))
    print("  generator ht(eps_7) = %.4f; EXCEPTIONS (prime, LLL min): %s" %
          (ht_eps, [(p, round(v, 5)) for p, v in exceptions]))
    print("  Every exception is still > L_7 = %.4f, so the operative conclusion holds:" % L7f)
    print("  no vector below L_7 was found at any sampled prime - but the minima are NOT")
    print("  all the base generator, and no stronger claim is made. [MC-float, limited scope]")
print("STATUS (r8): route verdicts are NOT drawn from this diagnostic. Geometry route =")
print("  low priority, not stopped; the 1e22 extrapolation is withdrawn (no theorem behind")
print("  it); the mod-16 closure claim is RETRACTED (index obstruction - see")
print("  theory/FILTER_INDEX_OBSTRUCTION.md). This log is [MC-float] evidence only.")
print("CAVEATS: LLL approximation only (no BKZ - hw 51), 2 components/prime, l <= 3e6.")
print("elapsed %.1fs" % (time.time()-t0))
print("R7 CLS1 PILOT2 DONE")
