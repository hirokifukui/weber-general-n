# r6_flagship_replay - P1-3/P1-4: index-free replay of all 64 flagship certificates.
# Each component is identified by its irreducible polynomial f (not by enumeration order).
# Per witness: f, w, witness coeffs, exact integer membership f*a = 0 mod (l, x^64+1),
# nonzero residue (a not in lR), certified nonzero log-coordinate, interval bounds
# (RealBallField 256) for rho and T. One certificate file per (f, route) in
# certificates/flagship/. Environment in environment/.
import sys, os
PREC=256
RBF=RealBallField(PREC)
l=1000000321
N=128; d=64; MOD=512
th=RBF.pi()/MOD
ks=[pow(3,i,MOD) for i in range(N)]
lam=[]
for k in ks:
    X=2*(2*k*th).cos()
    lam.append(((X+1)/(X-1)).abs().log())
L7=RBF(128).sqrt()*(RBF(2)+RBF(5).sqrt()).log()
F=GF(l); Rp=PolynomialRing(F,'y'); y=Rp.gen()
fac=[g for g,e in (y**64+1).factor()]
fac.sort(key=lambda g: ZZ(g[0]))
Zx=PolynomialRing(ZZ,'x'); x=Zx.gen()
outdir="../certificates/flagship"
ncert=0; nfail=0
for line in open("r5_witnesses_l1000000321.txt"):
    if line.startswith("#"): continue
    parts=[p.strip() for p in line.split("|")]
    ci=int(parts[0]); route=parts[2]; co=[ZZ(int(t)) for t in parts[3].split(",")]
    g=fac[ci]
    a_const=ZZ(g[0])   # f = x^2 + a_const : the index-free identifier
    gz=sum(ZZ(cc)*x**k for k,cc in enumerate(g.list()))
    apoly=sum(co[k]*x**k for k in range(d))
    mem=all(cc%l==0 for cc in ((gz*apoly)%(x**64+1)).coefficients())
    nz=not all(cc%l==0 for cc in co)
    ys=[sum(RBF(co[k])*lam[(k+j)%N] for k in range(d) if co[k])/l for j in range(N)]
    ynz=any(t.abs().lower()>0 for t in ys)
    Q=sum(t*t for t in ys); rho=Q.sqrt()/L7
    T=sum((2*t).exp() for t in ys)
    if route=="RHO": ok=mem and nz and ynz and (rho.upper()<1)
    else: ok=mem and nz and ynz and (T.upper()<4224)
    v="CERT" if ok else "FAIL"
    if ok: ncert+=1
    else: nfail+=1
    fn="%s/cert_f_x2p%s_%s.txt"%(outdir,a_const,route)
    with open(fn,"w") as fh:
        fh.write("l = %d\nf = x^2 + %s  (irreducible mod l; index-free identifier)\n"%(l,a_const))
        fh.write("w = (x^64+1)/f in F_l[x]\nroute = %s\n"%route)
        fh.write("witness coefficients (a_0..a_63) =\n%s\n"%(",".join(str(c) for c in co)))
        fh.write("exact membership f*a = 0 mod (l, x^64+1): %s\n"%mem)
        fh.write("a not in l*R (some coeff nonzero mod l): %s\n"%nz)
        fh.write("some log-coordinate certified nonzero: %s\n"%ynz)
        fh.write("rho upper bound (RBF %d) = %s\n"%(PREC,rho.upper()))
        fh.write("T   upper bound (RBF %d) = %s\n"%(PREC,T.upper()))
        fh.write("verdict: %s\n"%v)
    print("f = x^2+%-12s %-4s mem=%s nz=%s ynz=%s  rho<=%.6f T<=%.1f  %s"%(a_const,route,mem,nz,ynz,float(rho.upper()),float(T.upper()),v))
    sys.stdout.flush()
print("REPLAY SUMMARY: CERT %d / FAIL %d of 64"%(ncert,nfail))
print("R6 FLAGSHIP REPLAY DONE")
