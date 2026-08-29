# r5_mu0_tbody - (a) corrected pair floor (lags 1..63), (b) BKZ + exact enumeration for mu0
# on the l-free trivial form Q(b) = 2|Lambda' b|^2, (c) T-body volume -> refined l*.
import mpmath as mp, sys, time
mp.mp.dps=40
N=128; d=64; MOD=512; th=mp.pi/MOD
ks=[pow(3,i,MOD) for i in range(N)]
lam=[mp.log(abs((2*mp.cos(2*mp.mpf(k)*th)+1)/(2*mp.cos(2*mp.mpf(k)*th)-1))) for k in ks]
L0sq=(mp.sqrt(N)*mp.log(2+mp.sqrt(5)))**2
S2=sum(t*t for t in lam)
C=[sum(lam[m]*lam[(m+k)%N] for m in range(N)) for k in range(N)]
cmax63=max(abs(C[k]) for k in range(1,64))
print("(a) max_{1<=k<=63}|C(k)| =",mp.nstr(cmax63,8),"-> pair floor =",mp.nstr(2*S2-2*cmax63,8))
# (b) l-free lattice: rows = SC*lam-profile of e_k (k=0..63), 128 cols
SC=10**9
emb=[[int(mp.nint(SC*lam[(k+j)%N])) for j in range(N)] for k in range(d)]
B=matrix(ZZ,emb).LLL().BKZ(block_size=24)
B=B.BKZ(block_size=40)
best=None
for i in range(B.nrows()):
    if B.row(i)==0: continue
    nrm=sum(int(B[i,j])**2 for j in range(N))/float(SC)**2
    if best is None or nrm<best: best=nrm
print("(b) mu0 BKZ-40 upper bound / best found =",best," (vs c=0.98*L0^2 =",float(mp.mpf('0.98')*L0sq),")")
sys.stdout.flush()
# exact enumeration attempt with pari qfminim on scaled integer Gram (budget-guarded)
import cypari2
pari=cypari2.Pari(); pari.allocatemem(2*10**9)
G2=[[0]*d for _ in range(d)]
for a in range(d):
    for b in range(a,d):
        v=2*sum(lam[(a+j)%N]*lam[(b+j)%N] for j in range(N))
        G2[a][b]=G2[b][a]=int(mp.nint(mp.mpf(10**6)*v))
gp=pari.matrix(d,d,[G2[i][j] for i in range(d) for j in range(d)])
t0=time.time()
try:
    res=pari.qfminim(gp,int(270*10**6),200,2)
    print("(b2) qfminim: count(Q<=270) =",res[0]," min found =",float(res[1])/10**6," time %.0fs"%(time.time()-t0))
except Exception as e:
    print("(b2) qfminim failed/slow:",str(e)[:100])
sys.stdout.flush()
# (c) T-body volume: {y in R^64 : sum 2cosh(2y_j) <= 4224}. ln Vol = inf_s [s*M + 64 ln Z(s)], M=2112 (per-side sum cosh)
M=mp.mpf(2112)
def lnvol(s):
    Z=mp.quad(lambda t: mp.e**(-s*mp.cosh(2*t)), [-6,6])
    return s*M+64*mp.log(Z)
lo,hi=mp.mpf('0.001'),mp.mpf('2')
for _ in range(60):
    m1=lo+(hi-lo)/3; m2=hi-(hi-lo)/3
    if lnvol(m1)<lnvol(m2): hi=m2
    else: lo=m1
sbest=(lo+hi)/2; lnVT=lnvol(sbest)
lnVQ=32*mp.log(mp.pi)-mp.log(mp.factorial(32))+32*mp.log(mp.mpf('0.98')*L0sq/2)
print("(c) ln Vol(T-body) =",mp.nstr(lnVT,8)," vs ln Vol(Q-ball) =",mp.nstr(lnVQ,8))
lndet=mp.mpf('155.6031072')
for tag,lnv in (("Q-ball",lnVQ),("T-body",lnVT)):
    need=64*mp.log(2)+lndet-lnv
    print("    %s: deg-2 l* = %s   deg-1 l* = %s"%(tag,mp.nstr(mp.e**(need/2),6),mp.nstr(mp.e**need,6)))
print("MU0 TBODY DONE")
