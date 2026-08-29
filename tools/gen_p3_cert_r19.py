#!/usr/bin/env python3
"""gen_p3_cert_r19.py (r19) -- GENERATOR of the p = 3 certificate certificates/p3/D3_cert_r19.json, format v3 (GPT r18 items 6-15
= hw 882-891; ERRATA_R19 E19-1; margin policy hw 981).
Inputs (both read-only, both hashed into the certificate header):
  A  sage/r19_trackB/p3_covol_balls_r19.json      producer balls (determinant route, direct-exponential DFT)
  B  sage/r19_trackB/p3_readonly_recomputed_r19.json  the read-only recomputation (Gram-Schmidt route, omega-power DFT), written by
     scripts/verify_p3_readonly.sage --out
For each of the 8 load-bearing quantities of each of the 15 rows the CERTIFIED interval is  widen_x2( hull(A, B) ):
the exact dyadic hull of the two independent enclosures, widened outward about its centre to twice its half-width (exact dyadic
arithmetic, tools/p3_interval.py; no rounding anywhere). Both inputs and the bare hull are kept per field under "provenance".
Rationale: A and B are both rigorous Arb enclosures of the same true value but their rounding histories differ, so neither contains
the other (r18: A subset B in 110/120, equal in 45/120, containment I_B subset I_A failed in 65/120). The certified interval must
CONTAIN any independent rigorous recomputation; the hull contains both inputs, and the x2 margin leaves room for a foreign Arb build
whose balls differ from B at the last bits. The margin is documented here and in the header; the relative width stays below 1e-1100.
Derived fields improve_f1 / improve_f2 are recomputed OUTWARD from the certified intervals in exact decimal (G.lo/C.hi .. G.hi/C.lo).
Usage: python3 tools/gen_p3_cert_r19.py [--producer A] [--readonly B] [--out certificates/p3/D3_cert_r19.json] [--check]
  --check regenerates in memory and compares with the shipped file (rows/intervals byte-identical except timestamp) -> exit 0/1."""
import json, hashlib, sys, os, argparse, time
from decimal import Decimal, getcontext, ROUND_FLOOR, ROUND_CEILING
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT + "/tools")
from p3_interval import endpoints, widened_hull, hull, interval_from_dyadics, dyadic_of_sme, contains
getcontext().prec = 1400
ap = argparse.ArgumentParser()
ap.add_argument("--producer", default="sage/r19_trackB/p3_covol_balls_r19.json")
ap.add_argument("--readonly", default="sage/r19_trackB/p3_readonly_recomputed_r19.json")
ap.add_argument("--out", default="certificates/p3/D3_cert_r19.json")
ap.add_argument("--factor", type=int, default=2)
ap.add_argument("--check", action="store_true")
args = ap.parse_args()
os.chdir(ROOT)
FIELDS = ("Lrel_3n", "D_gram", "D_dft", "D_intersection", "C3rel", "C3rel_sqrt", "MO16_G_f1", "MO16_G_f2")
def get_field(sr, name):
    if name == "D_gram": return sr["route_gram"]["D"]
    if name == "D_dft": return sr["route_dft"]["D"]
    return sr[name]
def set_field(row, name, iv):
    if name == "D_gram": row["route_gram"]["D"] = iv
    elif name == "D_dft": row["route_dft"]["D"] = iv
    else: row[name] = iv
def dec_to_dy(x, mode):
    """Decimal -> exact dyadic bound at scale 2^-4000: lo rounded DOWN, hi rounded UP (never inward)."""
    x = Decimal(x); s = 1 if x >= 0 else -1; ax = abs(x)
    m = (ax * (Decimal(2) ** 4000)).to_integral_value(rounding=(ROUND_FLOOR if (mode == "lo") == (s > 0) else ROUND_CEILING))
    return dyadic_of_sme(s, int(m), -4000)
def ratio_iv(num_iv, den_iv):
    """outward interval of num/den from two stored positive intervals: [num.lo/den.hi, num.hi/den.lo]"""
    nl, nh = endpoints(num_iv); dl, dh = endpoints(den_iv); assert dl > 0
    return interval_from_dyadics(dec_to_dy(nl / dh, "lo"), dec_to_dy(nh / dl, "hi"), 12)
def sqrt_iv(iv):
    lo, hi = endpoints(iv); assert lo >= 0
    return interval_from_dyadics(dec_to_dy(lo.sqrt(), "lo"), dec_to_dy(hi.sqrt(), "hi"), 40)
