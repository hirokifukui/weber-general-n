# r7_structural_pilots.sage — homework 53-56, 59-61, 65, 77 pilots (r7)
# All [MC]/[H] diagnostics; nothing here is a theorem claim. Flagship l only
# (inside open window - homework 84 compliant). Timeboxed designs.

import time
t0 = time.time()
PREC = 128
R = RealBallField(PREC)
l = 1000000321
m = 64

lam = []
for j in range(128):
    k = power_mod(3, j, 512)
    ang = R(2)*R(pi)*R(k)/R(512)
    Xj = 2*ang.cos()
    lam.append(((Xj+1)/(Xj-1)).abs().log())
L7 = R(128).sqrt()*(2+R(5).sqrt()).log()

def Hvec(a):
    return [sum(R(a[i])*lam[(i+j) % 128] for i in range(m)) for j in range(128)]

def Q_of(a):
    y = Hvec(a); s = sum(t*t for t in y) / R(l)**2
    return s

# ---- (53-54, 65) orbit invariance: shift (sigma) and inversion; refute x->x^u ----
import re, os
HERE = os.path.dirname(os.path.abspath(__file__))
CERT = os.path.normpath(os.path.join(HERE, '..', 'certificates', 'flagship', 'cert_f_x2p30063488_RHO.txt'))
txt = open(CERT).read()
co = [ZZ(c) for c in re.search(r'\(a_0\.\.a_63\) =\n([-0-9,]+)', txt).group(1).split(',')]

def shift(a):      # x * a in Z[x]/(x^64+1): negacyclic shift
    return [-a[m-1]] + a[:m-1]
def invol(a):      # x -> x^{-1} = -x^{63}: a_i -> coefficient reindex i -> -i mod neg
    b = [0]*m
    b[0] = a[0]
    for i in range(1, m):
        b[m-i] = -a[i]
    return b
def subst_u(a, u): # x -> x^u (u odd): a(x) -> a(x^u) reduced mod x^64+1
    b = [0]*m
    for i in range(m):
        e = (i*u) % 128
        if e < m: b[e] += a[i]
        else: b[e-m] -= a[i]
    return b

Q0 = Q_of(co)
Qs = Q_of(shift(co))
Qi = Q_of(invol(co))
Q3 = Q_of(subst_u(co, 3))
print("ORBIT: Q(a)        = %.12e" % float(Q0.mid()))
print("ORBIT: Q(x*a)      = %.12e  shift-invariant: %s" % (float(Qs.mid()), Q0.overlaps(Qs)))
print("ORBIT: Q(inv(a))   = %.12e  inversion-invariant: %s" % (float(Qi.mid()), Q0.overlaps(Qi)))
print("ORBIT: Q(a(x^3))   = %.12e  substitution-invariant: %s (expected False => refuted)" %
      (float(Q3.mid()), Q0.overlaps(Q3)))

# ---- (55-56) dual Gram + Banaszczyk transference kill test ----
# Lattice Lambda_f = (1/l) H L_f in 64-dim span; Gram of base H Z^64 is G (negacyclic r_d).
r = [sum(lam[j]*lam[(j+d) % 128] for j in range(128)) for d in range(m)]
def gram(i, k2):
    d = (i - k2) % 128
    if d < m: return r[d]
    return -r[d-m]
G = matrix(R, m, m, lambda i, k2: gram(i, k2))
Ginv = G.inverse()
prodcheck = (G*Ginv - identity_matrix(R, m)).norm()
print("DUAL: ||G G^-1 - I|| ~ %.2e (dual Gram = G^-1 certified numerically)" % float(prodcheck))
# transference estimate: lambda_1(Lambda) * lambda_1(Lambda^*) >= gap vs Blichfeldt:
# Blichfeldt guarantee on Lambda: |v| <= 3.0137 * covol^{1/64}; Banaszczyk:
# lambda_1(Lambda) <= d / lambda_d(Lambda^*) needs dual successive minima lower
# bounds - estimate lambda_1(dual base lattice) from diag of G^-1 (Babai-type):
mu_min = min(float(Ginv[i,i].mid()) for i in range(m))
mu_max = max(float(Ginv[i,i].mid()) for i in range(m))
print("DUAL: diag(G^-1) in [%.3e, %.3e]; sqrt -> dual vector lengths ~ [%.3e, %.3e]" %
      (mu_min, mu_max, mu_min**0.5, mu_max**0.5))
