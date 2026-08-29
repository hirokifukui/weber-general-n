#!/usr/bin/env python3
"""check_p3_cert.py (r19) -- PRODUCER-RECORD CONSISTENCY gate on certificates/p3/D3_cert_r19.json (single source of every printed
p = 3 number), format v3 (GPT r18 items 7-15, 66-78 = hw 883-891, 942-954). ROLE: the first of three, never merged with the others
(semantic recomputation = scripts/verify_p3_readonly.sage, step 04f; coverage = tools/check_p3_containment.py, step 04g):
 (1) format_version p3_covol_cert_r19_v3; prec_bits 4000; header fields interval_format / rounding_mode / coverage_relation /
     margin_policy / conventions; the two INPUT files named in the header exist and have the recorded sha256 (producer balls
     sage/r19_trackB/p3_covol_balls_r19.json with script_sha256 = sha256 of its .sage; read-only recomputation
     sage/r19_trackB/p3_readonly_recomputed_r19.json whose verifier_sha256 = sha256 of the CURRENT scripts/verify_p3_readonly.sage);
 (2) 15 rows (n = 1..5, r = 1..n); per row and per load-bearing field: every stored interval has EXACT dyadic endpoints lo < hi
     bracketed by its directed decimals (tools/p3_interval.py), the certified interval EQUALS widen_x2(hull(provenance.producer,
     provenance.readonly)) recomputed here in exact dyadics, provenance.hull equals the bare hull, D_gram lo > 0, D_gram/D_dft
     (producer ball) encloses 1, D_intersection meets the meet of the two certified routes, every radius < 1e-800,
     relnorm_zero_all_j and hat_zero_all_3divk True, min |hat lambda_k| (3 !| k) lower bound > 0 (producer and read-only),
     improved_f1 / improved_f2 True AND re-evaluated on the exact endpoints (C3rel.hi < G(3,r,1).lo, sqrt(C3rel).hi < G(3,r,2).lo),
     improve_f1 / improve_f2 equal the outward ratios recomputed here, disc_exp = 3^{r-1}(2r-1), and the MO2016 Example 1.6 check
     G(3,3,2) in [4.24e4, 4.3e4];
 (3) the numbers PRINTED in the paper (paper/draft/main_*.tex), the Blueprint (blueprint/src/content.tex) and the freeze are
     generated from the EXACT endpoints with the rounding convention "our constants rounded UP (upper endpoint), comparators and
     improvement factors rounded DOWN (lower endpoint)", 5 significant digits, and must appear VERBATIM; --print shows the strings.
 Prints 'P3 CERT CHECK: PASS' and exits 0, or lists failures and exits 1."""
import json, hashlib, sys, glob, os
from decimal import Decimal, getcontext, ROUND_CEILING, ROUND_FLOOR
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT + "/tools")
from p3_interval import endpoints, widened_hull, hull, interval_from_dyadics, dyadic_of_sme, overlap
getcontext().prec = 1400
J = json.load(open(ROOT + "/certificates/p3/D3_cert_r19.json"))
bad = []
if J.get("format_version") != "p3_covol_cert_r19_v3": bad.append("format_version != p3_covol_cert_r19_v3")
if int(J.get("prec_bits", 0)) != 4000: bad.append("prec_bits != 4000")
for fld in ("interval_format", "rounding_mode", "coverage_relation", "margin_policy", "conventions", "inputs", "load_bearing_fields"):
    if fld not in J: bad.append("header field %s missing" % fld)
