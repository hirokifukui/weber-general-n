# r5_escalate_6327 - specified escalation (BKZ-24 -> BKZ-40 + top-24 pairwise combos; BKZ-50 abandoned on deg-2: enumeration blow-up, 56 CPU-min without finishing one prime — see ERRATA E6)
# on ALL components of the cls 63 / cls 127 stress primes that stayed OPEN under BKZ-24.
# Language discipline: outcomes reported as "search stability under specified escalation",
# never "saturation" (GPT-r1 sec. 10).
import mpmath as mp, sys, time
mp.mp.dps=40
N=128; d=64; MOD=512; th=mp.pi/MOD
ks=[pow(3,i,MOD) for i in range(N)]
lam=[mp.log(abs((2*mp.cos(2*mp.mpf(k)*th)+1)/(2*mp.cos(2*mp.mpf(k)*th)-1))) for k in ks]
L0=mp.sqrt(N)*mp.log(2+mp.sqrt(5))
def center(c,ll):
    c%=ll
    return c-ll if c>ll//2 else c
Zx=PolynomialRing(ZZ,'x'); x=Zx.gen()
def measures(co,l):
    ys=[sum(mp.mpf(int(co[k]))*lam[(k+j)%N] for k in range(d) if co[k])/l for j in range(N)]
    Q=sum(t*t for t in ys); T=sum(mp.e**(2*t) for t in ys)
    return Q,T
def ec(co,g,l):
    gz=sum(ZZ(cc)*x**k for k,cc in enumerate(g.list()))
    ap=sum(co[k]*x**k for k in range(d))
    return (not all(cc%l==0 for cc in co)) and all(cc%l==0 for cc in ((gz*ap)%(x**64+1)).coefficients())
def esc_prime(l):
    F=GF(l); Rp=PolynomialRing(F,'y'); yy=Rp.gen()
    fac=[g for g,e in (yy**64+1).factor()]
    fac.sort(key=lambda g: ZZ(g[0]))
    nr=0;nt=0;no=0;worst=mp.mpf(0);openlist=[]
    for ci,g in enumerate(fac):
        w=(yy**64+1)//g
        wz=sum(ZZ(cc)*x**k for k,cc in enumerate(w.list()))
        gens=[]
        for j in range(g.degree()):
            p=(x**j*wz)%(x**64+1)
            c=[ZZ(cc) for cc in p.list()]; c=c+[0]*(64-len(c))
            gens.append([center(ZZ(cc),l) for cc in c])
        rows=[[l if i==j else 0 for j in range(d)] for i in range(d)]+gens
        M=matrix(ZZ,rows).hermite_form(include_zero_rows=False)
        assert M.nrows()==64 and abs(M.det())==l**(64-g.degree())
        SC=10**9
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
        bq=None;bqco=None;bt=None;btco=None
        def upd(co):
            nonlocal bq,bqco,bt,btco
            Q,T=measures(co,l)
            if bq is None or Q<bq: bq,bqco=Q,co
            if bt is None or T<bt: bt,btco=T,co
        for _,co in cand: upd(co)
        top=[co for _,co in cand[:24]]
        for i in range(len(top)):
            for j in range(i+1,len(top)):
                for s in [1,-1]:
                    co=[top[i][k]+s*top[j][k] for k in range(d)]
                    if all(ZZ(cc)%l==0 for cc in co): continue
                    upd(co)
        rho=mp.sqrt(bq)/L0
        print("  c%02d rho=%s T=%s"%(ci,mp.nstr(rho,6),mp.nstr(bt,7))); sys.stdout.flush()
        if rho>worst: worst=rho
        if rho<1 and ec(bqco,g,l): nr+=1
        elif bt<4224 and ec(btco,g,l): nt+=1
        else:
            no+=1; openlist.append((ci,mp.nstr(rho,6),mp.nstr(bt,7)))
        sys.stdout.flush()
    print("ESC l=%d : RHO %d T %d OPEN %d worst=%s" % (l,nr,nt,no,mp.nstr(worst,7)))
    if openlist: print("   open:",openlist)
    sys.stdout.flush()
for l in [1000000447, 10000000319, 1000000000063, 10000000000003903, 1000001279, 10000003199, 1000000002431, 10000000000000639]:
    t0=time.time(); esc_prime(ZZ(l)); print("   %.0fs" % (time.time()-t0)); sys.stdout.flush()
print("ESCALATION DONE")
