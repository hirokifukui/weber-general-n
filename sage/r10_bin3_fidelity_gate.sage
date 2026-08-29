# r10 bin 3: statement-fidelity gate for Theorem A / Proposition D_n (all from KY definitions).
# Sections: [S1] D_n two routes n=2..7 + C_n table + n=7 thresholds
#           [S2] Blichfeldt orientation + Lemma C/D covolume identity on ACTUAL lattices (n=3,4)
#           [S3] planted negative controls for S2
#           [S4] (bin-4 preliminary) L(1,chi) closed form for D_n at n=2..5
from sage.all import *
R = RealField(300); C_ = ComplexField(300)
pari.set_real_precision(120)
def lams(n):
    M = 2**(n+2); N = 2**n
    out=[]
    for j in range(N):
        X = 2*R(cos(R(pow(3,j,M))*2*R.pi()/M))
        out.append(log(abs((X+1)/(X-1))))
    return out
def Hmat(n):
    N=2**n; m=2**(n-1); L=lams(n)
    return matrix(R, N, m, lambda j,i: L[(i+j)%N]), L
def lnD_gram(n):
    H,_ = Hmat(n); G = H.transpose()*H
    return log(G.det())/2
def lnD_char(n):
    N=2**n; m=2**(n-1); L=lams(n)
    s = -R(m)/2*log(R(2))
    for r in range(m):
        w = C_(exp(2*C_.pi()*C_(0,1)*(2*r+1)/N))
        s += log(abs(sum(L[j]*w**j for j in range(N))))
    return s
def lnC(n, lnD):
    m=2**(n-1); L7 = sqrt(R(2)**n)*log(2+sqrt(R(5)))
    return R(m)/2*log(2/R.pi()) + log(gamma(R(m+2)/2+1)) + lnD - m*log(L7)
print("[S1] D_n two routes and C_n")
lnDs={}
for n in range(2,8):
    a=lnD_gram(n); b=lnD_char(n); lnDs[n]=a
    c=lnC(n,a)
    print("n=%d m=%d lnD gram=%s char=%s |diff|=%s  lnC=%s  C_n=%s" % (n,2**(n-1),a.str(digits=25),b.str(digits=25),(a-b).abs().str(digits=3),c.str(digits=20),exp(c).str(digits=8)))
c7 = exp(lnC(7,lnDs[7]))
print("n=7 thresholds: deg-1 C_7 = %s (cert 1.7273421630363529579743e30); deg-2 sqrt(C_7) = %s (cert 1.314283897427172e15)" % (c7.str(digits=20), sqrt(c7).str(digits=16)))
print("ord_128 table: " + ", ".join("%d->%d"%(c, Mod(c,128).multiplicative_order()) for c in [1,63,65,127,3,5,31,33,97]))

