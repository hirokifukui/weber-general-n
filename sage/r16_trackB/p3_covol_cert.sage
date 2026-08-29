# p3_covol_cert.sage -- R16 Track B: RIGOROUS enclosures (ball arithmetic, Arb via Sage RealBallField) of the covolumes
# D_r^{(n)} of the Horie-unit log lattices at p = 3 and of the constants C3_{n,r} = (2/pi)^{c/2} Gamma(2+c/2) D_r^{(n)} / L_{3,n}^c,
# n = 1..5, r = 1..n (c = 2*3^{r-1}, L_{3,n} = sqrt(3^n) log((1+sqrt5)/2)). Every printed quantity is a ball [mid +- rad];
# the certificate records outward-rounded endpoints. Objects as in sage/r16_trackB/p3_gate2_pilot.sage (floats) which this
# script supersedes for the paper: eta_n = sin(2(1+3^n)pi/3^{n+1})/sin(2pi/3^{n+1}), sigma = multiplication by 4 on the
# conjugate index, log vectors H(sigma^{3^{n-r} j} eta_n), j < c, Gram determinant.
# Competitors (MO2013 verbatim): G1 = (sqrt6*3/2)^c c!, Gcyclo = sqrt6^c (3/2)^{c/2} c!, Morisawa Thm 0.3 = 2^{c/2} c!  (exact rationals * sqrt6 powers; printed as balls).
import json, hashlib, time
PREC = 4000
RBF = RealBallField(PREC)
def ball_str(x, digits=40):
    lo = x.lower(); hi = x.upper()
    return {"mid": x.mid().str(digits=digits, no_sci=False), "rad_upper": x.rad().str(digits=8), "lo": lo.str(digits=digits, no_sci=False), "hi": hi.str(digits=digits, no_sci=False)}
pi_ = RBF.pi()
phi = (1 + RBF(5).sqrt())/2
logphi = phi.log()
out = {"format_version": "p3_covol_cert_r16_v1", "produced_by": "sage/r16_trackB/p3_covol_cert.sage", "prec_bits": int(PREC),
       "timestamp_utc": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()), "rows": []}
print("n r    N   c   D lo / hi (10 digits)                     rad(D)     C3 lo / hi                              Thm0.3       C3hi/Thm0.3")
for n in range(1, 6):
    N = 3^n; q = 3^(n+1)
    def eta_ball(k):
        k = k % q
        return (RBF(2*k*(1+N))*pi_/q).sin() / (RBF(2*k)*pi_/q).sin()
    logs = [eta_ball(power_mod(4, t, q)).abs().log() for t in range(N)]
    tot = sum(logs)
    assert tot.contains_zero(), "unit check: sum of logs must contain 0"
    assert RealField(30)(tot.rad()) < RealField(30)(2)^(-PREC//2), tot   # tight unit check (radius of the sum of logs)
    L = RBF(N).sqrt() * logphi
    for r in range(1, n+1):
        c = 2*3^(r-1); step = 3^(n-r)
        M = matrix(RBF, [[logs[(step*i+j) % N] for j in range(N)] for i in range(c)])
        G = M * M.transpose()
        det = G.determinant()
        assert det.lower() > 0, (n, r, det)
        D = det.sqrt()
        Kc = (RBF(2)/pi_)^(c/2) * (RBF(2)+RBF(c)/2).gamma()
        C3 = Kc * D / L^c
        G1 = (RBF(6).sqrt()*3/2)^c * factorial(c)
        Gcy = RBF(6).sqrt()^c * (RBF(3)/2)^(c/2) * factorial(c)
        T03 = RBF(2)^(c/2) * factorial(c)
        ratio = C3 / T03
        row = {"n": int(n), "r": int(r), "N": int(N), "c": int(c), "L_3n": ball_str(L), "D": ball_str(D), "C3": ball_str(C3),
               "C3_sqrt": ball_str(C3.sqrt()), "G1_f": ball_str(G1), "Gcyclo_f": ball_str(Gcy), "Thm03": ball_str(T03),
               "ratio_C3_over_Thm03": ball_str(ratio, 12), "log10_C3_upper": RealField(80)(C3.upper()).log10().str(digits=10),
               "C3_upper_integer_bound": str(C3.upper().ceil())}
        out["rows"].append(row)
        json.dump(out, open("certificates/p3/D3_cert_r16.json","w"), indent=1)   # incremental dump (run 1 lost n=5,r=5 to a JSON type error)
        print("%d %d %4d %3d  %s / %s  %s  %s / %s  %s  %s" % (n, r, N, c, D.lower().str(digits=10), D.upper().str(digits=10), D.rad().str(digits=3),
              C3.lower().str(digits=10), C3.upper().str(digits=10), T03.upper().str(digits=6), ratio.upper().str(digits=6)), flush=True)
src = open("sage/r16_trackB/p3_covol_cert.sage","rb").read()
out["script_sha256"] = hashlib.sha256(src).hexdigest()
json.dump(out, open("certificates/p3/D3_cert_r16.json","w"), indent=1)
print("R16 P3 COVOL CERT DONE ; rows", len(out["rows"]), "; script sha256", out["script_sha256"][:12])
