# r10 bin 4: THIRD route to D_7 (and C_7) via Prop D(ii): D_n = 2^{m(n+1)/2+1} prod_{chi even, cond 2^{n+2}} |L(1,chi)|
# plus the closed form Cor A': C_n = 2 (4/pi)^{m/2} Gamma(2+m/2) prod|L(1,chi)| / log(2+sqrt5)^m, n = 2..7.
from sage.all import *
import time
pari.set_real_precision(60)
R = RealField(200); C_ = ComplexField(200)
print("[L-route] PARI real precision 60 digits")
res={}
for n in range(2,8):
    q=2**(n+2); m=2**(n-1); t0=time.time()
    Dg = DirichletGroup(q, CyclotomicField(2**n))
    chis=[ch for ch in Dg if ch.is_even() and ch.conductor()==q]
    assert len(chis)==m
    s=R(0); vals=[]
    for ch in chis:
        Lv = C_(ch.lfunction(algorithm='pari')(1))
        vals.append(Lv); s += log(abs(Lv))
    lnD = (R(m)*(n+1)/2+1)*log(R(2)) + s
    lnC = log(R(2)) + R(m)/2*log(4/R.pi()) + log(gamma(R(m)/2+2)) + s - m*log(log(2+sqrt(R(5))))
    res[n]=(lnD,lnC)
    print("n=%d  #chi=%d  sum ln|L(1,chi)| = %s   lnD_n(L-route) = %s   lnC_n(Cor A') = %s   C_n = %s   [%.1fs]" % (n,m,s.str(digits=30),lnD.str(digits=30),lnC.str(digits=30),exp(lnC).str(digits=12),time.time()-t0))
    if n==7:
        print("  n=7 reference: lnD_7 DET/SPEC/KY-rebuild = 177.783817017911485959589398831214 ; lnC_7 cert = 69.6241366950340814513293024675")
        print("  n=7 diff lnD = %s ; diff lnC = %s" % ((lnD-R('177.783817017911485959589398831214')).str(digits=4),(lnC-R('69.6241366950340814513293024675')).str(digits=4)))
        # per-character sanity: chi(3) primitive 2^n-th root; product |1-chi(3)| = 2
        p=R(1)
        for ch in chis: p *= abs(C_(ch(3))-1)
        print("  prod_chi |1-chi(3)| = %s (must be 2)" % p.str(digits=20))
        # dump the 64 values for the Magma cross-check
        with open("r10_bin4_L1_n7_sage.txt","w") as fh:
            for ch,Lv in zip(chis,vals):
                fh.write("%s %s\n" % (ch.values_on_gens()[0], abs(Lv).str(digits=40)) if False else "%s\n" % abs(Lv).str(digits=40))
print("R10 BIN4 LVALUE DONE")
print("[L-route, n=7, prec=200 bits]")
n=7; q=512; m=64
Dg = DirichletGroup(q, CyclotomicField(128)); chis=[ch for ch in Dg if ch.is_even() and ch.conductor()==q]
s=R(0)
for ch in chis:
    Lv = C_(ch.lfunction(prec=200, algorithm='pari')(1)); s += log(abs(Lv))
lnD = (R(m)*(n+1)/2+1)*log(R(2)) + s
print("  lnD_7 (L-route, 200 bits) = %s ; diff vs DET = %s" % (lnD.str(digits=45), (lnD-R('177.783817017911485959589398831214116568163939126')).str(digits=4)))
print("R10 BIN4 LVALUE HIPREC DONE")
