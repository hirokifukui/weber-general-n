# r16_hatCn_pilot.sage -- computation-free constant hat C_n vs certified C_n (hw 667 / GPT r15 item 33)
# U(q) from Ramare, Approximate formulae for L(1,chi) II, Acta Arith 112 (2004), Corollary 1 with h=1, k=2,
# chi even primitive, 2 | q, q >= k^2 4^{omega(h)} = 4:
#   |L(1,chi)| <= (1/4)(log q + 2 log 2) + log(4q)/sqrt(q)          [read 2026-08-26 from the author's preprint PDF]
# hat C_n = 2 (4/pi)^{m/2} Gamma(2+m/2) (U(q)/log(2+sqrt5))^m,  m = 2^{n-1}, q = 2^{n+2}   (Cor A' with prod|L| <= U^m)
import json
R = RealField(200)
cert = json.load(open("certificates/constants/Cn_interval_r14.json"))
rows = {int(r["n"]): r for r in cert["rows"]}
print("n  m   q     U(q)       maxL(numerical)  C_n(cert mid)       hatC_n              hatC_n/C_n   log10 hatC_n")
for n in range(2, 10):  # n = 2..9 (hw 667)
    m = 2^(n-1); q = 2^(n+2)
    U = (R(log(q)) + 2*R(log(2)))/4 + R(log(4*q))/R(sqrt(q))
    hatC = 2 * (R(4)/R(pi))^(m/2) * gamma(R(2)+R(m)/2) * (U/R(log(2+sqrt(5))))^m
    # numerical max |L(1,chi)| over even characters of conductor exactly q (non-rigorous pilot)
    # digamma route (paper sect. const): L(1,chi) = -(1/q) sum_a chi(a) psi(a/q), nontrivial chi mod q; 200-bit reals, numerical (not a ball)
    RBF = RealBallField(200); CBF = ComplexBallField(200)
    G = DirichletGroup(q, CyclotomicField(2^n))
    psi = {a: (RBF(a)/RBF(q)).psi() for a in range(1, q) if a % 2 == 1}
    maxL = R(0)
    for chi in G:
        if chi.is_even() and chi.conductor() == q:
            v = abs(-(sum(CBF(chi(a)) * CBF(psi[a]) for a in psi)) / q)
            maxL = max(maxL, R(v.upper()))
    Cn = R(rows[n]["C_mid"])
    print("%d %3d %5d  %.6f  %.6f  %.6e  %.6e  %.3e  %.2f" % (n, m, q, U, maxL, Cn, hatC, hatC/Cn, log(hatC,10)), flush=True)
print("R16 HATCN PILOT DONE")
