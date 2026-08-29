# verify_p3_readonly.sage (r19) -- READ-ONLY replay verifier for the p = 3 certificate certificates/p3/D3_cert_r19.json
# (r18: GPT r17 items 12-31 = hw 788-807; r19: GPT r18 items 1-5, 16-24, 66-78 = hw 877-881, 892-900, 942-954; ERRATA_R19 E19-1).
# ROLE (one of three, never merged -- hw 943-947): SEMANTIC RECOMPUTATION. It does NOT trust the shipped JSON: every quantity is
# rebuilt FROM THE DEFINITIONS in Arb ball arithmetic (Sage RealBallField / ComplexBallField) and only then compared with the shipped
# intervals (exact dyadic endpoints, tools/p3_interval.py). The other two roles: tools/check_p3_cert.py = producer-record internal
# consistency + print strings (step 04e); tools/check_p3_containment.py = certificate COVERAGE on a stored recomputation (step 04g).
# COVERAGE GATE (r19, replaces the r18 overlap test): for each of the 8 load-bearing intervals of each of the 15 rows (120 in all)
#   the shipped interval must CONTAIN the recomputed interval, I_rec subset I_ship (tools/p3_interval.contains). Overlap
#   (I_rec meets I_ship) is NOT accepted: it was the r18 gate and 65/120 shipped intervals failed containment under it
#   (ERRATA_R19 E19-1). The containment count is printed and stored in the structured summary.
# SCHEMA: accepts format_version p3_covol_cert_r19_v3 only; p3_covol_cert_r18_v2 is REJECTED as deprecated (overlap-era
#   certificate, not outward); any other value is rejected as unknown.
# Independence from the producer balls (sage/r19_trackB/p3_covol_balls_r19.sage): (i) eta_n from sin(2 a pi/q)/sin(2 pi/q) AND
# cross-checked against the cyclotomic form (1/2)|1 - zeta_q^{2m}| (a different evaluation path: complex exponentials);
# (ii) the Gram route uses a hand-written Gram-Schmidt orthogonalisation (det = product of squared GS norms), not a
# determinant routine; (iii) the DFT uses a precomputed table of powers of omega = exp(-2 pi i/N) (minus sign);
# (iv) the floor Lrel, C3rel, and the MO2016 comparator G(3,s,f) are recomputed from the formulas of the statements.
# Conventions are those of the certificate header (N = 3^n, q = 3^{n+1}, a = 1+N, sigma = zeta -> zeta^4, minus-sign DFT).
# Usage: sage scripts/verify_p3_readonly.sage [--cert PATH] [--out DIR] [--prec BITS] [--nmax N] [--rows K] [--negctl]
#   Prints 'P3 READONLY VERIFY: PASS ...' / 'FAIL ...'; writes p3_readonly_recomputed.json (the recomputation, input B of the
#   certificate generator and of the containment checker), p3_readonly_summary.json (STRUCTURED: schema, containment
#   checked/failed, verifier version + sha256, cert sha256, negctl planted/rejected, fails) and, with --negctl, plants TWELVE
#   bad certificates in --out and requires that each is REJECTED ('P3 READONLY NEGCTL: PASS (12/12 rejected)'); the planted
#   set is written to p3_negctl_ledger.json (single source of the negative-control ledger, hw 901-902). Exit 0 iff PASS.
import json, hashlib, sys, os, time, argparse, copy
ap = argparse.ArgumentParser()
ap.add_argument("--cert", default="certificates/p3/D3_cert_r19.json")
ap.add_argument("--out", default=None)
ap.add_argument("--prec", type=int, default=4000)
ap.add_argument("--nmax", type=int, default=5)
ap.add_argument("--rows", type=int, default=15)
ap.add_argument("--negctl", action="store_true")
ap.add_argument("--maxrelwidth", default="1e-700", help="hard gate on the relative width of every shipped interval")
ap.add_argument("--allow-overlap-report", action="store_true", help="also print the overlap relation (diagnostic only; never a gate)")
args = ap.parse_args()
PREC = int(args.prec); NMAX = int(args.nmax); ROWS = int(args.rows)
OUTDIR = args.out or ("/tmp/p3_readonly_" + time.strftime("%Y%m%d_%H%M%S"))
os.makedirs(OUTDIR, exist_ok=True)
sys.path.insert(0, "tools")
from p3_interval import endpoints, overlap, contains, interval_dict, interval_from_decimals
from decimal import Decimal
SELF = open("scripts/verify_p3_readonly.sage", "rb").read()   # run from the package root
SELF_SHA = hashlib.sha256(SELF).hexdigest()
RBF = RealBallField(PREC); CBF = ComplexBallField(PREC); RIF = RealIntervalField(PREC)
pi_ = RBF.pi(); three = RBF(3)
def iv(x, digits=40):
    return interval_dict(x.lower().sign_mantissa_exponent(), x.upper().sign_mantissa_exponent(), x.rad().str(digits=8),
                         x.mid().str(digits=int(digits), no_sci=False), int(digits))
