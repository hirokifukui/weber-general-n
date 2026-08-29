# p3_covol_cert_r18.sage -- R18 Track B certificate PRODUCER, format v2 (GPT r17 items 32-44, hw 808-820).
# Mathematics identical to sage/r17_trackB/p3_covol_cert_r17.sage (retained): rigorous enclosures (Arb balls via Sage
# RealBallField/ComplexBallField at PREC bits) of the covolumes D_r^{(n)} of the Horie-unit log lattices at p = 3 by two
# linear-algebraic routes from the same log profile (Gram determinant; character product of Theorem rank3), of the
# relative-norm-one floor Lrel_{3,n} (MO2016 Lemma 2.5(2), L2 height), of C3rel_{n,r} = (2/pi)^{c/2} Gamma(2+c/2) D_r^{(n)} / Lrel^c,
# and of the comparator G(3,s,f) of MO2016 Theorem A. n = 1..NMAX, r = 1..n.
# CONVENTIONS (fixed here, in the paper and in the verifier): N = 3^n, q = 3^{n+1}, a = 1+N;
#   eta_n = sin(2 a pi/q) / sin(2 pi/q); sigma: zeta_q -> zeta_q^4; sigma^j eta_n = sin(2 a 4^j pi/q)/sin(2 4^j pi/q);
#   lambda_j = log|sigma^j eta_n| (j in Z/N); hat lambda_k = sum_j lambda_j exp(-2 pi i j k / N) (MINUS sign);
#   W_{n,r}(a) = (1/N) sum_{k == a mod 3^r} |hat lambda_k|^2; (D_r^{(n)})^2 = 3^{3^{r-1}(2r-1)} prod_{a in (Z/3^r)^x} W_{n,r}(a);
#   Gram route: rows H(sigma^{3^{n-r} i} eta_n), i < c = 2 3^{r-1}, D = sqrt(det(M M^T)).
# FORMAT v2: every enclosed quantity is stored as an EXACT dyadic outward interval
#   {"lo": {"sign","mantissa","exp2"}, "hi": {...}}  with value = sign * mantissa * 2^exp2   (the Arb ball endpoints
#   mid -/+ rad rounded outward at PREC bits), plus "rad_upper" (decimal, upper bound of the ball radius), "mid" (decimal,
#   nearest, for display only) and DIRECTED 40-digit decimals "lo_dec" (rounded DOWN) / "hi_dec" (rounded UP).
#   lo < hi is asserted for every stored interval. Display strings are never the proved values: the proof values are the dyadics.
import json, hashlib, time, os
PREC = int(os.environ.get("P3_PREC", "4000")); NMAX = int(os.environ.get("P3_NMAX", "5"))
OUT = os.environ.get("P3_OUT", "certificates/p3/D3_cert_r18.json")
RBF = RealBallField(PREC); CBF = ComplexBallField(PREC)
import sys; sys.path.insert(0, "tools"); from p3_interval import interval_dict
def ball(x, digits=40):
    lo = x.lower(); hi = x.upper()
    assert lo < hi or (lo == hi and x.rad() == 0), ("degenerate", x)
    return interval_dict(lo.sign_mantissa_exponent(), hi.sign_mantissa_exponent(), x.rad().str(digits=8),
                         x.mid().str(digits=int(digits), no_sci=False), int(digits))
