# r4d - saturation diagnostics: (1) trivial-vector scale ht(eps_7)/L0,
# (2) Gaussian heuristic vs observed min for components 3, 23, 8, 28 (28 = worst rho).
import mpmath as mp
mp.mp.dps=40
n=7; N=128; d=64; MOD=512; th=mp.pi/MOD
ks=[pow(3,i,MOD) for i in range(N)]
lam=[]
for k in ks:
    X=2*mp.cos(2*mp.mpf(k)*th); lam.append(mp.log(abs((X+1)/(X-1))))
L0=mp.sqrt(N)*mp.log(2+mp.sqrt(5))
hteps=mp.sqrt(sum(t*t for t in lam))
print("(1) ht(eps_7) = %s   L0 = %s   ratio (rho of trivial l*e0) = %s"
      % (mp.nstr(hteps,10), mp.nstr(L0,10), mp.nstr(hteps/L0,10)))
SC=10**9
l=1000000321
F=GF(l); Rp=PolynomialRing(F,'y'); y=Rp.gen()
fac=[g for g,e in (y**64+1).factor()]
fac.sort(key=lambda g: ZZ(g[0]))
def center(c,ll):
    c%=ll
    return c-ll if c>ll//2 else c
obs={3:mp.mpf("1.0037295"),23:mp.mpf("1.0294313"),8:mp.mpf("1.0408261"),28:mp.mpf("1.125029")}
print("(2) Gaussian heuristic (in rho units) vs observed BKZ min:")
for ci in [3,23,8,28]:
    g=fac[ci]
    w=(y**64+1)//g; c=[ZZ(cc) for cc in w.list()]; c=c+[0]*(64-len(c))
    rows=[[l if i==j else 0 for j in range(d)] for i in range(d)]+[[center(cc,l) for cc in c]]
    M=matrix(ZZ,rows).hermite_form(include_zero_rows=False)
    emb=[]
    for i in range(M.nrows()):
        a=list(M.row(i))
        emb.append([SC*sum(mp.mpf(int(a[k]))*lam[(k+j)%N] for k in range(d) if a[k])/l for j in range(N)])
    G=[[sum(emb[i][j]*emb[k][j] for j in range(N)) for k in range(d)] for i in range(d)]
    detG=mp.det(mp.matrix(G))
    vol=mp.sqrt(abs(detG))          # covolume in scaled units
    gh=mp.sqrt(mp.mpf(d)/(2*mp.pi*mp.e))*vol**(mp.mpf(1)/d)/SC    # unscale
    print("  comp %-3d GH_rho = %s   observed = %s   obs/GH = %s"
          % (ci, mp.nstr(gh/L0,8), mp.nstr(obs[ci],8), mp.nstr(obs[ci]/(gh/L0),6)))
print("R4D DIAG DONE")