if J.get("coverage_relation") != "I_rec subset I_ship (containment); overlap is not accepted": bad.append("coverage_relation is not containment")
def sha(path): return hashlib.sha256(open(path, "rb").read()).hexdigest()
try:
    A = J["inputs"]["producer_balls"]; B = J["inputs"]["readonly_recomputed"]
    if sha(ROOT + "/" + A["path"]) != A["sha256"]: bad.append("producer balls sha256 mismatch: %s" % A["path"])
    if sha(ROOT + "/sage/r19_trackB/p3_covol_balls_r19.sage") != A.get("script_sha256"): bad.append("producer script sha256 mismatch")
    if json.load(open(ROOT + "/" + A["path"])).get("script_sha256") != A.get("script_sha256"): bad.append("producer balls file does not carry the recorded script sha")
    if sha(ROOT + "/" + B["path"]) != B["sha256"]: bad.append("read-only recomputation sha256 mismatch: %s" % B["path"])
    if sha(ROOT + "/scripts/verify_p3_readonly.sage") != B.get("verifier_sha256"): bad.append("read-only recomputation was not produced by the CURRENT verifier (verifier_sha256 mismatch)")
    if json.load(open(ROOT + "/" + B["path"])).get("verifier_sha256") != B.get("verifier_sha256"): bad.append("read-only recomputation file does not carry the recorded verifier sha")
except Exception as e:
    bad.append("inputs header unreadable: %r" % (e,))
MARGIN = 2
if ("widen_x%d" % MARGIN) not in J.get("margin_policy", ""): bad.append("margin_policy is not widen_x%d" % MARGIN)
def dec_to_dy(x, mode):
    x = D(x); s_ = 1 if x >= 0 else -1; ax = abs(x)
    m = (ax * (D(2) ** 4000)).to_integral_value(rounding=(ROUND_FLOOR if (mode == "lo") == (s_ > 0) else ROUND_CEILING))
    return dyadic_of_sme(s_, int(m), -4000)
def ratio_iv(num_iv, den_iv):
    nl, nh = endpoints(num_iv); dl, dh = endpoints(den_iv)
    return interval_from_dyadics(dec_to_dy(nl / dh, "lo"), dec_to_dy(nh / dl, "hi"), 12)
def LO(iv): return endpoints(iv)[0]
def HI(iv): return endpoints(iv)[1]
rows = {(r["n"], r["r"]): r for r in J["rows"]}
if len(rows) != 15: bad.append("row count %d != 15" % len(rows))
D = lambda s: Decimal(s)
def sig(x, mode, digits=5):
    """round Decimal x to `digits` significant digits, up (ROUND_CEILING) or down (ROUND_FLOOR); return 'm.mmmm\\times10^{e}' TeX."""
    x = D(x); e = x.adjusted()
    q = D(1).scaleb(e - digits + 1)
    y = (x / q).to_integral_value(rounding=mode) * q
    m = y.scaleb(-e)
    s = format(m, 'f')
    if '.' not in s: s += '.'
    s = (s + '0' * digits)[:digits + 1]
    return "%s\\times10^{%d}" % (s, e)
