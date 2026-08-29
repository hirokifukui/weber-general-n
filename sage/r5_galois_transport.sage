# r5_galois_transport - TEST: sigma_u (x -> x^u) maps the comp-28 best witness (rho=0.9387)
# onto every component with IDENTICAL Q. If 32/32 hit with equal rho, all component minima
# coincide and per-prime search cost drops 32x; flagship margin improves to <= 0.9387.
import mpmath as mp, sys
mp.mp.dps=40
N=128; d=64; MOD=512; th=mp.pi/MOD
ks=[pow(3,i,MOD) for i in range(N)]
lam=[mp.log(abs((2*mp.cos(2*mp.mpf(k)*th)+1)/(2*mp.cos(2*mp.mpf(k)*th)-1))) for k in ks]
L0=mp.sqrt(N)*mp.log(2+mp.sqrt(5))
l=1000000321
F=GF(l); Rp=PolynomialRing(F,'y'); y=Rp.gen()
fac=[g for g,e in (y**64+1).factor()]
fac.sort(key=lambda g: ZZ(g[0]))
Zx=PolynomialRing(ZZ,'x'); x=Zx.gen()
# load the best rho witness (comp 28, rho=0.938718) from r5 witness file
co=None
for line in open("r5_witnesses_l1000000321.txt"):
    if line.startswith("28 |") and "| RHO |" in line:
        co=[ZZ(int(t)) for t in line.split("|")[3].split(",")]
assert co is not None
def measure(cc):
    ys=[sum(mp.mpf(int(cc[k]))*lam[(k+j)%N] for k in range(d) if cc[k])/l for j in range(N)]
    return mp.sqrt(sum(t*t for t in ys))/L0
def member(cc,g):
    gz=sum(ZZ(t)*x**k for k,t in enumerate(g.list()))
    ap=sum(cc[k]*x**k for k in range(d))
    return (not all(t%l==0 for t in cc)) and all(t%l==0 for t in ((gz*ap)%(x**64+1)).coefficients())
rho0=measure(co)
print("source: comp 28  rho =",mp.nstr(rho0,8))
apoly=sum(co[k]*x**k for k in range(d))
hit={}
for u in range(1,128,2):
    im=apoly.subs(x=x**u) % (x**64+1)
    cc=[ZZ(t) for t in im.list()]; cc=cc+[0]*(64-len(cc))
    tgt=[ci for ci,g in enumerate(fac) if member(cc,g)]
    if len(tgt)==1:
        r=measure(cc)
        ci=tgt[0]
        if ci not in hit: hit[ci]=(u,mp.nstr(r,8))
print("components hit:",len(hit),"/ 32")
vals=set(v[1] for v in hit.values())
print("distinct transported rho values:",len(vals),"->",sorted(vals)[:3])
print("GALOIS TRANSPORT",("CONFIRMED" if len(hit)==32 and len(vals)==1 and list(vals)[0]==mp.nstr(rho0,8) else "PARTIAL/FAIL"))
