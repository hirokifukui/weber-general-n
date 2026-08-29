# r3b - DAGGER VERIFICATION (2026-08-23)
# (a) Nr_{n/n-1}(eta_n) = -1 numerically, n=3..7  [MO section 3.3 asserts without proof]
#     using bridge (ii): sigma^j(eta) = (-1)^j tan(3^j theta); tau = sigma^(2^(n-1)), even j => sign +.
# (b) rederive cls65 l=1000000321 rho with WITNESS extraction + EXACT membership checks:
#     chk1: a not in l*R (some coeff nonzero mod l)   chk2: f*a = 0 in F_l[x]/(x^64+1)  (a in M_f)
#     chk3: antisymmetry y_{j+64} = -y_j  (structural: Nr(eps)=1)
#     chk4: max|y_j| well away from 0  (needed: eta^{(1-z)a} not in E_{n-1})
# height convention: ht(eta^{(1-z)a}) = l*sqrt(Q), threshold l*sqrt(128)*log(2+sqrt5); rho = sqrt(Q)/L0.
import mpmath as mp, sys
mp.mp.dps=40
print("(a) relative norms eta_n * tau(eta_n):")
for n in [3,4,5,6,7]:
    MODn=2**(n+2); thn=mp.pi/MODn; half=2**(n-1)
    t=pow(3,half,MODn)
    v=mp.tan(thn)*mp.tan(mp.mpf(t)*thn)   # (-1)^half = +1, half even
    print("  n=%d  3^(2^(n-1)) mod 2^(n+2) = %d   Nr = %s" % (n,t,mp.nstr(v,25)))
sys.stdout.flush()
print("(b) cls 65, l=1000000321, 8 sampled components, witness extraction:")
n=7; N=128; d=64; MOD=512; th=mp.pi/MOD
ks=[pow(3,i,MOD) for i in range(N)]
lam=[]
for k in ks:
    X=2*mp.cos(2*mp.mpf(k)*th); lam.append(mp.log(abs((X+1)/(X-1))))
L0=mp.sqrt(N)*mp.log(2+mp.sqrt(5))
SC=10**7
l=1000000321
F=GF(l); Rp=PolynomialRing(F,'y'); y=Rp.gen()
fac=[g for g,e in (y**64+1).factor()][:8]
Zx=PolynomialRing(ZZ,'x'); x=Zx.gen()
def center(c,ll):
    c%=ll
    return c-ll if c>ll//2 else c
best=(None,)*5
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
    for i in range(B.nrows()):
        if B.row(i)==0: continue
        co=(U.row(i)*M)
        if all(ZZ(cc)%l==0 for cc in co): continue
        ys=[sum(mp.mpf(int(co[k]))*lam[(k+j)%N] for k in range(d) if co[k])/l for j in range(N)]
        Q=sum(t2*t2 for t2 in ys)
        if best[0] is None or Q<best[0]: best=(Q,ci,g,[ZZ(cc) for cc in co],ys)
Q,ci,g,co,ys=best
rho=mp.sqrt(Q)/L0
print("  best component index %d   f = %s" % (ci,g))
print("  rho = %s   (r3 logged 0.989279)" % mp.nstr(rho,10))
print("  ht(eta^((1-z)a)) = l*sqrt(Q) = %s   threshold l*sqrt(128)*log(2+sqrt5) = %s"
      % (mp.nstr(l*mp.sqrt(Q),12), mp.nstr(l*L0,12)))
apoly=sum(co[k]*x**k for k in range(d))
gz=sum(ZZ(cc)*x**k for k,cc in enumerate(g.list()))
chk1 = not all(cc%l==0 for cc in co)
prod=(gz*apoly) % (x**64+1)
chk2 = all(cc%l==0 for cc in prod.coefficients())
anti=max(abs(ys[j+64]+ys[j]) for j in range(64))
ymax=max(abs(t2) for t2 in ys); ymin_nz=ymax  # report scale
print("  chk1 (a not in l*R): %s" % chk1)
print("  chk2 (f*a = 0 mod (l, x^64+1), i.e. a in M_f): %s" % chk2)
print("  chk3 antisymmetry max|y_{j+64}+y_j| = %s" % mp.nstr(anti,5))
print("  chk4 max|y_j| = %s  (must be provably nonzero for the E_{n-1} exclusion)" % mp.nstr(ymax,10))
print("  witness coeffs (first 16): %s" % co[:16])
print("  witness coeffs (last 48 nonzero count): %d of 64" % sum(1 for cc in co if cc!=0))
print("R3B DAGGER CHECK DONE")
