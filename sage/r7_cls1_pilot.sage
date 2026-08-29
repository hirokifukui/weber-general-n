# r7_cls1_pilot.sage — homework 67, 71-73, 75 pilot (r7, numpy-vectorized)
# Empirical shortest orbit vector of Lambda_f = (1/l) H L_f for small l = 1 (mod 128),
# full scalar-orbit enumeration with trivial centered lift (= nearest-plane in the
# trivial basis; the reported min is an UPPER bound on the b!=0 part of lambda_1 -
# z-optimization could only shrink it, so a dip below a target KILLS a uniform
# lower-bound hope at that target; staying above is inconclusive-positive).
# The b=0 part (base lattice H Z^64) has certified lambda_1 >= L_7 = 16.33 by the
# MO height floor on genuine A_7 units - not measured here.
# Diagnostic [MC-float]; small primes are below the known fence (calibration use, hw 50).

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
GH = math.sqrt(m/(2*math.pi*math.e))
BL = math.sqrt((2/math.pi) * math.exp(math.lgamma(34)/32))
L7f = math.sqrt(128)*math.log(2+math.sqrt(5))

print("prime   min|v|(orbit)  covol^{1/64}  const  (BL=%.4f GH=%.4f target 1.404; L7=%.3f)" % (BL, GH, L7f))
consts = []
for l in prime_range(257, 120000):
    if l % 128 != 1: continue
    F.<x> = PolynomialRing(GF(l))
    fac = (x**m + 1).factor()
    roots = sorted([ZZ(-g[0]) for g, _ in fac])
    assert len(roots) == 64
    reps = []
    seen = set()
    for c in roots:
        if c in seen: continue
        reps.append(c); seen.add(c); seen.add(ZZ(inverse_mod(c, l)))
    covol = math.exp((lnD7 - math.log(l))/m)
    best_all = None
    for c in reps[:4]:
        w = (x**m + 1)//(x - c)
        wl = np.array([int(w[i]) for i in range(m)], dtype=np.int64)
        bs = np.arange(1, l, dtype=np.int64)
        # centered lifts of b*w mod l, batched in chunks to bound memory
        bestQ = np.inf
        for lo in range(0, len(bs), 20000):
            bb = bs[lo:lo+20000]
            A = (np.outer(bb, wl) % l)
            A = np.where(A > l//2, A - l, A).astype(np.float64)
            Y = A @ Lmat.T / float(l)             # (chunk,128)
            Q = np.einsum('ij,ij->i', Y, Y)
            q = Q.min()
            if q < bestQ: bestQ = q
        if best_all is None or bestQ < best_all: best_all = bestQ
    c0 = math.sqrt(best_all)/covol
    consts.append((l, c0, math.sqrt(best_all)))
    print("%6d   %9.5f     %9.5f   %7.4f" % (l, math.sqrt(best_all), covol, c0))
    if time.time() - t0 > 2400:
        print("TIMEBOX reached"); break

cs = [c for _, c, _ in consts]
print("SUMMARY over %d primes: min const = %.4f, mean = %.4f, max = %.4f" %
      (len(cs), min(cs), sum(cs)/len(cs), max(cs)))
print("VERDICT (75): smallest realized constant %.4f vs 1.404: %s" %
      (min(cs),
       "ABOVE at all sampled primes - a 1.404 uniform lower bound is not refuted (inconclusive-positive; z-opt untested)"
       if min(cs) >= 1.404 else
       "BELOW 1.404 observed - pure-geometry uniform bound at 1.404 is DEAD (hw 76: stop route)"))
print("VERDICT (73): const floor needed for 2.147x below-Blichfeldt improvement = %.4f: %s" %
      (BL/2.147, "not refuted" if min(cs) >= BL/2.147 else "REFUTED at these primes"))
print("NOTE: min orbit |v| vs L7=16.33: primes with min|v| < L7 are the ones a uniform")
print("      theorem must reach; their const values are the design constraint.")
print("elapsed %.1fs" % (time.time()-t0))
print("R7 CLS1 PILOT DONE")
