#!/usr/bin/env python3
"""check_p3_containment.py (r19) -- CERTIFICATE COVERAGE checker for the p = 3 certificate (GPT r18 items 3-5, 16, 70 = hw 879-881,
892, 946; ERRATA_R19 E19-1). ROLE: the third of three (producer-record consistency = tools/check_p3_cert.py; semantic recomputation
= scripts/verify_p3_readonly.sage; coverage = this file). Pure python, no Sage: it reads the shipped certificate and a STORED
recomputation (default: the read-only recomputation shipped as sage/r19_trackB/p3_readonly_recomputed_r19.json, or any
p3_readonly_recomputed.json written by the verifier with --out) and reports, for each of the 8 load-bearing intervals of each of
the 15 rows (120 in all), whether the shipped interval CONTAINS the recomputed one (tools/p3_interval.contains). The hard gate is
120/120. Overlap is reported for information only and never accepted.
Usage: python3 tools/check_p3_containment.py [--cert certificates/p3/D3_cert_r19.json] [--recomputed PATH] [--report]
  Prints 'P3 CONTAINMENT: PASS (120/120)' / 'FAIL (k/120)'; --report lists every field with lo/hi gaps. Exit 0 iff 120/120.
  Applied to the r18 certificate with the same recomputation it reproduces the r18 defect: 55/120 (65 failures)."""
import json, sys, os, argparse
from decimal import getcontext
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT + "/tools")
from p3_interval import endpoints, contains, overlap
getcontext().prec = 1400
ap = argparse.ArgumentParser()
ap.add_argument("--cert", default="certificates/p3/D3_cert_r19.json")
ap.add_argument("--recomputed", default="sage/r19_trackB/p3_readonly_recomputed_r19.json")
ap.add_argument("--report", action="store_true")
ap.add_argument("--allow-schema", default="p3_covol_cert_r19_v3,p3_covol_cert_r18_v2", help="schemas readable by this checker (v2 only for the errata reproduction)")
args = ap.parse_args()
os.chdir(ROOT)
FIELDS = ("Lrel_3n", "D_gram", "D_dft", "D_intersection", "C3rel", "C3rel_sqrt", "MO16_G_f1", "MO16_G_f2")
def get_field(sr, name):
    if name == "D_gram": return sr["route_gram"]["D"]
    if name == "D_dft": return sr["route_dft"]["D"]
    return sr[name]
J = json.load(open(args.cert)); R = json.load(open(args.recomputed))
fv = J.get("format_version")
if fv not in args.allow_schema.split(","):
    print("P3 CONTAINMENT: FAIL (schema %r not readable)" % fv); sys.exit(1)
rows = {(int(r["n"]), int(r["r"])): r for r in J["rows"]}
checked = failed = 0; per = {f: 0 for f in FIELDS}; lines = []
for key in sorted(rows):
    sr = rows[key]; vr = R["rows"]["%d,%d" % key]
    for name in FIELDS:
        se = endpoints(get_field(sr, name)); ve = endpoints(vr[name]); checked += 1
        ok = contains(se, ve)
        if not ok: failed += 1; per[name] += 1
        lines.append("%-4s %-15s %s lo_gap %s hi_gap %s meets=%s" % ("%d,%d" % key, name, "CONTAINS" if ok else "FAILS   ",
                     format(ve[0] - se[0], ".3E"), format(se[1] - ve[1], ".3E"), overlap(se, ve)))
if args.report:
    print("\n".join(lines)); print("per-field failures:", per)
print("P3 CONTAINMENT: %s (%d/%d ; cert %s schema %s ; recomputation %s verifier_sha256 %s)" % ("PASS" if failed == 0 else "FAIL", checked - failed, checked,
      args.cert, fv, args.recomputed, R.get("verifier_sha256", "")[:12]))
sys.exit(0 if failed == 0 and checked == 15 * len(FIELDS) else 1)
