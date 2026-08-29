# r4c - ESCALATION PILOT: components 3, 23, 8 (needed gains 0.4% / 2.9% / 4.1%)
# Changes vs r4: SC 1e7 -> 1e9, BKZ 24 -> 24 then 40 (two tours), post-search over
# pairwise combos v_i +/- v_j of the 16 shortest rows (Q and T tracked separately).
# Timing printed per component for the full-sweep budget (5-20x rule).
import mpmath as mp, sys, time
mp.mp.dps=40
n=7; N=128; d=64; MOD=512; th=mp.pi/MOD
ks=[pow(3,i,MOD) for i in range(N)]
lam=[]
for k in ks:
    X=2*mp.cos(2*mp.mpf(k)*th); lam.append(mp.log(abs((X+1)/(X-1))))
L0=mp.sqrt(N)*mp.log(2+mp.sqrt(5))
SC=10**9
l=1000000321
F=GF(l); Rp=PolynomialRing(F,'y'); y=Rp.gen()
fac=[g for g,e in (y**64+1).factor()]
fac.sort(key=lambda g: ZZ(g[0]))
Zx=PolynomialRing(ZZ,'x'); x=Zx.gen()
def center(c,ll):
    c%=ll
    return c-ll if c>ll//2 else c
def measures_co(co):
    ys=[sum(mp.mpf(int(co[k]))*lam[(k+j)%N] for k in range(d) if co[k])/l for j in range(N)]
    Q=sum(t*t for t in ys); T=sum(mp.e**(2*t) for t in ys)
    return Q,T
wf=open("r4_witnesses_l1000000321.txt","a")
for ci in [3,23,8]:
    t0=time.time()
    g=fac[ci]
    w=(y**64+1)//g; c=[ZZ(cc) for cc in w.list()]; c=c+[0]*(64-len(c))
    rows=[[l if i==j else 0 for j in range(d)] for i in range(d)]+[[center(cc,l) for cc in c]]
    M=matrix(ZZ,rows).hermite_form(include_zero_rows=False)
    emb=[]
    for i in range(M.nrows()):
        a=list(M.row(i))
        emb.append([int(mp.nint(SC*sum(mp.mpf(int(a[k]))*lam[(k+j)%N] for k in range(d) if a[k])/l)) for j in range(N)])
    B=matrix(ZZ,emb).LLL().BKZ(block_size=24)
    B=B.BKZ(block_size=40)
    U=matrix(ZZ,emb).solve_left(B)
    cand=[]
    for i in range(B.nrows()):
        if B.row(i)==0: continue
        co=(U.row(i)*M)
        if all(ZZ(cc)%l==0 for cc in co): continue
        nrm=sum(int(B[i,j])**2 for j in range(N))
        cand.append((nrm,[ZZ(cc) for cc in co]))
    cand.sort(key=lambda t:t[0])
    # base rows
    bq=None;bqco=None;bt=None;btco=None
    def upd(co):
        global bq,bqco,bt,btco
        Q,T=measures_co(co)
        if bq is None or Q<bq: bq,bqco=Q,co
        if bt is None or T<bt: bt,btco=T,co
    for _,co in cand: upd(co)
    # pairwise combos of 16 shortest
    top=[co for _,co in cand[:16]]
    for i in range(len(top)):
        for j in range(i+1,len(top)):
            for s in [1,-1]:
                co=[top[i][k]+s*top[j][k] for k in range(d)]
                if all(ZZ(cc)%l==0 for cc in co): continue
                upd(co)
    rho=mp.sqrt(bq)/L0
    # exact checks on the best-Q vector
    gz=sum(ZZ(cc)*x**k for k,cc in enumerate(g.list()))
    apoly=sum(bqco[k]*x**k for k in range(d))
    c1=not all(cc%l==0 for cc in bqco)
    c2=all(cc%l==0 for cc in ((gz*apoly)%(x**64+1)).coefficients())
    el=time.time()-t0
    verdict="RHO_PASS" if rho<1 else ("T_PASS" if bt<4224 else "OPEN")
    print("comp %-3d rho=%-12s T=%-12s chk1=%s chk2=%s  %-8s  %.0fs"
          % (ci,mp.nstr(rho,8),mp.nstr(bt,8),c1,c2,verdict,el))
    sys.stdout.flush()
    wf.write("%d | %s | RHOesc | %s\n" % (ci,ZZ(g[0]),",".join(str(cc) for cc in bqco)))
    wf.write("%d | %s | Tesc | %s\n" % (ci,ZZ(g[0]),",".join(str(cc) for cc in btco)))
wf.close()
print("R4C PILOT DONE")