UP, DN = ROUND_CEILING, ROUND_FLOOR
for k, r in rows.items():
    try:
        Dg = r["route_gram"]["D"]; Dd = r["route_dft"]["D"]; Di = r["D_intersection"]
        for name, iv in (("D_gram", Dg), ("D_dft", Dd), ("D_intersection", Di), ("C3rel", r["C3rel"]), ("C3rel_sqrt", r["C3rel_sqrt"]),
                         ("Lrel_3n", r["Lrel_3n"]), ("MO16_G_f1", r["MO16_G_f1"]), ("MO16_G_f2", r["MO16_G_f2"]),
                         ("improve_f1", r["improve_f1"]), ("improve_f2", r["improve_f2"]), ("D_gram_over_D_dft", r["D_gram_over_D_dft"])):
            lo, hi = endpoints(iv)          # asserts lo <= hi and directed decimals bracket the dyadics
            if not (lo < hi): bad.append("degenerate interval %s at %s" % (name, k))
            if name in ("D_gram", "D_dft", "C3rel", "C3rel_sqrt", "Lrel_3n", "MO16_G_f1", "MO16_G_f2") and D(iv["rad_upper"]) >= D("1e-800"):
                bad.append("radius too large at %s %s: %s" % (k, name, iv["rad_upper"]))
        if LO(Dg) <= 0: bad.append("D_gram lo <= 0 at %s" % (k,))
        if not (LO(r["D_gram_over_D_dft"]) <= 1 <= HI(r["D_gram_over_D_dft"])): bad.append("two covolume routes disagree at %s" % (k,))
        ilo, ihi = max(LO(Dg), LO(Dd)), min(HI(Dg), HI(Dd))     # exact meet of the two certified route enclosures
        if not (ilo <= ihi): bad.append("the two route enclosures do not intersect at %s" % (k,))
        elif not overlap((LO(Di), HI(Di)), (ilo, ihi)): bad.append("D_intersection does not meet the meet of the routes at %s" % (k,))
        # certified interval = widen_x2(hull(producer, readonly)) recomputed in exact dyadics; provenance.hull = bare hull
        prov = r.get("provenance") or {}
        for name in ("Lrel_3n", "D_gram", "D_dft", "D_intersection", "C3rel", "C3rel_sqrt", "MO16_G_f1", "MO16_G_f2"):
            pv = prov.get(name)
            if not pv: bad.append("provenance missing for %s at %s" % (name, k)); continue
            cert = {"D_gram": Dg, "D_dft": Dd, "D_intersection": Di}.get(name, r.get(name))
            want = widened_hull(pv["producer"], pv["readonly"], MARGIN)
            if (want["lo"], want["hi"]) != (cert["lo"], cert["hi"]): bad.append("certified %s at %s is not widen_x%d(hull(producer, readonly))" % (name, k, MARGIN))
            h = hull(pv["producer"], pv["readonly"])
            if (h[0], h[1]) != (pv["hull"]["lo"], pv["hull"]["hi"]): bad.append("provenance.hull wrong for %s at %s" % (name, k))
            for src_name in ("producer", "readonly", "hull"):
                endpoints(pv[src_name])
        if D(r.get("readonly_min_abs_hat_lambda_3notdivk_lower", "0")) <= 0: bad.append("read-only min |hat lambda| lower bound <= 0 at %s" % (k,))
        for nm, num, den in (("improve_f1", r["MO16_G_f1"], r["C3rel"]), ("improve_f2", r["MO16_G_f2"], r["C3rel_sqrt"])):
            want = ratio_iv(num, den)
            if (want["lo"], want["hi"]) != (r[nm]["lo"], r[nm]["hi"]): bad.append("%s is not the outward ratio of the certified intervals at %s" % (nm, k))
        n_, r_ = k
        if int(r.get("disc_exp", -1)) != 3 ** (r_ - 1) * (2 * r_ - 1): bad.append("disc_exp wrong at %s" % (k,))
        if int(r.get("c", -1)) != 2 * 3 ** (r_ - 1): bad.append("c wrong at %s" % (k,))
        if not r.get("relnorm_zero_all_j"): bad.append("relnorm flag false at %s" % (k,))
        if not r.get("hat_zero_all_3divk"): bad.append("hat_zero flag false at %s" % (k,))
        if D(r["min_abs_hat_lambda_3notdivk_lower"]) <= 0: bad.append("min |hat lambda| lower bound <= 0 at %s" % (k,))
        if not (HI(r["C3rel"]) < LO(r["MO16_G_f1"])): bad.append("no f=1 improvement at %s" % (k,))
        if not (HI(r["C3rel_sqrt"]) < LO(r["MO16_G_f2"])): bad.append("no f=2 improvement at %s" % (k,))
        if not (r.get("improved_f1") is True and r.get("improved_f2") is True): bad.append("improved flags not both True at %s" % (k,))
    except Exception as e:
        bad.append("row %s unreadable: %r" % (k, e))
