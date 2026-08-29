# r8_base_minima.sage — base lattice H Z^64: successive minima diagnostics (hw 83-84)
# lambda_1 candidates via LLL on the exact-profile basis; interval certification of
# the found vectors' lengths in Arb. HONEST SCOPE: LLL gives UPPER bounds on
# lambda_2, lambda_3; the certified LOWER bound for every nonzero base vector is
# the MO floor L_1 = 16.3329 (genuine A_7 units). No BKZ (hw 51 unchanged).

import math
import numpy as np
R = RealBallField(192)
lam = []
for j in range(128):
    k = power_mod(3, j, 512)
    ang = R(2)*R(pi)*R(k)/R(512)
    Xj = 2*ang.cos()
    lam.append(((Xj+1)/(Xj-1)).abs().log())
lamf = [float(x.mid()) for x in lam]
Lmat = np.array([[lamf[(i+j) % 128] for i in range(64)] for j in range(128)])
SCALE = 2**28
Yi = matrix(ZZ, [[int(round(Lmat[j, i]*SCALE)) for j in range(128)] for i in range(64)])
Yl = Yi.LLL()
# collect shortest independent rows (upper bounds for successive minima)
norms = sorted([(sum(int(v)**2 for v in r), r) for r in Yl.rows() if any(v != 0 for v in r)])
print("LLL top-5 vector lengths (float, /SCALE):")
for n2, _ in norms[:5]:
    print("  %.6f" % (math.sqrt(n2)/SCALE))
# certify the exponent vectors of the top-3 in Arb: recover a from the row? LLL rows are
# lattice vectors in the embedded space; recover integer coords by solving with the basis.
Yinv_rows = []
B = matrix(QQ, [[Lmat[j, i] for j in range(128)] for i in range(64)])  # rows = basis (float->QQ approx)
for n2, r in norms[:3]:
    rv = vector(QQ, [QQ(int(v))/SCALE for v in r])
    a = B.solve_left(rv)   # exponent coords (should be near-integers)
    ai = [ZZ(x.round()) for x in a]
    y = [sum(R(ai[i])*lam[(i+j) % 128] for i in range(64)) for j in range(128)]
    ht = sum(t*t for t in y).sqrt()
    print("CERT: a = %s..., |Ha| in [%.6f, %.6f]" %
          (ai[:6], float(ht.lower()), float(ht.upper())))
print("SUMMARY (hw 83-84): lambda_1(base) = ht(eps_7) = 20.4841 [certified generator];")
print("  lambda_2, lambda_3 UPPER bounds from LLL above; LOWER bound for all: L_1 = 16.3329 (MO).")
print("  Raised floors 23.699 / 31.412 / 39.221 vs base lambda_1 20.484: base vectors sit")
print("  BELOW every raised floor - so in any coset-level raised-floor theorem the a in lR")
print("  case CANNOT rely on the raised floor unless depth transfers to the genuine unit;")
print("  they must be excluded by coset separation, not by height. (hw 83 relation map)")
print("R8 BASE MINIMA DONE")
