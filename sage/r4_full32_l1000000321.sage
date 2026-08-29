# r4 - FULL 32-COMPONENT SWEEP, cls 65, l = 1000000321 (2026-08-23)
# Engine identical to r2/r3/r3b (HNF lift lattice, LLL+BKZ-24, eps-side logs, 128 shifts).
# Per component: best-Q vector (rho route) and best-T vector (trace route) tracked separately.
# Exact checks per rho-witness: chk1 a not in l*R, chk2 f*a = 0 mod (l, x^64+1)  (integer arith).
# Verdict per component: RHO_PASS (rho<1) / T_PASS (T<4224) / OPEN.
# Witness vectors appended to r4_witnesses_l1000000321.txt for the certificate step.
import mpmath as mp, sys
mp.mp.dps=40
n=7; N=128; d=64; MOD=512; th=mp.pi/MOD
ks=[pow(3,i,MOD) for i in range(N)]
lam=[]
for k in ks:
    X=2*mp.cos(2*mp.mpf(k)*th); lam.append(mp.log(abs((X+1)/(X-1))))
L0=mp.sqrt(N)*mp.log(2+mp.sqrt(5))
SC=10**7
l=1000000321
F=GF(l); Rp=PolynomialRing(F,'y'); y=Rp.gen()
fac=[g for g,e in (y**64+1).factor()]
fac.sort(key=lambda g: ZZ(g[0]))       # deterministic order by constant term
assert len(fac)==32
Zx=PolynomialRing(ZZ,'x'); x=Zx.gen()
def center(c,ll):
    c%=ll
    return c-ll if c>ll//2 else c
wf=open("r4_witnesses_l1000000321.txt","w")
wf.write("# l=1000000321 cls65 witnesses. lines: comp_index | f_const | route | coeffs(64)\n")
print("idx  f=y^2+c (c)          rho          T_best        chk1  chk2  verdict")
sys.stdout.flush()
n_rho=0; n_t=0; n_open=0; worst_rho=None
for ci,g in enumerate(fac):
    w=(y**64+1)//g; c=[ZZ(cc) for cc in w.list()]; c=c+[0]*(64-len(c))
    rows=[[l if i==j else 0 for j in range(d)] for i in range(d)]+[[center(cc,l) for cc in c]]
    M=matrix(ZZ,rows).hermite_form(include_zero_rows=False)
    emb=[]
    for i in range(M.nrows()):
        a=list(M.row(i))
        emb.append([int(mp.nint(SC*sum(mp.mpf(int(a[k]))*lam[(k+j)%N] for k in range(d) if a[k])/l)) for j in range(N)])
    B=matrix(ZZ,emb).LLL().BKZ(block_size=24)
    U=matrix(ZZ,emb).solve_left(B)
    bq=None; bqco=None; bt=None; btco=None
    for i in range(B.nrows()):
        if B.row(i)==0: continue
        co=(U.row(i)*M)
        if all(ZZ(cc)%l==0 for cc in co): continue
        ys=[sum(mp.mpf(int(co[k]))*lam[(k+j)%N] for k in range(d) if co[k])/l for j in range(N)]
        Q=sum(t2*t2 for t2 in ys); T=sum(mp.e**(2*t2) for t2 in ys)
        if bq is None or Q<bq: bq,bqco=Q,[ZZ(cc) for cc in co]
        if bt is None or T<bt: bt,btco=T,[ZZ(cc) for cc in co]
    rho=mp.sqrt(bq)/L0
    if worst_rho is None or rho>worst_rho: worst_rho=rho
    apoly=sum(bqco[k]*x**k for k in range(d))
    gz=sum(ZZ(cc)*x**k for k,cc in enumerate(g.list()))
    chk1 = not all(cc%l==0 for cc in bqco)
    chk2 = all(cc%l==0 for cc in ((gz*apoly)%(x**64+1)).coefficients())
    if rho<1: verdict="RHO_PASS"; n_rho+=1
    elif bt<4224: verdict="T_PASS"; n_t+=1
    else: verdict="OPEN"; n_open+=1
    print("%-4d %-20s %-12s %-13s %-5s %-5s %s"
          % (ci,str(ZZ(g[0])),mp.nstr(rho,7),mp.nstr(bt,8),chk1,chk2,verdict))
    sys.stdout.flush()
    wf.write("%d | %s | RHO | %s\n" % (ci,ZZ(g[0]),",".join(str(cc) for cc in bqco)))
    wf.write("%d | %s | T   | %s\n" % (ci,ZZ(g[0]),",".join(str(cc) for cc in btco)))
wf.close()
print("SUMMARY: RHO_PASS %d / T_PASS %d / OPEN %d of 32   worst rho = %s"
      % (n_rho,n_t,n_open,mp.nstr(worst_rho,7)))
print("R4 FULL32 DONE")