print("[S2] Blichfeldt orientation and covolume identity on actual saturation lattices")
def Lf_basis(n,l,f,F):
    # L_f = preimage of M_f = w*F_l[x]/(F), w = F/f; basis over Z: lifts of w*x^i (i<deg f) plus l*e_i
    m=2**(n-1)
    Fl = GF(l); Rl = PolynomialRing(Fl,'x'); x = Rl.gen()
    w = (F//f)
    rows=[]
    for i in range(f.degree()):
        p = (w*x**i) % F
        rows.append([ZZ(p[k]) for k in range(m)])
    for i in range(m):
        rows.append([l if k==i else 0 for k in range(m)])
    B = matrix(ZZ, rows).hermite_form(include_zero_rows=False)
    return B
def blich_bound(n, d, lnD):
    m=2**(n-1)
    return (2/R.pi()) * gamma(R(m+2)/2+1)**(R(2)/m) * exp((lnD - d*log(R(l_)))*R(2)/m)
for n,ls in [(3,[3,5,7,17,97]),(4,[3,5,7,17,97,257])]:
    m=2**(n-1); H,L = Hmat(n)
    for l_ in ls:
        Fl=GF(l_); Rl=PolynomialRing(Fl,'x'); x=Rl.gen(); F = x**m+1
        facs = [f for f,e in F.factor()]
        degs = set(f.degree() for f in facs)
        assert len(degs)==1 and list(degs)[0]==Mod(l_,2**n).multiplicative_order(), "Lemma B fails"
        d = list(degs)[0]
        for f in facs[:2]:
            B = Lf_basis(n,l_,f,F)
            assert abs(B.det()) == l_**(m-d), "Lemma C index fails"
            V = (B.change_ring(R) * H.transpose()) / l_      # rows = (1/l) H a for basis a
            G = V*V.transpose()
            lncov = log(G.det())/2
            target = lnDs[n] - d*log(R(l_))
            Gq = G * 10**15
            GZ = matrix(ZZ, m, m, lambda i,j: (Gq[i,j]).round())
            bd = (2/R.pi()) * gamma(R(m+2)/2+1)**(R(2)/m) * exp(target*R(2)/m)
            Bsc = ZZ((bd*10**15).ceil())
            U = GZ.LLL_gram(); GZ = U.transpose()*GZ*U   # LLL-reduce the Gram first (same lattice, same minima)
            mn = pari(GZ).qfminim(Bsc, None, 2)      # flag 2 (flag 0 raises 'precision too low' on these Grams); all v with v^T GZ v <= Bsc
            cnt = ZZ(mn[0])
            vecs = [vector(ZZ, [ZZ(mn[2][i,c]) for i in range(m)]) for c in range(mn[2].ncols())]
            minsq = min(R(v*GZ*v) for v in vecs)/10**15 if vecs else R('inf')
            ok = cnt > 0 and minsq <= bd            # Blichfeldt: a nonzero v with |v|^2 <= bound must exist
            print("n=%d l=%d f=%s d=%d  |lncov-(lnD-d ln l)|=%s  min|v|^2=%s  Blichfeldt bound=%s  min<=bound:%s ratio=%s" % (n,l_,f,d,(lncov-target).abs().str(digits=3), minsq.str(digits=10), bd.str(digits=10), ok, (minsq/bd).str(digits=5)))
            assert (lncov-target).abs() < 1e-40 and ok

print("[S3] planted negative controls")
n=3; m=4; H,L=Hmat(3); l_=17
Fl=GF(l_); Rl=PolynomialRing(Fl,'x'); x=Rl.gen(); F=x**m+1; f=[g for g,e in F.factor()][0]; d=f.degree()
B=Lf_basis(n,l_,f,F)
V=(B.change_ring(R)*H.transpose())/l_; G=V*V.transpose(); lncov=log(G.det())/2
wrong1 = lnDs[3] - (m-d)*log(R(l_))     # index/cofactor confusion
wrong2 = lnDs[3]                         # forgot the 1/l scaling
wrong3 = lnDs[3] - d*log(R(l_)) - R(m)/2*log(R(2))  # dropped the 2^{m/2} of Lemma D(iii)
for name,w in [("index m-d instead of d",wrong1),("no 1/l^d",wrong2),("dropped 2^{m/2}",wrong3)]:
    print("  control '%s': |lncov - wrong| = %s (must be >> 0) -> %s" % (name,(lncov-w).abs().str(digits=4),"REJECTED" if (lncov-w).abs()>1e-3 else "NOT REJECTED"))

print("[S4a] eps_n = (1-z^3)^2 (1-z^2) / ((1-z)^2 (1-z^6)), z = zeta_{2^{n+2}} : numeric check")
for n in range(2,8):
    M=2**(n+2); z = C_(exp(2*C_.pi()*C_(0,1)/M)); X = 2*(z.real())
    lhs = (X+1)/(X-1); rhs = ((1-z**3)**2*(1-z**2)/((1-z)**2*(1-z**6)))
    print("  n=%d |lhs-rhs| = %s" % (n, abs(lhs-rhs).str(digits=3)))
print("[S4] bin-4 preliminary: D_n = 2^{m(n+1)/2+1} prod_{chi cond=2^{n+2}, even} |L(1,chi)| ?")
for n in range(2,6):
    q=2**(n+2); m=2**(n-1)
    Dg = DirichletGroup(q, CyclotomicField(2**n))
    chis=[ch for ch in Dg if ch.is_even() and ch.conductor()==q]
    assert len(chis)==m
    s=R(0)
    for ch in chis:
        Lv = C_(ch.lfunction(algorithm='pari')(1))
        s += log(abs(Lv))
    pred = (R(m)*(n+1)/2+1)*log(R(2)) + s   # corrected: per-character |1-chi(3)| sqrt(f) |L(1,chi)| (no extra 2)
    print("n=%d #chi=%d  lnD gram=%s  closed form=%s  diff=%s" % (n,len(chis),lnDs[n].str(digits=25),pred.str(digits=25),(lnDs[n]-pred).str(digits=4)))
print("R10 BIN3 FIDELITY GATE DONE")
