# r6_search_regression - P1-6/P1-7: regression against the PROVEN Blichfeldt bound, cls 1, l ~ 1e33.
# Correct large-l engine (Gram-first): the y-space Gram of the HNF basis is O(1e4) independent
# of l; compute it at dps 60, integerize at K=1e12, LLL via pari.qflllgram (exact integer Gram),
# transform the coefficient basis, THEN embed the reduced basis (small combination coeffs) and
# BKZ-24. Verdict per component: FOUND(rho) if rho < 1, else SEARCH_FAILURE_AGAINST_PROVEN_BOUND
# (never OPEN: l exceeds the certified deg-1 threshold 1.728e30, existence is proven;
# envelope rho_Blich = (C7/l)^{1/64}).
import mpmath as mp, sys, time
mp.mp.dps=60
pari.allocatemem(4*10**9)
N=128; d=64; MOD=512; th=mp.pi/MOD
ks=[pow(3,i,MOD) for i in range(N)]
lam=[mp.log(abs((2*mp.cos(2*mp.mpf(k)*th)+1)/(2*mp.cos(2*mp.mpf(k)*th)-1))) for k in ks]
L0=mp.sqrt(N)*mp.log(2+mp.sqrt(5))
l=ZZ(1000000000000000000000000000018049)
C7u=mp.mpf('1.7273421630363531e30')
env=(C7u/mp.mpf(str(l)))**(mp.mpf(1)/64)
print("l = %s (cls %s mod 128) > certified deg-1 threshold; Blichfeldt envelope rho <= %s"%(l,l%128,mp.nstr(env,5))); sys.stdout.flush()
NCOMP=int(sys.argv[1]) if len(sys.argv)>1 else 1
F=GF(l); Rp=PolynomialRing(F,'y'); yy=Rp.gen()
fac=[g for g,e in (yy**64+1).factor()]
fac.sort(key=lambda g: ZZ(g[0]))
Zx=PolynomialRing(ZZ,'x'); x=Zx.gen()
def center(c,ll):
    c%=ll
    return c-ll if c>ll//2 else c
K=10**8; SC=10**9
nf=0; nfail=0
for ci,g in enumerate(fac[:NCOMP]):
    t0=time.time()
    w=(yy**64+1)//g
    wz=sum(ZZ(cc)*x**k for k,cc in enumerate(w.list()))
    c=[ZZ(cc) for cc in wz.list()]; c=c+[0]*(64-len(c))
    gen=[center(ZZ(cc),l) for cc in c]
    rows=[[l if i==j else 0 for j in range(d)] for i in range(d)]+[gen]
    M=matrix(ZZ,rows).hermite_form(include_zero_rows=False)
    assert M.nrows()==64 and abs(M.det())==l**63
    # y-profiles of the 64 HNF basis rows at dps60 (exact rational coeffs / l)
    Y=[]
    for i in range(64):
        a=list(M.row(i))
        Y.append([sum(mp.mpf(int(a[k]))*lam[(k+j)%N] for k in range(d) if a[k])/mp.mpf(str(l)) for j in range(N)])
    # exact-precision Gram, integerized at K
    Gi=[[int(mp.nint(K*sum(Y[i][j]*Y[kk][j] for j in range(N)))) for kk in range(64)] for i in range(64)]
    gp=pari.matrix(64,64,[Gi[i][j] for i in range(64) for j in range(64)])
    U=pari.qflllgram(gp)
    Um=matrix(ZZ,64,64,[[int(U[j][i]) for j in range(64)] for i in range(64)])  # columns -> rows
    B2=Um*M   # LLL-reduced coefficient basis (rows)
    # embed the reduced basis (per-row absolute y-error ~1e-25 + rounding 5e-10) and BKZ
    emb=[]
    for i in range(64):
        a=list(B2.row(i))
        emb.append([int(mp.nint(SC*sum(mp.mpf(int(a[k]))*lam[(k+j)%N] for k in range(d) if a[k])/mp.mpf(str(l)))) for j in range(N)])
    E=matrix(ZZ,emb)
    B=E.LLL().BKZ(block_size=24)
    Uc=E.solve_left(B)
    best=None;bestco=None
    for i in range(B.nrows()):
        if B.row(i)==0: continue
        co=(Uc.row(i)*B2)
        if all(ZZ(cc)%l==0 for cc in co): continue
        ys=[sum(mp.mpf(int(co[k]))*lam[(k+j)%N] for k in range(d) if co[k])/mp.mpf(str(l)) for j in range(N)]
        Q=sum(t*t for t in ys)
        if best is None or Q<best: best,bestco=Q,[ZZ(cc) for cc in co]
    rho=mp.sqrt(best)/L0
    ver="FOUND rho=%s"%mp.nstr(rho,6) if rho<1 else "SEARCH_FAILURE_AGAINST_PROVEN_BOUND (best rho=%s)"%mp.nstr(rho,6)
    if rho<1: nf+=1
    else: nfail+=1
    print("comp f=x+%s : %s   (envelope %s)  %.0fs"%(ZZ(g[0]),ver,mp.nstr(env,4),time.time()-t0))
    sys.stdout.flush()
print("REGRESSION SUMMARY: FOUND %d / SEARCH_FAILURE %d of %d"%(nf,nfail,NCOMP))
print("R6 SEARCH REGRESSION DONE")