pi_ = RBF.pi(); three = RBF(3)
phi = (1 + RBF(5).sqrt())/2; logphi = phi.log()
L3_mo16 = ((three^(RBF(40)/81) + (three^(RBF(80)/81) + 4).sqrt())/2).log()
base_mo16 = (2*pi_).sqrt() / (three^(RBF(3)/4) * L3_mo16)
def G_mo16(s, f):
    c = 2*3^(s-1)
    return (base_mo16^c * RBF(factorial((c+2)//2)))^(RBF(1)/f)
out = {"format_version": "p3_covol_cert_r18_v2", "produced_by": "sage/r18_trackB/p3_covol_cert_r18.sage", "prec_bits": int(PREC),
       "timestamp_utc": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
       "interval_format": "exact dyadic outward endpoints: value = sign*mantissa*2^exp2; lo = Arb ball lower endpoint (mid-rad rounded down at prec_bits), hi = upper endpoint (mid+rad rounded up); lo_dec/hi_dec = directed 40-digit decimals (down/up); mid = display only",
       "rounding_mode": "outward (lo: RNDD, hi: RNDU) at prec_bits; decimals directed; Arb ball arithmetic throughout",
       "conventions": {"N": "3^n", "q": "3^(n+1)", "a": "1+3^n", "eta_n": "sin(2 a pi/q)/sin(2 pi/q)", "sigma": "zeta_q -> zeta_q^4",
                       "lambda_j": "log|sigma^j eta_n|, j in Z/N", "dft": "hat lambda_k = sum_j lambda_j exp(-2 pi i j k/N) (minus sign)",
                       "W": "W_{n,r}(a) = (1/N) sum_{k == a (3^r)} |hat lambda_k|^2", "disc": "|disc Q(zeta_{3^r})| = 3^{3^{r-1}(2r-1)}",
                       "D_dft": "sqrt(disc * prod_{a in (Z/3^r)^x} W_{n,r}(a))", "D_gram": "sqrt det(M M^T), M rows H(sigma^{3^{n-r} i} eta_n), i < c",
                       "C3rel": "(2/pi)^{c/2} Gamma(2+c/2) D_gram / Lrel^c", "c": "2*3^(r-1)"},
       "floor": "Lrel_{3,n} = sqrt(3^n) log((3^{(3^n-1)/(2 3^n)} + sqrt(3^{(3^n-1)/3^n}+4))/2) (MO2016 Lemma 2.5(2), L2 height)",
       "comparator": "MO2016 Theorem A p=3: G(3,s,f) = ((sqrt(2pi)/(3^(3/4) log((3^(40/81)+sqrt(3^(80/81)+4))/2)))^c ((c+2)/2)!)^(1/f), c = 2 3^(s-1)",
       "mo16_example16_check_G332": ball(G_mo16(3,2), 12), "rows": []}
print("MO2016 Example 1.6 check: G(3,3,2) =", G_mo16(3,2).mid().str(digits=8), "(paper: 4.3e4 rounded up)")
for n in range(1, NMAX+1):
    N = 3^n; q = 3^(n+1); a = 1+N
    def eta_ball(k):
        k = k % q
        return (RBF(2*k*a)*pi_/q).sin() / (RBF(2*k)*pi_/q).sin()
    logs = [eta_ball(power_mod(4, t, q)).abs().log() for t in range(N)]
    tot = sum(logs)
    assert tot.contains_zero(), "unit check"
    h3 = N//3
    relnorm_ok = all((logs[j] + logs[(j+h3) % N] + logs[(j+2*h3) % N]).contains_zero() for j in range(N))
    assert relnorm_ok, "relative norm check failed"
    hat = []
    for k in range(N):
        s = CBF(0)
        for j in range(N):
            s += CBF(logs[j]) * CBF(-2*pi_*RBF(j*k % N)/N * CBF(0,1)).exp()
        hat.append(s)
    div3_ok = all(hat[k].contains_zero() for k in range(N) if k % 3 == 0)
    assert div3_ok, "hat lambda_k must contain 0 for 3|k"
    min_nondiv3 = min(hat[k].abs().lower() for k in range(N) if k % 3 != 0)
    assert min_nondiv3 > 0
    absq = [hat[k].abs()^2 for k in range(N)]
    Lrel = RBF(N).sqrt() * ((three^(RBF(N-1)/(2*N)) + (three^(RBF(N-1)/N) + 4).sqrt())/2).log()
    Lsch = RBF(N).sqrt() * logphi
    for r in range(1, n+1):
        c = 2*3^(r-1); step = 3^(n-r); m = 3^r
        M = matrix(RBF, [[logs[(step*i+j) % N] for j in range(N)] for i in range(c)])
        det_gram = (M * M.transpose()).determinant()
        assert det_gram.lower() > 0, (n, r, det_gram)
        D_gram = det_gram.sqrt()
        W = {}
        for k in range(N):
            if k % 3 != 0: W[k % m] = W.get(k % m, RBF(0)) + absq[k] / N
        assert len(W) == c
        prodW = RBF(1)
        for aa in sorted(W): prodW *= W[aa]
        disc = RBF(3)^(3^(r-1)*(2*r-1))
        det_dft = disc * prodW
        assert det_dft.lower() > 0
        D_dft = det_dft.sqrt()
        ratio = D_gram / D_dft
        assert (ratio - 1).contains_zero(), (n, r, ratio)
        # intersection of the two enclosures (both contain the true D)
        lo_i = max(D_gram.lower(), D_dft.lower()); hi_i = min(D_gram.upper(), D_dft.upper())
        assert lo_i <= hi_i, (n, r, "routes do not intersect")
        D_int = RBF(RealIntervalField(PREC)(lo_i, hi_i))
        Kc = (RBF(2)/pi_)^(c/2) * (RBF(2)+RBF(c)/2).gamma()
        C3rel = Kc * D_int / Lrel^c
        C3sch = Kc * D_int / Lsch^c
        G1 = G_mo16(r, 1); G2 = G_mo16(r, 2)
        imp1 = bool(C3rel.upper() < G1.lower()); imp2 = bool(C3rel.sqrt().upper() < G2.lower())
        T03 = RBF(2)^(c/2) * factorial(c); G1_13 = (RBF(6).sqrt()*3/2)^c * factorial(c)
        row = {"n": int(n), "r": int(r), "N": int(N), "c": int(c), "disc_exp": int(3^(r-1)*(2*r-1)),
               "Lrel_3n": ball(Lrel), "Lsch_3n_r16": ball(Lsch),
               "route_gram": {"D": ball(D_gram)}, "route_dft": {"D": ball(D_dft), "W": {str(aa): ball(W[aa]) for aa in sorted(W)}},
               "D_gram_over_D_dft": ball(ratio, 12), "D_intersection": ball(D_int),
               "min_abs_hat_lambda_3notdivk_lower": min_nondiv3.str(digits=12), "relnorm_zero_all_j": bool(relnorm_ok), "hat_zero_all_3divk": bool(div3_ok),
               "C3rel": ball(C3rel), "C3rel_sqrt": ball(C3rel.sqrt()), "C3sch_r16": ball(C3sch),
               "MO16_G_f1": ball(G1), "MO16_G_f2": ball(G2), "improve_f1": ball(G1/C3rel, 12), "improve_f2": ball(G2/C3rel.sqrt(), 12),
               "improved_f1": imp1, "improved_f2": imp2, "MO13_Thm03": ball(T03), "MO13_G1_f": ball(G1_13),
               "log10_C3rel_upper": RealField(80)(C3rel.upper()).log10().str(digits=10), "C3rel_upper_integer_bound": str(C3rel.upper().ceil())}
        out["rows"].append(row)
        json.dump(out, open(OUT, "w"), indent=1)
        print("%d %d %4d %3d  D_int lo %s  ratio-1 rad %s  min|hat| %s  C3rel [%s, %s]  G1 %s G2 %s  %s %s" % (n, r, N, c, D_int.lower().str(digits=10),
              (ratio-1).rad().str(digits=3), min_nondiv3.str(digits=6), C3rel.lower().str(digits=10), C3rel.upper().str(digits=10),
              G1.lower().str(digits=6), G2.lower().str(digits=6), imp1, imp2), flush=True)
src = open("sage/r18_trackB/p3_covol_cert_r18.sage", "rb").read()
out["script_sha256"] = hashlib.sha256(src).hexdigest()
json.dump(out, open(OUT, "w"), indent=1)
print("R18 P3 COVOL CERT DONE ; rows", len(out["rows"]), "; prec", PREC, "; script sha256", out["script_sha256"][:12])