g332 = D(J["mo16_example16_check_G332"]["mid"])
if not (D("4.24e4") <= g332 <= D("4.3e4")): bad.append("MO2016 Example 1.6 check failed: G(3,3,2) = %s" % g332)
# generated display strings (single source)
gen = {}
c44 = rows.get((4, 4))
if c44:
    gen["C44"] = sig(HI(c44["C3rel"]), UP)            # threshold, f = 1 (exact upper endpoint, rounded up)
    gen["C44sqrt"] = sig(HI(c44["C3rel_sqrt"]), UP)   # threshold, f = 2
    gen["G441"] = sig(LO(c44["MO16_G_f1"]), DN)
    gen["G442"] = sig(LO(c44["MO16_G_f2"]), DN)
    gen["imp441"] = sig(LO(c44["improve_f1"]), DN)
    gen["imp442"] = sig(LO(c44["improve_f2"]), DN)
    gen["C44_bracket"] = "[%s,%s]" % (sig(LO(c44["C3rel"]), DN, 10), sig(HI(c44["C3rel"]), UP, 10))
    gen["C44sqrt_bracket"] = "[%s,%s]" % (sig(LO(c44["C3rel_sqrt"]), DN, 10), sig(HI(c44["C3rel_sqrt"]), UP, 10))
    gen["Lrel34"] = c44["Lrel_3n"]["mid"][:18]
TABLE_ROWS = [(2, 2), (3, 3), (4, 1), (4, 2), (4, 3), (4, 4), (5, 4), (5, 5)]
table_lines = []
for k in TABLE_ROWS:
    r = rows[k]
    line = "%d & %d & %d & $%s$ & $%s$ & $%s$ & $%s$ & $%s$ & $%s$\\\\" % (k[0], k[1], r["c"], sig(HI(r["C3rel"]), UP), sig(HI(r["C3rel_sqrt"]), UP),
            sig(LO(r["MO16_G_f1"]), DN), sig(LO(r["MO16_G_f2"]), DN), sig(LO(r["improve_f1"]), DN, 3), sig(LO(r["improve_f2"]), DN, 3))
    table_lines.append(line)
if "--print" in sys.argv:
    for k, v in gen.items(): print(k, "=", v)
    print("\n".join(table_lines)); sys.exit(0)
papers = glob.glob(ROOT + "/paper/draft/main_*.tex")
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from texsrc import expand_statements   # r21: single-sourced statements inlined (proofs/statements/)
paper = expand_statements((open(max(papers)).read() if papers else ""), ROOT) + "".join(open(f).read() for f in sorted(glob.glob(ROOT + "/proofs/*.tex")))
bp = expand_statements(open(ROOT + "/blueprint/src/content.tex").read(), ROOT)
for name in ("C44", "C44sqrt", "G441", "G442", "imp441", "imp442", "C44_bracket", "C44sqrt_bracket"):
    if gen[name] not in paper: bad.append("paper does not contain the generated %s = %s" % (name, gen[name]))
for name in ("C44", "C44sqrt", "C44_bracket", "C44sqrt_bracket"):
    if gen[name] not in bp: bad.append("blueprint does not contain the generated %s = %s" % (name, gen[name]))
for line in table_lines:
    if line not in paper: bad.append("paper table row missing or stale: %s" % line)
print("p3 certificate (v3, exact dyadic endpoints, widen_x%d(hull(producer, readonly))): rows %d ; prec_bits %s ; inputs A %s / B %s ; two routes agree ; improved in both classes 15/15" % (MARGIN, len(rows), J.get("prec_bits"), (J.get("inputs", {}).get("producer_balls", {}).get("sha256") or "")[:12], (J.get("inputs", {}).get("readonly_recomputed", {}).get("sha256") or "")[:12]))
if bad:
    for b in bad: print("FAIL:", b)
    print("P3 CERT CHECK: FAIL"); sys.exit(1)
print("P3 CERT CHECK: PASS")
