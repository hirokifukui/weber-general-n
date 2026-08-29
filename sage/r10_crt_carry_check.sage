# r10: CRT carry identity check. For coprime f1, f2 and NONTRIVIAL characters chi1 mod f1, chi2 mod f2,
#   (1/(f1 f2)) sum_{c=1}^{f1 f2} chi1(c) chi2(c) c  =  - sum_{a=1}^{f1} sum_{b=1}^{f2} chi1(a) chi2(b) kappa(a,b),
# kappa(a,b) = (a e1 + b e2 - c(a,b)) / (f1 f2), e1 = f2 (f2^{-1} mod f1), e2 = f1 (f1^{-1} mod f2), c(a,b) in [1,f1 f2] the CRT lift.
# Also: the two "naive" terms vanish, and the identity FAILS when one character is trivial (control).
from sage.all import *
import random
random.seed(int(20260825))
def check(f1, f2, chi1, chi2):
    e1 = f2 * ZZ(inverse_mod(f2, f1)); e2 = f1 * ZZ(inverse_mod(f1, f2)); f = f1*f2
    lhs = sum(chi1(c)*chi2(c)*c for c in range(1, f+1)) / f
    rhs = 0; naive1 = 0; naive2 = 0
    for a in range(1, f1+1):
        for b in range(1, f2+1):
            c = ZZ(crt(a, b, f1, f2)) % f
            if c == 0: c = f
            kap = (a*e1 + b*e2 - c)
            assert kap % f == 0 and kap >= 0
            rhs -= chi1(a)*chi2(b)*(kap // f)
            naive1 += chi1(a)*chi2(b)*a*e1; naive2 += chi1(a)*chi2(b)*b*e2
    return lhs, rhs, naive1/f, naive2/f
ok = True
for (f1, f2) in [(16, 7), (16, 11), (64, 7), (8, 97), (32, 13), (9, 16), (5, 7)]:
    G1 = DirichletGroup(f1); G2 = DirichletGroup(f2)
    nontriv1 = [c for c in G1 if not c.is_trivial()]; nontriv2 = [c for c in G2 if not c.is_trivial()]
    for _ in range(4):
        chi1 = random.choice(nontriv1); chi2 = random.choice(nontriv2)
        lhs, rhs, n1, n2 = check(f1, f2, chi1, chi2)
        good = (lhs == rhs) and n1 == 0 and n2 == 0
        ok = ok and good
        print("f1=%d f2=%d cond=(%d,%d) prim=(%s,%s): lhs==rhs %s ; naive terms (%s,%s) ; B1 = %s" % (f1, f2, chi1.conductor(), chi2.conductor(), chi1.is_primitive(), chi2.is_primitive(), lhs == rhs, n1 == 0, n2 == 0, str(lhs)[:40]))
    # control: chi2 trivial -> identity must FAIL in general
    chi1 = random.choice(nontriv1); chi2 = G2[0]
    lhs, rhs, n1, n2 = check(f1, f2, chi1, chi2)
    print("  CONTROL chi2 trivial: lhs==rhs %s (expected False in general); naive1 = %s" % (lhs == rhs, str(n1)[:30]))
# Washington B_{1,chi} comparison for primitive products (incl. k=4, l=7 = the Luo counterexample parameters)
for (f1, f2, K) in [(16, 7, CyclotomicField(12)), (32, 13, CyclotomicField(48)), (64, 7, CyclotomicField(96))]:
    G1 = DirichletGroup(f1, K); G2 = DirichletGroup(f2, K); G = DirichletGroup(f1*f2, K)
    chi1 = [c for c in G1 if c.is_primitive()][1]; chi2 = [c for c in G2 if c.is_primitive() and not c.is_trivial()][1]
    lhs, rhs, _, _ = check(f1, f2, chi1, chi2)
    chi = G(chi1.extend(f1*f2)) * G(chi2.extend(f1*f2))
    print("f1=%d f2=%d: product conductor %d ; Sage B_{1,chi} == carry formula : %s ; value %s" % (f1, f2, chi.conductor(), chi.bernoulli(1) == rhs, str(rhs)[:40]))
print("ALL NONTRIVIAL CASES PASS:", ok)
print("R10 CRT CARRY CHECK DONE")
