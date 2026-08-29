# r5_esc_fast - FAST escalation engine (2026-08-23). One prime per invocation (argv).
# Speed design: search in INTEGER/double precision (Q = |b|^2/SC^2 from the embedding;
# T from float y's); mpmath dps40 only to RECORD the two winners. Combos via precomputed
# dot products. BKZ 24->40. Certification remains r5_verify's job (RealBallField).
import mpmath as mp, sys, time, math
mp.mp.dps=40
N=128; d=64; MOD=512; th=mp.pi/MOD
ks=[pow(3,i,MOD) for i in range(N)]
lam=[mp.log(abs((2*mp.cos(2*mp.mpf(k)*th)+1)/(2*mp.cos(2*mp.mpf(k)*th)-1))) for k in ks]
lamf=[float(t) for t in lam]
L0=mp.sqrt(N)*mp.log(2+mp.sqrt(5)); L0f=float(L0)
def center(c,ll):
    c%=ll
    return c-ll if c>ll//2 else c
Zx=PolynomialRing(ZZ,'x'); x=Zx.gen()
l=ZZ(sys.argv[1]); SC=10**9; SCf=float(SC)
F=GF(l); Rp=PolynomialRing(F,'y'); yy=Rp.gen()
fac=[g for g,e in (yy**64+1).factor()]
fac.sort(key=lambda g: ZZ(g[0]))
def measure40(co):
    ys=[sum(mp.mpf(int(co[k]))*lam[(k+j)%N] for k in range(d) if co[k])/l for j in range(N)]
    Q=sum(t*t for t in ys); T=sum(mp.e**(2*t) for t in ys)
    return Q,T
def ec(co,g):
    gz=sum(ZZ(cc)*x**k for k,cc in enumerate(g.list()))
    ap=sum(co[k]*x**k for k in range(d))
    return (not all(cc%l==0 for cc in co)) and all(cc%l==0 for cc in ((gz*ap)%(x**64+1)).coefficients())
nr=0;nt=0;no=0;worst=0.0;openlist=[]
t00=time.time()
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
    emb=[]
    for i in range(M.nrows()):
        a=list(M.row(i))
        emb.append([int(mp.nint(SC*sum(mp.mpf(int(a[k]))*lam[(k+j)%N] for k in range(d) if a[k])/l)) for j in range(N)])
    E=matrix(ZZ,emb)
    B=E.LLL().BKZ(block_size=24)
    B=B.BKZ(block_size=40)
    rowsB=[[int(B[i,j]) for j in range(N)] for i in range(B.nrows()) if not B.row(i)==0]
    # float search over rows + top-24 pairwise combos, integer norms / float T
    def qt_of(v):
        q=0.0; t=0.0
        for z in v:
            yj=z/SCf; q+=yj*yj; t+=math.exp(2.0*yj)
        return q,t
    scored=[]
    for v in rowsB:
        q,t=qt_of(v); scored.append((q,t,v))
    scored.sort(key=lambda s:s[0])
    bq,bt_of_bq,bv=scored[0]
    bt=min(s[1] for s in scored); btv=[s[2] for s in scored if s[1]==bt][0]
    top=[s[2] for s in scored[:24]]
    for i in range(len(top)):
        for j in range(i+1,len(top)):
            vp=[top[i][k]+top[j][k] for k in range(N)]
            vm=[top[i][k]-top[j][k] for k in range(N)]
            for v in (vp,vm):
                if all(z==0 for z in v): continue
                q,t=qt_of(v)
                if q<bq: bq,bv=q,v
                if t<bt: bt,btv=t,v
    # recover exact coefficients for the two winners; drop l*R-trivial ones
    def coeffs_of(v):
        u=E.solve_left(vector(ZZ,v))
        co=(u*M)
        return [ZZ(cc) for cc in co]
    out=[]
    for tag,v in (("Q",bv),("T",btv)):
        co=coeffs_of(v)
        if all(cc%l==0 for cc in co): out.append((tag,None,None,None)); continue
        Q40,T40=measure40(co)
        out.append((tag,co,Q40,T40))
    rho=None;Tbest=None;okq=False;okt=False
    for tag,co,Q40,T40 in out:
        if co is None: continue
        if tag=="Q": rho=float(mp.sqrt(Q40))/L0f; okq=ec(co,g)
        else: Tbest=float(T40); okt=ec(co,g)
    print("  c%02d rho=%.5f T=%.1f" % (ci,-1 if rho is None else rho,-1 if Tbest is None else Tbest)); sys.stdout.flush()
    if rho is not None and rho>worst: worst=rho
    if rho is not None and rho<1 and okq: nr+=1
    elif Tbest is not None and Tbest<4224 and okt: nt+=1
    else: no+=1; openlist.append((ci,"%.4f"%(-1 if rho is None else rho),"%.0f"%(-1 if Tbest is None else Tbest)))
print("ESC l=%d : RHO %d T %d OPEN %d worst=%.5f  %.0fs" % (l,nr,nt,no,worst,time.time()-t00))
if openlist: print("   open:",openlist)
print("ESC_FAST DONE l=%d" % l)
