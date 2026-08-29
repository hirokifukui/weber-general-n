# r5 - FULL 32-COMPONENT SWEEP ON THE CORRECT LATTICE  l*R + Z*w + Z*(x*w)  (2026-08-23)
# Post GPT-r1 review. Gate: r5_full_component.sage must PASS first (det l^62, ref==opt).
# Per component: correct lattice, det assert inline, LLL+BKZ24+BKZ40, pairwise combos of top 16,
# best-Q and best-T tracked separately, EXACT membership checks on BOTH witnesses.
# Output: high-precision (dps40) values; certification is r5_verify.sage's job (RealBallField).
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
def cvec(p,ll):
    c=[ZZ(cc) for cc in p.list()]; c=c+[0]*(64-len(c))
    return [center(ZZ(cc),ll) for cc in c]
def measures_co(co):
    ys=[sum(mp.mpf(int(co[k]))*lam[(k+j)%N] for k in range(d) if co[k])/l for j in range(N)]
    Q=sum(t*t for t in ys); T=sum(mp.e**(2*t) for t in ys)
    return Q,T
def exact_checks(co,g):
    gz=sum(ZZ(cc)*x**k for k,cc in enumerate(g.list()))
    apoly=sum(co[k]*x**k for k in range(d))
    c1=not all(cc%l==0 for cc in co)
    c2=all(cc%l==0 for cc in ((gz*apoly)%(x**64+1)).coefficients())
    return c1,c2
wf=open("r5_witnesses_l1000000321.txt","w")
wf.write("# r5 CORRECT-LATTICE witnesses. lines: comp_index | f_const | route | coeffs(64)\n")
print("idx  c                    rho          T_best        Qc1 Qc2 Tc1 Tc2  verdict   t")
sys.stdout.flush()
n_rho=0;n_t=0;n_open=0;worst=None;rhos=[]
for ci,g in enumerate(fac):
    t0=time.time()
    w=(y**64+1)//g
    wz=sum(ZZ(cc)*x**k for k,cc in enumerate(w.list()))
    rows=[[l if i==j else 0 for j in range(d)] for i in range(d)]+[cvec(wz,l),cvec((x*wz)%(x**64+1),l)]
    M=matrix(ZZ,rows).hermite_form(include_zero_rows=False)
    assert M.nrows()==64 and abs(M.det())==l**62, "P0 gate violated at runtime"
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
        global bq,bqco,bt,btco
        Q,T=measures_co(co)
        if bq is None or Q<bq: bq,bqco=Q,co
        if bt is None or T<bt: bt,btco=T,co
    for _,co in cand: upd(co)
    top=[co for _,co in cand[:16]]
    for i in range(len(top)):
        for j in range(i+1,len(top)):
            for s in [1,-1]:
                co=[top[i][k]+s*top[j][k] for k in range(d)]
                if all(ZZ(cc)%l==0 for cc in co): continue
                upd(co)
    rho=mp.sqrt(bq)/L0; rhos.append(rho)
    qc1,qc2=exact_checks(bqco,g); tc1,tc2=exact_checks(btco,g)
    if worst is None or rho>worst: worst=rho
    if rho<1 and qc1 and qc2: verdict="RHO_PASS"; n_rho+=1
    elif bt<4224 and tc1 and tc2: verdict="T_PASS"; n_t+=1
    else: verdict="OPEN"; n_open+=1
    el=time.time()-t0
    print("%-4d %-20s %-12s %-13s %-3s %-3s %-3s %-3s  %-8s %.0fs"
          % (ci,str(ZZ(g[0])),mp.nstr(rho,7),mp.nstr(bt,8),qc1,qc2,tc1,tc2,verdict,el))
    sys.stdout.flush()
    wf.write("%d | %s | RHO | %s\n" % (ci,ZZ(g[0]),",".join(str(cc) for cc in bqco)))
    wf.write("%d | %s | T   | %s\n" % (ci,ZZ(g[0]),",".join(str(cc) for cc in btco)))
wf.close()
import statistics
print("SUMMARY: RHO_PASS %d / T_PASS %d / OPEN %d of 32   worst rho = %s   max rho = %s"
      % (n_rho,n_t,n_open,mp.nstr(worst,7),mp.nstr(max(rhos),7)))
print("R5 FULL32 DONE")
