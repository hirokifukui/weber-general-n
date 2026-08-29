# r5_moments_deg2 - Phase D groundwork: spectrum + moment budget for the deg-2 uniform theorem
# All identities elementary [P]; numbers dps40 [MC]. No lattice search here.
import mpmath as mp
mp.mp.dps=40
N=128; d=64; MOD=512; th=mp.pi/MOD
ks=[pow(3,i,MOD) for i in range(N)]
lam=[mp.log(abs((2*mp.cos(2*mp.mpf(k)*th)+1)/(2*mp.cos(2*mp.mpf(k)*th)-1))) for k in ks]
L0=mp.sqrt(N)*mp.log(2+mp.sqrt(5)); L0sq=L0*L0
S2=sum(t*t for t in lam)                 # = ht(eps_7)^2 over all 128 conjugates
# circulant spectrum of G: eigenvalues = |DFT(lam)|^2 (G_{ik}=C(i-k), C=autocorrelation)
evs=[]
for r in range(N):
    z=sum(lam[m]*mp.e**(2j*mp.pi*r*m/N) for m in range(N))
    evs.append(abs(z)**2)
evs_sorted=sorted(evs)
# uniform-coefficient model: each of the 64 coefficients uniform centered residue mod l, l->inf
# E[Q] = (1/12) * sum_j sum_{i<64} lam_{i+j}^2 = (64/12) * S2   (exact limit)
EQ=mp.mpf(64)/12*S2
# second moment of a single y_j in the independent model: Var(y_j)=(1/12)*sum_{i<64} lam_{i+j}^2
print("S2 = sum lam^2              =", mp.nstr(S2,10))
print("L0^2 (rho threshold)        =", mp.nstr(L0sq,10))
print("E[Q] uniform model          =", mp.nstr(EQ,10))
print("E[Q]/L0^2                   =", mp.nstr(EQ/L0sq,8), "  (mean pigeonhole fails by this factor)")
print("spectrum |DFT lam|^2: min   =", mp.nstr(evs_sorted[0],8))
print("                     median =", mp.nstr(evs_sorted[N//2],8))
print("                     max    =", mp.nstr(evs_sorted[-1],8))
print("trace check sum(evs)/N == S2:", mp.nstr(sum(evs)/N,10))
# observed r5 minima band (from r5_full32 log): rho in [0.9387, 0.9977] -> Q in:
print("observed Q band r5          = [", mp.nstr((mp.mpf('0.9387')**2)*L0sq,8), ",", mp.nstr((mp.mpf('0.9977')**2)*L0sq,8), "]")
print("required covering deficit   = observed_min_Q / E[Q] ~", mp.nstr((mp.mpf('0.94')**2)*L0sq/EQ,6))
print("MOMENTS DONE")
