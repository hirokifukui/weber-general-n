# r5_tfloor - min T over the l-free trivial lattice (BKZ-40 + top-32 combos) [MC upper-bd search]
import mpmath as mp, math, sys
mp.mp.dps=40
N=128; d=64; MOD=512; th=mp.pi/MOD
ks=[pow(3,i,MOD) for i in range(N)]
lam=[mp.log(abs((2*mp.cos(2*mp.mpf(k)*th)+1)/(2*mp.cos(2*mp.mpf(k)*th)-1))) for k in ks]
SC=10**9; SCf=float(SC)
emb=[[int(mp.nint(SC*lam[(k+j)%N])) for j in range(N)] for k in range(d)]
B=matrix(ZZ,emb).LLL().BKZ(block_size=24); B=B.BKZ(block_size=40)
rowsB=[[int(B[i,j]) for j in range(N)] for i in range(B.nrows()) if not B.row(i)==0]
def tval(v): return sum(math.exp(2.0*z/SCf) for z in v)
scored=sorted(((tval(v),v) for v in rowsB),key=lambda s:s[0])
bt=scored[0][0]
top=[s[1] for s in scored[:32]]
for i in range(len(top)):
    for j in range(i+1,len(top)):
        for sg in (1,-1):
            v=[top[i][k]+sg*top[j][k] for k in range(N)]
            if all(z==0 for z in v): continue
            t=tval(v)
            if t<bt: bt=t
print("T-floor search (trivial lattice): min T found =",bt," vs 4224  ->",("SAFE margin" if bt>4224 else "T-ROUTE FLOOR VIOLATED"))
