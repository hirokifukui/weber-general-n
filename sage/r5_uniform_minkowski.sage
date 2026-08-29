# r5_uniform_minkowski - item 5/7 engine: anti-periodicity + Minkowski thresholds (2026-08-23)
import mpmath as mp, sys
mp.mp.dps=60
N=128; d=64; MOD=512; th=mp.pi/MOD
ks=[pow(3,i,MOD) for i in range(N)]
lam=[mp.log(abs((2*mp.cos(2*mp.mpf(k)*th)+1)/(2*mp.cos(2*mp.mpf(k)*th)-1))) for k in ks]
# (1) ANTI-PERIODICITY: lam[m+64] = -lam[m] ?
err=max(abs(lam[m]+lam[(m+64)%N]) for m in range(N))
print("(1) anti-periodicity max|lam_m + lam_{m+64}| =",mp.nstr(err,5))
L0sq=(mp.sqrt(N)*mp.log(2+mp.sqrt(5)))**2
# (2) 64-dim slice Lambda' and its determinant
A=[[lam[(i+j)%N] for i in range(d)] for j in range(d)]
Am=mp.matrix(A)
det=mp.det(Am)
print("(2) ln|det Lambda'| =",mp.nstr(mp.log(abs(det)),10))
# cross-check vs product of nonzero evs of H^T H = 2 Lambda'^T Lambda'
# (3) Minkowski threshold: V64*(c/2)^32 * l^e >= 2^64 * |det|  (e=2 deg-2, e=1 deg-1)
# ln V64 = 32 ln pi - ln(32!)
lnV=32*mp.log(mp.pi)-mp.log(mp.factorial(32))
c=mp.mpf('0.98')*L0sq   # small safety margin below L0^2
lnLHS=lnV+32*mp.log(c/2)
lnRHS0=64*mp.log(2)+mp.log(abs(det))
# need e*ln l >= lnRHS0 - lnLHS
need=lnRHS0-lnLHS
print("(3) ln l threshold: deg-2 needs ln l >=",mp.nstr(need/2,8)," -> l* =",mp.nstr(mp.e**(need/2),6))
print("    deg-1 needs ln l >=",mp.nstr(need,8)," -> l* =",mp.nstr(mp.e**need,6))
print("    (c = 0.98*L0^2 =",mp.nstr(c,8),")")
# (4) trivial floor: form Q(b) = 2|Lambda' b|^2 on Z^64; Gram G2 = 2 A^T A; report smallest
# diagonal (= Q(e_k) = 2*sum_{j<64} lam_{k+j}^2 = S2) and autocorrelation max off-diag
S2=sum(t*t for t in lam)
print("(4) Q(l*e_k) = S2 =",mp.nstr(S2,8)," vs L0^2 =",mp.nstr(L0sq,8))
C=[sum(lam[m]*lam[(m+k)%N] for m in range(N)) for k in range(N)]
cmax=max(abs(C[k]) for k in range(1,N))
print("    max_{k!=0}|C(k)| =",mp.nstr(cmax,8)," -> pair floor 2*S2-2*max|C| =",mp.nstr(2*S2-2*cmax,8))
print("MINKOWSKI CONSTANTS DONE")
