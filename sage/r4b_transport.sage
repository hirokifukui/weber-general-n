# r4b - INVERSE-PAIRING TABLE + WITNESS TRANSPORT TEST (2026-08-23)
# Pairing rule [MC exact]: components pair by c*c' = 1 mod l (roots r <-> r^-1).
# Transport map candidate: phi(a)(x) = a(x^-1) = a(-x^63) mod (x^64+1)  (+ any unit x^k shift).
# Validation: transported vector re-passes EXACT membership in the partner component,
# and its rho/T are recomputed from scratch. No general isometry theorem is assumed.
import mpmath as mp, sys
mp.mp.dps=40
n=7; N=128; d=64; MOD=512; th=mp.pi/MOD
ks=[pow(3,i,MOD) for i in range(N)]
lam=[]
for k in ks:
    X=2*mp.cos(2*mp.mpf(k)*th); lam.append(mp.log(abs((X+1)/(X-1))))
L0=mp.sqrt(N)*mp.log(2+mp.sqrt(5))
l=1000000321
F=GF(l); Rp=PolynomialRing(F,'y'); y=Rp.gen()
fac=[g for g,e in (y**64+1).factor()]
fac.sort(key=lambda g: ZZ(g[0]))
cvals=[ZZ(g[0]) for g in fac]
Zx=PolynomialRing(ZZ,'x'); x=Zx.gen()
# full inverse pairing
inv_of={}
for i,ci in enumerate(cvals):
    cinv=ZZ(F(ci)**(-1))
    j=cvals.index(cinv)
    inv_of[i]=j
print("full inverse pairing (i <-> j):")
seen=set(); pairlist=[]
for i in range(32):
    j=inv_of[i]
    if i not in seen:
        seen.add(i); seen.add(j); pairlist.append((i,j))
        print("  (%d, %d)   c=%d <-> c=%d" % (i,j,cvals[i],cvals[j]))
print("n_pairs = %d (self-paired: %s)" % (len(pairlist), [p for p in pairlist if p[0]==p[1]]))
sys.stdout.flush()
# load witnesses
wit={}
for line in open("r4_witnesses_l1000000321.txt"):
    if line.startswith("#"): continue
    parts=[p.strip() for p in line.split("|")]
    ci=int(parts[0]); route=parts[2]; co=[ZZ(int(t)) for t in parts[3].split(",")]
    wit[(ci,route)]=co
def yvec(co):
    return [sum(mp.mpf(int(co[k]))*lam[(k+j)%N] for k in range(d) if co[k])/l for j in range(N)]
def measures(co):
    ys=yvec(co); Q=sum(t*t for t in ys); T=sum(mp.e**(2*t) for t in ys)
    return mp.sqrt(Q)/L0, T
def transport(co):
    apoly=sum(co[k]*x**k for k in range(d))
    b=apoly.subs(x=-x**63) % (x**64+1)
    bc=[ZZ(cc) for cc in b.list()]; bc=bc+[0]*(64-len(bc))
    return bc
def memcheck(co,ci):
    g=fac[ci]; gz=sum(ZZ(cc)*x**k for k,cc in enumerate(g.list()))
    apoly=sum(co[k]*x**k for k in range(d))
    c1 = not all(cc%l==0 for cc in co)
    c2 = all(cc%l==0 for cc in ((gz*apoly)%(x**64+1)).coefficients())
    return c1,c2
# TEST 1: transport RHO witness 7 -> 19
print("TEST 1: rho witness comp 7 -> comp %d" % inv_of[7])
b=transport(wit[(7,"RHO")])
c1,c2=memcheck(b,inv_of[7]); r,t=measures(b)
print("  membership in partner: chk1=%s chk2=%s   rho=%s  T=%s" % (c1,c2,mp.nstr(r,9),mp.nstr(t,8)))
# TEST 2/3/4: transport T witnesses 14->13, 31->21, 9->partner
for src in [14,31,9]:
    dst=inv_of[src]
    b=transport(wit[(src,"T")])
    c1,c2=memcheck(b,dst); r,t=measures(b)
    print("T witness %d -> %d : chk1=%s chk2=%s  rho=%s  T=%s  (source T route)"
          % (src,dst,c1,c2,mp.nstr(r,9),mp.nstr(t,8)))
    if c1 and c2 and t<4224:
        wf=open("r4_witnesses_l1000000321.txt","a")
        wf.write("%d | %s | Ttr | %s\n" % (dst,cvals[dst],",".join(str(cc) for cc in b)))
        wf.close()
print("R4B TRANSPORT DONE")
