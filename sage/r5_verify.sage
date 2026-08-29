# r5_verify - INTERVAL CERTIFICATION of r5 witnesses (RealBallField 256)  (2026-08-23)
# Separated from search per GPT r1 section 9. Input: r5_witnesses_l1000000321.txt.
# Per RHO witness: certify rho.upper() < 1 AND exists j: |y_j|.lower() > 0 (lambda != 0).
# Per T witness:   certify T.upper() < 4224 (and same nonvanishing).
# Membership was already exact (integer arithmetic) in r5 search; re-checked here too.
import sys
PREC=256
RBF=RealBallField(PREC)
l=1000000321
N=128; d=64
th=RBF.pi()/512
ks=[pow(3,i,512) for i in range(N)]
lam=[]
for k in ks:
    X=2*(2*k*th).cos()
    lam.append(((X+1)/(X-1)).abs().log())
L0=RBF(128).sqrt()*(RBF(2)+RBF(5).sqrt()).log()
F=GF(l); Rp=PolynomialRing(F,'y'); y=Rp.gen()
fac=[g for g,e in (y**64+1).factor()]
fac.sort(key=lambda g: ZZ(g[0]))
Zx=PolynomialRing(ZZ,'x'); x=Zx.gen()
def exact_checks(co,g):
    gz=sum(ZZ(cc)*x**k for k,cc in enumerate(g.list()))
    apoly=sum(co[k]*x**k for k in range(d))
    c1=not all(cc%l==0 for cc in co)
    c2=all(cc%l==0 for cc in ((gz*apoly)%(x**64+1)).coefficients())
    return c1 and c2
ncert_r=0; ncert_t=0; nfail=0
print("comp route  bound(upper)              nonzero_y  exact  verdict")
for line in open("r5_witnesses_l1000000321.txt"):
    if line.startswith("#"): continue
    parts=[p.strip() for p in line.split("|")]
    ci=int(parts[0]); route=parts[2]; co=[ZZ(int(t)) for t in parts[3].split(",")]
    g=fac[ci]
    ys=[sum(RBF(co[k])*lam[(k+j)%N] for k in range(d) if co[k])/l for j in range(N)]
    Q=sum(t*t for t in ys)
    nz=any(t.abs().lower()>0 for t in ys)
    ex=exact_checks(co,g)
    if route=="RHO":
        rho=Q.sqrt()/L0
        ok = rho.upper()<1 and nz and ex
        v="CERT_RHO" if ok else "FAIL"
        if ok: ncert_r+=1
        else: nfail+=1
        print("%-4d %-5s rho<=%-22s %-9s %-6s %s" % (ci,route,rho.upper(),nz,ex,v))
    else:
        T=sum((2*t).exp() for t in ys)
        ok = T.upper()<4224 and nz and ex
        v="CERT_T" if ok else "no_cert(T)"
        if ok: ncert_t+=1
        print("%-4d %-5s T<=%-24s %-9s %-6s %s" % (ci,route,T.upper(),nz,ex,v))
    sys.stdout.flush()
print("SUMMARY: CERT_RHO %d/32   CERT_T %d/32   RHO-FAIL %d" % (ncert_r,ncert_t,nfail))
print("R5 VERIFY DONE")
