# r10 bin 1 (a)+(d)(i): independent recomputation of the Blichfeldt constant chain
# and of the character-product (group-determinant) formula for D_7.
# Inputs are ONLY the KY definitions (X_n, sigma = 3-multiplication, eps_n=(X+1)/(X-1)).
# No project data is read. Python3 + mpmath. Run: python3 r10_bin1_constant_audit.py
from mpmath import mp, mpf, cos, sin, pi, log, matrix, mpc, fabs, nstr, eigsy, gamma, sqrt, exp, factorial
mp.dps = 40
n = 7; m = 2**(n-1); N = 2**n; M = 2**(n+2)
def lam(j):
    X = 2*cos(pow(3, j, M) * 2*pi/M)      # reduce 3^j mod 2^{n+2} BEFORE the angle (precision)
    return log(fabs((X+1)/(X-1)))
L = [lam(j) for j in range(N)]
print("ANTIPERIOD max|lam_{j+m}+lam_j| =", nstr(max(fabs(L[j+m]+L[j]) for j in range(m)), 5))
H = matrix(N, m)
for j in range(N):
    for i in range(m):
        H[j, i] = L[(i+j) % N]
G = H.T*H
ev = sorted(eigsy(G)[0])
lnD_gram = sum(log(x) for x in ev)/2
def e(x): return mpc(cos(x), sin(x))
prod_ln = mpf(0); maxres = mpf(0)
for r in range(m):
    th = 2*pi*(2*r+1)/N                    # omega_r = zeta_{2^n}^{2r+1}: the 2^{n-1} relative characters
    Lhat = sum(L[j]*e(j*th) for j in range(N))
    mu = abs(Lhat)**2/2
    v = [e(i*th) for i in range(m)]
    maxres = max(maxres, abs(sum(G[0, k]*v[k] for k in range(m)) - mu*v[0]))
    prod_ln += log(abs(Lhat))
lnD_char = -(mpf(m)/2)*log(2) + prod_ln
print("EIGENVECTOR residual max =", nstr(maxres, 3))
print("lnD7 GRAM   =", nstr(lnD_gram, 30))
print("lnD7 CHARPROD (= -m/2 ln2 + sum_chi ln|sum_j chi(sigma^j) lam_j|) =", nstr(lnD_char, 30))
print("lnD7 CERT   = 177.783817017911485959589398831214116568 (sage/r6_blichfeldt_cert.log PREC 512)")
L7 = sqrt(mpf(2)**n)*log(2+sqrt(5))
lnC7 = (mpf(m)/2)*log(2/pi) + log(gamma(1+mpf(m+2)/2)) + lnD_gram - m*log(L7)
print("L7 height form sqrt(2^7)log(2+sqrt5) =", nstr(L7, 20))
print("lnC7 recomputed =", nstr(lnC7, 30), " CERT 69.62413669503408145132930246749633921005")
print("C7 =", nstr(exp(lnC7), 20), " CERT upper 1.7273421630363529579743e30")
print("Gamma(1+(m+2)/2) == 33! :", gamma(1+mpf(m+2)/2) == factorial(33))
print("Cauchy-Schwarz: 2*2^{n-1}log(2+sqrt5)/sqrt(2^n) =", nstr(2*(2**(n-1))*log(2+sqrt(5))/sqrt(mpf(2)**n), 20))
for name, Lx in [("17*2^n (MO3 Prop 6.6 trace)", 17*2**n), ("33*2^n (KY Thm 2.3 trace)", 33*2**n),
                 ("2^{n-1}log(2+sqrt5) (MO3 Thm 5.3 Mahler, no C-S)", (2**(n-1))*log(2+sqrt(5)))]:
    lnC = (mpf(m)/2)*log(2/pi) + log(gamma(1+mpf(m+2)/2)) + lnD_gram - m*log(mpf(Lx))
    print(f"MIXUP if L_7 := {name}: C7 = {nstr(exp(lnC), 5)}")
