# ROUND 3 - true n=7 kill test. Classes {1,63,65,127} mod 128, log-scale primes.
# Lift lattice L = l*R + w*R (w = cofactor lift), metric Q(g)=sum_j y_j^2, y_j=(1/l)sum_i a_i lam_{i+j};
# judge by T = sum_j exp(2 y_j) over all 128 j (equals 2*sum cosh since j and j+64 pair);
# nonzero-component condition g mod l != 0. rho = sqrt(Q_min)/ (sqrt(128)*log(2+sqrt5)).
import mpmath as mp, sys
mp.mp.dps=30
n=7; N=128; d=64; MOD=512; th=mp.pi/MOD
ks=[pow(3,i,MOD) for i in range(N)]
lam=[]
for k in ks:
    X=2*mp.cos(2*mp.mpf(k)*th); lam.append(mp.log(abs((X+1)/(X-1))))
L0=mp.sqrt(N)*mp.log(2+mp.sqrt(5))
SC=10**7
def comps(l,cls):
    F=GF(l)
    if cls==1:
        z=F.multiplicative_generator(); r=z**((l-1)//128)
        roots=[r**(2*i+1) for i in range(8)]           # sample 8 of 64 linear comps
        return [( [ZZ((-rr)**(63-j)) for j in range(64)], 1) for rr in roots]
    else:
        R=PolynomialRing(F,'y'); y=R.gen()
        fac=[g for g,e in (y**64+1).factor()][:8]      # sample 8 of 32 quadratic comps
        out=[]
        for g in fac:
            w=(y**64+1)//g; c=[ZZ(cc) for cc in w.list()]
            out.append((c+[0]*(64-len(c)), g.degree()))
        return out
def center(c,l):
    c%=l
    return c-l if c>l//2 else c
def run(l,cls):
    best_all=[]
    for w,f in comps(l,cls):
        rows=[[l if i==j else 0 for j in range(d)] for i in range(d)]+[ [center(c,l) for c in w] ]
        M=matrix(ZZ,rows).hermite_form(include_zero_rows=False)
        emb=[]
        for i in range(M.nrows()):
            a=list(M.row(i))
            emb.append([int(mp.nint(SC*sum(mp.mpf(int(a[k]))*lam[(k+j)%N] for k in range(d) if a[k])/l)) for j in range(N)])
        B=matrix(ZZ,emb).LLL().BKZ(block_size=24)
        U=matrix(ZZ,emb).solve_left(B)                 # coefficient tracking
        bt=None; bq=None
        for i in range(B.nrows()):
            if B.row(i)==0: continue
            co=(U.row(i)*M)
            if all(ZZ(c)%l==0 for c in co): continue   # trivial part l*R: excluded
            ys=[mp.mpf(int(B[i,j]))/SC for j in range(N)]
            T=sum(mp.e**(2*y) for y in ys); Q=sum(y*y for y in ys)
            if bt is None or T<bt: bt,bq=T,Q
        best_all.append((bt,bq,f))
    mu=min(b[0] for b in best_all if b[0] is not None)
    worst=max(b[0] for b in best_all if b[0] is not None)
    rho=min(mp.sqrt(b[1]) for b in best_all if b[1] is not None)/L0
    return mu,worst,rho
def firstprime(lo,cls):
    p=next_prime(lo)
    while p%128!=cls: p=next_prime(p)
    return p
print("cls  scale   l                    f  muT(best)     worstT       rho")
sys.stdout.flush()
for cls,f,scales in [(1,1,[10**9,10**12,10**16,10**24,10**33]),
                     (63,2,[10**9,10**12,10**16]),
                     (65,2,[10**9,10**12,10**16]),
                     (127,2,[10**9,10**12,10**16])]:
    for s in scales:
        l=firstprime(s,cls)
        mu,worst,rho=run(l,cls)
        print("%-4d 1e%-4d %-20d %-2d %-13s %-12s %s"
              % (cls,len(str(s))-1,l,f,mp.nstr(mu,8),mp.nstr(worst,8),mp.nstr(rho,6)))
        sys.stdout.flush()
print("verdict bands: <4224 close | 4224-15000 L_sat | 15000-53376 hard | >53376 stop")