def dec_pair(x):
    return endpoints(iv(x))
# ---------------- the definitions, recomputed ----------------
def floor_Lrel(n):
    N = 3^n
    return RBF(N).sqrt() * ((three^(RBF(N-1)/(2*N)) + (three^(RBF(N-1)/N) + 4).sqrt())/2).log()   # MO2016 Lemma 2.5(2)
def G_mo16(s, f):
    c = 2*3^(s-1)
    L3 = ((three^(RBF(40)/81) + (three^(RBF(80)/81) + 4).sqrt())/2).log()
    base = (2*pi_).sqrt() / (three^(RBF(3)/4) * L3)
    return (base^c * RBF(factorial((c+2)//2)))^(RBF(1)/f)                                          # MO2016 Theorem A, p = 3
def Kconst(c):
    return (RBF(2)/pi_)^(c/2) * (RBF(2)+RBF(c)/2).gamma()
def gram_schmidt_det(vecs):
    """det(M M^T) = prod of squared norms of the Gram-Schmidt orthogonalisation of the rows (RBF vectors)."""
    basis = []; det = RBF(1)
    for v in vecs:
        w = list(v)
        for b, nb in basis:
            coef = sum(w[i]*b[i] for i in range(len(w))) / nb
            w = [w[i] - coef*b[i] for i in range(len(w))]
        nw = sum(x*x for x in w)
        basis.append((w, nw)); det *= nw
    return det
def compute():
    T0 = time.time(); res = {"format_version": "p3_readonly_recomputed_r19", "prec_bits": int(PREC), "verifier": "scripts/verify_p3_readonly.sage", "verifier_version": "r19", "verifier_sha256": SELF_SHA,
                             "timestamp_utc": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()), "rows": {}}
    g332 = G_mo16(3, 2); res["mo16_example16_G332"] = iv(g332, 12)
    assert RBF(42000) < g332 < RBF(43000), "MO2016 Example 1.6 check failed"
    for n in range(1, NMAX+1):
        N = 3^n; q = 3^(n+1); a = 1+N
        zeta = (2*pi_*CBF(0,1)/q).exp()                      # zeta_q
        lam = []; lam_cyc = []
        for j in range(N):
            m = power_mod(4, j, q)
            e1 = (RBF(2*m*a)*pi_/q).sin() / (RBF(2*m)*pi_/q).sin()          # definition: sigma^j eta_n
            lam.append(e1.abs().log())
            c1 = (1 - zeta^((2*m*a) % q)).abs(); c0 = (1 - zeta^((2*m) % q)).abs()   # cyclotomic form, |sin(2 pi t/q)| = |1-zeta^{2t}|/2
            lam_cyc.append((c1/c0).log())
        assert all((lam[j] - lam_cyc[j]).contains_zero() for j in range(N)), "sin form vs cyclotomic form disagree"
        assert sum(lam).contains_zero(), "eta_n is not a unit?"
        h3 = N//3
        assert all((lam[j] + lam[(j+h3) % N] + lam[(j+2*h3) % N]).contains_zero() for j in range(N)), "relative norm != 1"
        omega = (-2*pi_*CBF(0,1)/N).exp(); pw = [omega^t for t in range(N)]
        hat = [sum(CBF(lam[j]) * pw[(j*k) % N] for j in range(N)) for k in range(N)]
        assert all(hat[k].contains_zero() for k in range(N) if k % 3 == 0), "hat lambda_k not zero at 3 | k"
        minh = min(hat[k].abs().lower() for k in range(N) if k % 3 != 0)
        assert minh > 0, "hat lambda_k not bounded away from 0 at 3 !| k"
        absq = [hat[k].abs()^2 for k in range(N)]
        Lrel = floor_Lrel(n)
        for r in range(1, n+1):
            c = 2*3^(r-1); step = 3^(n-r); m3 = 3^r
            rows_ = [[lam[(step*i + j) % N] for j in range(N)] for i in range(c)]
            det_g = gram_schmidt_det(rows_)
            assert det_g.lower() > 0
            D_g = det_g.sqrt()
            W = {}
            for k in range(N):
                if k % 3 != 0: W[k % m3] = W.get(k % m3, RBF(0)) + absq[k] / N
            assert len(W) == c
            disc_exp = 3^(r-1)*(2*r-1)
            det_d = RBF(3)^disc_exp
            for aa in sorted(W): det_d *= W[aa]
            D_d = det_d.sqrt()
            assert (D_g/D_d - 1).contains_zero(), (n, r, "routes disagree")
            lo_i = max(D_g.lower(), D_d.lower()); hi_i = min(D_g.upper(), D_d.upper()); assert lo_i <= hi_i
            D_i = RBF(RIF(lo_i, hi_i))
            C = Kconst(c) * D_i / Lrel^c
            G1 = G_mo16(r, 1); G2 = G_mo16(r, 2)
            imp1 = bool(C.upper() < G1.lower()); imp2 = bool(C.sqrt().upper() < G2.lower())
            res["rows"]["%d,%d" % (n, r)] = {"n": int(n), "r": int(r), "c": int(c), "disc_exp": int(disc_exp),
                "Lrel_3n": iv(Lrel), "D_gram": iv(D_g), "D_dft": iv(D_d), "D_intersection": iv(D_i), "C3rel": iv(C), "C3rel_sqrt": iv(C.sqrt()),
                "MO16_G_f1": iv(G1), "MO16_G_f2": iv(G2), "min_abs_hat_3notdivk_lower": minh.str(digits=12),
                "improved_f1": imp1, "improved_f2": imp2}
            print("recomputed n=%d r=%d c=%d  D_int lo %s  C3rel hi %s  G1 lo %s G2 lo %s  imp %s %s" % (n, r, c, D_i.lower().str(digits=10),
                  C.upper().str(digits=10), G1.lower().str(digits=6), G2.lower().str(digits=6), imp1, imp2), flush=True)
    res["seconds"] = float(time.time() - T0)
    return res
# ---------------- comparison with a shipped certificate (never trusted, only compared) ----------------
SCHEMA_OK = "p3_covol_cert_r19_v3"; SCHEMA_DEPRECATED = {"p3_covol_cert_r18_v2": "r18 v2: overlap-era certificate, not outward (ERRATA_R19 E19-1)"}
FIELDS = ("Lrel_3n", "D_gram", "D_dft", "D_intersection", "C3rel", "C3rel_sqrt", "MO16_G_f1", "MO16_G_f2")
def get_field(sr, name):
    if name == "D_gram": return (sr.get("route_gram") or {}).get("D")
    if name == "D_dft": return (sr.get("route_dft") or {}).get("D")
    return sr.get(name)
def compare(cert_path, comp):
    """returns (fails, containment) with containment = {"checked": k, "failed": m, "detail": [...]}"""
    fails = []; cont = {"checked": int(0), "failed": int(0), "detail": []}
    try:
        J = json.load(open(cert_path))
    except Exception as e:
        return ["malformed JSON: %s" % e], cont
    try:
        fv = J.get("format_version")
        if fv != SCHEMA_OK:
            if fv in SCHEMA_DEPRECATED: fails.append("format_version %s is DEPRECATED (%s); only %s is accepted" % (fv, SCHEMA_DEPRECATED[fv], SCHEMA_OK))
            else: fails.append("format_version %r unknown; only %s is accepted" % (fv, SCHEMA_OK))
            return fails, cont
        if int(J.get("prec_bits", 0)) < PREC: fails.append("prec_bits %s < %d" % (J.get("prec_bits"), PREC))
        if "MO2016 Lemma 2.5(2)" not in J.get("floor", ""): fails.append("floor is not the MO2016 Lemma 2.5(2) relative-norm-one floor")
        if "MO2016 Theorem A" not in J.get("comparator", ""): fails.append("comparator is not MO2016 Theorem A")
        if J.get("coverage_relation") != "I_rec subset I_ship (containment); overlap is not accepted":
            fails.append("coverage_relation header missing or not containment")
        rows = {(int(r["n"]), int(r["r"])): r for r in J.get("rows", [])}
        if len(rows) != ROWS: fails.append("row count %d != %d" % (len(rows), ROWS))
        exp_rows = {(n, r) for n in range(1, NMAX+1) for r in range(1, n+1)}
        for key in sorted(exp_rows):
            if key not in rows: fails.append("row %s missing" % (key,)); continue
            sr = rows[key]; vr = comp["rows"]["%d,%d" % key]
            if int(sr.get("c", -1)) != vr["c"]: fails.append("c mismatch at %s" % (key,))
            if int(sr.get("disc_exp", -1)) != vr["disc_exp"]: fails.append("disc_exp mismatch at %s: shipped %s, recomputed %d" % (key, sr.get("disc_exp"), vr["disc_exp"]))
            shipped_ep = {}
            for name in FIELDS:
                siv = get_field(sr, name)
                if siv is None: fails.append("%s missing at %s" % (name, key)); continue
                try:
                    se = endpoints(siv)
                except Exception as e:
                    fails.append("%s unreadable at %s: %s" % (name, key, e)); continue
                ve = endpoints(vr[name])
                shipped_ep[name] = se
                cont["checked"] += int(1)
                ok = contains(se, ve)
                cont["detail"].append({"row": "%d,%d" % key, "field": name, "contains": bool(ok), "meets": bool(overlap(se, ve)),
                                       "lo_gap": format(ve[0] - se[0], ".3E"), "hi_gap": format(se[1] - ve[1], ".3E")})
                if not ok:
                    cont["failed"] += int(1)
                    fails.append("%s: shipped [%s,%s] does NOT CONTAIN recomputed [%s,%s] at %s (lo gap %s, hi gap %s; meets=%s)" % (name, siv["lo_dec"], siv["hi_dec"],
                                 vr[name]["lo_dec"], vr[name]["hi_dec"], key, format(ve[0]-se[0], ".3E"), format(se[1]-ve[1], ".3E"), overlap(se, ve)))
                width = se[1] - se[0]; scale = max(abs(se[1]), Decimal(int(1)))
                if width / scale > Decimal(str(args.maxrelwidth)): fails.append("%s: shipped interval too wide at %s (rel width %s > %s)" % (name, key, format(width/scale, ".3E"), args.maxrelwidth))
            # improvement: recomputed from OUR balls (load-bearing) and re-evaluated on the shipped endpoints
            if not (vr["improved_f1"] and vr["improved_f2"]): fails.append("recomputed: no improvement over MO2016 at %s" % (key,))
            if all(k in shipped_ep for k in ("C3rel", "MO16_G_f1", "C3rel_sqrt", "MO16_G_f2")):
                if not (shipped_ep["C3rel"][1] < shipped_ep["MO16_G_f1"][0]): fails.append("shipped endpoints: C3rel.hi >= G1.lo at %s" % (key,))
                if not (shipped_ep["C3rel_sqrt"][1] < shipped_ep["MO16_G_f2"][0]): fails.append("shipped endpoints: sqrt(C3rel).hi >= G2.lo at %s" % (key,))
            if sr.get("improved_f1") is not True or sr.get("improved_f2") is not True: fails.append("shipped improved flags not both True at %s" % (key,))
            if not (sr.get("relnorm_zero_all_j") is True and sr.get("hat_zero_all_3divk") is True): fails.append("shipped relnorm/hat flags not True at %s" % (key,))
    except Exception as e:
        fails.append("structural error: %r" % (e,))
    return fails, cont
comp = compute()
json.dump(comp, open(os.path.join(OUTDIR, "p3_readonly_recomputed.json"), "w"), indent=1, default=int)
fails, cont = compare(args.cert, comp)
cert_sha = hashlib.sha256(open(args.cert, "rb").read()).hexdigest() if os.path.exists(args.cert) else None
summary = {"format_version": "p3_readonly_summary_r19", "verifier": "scripts/verify_p3_readonly.sage", "verifier_version": "r19", "verifier_sha256": SELF_SHA,
           "cert": args.cert, "cert_sha256": cert_sha, "schema_accepted": SCHEMA_OK, "prec_bits": int(PREC), "rows_checked": len(comp["rows"]),
           "coverage_relation": "I_rec subset I_ship (containment)", "containment_checked": cont["checked"], "containment_failed": cont["failed"],
           "containment_expected": int(ROWS) * len(FIELDS), "status": "PASS" if not fails else "FAIL", "fails": fails, "seconds": comp["seconds"],
           "negctl": None, "timestamp_utc": comp["timestamp_utc"]}
json.dump({"detail": cont["detail"]}, open(os.path.join(OUTDIR, "p3_containment_detail.json"), "w"), indent=1, default=int)
if fails:
    print("P3 READONLY VERIFY: FAIL (%d) ; containment %d/%d" % (len(fails), cont["checked"] - cont["failed"], cont["checked"]))
    for f in fails: print("  -", f)
else:
    print("P3 READONLY VERIFY: PASS (rows %d, prec %d, containment %d/%d, cert sha256 %s, verifier sha256 %s, %ss)" % (len(comp["rows"]), PREC,
          cont["checked"] - cont["failed"], cont["checked"], (cert_sha or "")[:12], SELF_SHA[:12], comp["seconds"]))
rc = 1 if fails else 0
if args.negctl and not fails:
    base = json.load(open(args.cert)); plants = []
    def rec_iv(key, name): return comp["rows"]["%d,%d" % key][name]
    def mk(lo_dec, hi_dec):
        """stored interval from two Decimals (outward exact dyadic conversion, tools/p3_interval.interval_from_decimals)"""
        return interval_from_decimals(lo_dec, hi_dec)
    def set_field(row, name, iv):
        if name == "D_gram": row["route_gram"]["D"] = iv
        elif name == "D_dft": row["route_dft"]["D"] = iv
        else: row[name] = iv
    def shrink(key, name, side):
        """inward-moved version of the SHIPPED interval driven by the RECOMPUTED one: side in {'lo','hi','both'}"""
        rl, rh = endpoints(rec_iv(key, name)); sl, sh = endpoints(get_field(base_rows[key], name))
        w = rh - rl
        nlo = rl + w/int(4) if side in ("lo", "both") else sl
        nhi = rh - w/int(4) if side in ("hi", "both") else sh
        return mk(nlo, nhi)
    base_rows = {(int(r["n"]), int(r["r"])): r for r in base["rows"]}
    last = max(base_rows)
    # r18 planted set (kept)
    j1 = copy.deepcopy(base); j1["rows"][-1]["route_dft"] = {}; plants.append(("one route missing (route_dft.D deleted)", j1))
    j2 = copy.deepcopy(base); rr = j2["rows"][-1]; e = int(rr["disc_exp"]); rr["disc_exp"] = int(e + 1)
    lo = rr["route_dft"]["D"]["lo"]; hi = rr["route_dft"]["D"]["hi"]; sc = int(3); lo["mantissa"] = str(int(lo["mantissa"]) * sc); hi["mantissa"] = str(int(hi["mantissa"]) * sc)
    rr["route_dft"]["D"]["lo_dec"] = "%.3E" % (float(rr["route_dft"]["D"]["lo_dec"]) * float(3) * float(0.999)); rr["route_dft"]["D"]["hi_dec"] = "%.3E" % (float(rr["route_dft"]["D"]["hi_dec"]) * float(3) * float(1.001))
    plants.append(("wrong discriminant exponent (D_dft scaled by sqrt(3)^2)", j2))
    j3 = copy.deepcopy(base)
    for rr in j3["rows"]: rr["Lrel_3n"] = rr["Lsch_3n_r16"]
    plants.append(("weak (Schinzel) floor substituted, header string kept (numeric gate must fire)", j3))
    j4 = copy.deepcopy(base)
    for rr in j4["rows"]: rr["MO16_G_f1"] = rr["MO13_G1_f"]; rr["MO16_G_f2"] = rr["MO13_Thm03"]
    plants.append(("comparison with MO2013 only, header string kept (numeric gate must fire)", j4))
    plants.append(("malformed JSON (truncated)", None))
    # r19 planted set (GPT r18 items 17-23 = hw 893-899): each MEETS the recomputed interval but does not CONTAIN it
    j6 = copy.deepcopy(base); rows6 = {(int(r["n"]), int(r["r"])): r for r in j6["rows"]}
    for name in FIELDS:
        rl, rh = endpoints(rec_iv(last, name)); w = rh - rl
        set_field(rows6[last], name, mk((rl + rh)/int(2), rh + w))     # narrow shifted interval: meets rec, misses its lower half
    plants.append(("shifted narrow intervals on the last row: every field MEETS the recomputed interval but does not CONTAIN it (overlap-era gate would accept)", j6))
    j7 = copy.deepcopy(base); rows7 = {(int(r["n"]), int(r["r"])): r for r in j7["rows"]}
    for name in FIELDS: set_field(rows7[last], name, shrink(last, name, "lo"))
    plants.append(("shipped LOWER endpoints moved inward only (last row, all fields)", j7))
    j8 = copy.deepcopy(base); rows8 = {(int(r["n"]), int(r["r"])): r for r in j8["rows"]}
    for name in FIELDS: set_field(rows8[last], name, shrink(last, name, "hi"))
    plants.append(("shipped UPPER endpoints moved inward only (last row, all fields)", j8))
    for name, desc in (("D_gram", "Gram route alone under-covers"), ("D_dft", "spectral (DFT) route alone under-covers"),
                       ("C3rel", "C alone under-covers"), ("C3rel_sqrt", "sqrt C alone under-covers")):
        jj = copy.deepcopy(base); rows_j = {(int(r["n"]), int(r["r"])): r for r in jj["rows"]}
        for key in rows_j: set_field(rows_j[key], name, shrink(key, name, "both"))
        plants.append((desc + " (all rows; other fields untouched)", jj))
    rejected = int(0); ledger = []
    for i, (desc, jj) in enumerate(plants):
        pth = os.path.join(OUTDIR, "negctl_%d.json" % (i+1))
        if jj is None: open(pth, "w").write(json.dumps(base)[: 2000])
        else: json.dump(jj, open(pth, "w"))
        f, c2 = compare(pth, comp)
        ok = bool(f); rejected += int(ok)
        ledger.append({"id": int(i+1), "description": desc, "rejected": bool(ok), "first_reason": (f[0] if f else "")[:200],
                       "containment_failed": c2["failed"], "containment_checked": c2["checked"]})
        print("NEGCTL %d %s :: %s :: %s" % (i+1, desc, "REJECTED (correct)" if ok else "ACCEPTED (WRONG)", (f[0] if f else "")[:140]))
    print("P3 READONLY NEGCTL: %s (%d/%d rejected)" % ("PASS" if rejected == len(plants) else "FAIL", rejected, len(plants)))
    summary["negctl"] = {"planted": len(plants), "rejected": rejected, "status": "PASS" if rejected == len(plants) else "FAIL"}
    json.dump({"format_version": "p3_negctl_ledger_r19", "verifier_sha256": SELF_SHA, "cert_sha256": cert_sha, "planted": len(plants), "rejected": rejected,
               "controls": ledger}, open(os.path.join(OUTDIR, "p3_negctl_ledger.json"), "w"), indent=1, default=int)
    if rejected != len(plants): rc = 1
summary["status"] = "PASS" if rc == 0 else "FAIL"
json.dump(summary, open(os.path.join(OUTDIR, "p3_readonly_summary.json"), "w"), indent=1, default=int)
sys.exit(int(rc))
