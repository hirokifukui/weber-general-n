# p3_covol_cert_r17.sage -- R17 Track B (repair): RIGOROUS enclosures (ball arithmetic, Arb via Sage RealBallField/ComplexBallField)
# of the covolumes D_r^{(n)} of the Horie-unit log lattices at p = 3 by TWO routes, of the relative-norm-one floor
# Lrel_{3,n} = sqrt(3^n) log((3^{(3^n-1)/(2 3^n)} + sqrt(3^{(3^n-1)/3^n} + 4))/2)  (MO2016 Lemma 2.5(2) with ht = L2, Lemma 2.3 + Lemma 2.4(2)),
# of the constants C3rel_{n,r} = (2/pi)^{c/2} Gamma(2+c/2) D_r^{(n)} / Lrel_{3,n}^c, and of the best published comparator
# MO2016 Theorem A at p = 3: G(3,s,f) = ((sqrt(2 pi)/(3^{3/4} log((3^{40/81}+sqrt(3^{80/81}+4))/2)))^c ((c+2)/2)!)^{1/f}, c = 2 3^{s-1}.
# n = 1..5, r = 1..n. Route 1: Gram determinant (as r16). Route 2: (D_r^{(n)})^2 = 3^{3^{r-1}(2r-1)} prod_{a in (Z/3^r)^x} W_{n,r}(a),
# W_{n,r}(a) = (1/N) sum_{k == a (3^r)} |hat lambda_k|^2, hat lambda_k = sum_j lambda_j e^{-2 pi i jk/N}, lambda_j = log|sigma^j eta_n|.
# Checks recorded per row: relative norm (lambda_j + lambda_{j+N/3} + lambda_{j+2N/3} contains 0 for every j), hat lambda_k contains 0 for
# 3 | k, lower bound of min |hat lambda_k| over 3 !| k, D_gram / D_dft contains 1, C3rel upper < G(3,r,f) lower (both f).
# Objects as in sage/r16_trackB/p3_covol_cert.sage: eta_n = sin(2(1+3^n)pi/3^{n+1})/sin(2pi/3^{n+1}), sigma = multiplication by 4.
import json, hashlib, time
PREC = 4000
RBF = RealBallField(PREC); CBF = ComplexBallField(PREC)
def ball_str(x, digits=40):
    return {"mid": x.mid().str(digits=digits, no_sci=False), "rad_upper": x.rad().str(digits=8),
            "lo": x.lower().str(digits=digits, no_sci=False), "hi": x.upper().str(digits=digits, no_sci=False)}
