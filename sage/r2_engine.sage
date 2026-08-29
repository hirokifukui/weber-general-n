# ROUND 2 - component lift engine + exact reproduction of KY's published tables.
# T~r((g.eps)^2) = sum_{j=0}^{2^n-1} exp( (2/l) sum_i a_i lam_{i+j} ),  lam_i = log|sigma^i(eps_n)|,
# sigma = g3 (KY generator).  Calibration BEFORE any new number.
import mpmath as mp
mp.mp.dps=35
def lam_eps(n):
    MOD=2**(n+2); N=2**n; th=mp.pi/MOD
    ks=[pow(3,i,MOD) for i in range(N)]
    out=[]
    for k in ks:
        X=2*mp.cos(2*mp.mpf(k)*th)
        out.append(mp.log(abs((X+1)/(X-1))))
    return out
def Ttr(n,l,coeffs,lam):
    N=2**n
    tot=mp.mpf(0)
    for j in range(N):
        e=mp.mpf(0)
        for i,a in enumerate(coeffs):
            if a: e+=a*lam[(i+j)%N]
        tot+=mp.e**(2*e/l)
    return tot
def center(c,l):
    c%=l
    return c-l if c>l//2 else c
print("== n=4, l=3 (KY: 95.6..., 100.1...) ==")
lam4=lam_eps(4)
g1=[-1,0,-1,0,1]; g2=[-1,0,1,0,1]
print("  g1: %s   g2: %s" % (mp.nstr(Ttr(4,3,g1,lam4),7), mp.nstr(Ttr(4,3,g2,lam4),7)))
print("== n=4, l=7 (KY: 106.5, 546.9, 840.6, 160.2 ; g3' -> 200.7) ==")
gs={1:[-1,-1,-2,-3,2,-1,1],2:[-1,-3,-3,2,3,-3,1],3:[-1,3,-3,-2,3,3,1],4:[-1,1,-2,3,2,1,1],
    35:[-2,-1,1,3,-1,-1,2]}
for k in [1,2,3,4,35]:
    print("  g%s: %s" % (k, mp.nstr(Ttr(4,7,gs[k],lam4),7)))
print("== n=5, l=97 (KY: g1(center,4x)->1123.9 ; g10 -> 920.6 ; g15 -> 2985.0) ==")
lam5=lam_eps(5)
# center lift of 4*(x^16+1)/(x+19): cofactor sum_j (-a)^{15-j} x^j, a=19
a=19; co=[center(4*pow(-a,15-j,97),97) for j in range(16)]
print("  g1 : %s" % mp.nstr(Ttr(5,97,co,lam5),8))
g10=[-41,-16,-37,-31,-5,-54,-40,-44,-29,36,-38,-3,-13,-24,-7,2]
g15=[29,16,-38,-31,-84,-43,-7,-44,-41,-36,37,-3,-5,24,40,2]
print("  g10: %s   g15: %s" % (mp.nstr(Ttr(5,97,g10,lam5),8), mp.nstr(Ttr(5,97,g15,lam5),8)))
print("== n=7, l=1000000321 = 65 mod 128 (KY: t1..t32, e.g. t1=24947.7 t2=15616.7 t19=52445.8) ==")
lam7=lam_eps(7)
l=1000000321
A=[30063488,30912022,42483948,59955883,78186285,160612070,191346380,246360387,268629094,
   269645956,280492327,303644312,311722386,424439170,441230693,447503416]
A=A+[(-A[16-i]) % l for i in range(1,17)]
B=[231,231,867,125,386,231,100,100,64,36,702,771,231,2069,349,64,
   64,64,4,64,686,105,167,64,100,89,100,100,100,100,100,64]
ok=0; res=[]
for i in range(32):
    a=A[i]%l
    co=[0]*64
    for j in range(32):
        co[2*j]=center(B[i]*pow(-a,31-j,l),l)
    t=Ttr(7,l,co,lam7)
    res.append(t)
print("  t1=%s t2=%s t3=%s t19=%s t31=%s t32=%s"
      % tuple(mp.nstr(res[i],9) for i in [0,1,2,18,30,31]))
print("  all 32 below 53376? %s ; min=%s max=%s"
      % (all(t<53376 for t in res), mp.nstr(min(res),8), mp.nstr(max(res),8)))
