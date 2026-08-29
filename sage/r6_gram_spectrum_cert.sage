# r6_gram_spectrum_cert - P1-5: certified negacyclic spectrum of the 64-dim coefficient Gram.
# G = H^T H = 2 A^T A is symmetric NEGACIRCULANT: G[i][k] = C(i-k) with the 128-periodic
# autocorrelation C, which is ANTI-periodic (C(t+64) = -C(t)) by lambda anti-periodicity.
# Hence eigenvectors v_r = (omega_r^i), omega_r = zeta_128^{2r+1} (ODD 128th roots), and
# eigenvalues mu_r = sum_{u=0}^{63} C(u) * conj(omega_r)^u (window-independent because
# C(u) omega^{-u} is 64-periodic). All computed in ball arithmetic; positivity certified.
import sys
P=512
RBF=RealBallField(P); CBF=ComplexBallField(P)
N=128; d=64; MOD=512
th=RBF.pi()/MOD
ks=[pow(3,i,MOD) for i in range(N)]
lam=[]
for k in ks:
    X=2*(2*k*th).cos()
    lam.append(((X+1)/(X-1)).abs().log())
C=[sum(lam[m]*lam[(m+t)%N] for m in range(N)) for t in range(N)]
apC=max((C[t]+C[(t+64)%N]).abs().upper() for t in range(N))
I=CBF.gens()[0]
mus=[]
for r in range(d):
    om=( -I*RBF.pi()*(2*r+1)/64 ).exp()   # conj(omega_r) = e^{-i pi (2r+1)/64}
    mu=sum(CBF(C[u])*om**u for u in range(d))
    assert mu.imag().contains_zero(), "eigenvalue not certified real"
    mus.append(mu.real())
allpos=all(m.lower()>0 for m in mus)
los=sorted(m.lower() for m in mus); his=sorted(m.upper() for m in mus)
mn=min(mus,key=lambda m:m.upper()); mx=max(mus,key=lambda m:m.lower())
tr=sum(mus); trchk=(tr-64*C[0]).abs().upper()
print("C anti-periodicity defect <=",apC)
print("all 64 eigenvalues certified real and positive:",allpos)
print("min eigenvalue in [%s, %s]"%(mn.lower(),mn.upper()))
print("max eigenvalue in [%s, %s]"%(mx.lower(),mx.upper()))
kap=(mx/mn)
print("condition number kappa in [%s, %s]"%(kap.lower(),kap.upper()))
print("trace check |sum mu - 64*C(0)| <=",trchk)
print("halved (A^T A) spectrum for comparison with reviewer: min/2 = %s, max/2 = %s"%((mn/2).mid(),(mx/2).mid()))
print("R6 GRAM SPECTRUM CERT DONE")