pi_ = RBF.pi()
phi = (1 + RBF(5).sqrt())/2; logphi = phi.log()
three = RBF(3)
L3_mo16 = ((three^(RBF(40)/81) + (three^(RBF(80)/81) + 4).sqrt())/2).log()
base_mo16 = (2*pi_).sqrt() / (three^(RBF(3)/4) * L3_mo16)
def G_mo16(s, f):
    c = 2*3^(s-1)
    return (base_mo16^c * RBF(factorial((c+2)//2)))^(RBF(1)/f)
out = {"format_version": "p3_covol_cert_r17_v1", "produced_by": "sage/r17_trackB/p3_covol_cert_r17.sage", "prec_bits": int(PREC),
       "timestamp_utc": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
       "floor": "Lrel_{3,n} = sqrt(3^n) log((3^{(3^n-1)/(2 3^n)} + sqrt(3^{(3^n-1)/3^n}+4))/2) (MO2016 Lemma 2.5(2), L2 height)",
       "comparator": "MO2016 Theorem A p=3: G(3,s,f) = ((sqrt(2pi)/(3^(3/4) log((3^(40/81)+sqrt(3^(80/81)+4))/2)))^c ((c+2)/2)!)^(1/f), c = 2 3^(s-1)",
       "mo16_example16_check_G332": ball_str(G_mo16(3,2), 12), "rows": []}
print("MO2016 Example 1.6 check: G(3,3,2) =", G_mo16(3,2).mid().str(digits=8), "(paper: 4.3e4 rounded up)")
print("n r    N   c   D_gram lo (10 dig)   D_gram/D_dft-1 rad   min|hat|3!|k lo  C3rel lo / hi (10 dig)                  G(3,r,1) lo  G(3,r,2) lo   f1? f2?")
for n in range(1, 6):
    N = 3^n; q = 3^(n+1)
    def eta_ball(k):
        k = k % q
        return (RBF(2*k*(1+N))*pi_/q).sin() / (RBF(2*k)*pi_/q).sin()
    logs = [eta_ball(power_mod(4, t, q)).abs().log() for t in range(N)]
    tot = sum(logs)
    assert tot.contains_zero(), "unit check"
    assert RealField(30)(tot.rad()) < RealField(30)(2)^(-PREC//2), tot
    h3 = N//3
    relnorm_ok = all((logs[j] + logs[(j+h3) % N] + logs[(j+2*h3) % N]).contains_zero() for j in range(N))
    assert relnorm_ok, "relative norm check failed"
    # DFT of the log vector (complex balls)
    hat = []
    for k in range(N):
        s = CBF(0)
        for j in range(N):
            s += CBF(logs[j]) * CBF(-2*pi_*RBF(j*k % N)/N * CBF(0,1)).exp()
        hat.append(s)
    div3_ok = all(hat[k].contains_zero() for k in range(N) if k % 3 == 0)
    assert div3_ok, "hat lambda_k must contain 0 for 3|k"
    min_nondiv3 = min(hat[k].abs().lower() for k in range(N) if k % 3 != 0)
    assert min_nondiv3 > 0, "hat lambda_k lower bound must be positive for 3!|k"
    absq = [hat[k].abs()^2 for k in range(N)]
    Lrel = RBF(N).sqrt() * ((three^(RBF(N-1)/(2*N)) + (three^(RBF(N-1)/N) + 4).sqrt())/2).log()
    Lsch = RBF(N).sqrt() * logphi
    for r in range(1, n+1):
        c = 2*3^(r-1); step = 3^(n-r); m = 3^r
        M = matrix(RBF, [[logs[(step*i+j) % N] for j in range(N)] for i in range(c)])
        Gm = M * M.transpose()
        det_gram = Gm.determinant()
        assert det_gram.lower() > 0, (n, r, det_gram)
        D_gram = det_gram.sqrt()
        # route 2
        W = {}
        for k in range(N):
            if k % 3 != 0:
                W[k % m] = W.get(k % m, RBF(0)) + absq[k] / N
        assert len(W) == c
        prodW = RBF(1)
        for a in sorted(W): prodW *= W[a]
        disc = RBF(3)^(3^(r-1)*(2*r-1))
        det_dft = disc * prodW
        assert det_dft.lower() > 0
        D_dft = det_dft.sqrt()
        ratio = D_gram / D_dft
        assert ratio.contains_exact(1) or (ratio - 1).contains_zero(), (n, r, ratio)
        Kc = (RBF(2)/pi_)^(c/2) * (RBF(2)+RBF(c)/2).gamma()
        C3rel = Kc * D_gram / Lrel^c
        C3sch = Kc * D_gram / Lsch^c
        G1 = G_mo16(r, 1); G2 = G_mo16(r, 2)
        imp1 = bool(C3rel.upper() < G1.lower()); imp2 = bool(C3rel.sqrt().upper() < G2.lower())
        T03 = RBF(2)^(c/2) * factorial(c); G1_13 = (RBF(6).sqrt()*3/2)^c * factorial(c)
        row = {"n": int(n), "r": int(r), "N": int(N), "c": int(c), "Lrel_3n": ball_str(Lrel), "Lsch_3n": ball_str(Lsch),
               "D_gram": ball_str(D_gram), "D_dft": ball_str(D_dft), "D_gram_over_D_dft": ball_str(ratio, 12),
               "min_abs_hat_lambda_3notdivk_lower": min_nondiv3.str(digits=12), "relnorm_zero_all_j": bool(relnorm_ok), "hat_zero_all_3divk": bool(div3_ok),
               "C3rel": ball_str(C3rel), "C3rel_sqrt": ball_str(C3rel.sqrt()), "C3sch_r16": ball_str(C3sch),
               "MO16_G_f1": ball_str(G1), "MO16_G_f2": ball_str(G2), "improve_f1": ball_str(G1/C3rel, 12), "improve_f2": ball_str(G2/C3rel.sqrt(), 12),
               "improved_f1": imp1, "improved_f2": imp2, "MO13_Thm03": ball_str(T03), "MO13_G1_f": ball_str(G1_13),
               "log10_C3rel_upper": RealField(80)(C3rel.upper()).log10().str(digits=10), "C3rel_upper_integer_bound": str(C3rel.upper().ceil())}
        out["rows"].append(row)
        json.dump(out, open("certificates/p3/D3_cert_r17.json","w"), indent=1)
        print("%d %d %4d %3d  %s  %s  %s  %s / %s  %s  %s  %s %s" % (n, r, N, c, D_gram.lower().str(digits=10), (ratio-1).rad().str(digits=3),
              min_nondiv3.str(digits=6), C3rel.lower().str(digits=10), C3rel.upper().str(digits=10), G1.lower().str(digits=6), G2.lower().str(digits=6), imp1, imp2), flush=True)
src = open("sage/r17_trackB/p3_covol_cert_r17.sage","rb").read()
out["script_sha256"] = hashlib.sha256(src).hexdigest()
json.dump(out, open("certificates/p3/D3_cert_r17.json","w"), indent=1)
print("R17 P3 COVOL CERT DONE ; rows", len(out["rows"]), "; script sha256", out["script_sha256"][:12])