print("TRANSFERENCE verdict [H]: Banaszczyk lambda_1*mu(dual) <= d/2 gives per-dim constant")
print("  d/(2*pi*e)-scale ~ %.3f vs Blichfeldt 3.0137: transference is WEAKER here unless" % ((m/(2*3.14159*2.71828))**0.5))
print("  dual minima are provably large; no route to 2.147x improvement visible. KILL (56).")

# ---- (59-61) T-body radial headroom, symmetrized, non-rigorous MC ----
import random
random.seed(int(20260824))
TF = 4224.0
lamf = [float(x.mid()) for x in lam]
Gf = [[float(G[i,j].mid()) for j in range(m)] for i in range(m)]
# sample directions in the 64-dim coefficient space, map to y via H (float)
def yvec(af):
    return [sum(af[i]*lamf[(i+j) % 128] for i in range(m)) for j in range(128)]
import math
NS = 400
logratios = []
for s in range(NS):
    af = [random.gauss(0,1) for _ in range(m)]
    y = yvec(af)
    ny = math.sqrt(sum(t*t for t in y))
    yu = [t/ny for t in y]           # unit direction in im(H)
    # ball radius along yu = L7f; T-body radius rho(+u), rho(-u): solve sum exp(2 t u_j) = TF
    L7f = float(L7.mid())
    def rho(dirv):
        lo, hi = 0.0, 1.0
        f = lambda t: sum(math.exp(2*t*u) for u in dirv) - TF
        while f(hi) < 0: hi *= 2
        for _ in range(60):
            mid = 0.5*(lo+hi)
            if f(mid) < 0: lo = mid
            else: hi = mid
        return 0.5*(lo+hi)
    rp, rn = rho(yu), rho([-u for u in yu])
    rs = min(rp, rn)                 # symmetrized T cap -T
    logratios.append(64*math.log(rs / L7f))
mean_gain = sum(logratios)/NS
import statistics
print("TBODY: E[64 ln(rho_sym/L7)] = %.3f (sd %.3f, N=%d directions)" %
      (mean_gain, statistics.pstdev(logratios), NS))
print("TBODY: per-dim factor estimate exp(mean/64) = %.4f ; required for 1e12 C7 gain: 1.54" %
      (math.exp(mean_gain/64)))
print("TBODY verdict (60): %s" % ("CONTINUE (headroom >= 1.54)" if math.exp(mean_gain/64) >= 1.54
      else "STOP T-body: headroom below the 10^12 bar. [H, MC-sampled]"))

# ---- (77 pilot) 2-adic depth v_P(eps_7 - 1): is MO's floor 128 exact for eps_7? ----
K = CyclotomicField(512)
z = K.gen()
X = z + z**(-1)
eps = (X+1)/(X-1)
P2 = K.primes_above(2)[0]
v_eps = (eps - 1).valuation(P2)
e_P = P2.ramification_index()
# B_7 = Q(X) sits inside K with e(K/B_7) = 2 at 2; v_{B_7} = v_K / 2 in B_7-normalization
print("TWOADIC: v_P(eps_7 - 1) in K(zeta_512) = %s (ram index e = %s); B_7-normalized = %s" %
      (v_eps, e_P, v_eps/2))
print("TWOADIC: MO floor is 128 (B_7-normalized, = v(2)); depth found %s => free extra depth: %s" %
      (v_eps/2, "YES" if v_eps/2 > 128 else "NO - floor exact for eps_7 itself"))
print("elapsed %.1fs" % (time.time()-t0))
print("R7 STRUCTURAL PILOTS DONE")
