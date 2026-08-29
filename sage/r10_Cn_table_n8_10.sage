# r10: general-n table of C_n via Corollary A' (L-value closed form), n = 2..10, plus thresholds by degree.
from sage.all import *
import time
R = RealField(200); C_ = ComplexField(200)
print("C_n = 2 (4/pi)^{m/2} Gamma(2+m/2) prod_{chi even, cond 2^{n+2}} |L(1,chi)| / log(2+sqrt5)^m ; m = 2^{n-1}")
for n in range(2, 10):
    q = 2**(n+2); m = 2**(n-1); t0 = time.time()
    Dg = DirichletGroup(q, CyclotomicField(2**n))
    chis = [ch for ch in Dg if ch.is_even() and ch.conductor() == q]
    assert len(chis) == m
    s = R(0)
    for ch in chis:
        s += log(abs(C_(ch.lfunction(prec=100, algorithm='pari')(1))))
    lnC = log(R(2)) + R(m)/2*log(4/R.pi()) + log(gamma(R(m)/2+2)) + s - m*log(log(2+sqrt(R(5))))
    print("n=%2d m=%4d  sum ln|L| = %+.6f  log10 C_n = %s   (deg-1 threshold C_n ; deg-2 threshold sqrt(C_n) = 10^%s)  [%.0fs]" % (n, m, float(s), (lnC/log(R(10))).str(digits=12), (lnC/log(R(10))/2).str(digits=8), time.time()-t0))
print("R10 CN TABLE DONE")
