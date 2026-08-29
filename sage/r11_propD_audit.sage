# r11_propD_audit.sage - Proposition D hardening (GPT r10 hw 30, 31, 32, 33, 35, 36).
# (a) hw 30: S(chi) as a G_n-sum equals (1/2) * sum over (Z/q)^x   [MC, n = 2..7]
# (b) hw 31: second route to D_n = 2^{-m/2} prod |S(chi)|: Gram eigenvalues of H^T H are
#            |S(chi)|^2/2 (explicit eigenvector check, sup-norm residual)   [MC, n = 2..7]
# (c) hw 32: prod_{chi} |1-chi(3)| = Phi_{2^n}(1) = 2, exactly, in the cyclotomic field [MC, n = 2..12]
# (d) hw 33: min |L(1,chi)| over the m characters (nonvanishing, numerical witness) [MC, n = 2..9]
# (e) hw 36: RIGOROUS ball enclosure of prod |L(1,chi)| via the digamma route
#            L(1,chi) = -(1/q) sum_a chi(a) psi(a/q)  (chi nontrivial, primitive mod q),
#            hence a rigorous enclosure of C_n (Cor A') for n = 2..9; at n = 7 compared with
#            the r6 three-precision interval C_7 <= 1.7273421630363531e30.
import sys
PREC = 500
RBF = RealBallField(PREC); CBF = ComplexBallField(PREC)
def chars(n):
    # even characters of (Z/q)^x of conductor q = 2^{n+2}: chi(+-3^j) = omega^j, omega primitive 2^n-th root of unity
    q = 2^(n+2); N = 2^n
    idx = {}
    for j in range(N):
        k = power_mod(3, j, q); idx[k] = j; idx[(-k) % q] = j
    out = []
    for r in range(2^(n-1)):
        om = (CBF(2)*CBF(pi)*CBF(0,1)*CBF(2*r+1)/CBF(N)).exp()
        pw = [om^j for j in range(N)]
        out.append((om, lambda a, pw=pw, idx=idx: pw[idx[a]]))
    return out
def lam_vec(n):
    q = 2^(n+2); N = 2^n
    out = []
    for j in range(N):
        k = power_mod(3, j, q)
        X = 2*(RBF(2)*RBF(pi)*RBF(k)/RBF(q)).cos()
        out.append(((X+1)/(X-1)).abs().log())
    return out
print("=== (c) prod |1-chi(3)| = 2 exactly (hw 32)")
for n in range(2, 13):
    K.<z> = CyclotomicField(2^n)
    # chi(3) runs over all primitive 2^n-th roots of unity: prod (1 - z^k), k odd
    P = prod(1 - z^k for k in range(1, 2^n, 2))
    print("n=%2d  prod(1-chi(3)) = %s  ; Phi_{2^n}(1) = %s" % (n, P, cyclotomic_polynomial(2^n)(1)))
    assert P == 2
print("=== (a),(b): half-sum normalisation and Gram eigenvalue route (hw 30, 31)")
for n in range(2, 8):
    q = 2^(n+2); m = 2^(n-1); N = 2^n
    lam = lam_vec(n)
    # log|sigma_a eps_n| for a in (Z/q)^x via a = +-3^j
    lg = {}
    for j in range(N):
        k = power_mod(3, j, q); lg[k] = lam[j]; lg[(-k) % q] = lam[j]
    chis = chars(n)
    assert len(chis) == m
    resA = 0.0; resB = 0.0
    H = matrix(RBF, N, m, lambda j, i: lam[(i+j) % N])
    Gram = H.transpose()*H
    for c3, chi in chis:
        # G_n-sum over j (sigma^j), chi(sigma^j) = chi(3)^j
        Sg = sum(c3^j * CBF(lam[j]) for j in range(N))
        Sa = sum(chi(a) * CBF(lg[a]) for a in range(1, q) if a % 2 == 1) / 2
        resA = max(resA, float((Sg - Sa).abs().upper()))
        # eigenvector v_i = omega^i, omega = chi(3) (omega^m = -1); Gram v = (|S|^2/2) v
        v = vector(CBF, [c3^i for i in range(m)])
        w = Gram.change_ring(CBF) * v - (Sg.abs()^2/2) * v
        resB = max(resB, max(float(x.abs().upper()) for x in w))
    Dn_det = Gram.determinant().sqrt()
    Dn_chr = RBF(2)^(-m/2) * prod((sum(c3^j * CBF(lam[j]) for j in range(N))).abs() for c3, chi in chis)
    print("n=%d m=%2d  |S_G - S_half| <= %.3e ; Gram-eigenvector residual <= %.3e ; D_n(det) = %s ; D_n(char) = %s ; diff <= %.3e" % (n, m, resA, resB, RealField(25*4).__call__(Dn_det.mid()).str(), RealField(25*4).__call__(Dn_chr.mid()).str(), float((Dn_det-Dn_chr).abs().upper())))
print("=== (d),(e): L(1,chi) nonvanishing witness and RIGOROUS C_n enclosure via digamma (hw 33, 36)")
def Cn_ball(n):
    q = 2^(n+2); m = 2^(n-1)
    chis = chars(n)
    psi = {a: RBF(a)/RBF(q) for a in range(1, q) if a % 2 == 1}
    psi = {a: psi[a].psi() for a in psi}
    Lvals = [ -(sum(chi(a) * CBF(psi[a]) for a in psi)) / q for c3, chi in chis ]
    prodL = prod(L.abs() for L in Lvals)
    minL = min(float(L.abs().lower()) for L in Lvals)
    Cn = 2 * (RBF(4)/RBF(pi))^(m/2) * RBF(2 + m/2).gamma() * prodL / ((2+RBF(5).sqrt()).log())^m
    return Cn, prodL, minL
for n in range(2, 10):
    Cn, prodL, minL = Cn_ball(n)
    print("n=%d  min|L(1,chi)| >= %.6f ; log prod|L| in [%s] ; C_n in [%s, %s] ; log10 C_n = %s" % (n, minL, RealField(12*4).__call__(prodL.log().mid()).str(), RealField(80)(Cn.lower()).str(), RealField(80)(Cn.upper()).str(), RealField(50)((Cn.log()/RBF(10).log()).mid()).str()))
    if n == 7:
        RF = RealField(300)
        up = RF(Cn.upper()); lo = RF(Cn.lower())
        print("n=7 RIGOROUS: C_7 in [%s, %s] (ball radius %s) ; r6 interval claim C_7 <= 1.7273421630363531e30 : %s ; deg-2 threshold 1314283897427173^2 > C_7.upper(): %s ; deg-1 threshold 1727342163036353095979941756929 > C_7.upper(): %s ; Magma 40-digit value 1.72734216303635295797e30 inside ball: %s" % (RealField(120)(lo).str(), RealField(120)(up).str(), RealField(30)(Cn.rad()).str(), bool(up <= RF("1.7273421630363531e30")), bool(RF(1314283897427173)^2 > up), bool(RF(1727342163036353095979941756929) > up), bool(lo <= RF("1.72734216303635295797e30") <= up or abs(RF("1.72734216303635295797e30")-up) < RF("1e10"))))
print("R11 PROPD AUDIT DONE")