def build(A_path, B_path, factor):
    A = json.load(open(A_path)); B = json.load(open(B_path))
    assert A.get("format_version") == "p3_covol_balls_r19_producer", A.get("format_version")
    assert B.get("format_version") == "p3_readonly_recomputed_r19", B.get("format_version")
    assert int(A["prec_bits"]) == int(B["prec_bits"]) == 4000
    out = {"format_version": "p3_covol_cert_r19_v3", "produced_by": "tools/gen_p3_cert_r19.py", "prec_bits": 4000,
           "timestamp_utc": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
           "inputs": {"producer_balls": {"path": A_path, "sha256": hashlib.sha256(open(A_path, "rb").read()).hexdigest(), "format_version": A["format_version"],
                                         "produced_by": A["produced_by"], "script_sha256": A.get("script_sha256")},
                      "readonly_recomputed": {"path": B_path, "sha256": hashlib.sha256(open(B_path, "rb").read()).hexdigest(), "format_version": B["format_version"],
                                              "verifier": B["verifier"], "verifier_version": B.get("verifier_version"), "verifier_sha256": B["verifier_sha256"]}},
           "interval_format": "exact dyadic endpoints: value = sign*mantissa*2^exp2; lo_dec/hi_dec = directed 40-digit decimals (down/up); mid = display only; rad_upper = (hi-lo)/2 rounded up",
           "rounding_mode": "inputs: Arb ball arithmetic at prec_bits, outward endpoints (lo RNDD, hi RNDU); certificate: EXACT dyadic hull and widening, no rounding; decimals directed",
           "coverage_relation": "I_rec subset I_ship (containment); overlap is not accepted",
           "margin_policy": "certified interval = widen_x%d(hull(producer, readonly)): the half-width of the exact hull is multiplied by %d about its centre (hw 981); documented outward margin for foreign Arb builds" % (factor, factor),
           "load_bearing_fields": list(FIELDS), "conventions": A["conventions"], "floor": A["floor"], "comparator": A["comparator"],
           "mo16_example16_check_G332": A["mo16_example16_check_G332"], "rows": []}
    rowsB = B["rows"]
    stats = {"fields": 0, "A_in_cert": 0, "B_in_cert": 0, "A_eq_B": 0, "A_in_B": 0, "B_in_A": 0}
    for ra in A["rows"]:
        key = "%d,%d" % (int(ra["n"]), int(ra["r"])); rb = rowsB[key]
        assert int(ra["c"]) == int(rb["c"]) and int(ra["disc_exp"]) == int(rb["disc_exp"]), key
        row = json.loads(json.dumps(ra)); row["provenance"] = {}
        for name in FIELDS:
            ia, ib = get_field(ra, name), rb[name]
            cert = widened_hull(ia, ib, factor)
            h = hull(ia, ib)
            row["provenance"][name] = {"producer": ia, "readonly": ib, "hull": interval_from_dyadics(h[0], h[1])}
            set_field(row, name, cert)
            ea, eb, ec = endpoints(ia), endpoints(ib), endpoints(cert)
            stats["fields"] += 1; stats["A_in_cert"] += contains(ec, ea); stats["B_in_cert"] += contains(ec, eb)
            stats["A_eq_B"] += (ea == eb); stats["A_in_B"] += contains(eb, ea); stats["B_in_A"] += contains(ea, eb)
        row["improve_f1"] = ratio_iv(row["MO16_G_f1"], row["C3rel"]); row["improve_f2"] = ratio_iv(row["MO16_G_f2"], row["C3rel_sqrt"])
        row["improved_f1"] = bool(endpoints(row["C3rel"])[1] < endpoints(row["MO16_G_f1"])[0])
        row["improved_f2"] = bool(endpoints(row["C3rel_sqrt"])[1] < endpoints(row["MO16_G_f2"])[0])
        row["readonly_min_abs_hat_lambda_3notdivk_lower"] = rb["min_abs_hat_3notdivk_lower"]
        row["readonly_relnorm_zero_all_j"] = True; row["readonly_hat_zero_all_3divk"] = True   # asserted inside the verifier (assert statements)
        row["log10_C3rel_upper"] = format(endpoints(row["C3rel"])[1].log10(), ".10f")
        row["C3rel_upper_integer_bound"] = str(int(endpoints(row["C3rel"])[1].to_integral_value(rounding=ROUND_CEILING)))
        out["rows"].append(row)
    assert stats["A_in_cert"] == stats["fields"] == stats["B_in_cert"], stats
    out["generation_stats"] = stats
    return out
def strip_ts(j):
    j = json.loads(json.dumps(j)); j.pop("timestamp_utc", None); return j
gen = build(args.producer, args.readonly, args.factor)
if args.check:
    shipped = json.load(open(args.out))
    same = strip_ts(shipped) == strip_ts(gen)
    print("P3 CERT R19 GEN CHECK: %s (rows %d ; fields %d ; inputs A %s / B %s ; margin x%d)" % ("PASS" if same else "FAIL", len(gen["rows"]), gen["generation_stats"]["fields"],
          gen["inputs"]["producer_balls"]["sha256"][:12], gen["inputs"]["readonly_recomputed"]["sha256"][:12], args.factor))
    sys.exit(0 if same else 1)
json.dump(gen, open(args.out, "w"), indent=1)
print("R19 P3 CERT GENERATED:", args.out, "rows", len(gen["rows"]), "stats", gen["generation_stats"], "sha256", hashlib.sha256(open(args.out, "rb").read()).hexdigest()[:12])
