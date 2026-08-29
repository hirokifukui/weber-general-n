#!/bin/bash
# family_negctl.sh - nine planted negative controls for family_verify.sage (r10 bin 5: nc1-nc5; r11 hw 61: nc6-nc7 header tampering;
# r13 E13-1: nc8 = n>=3 header claiming the n=2 floor 17*2^n, nc9 = n=2 header claiming the uniform 33*2^n).
# Each corrupted copy of a PASSING witness file must be REJECTED (verdict NOT_EXCLUDED / FAIL).
# Usage: bash scripts/family_negctl.sh certificates/family/KY1000/witness_n7_l1000000321.txt [certificates/experiments/n2_floor_control/witness_n2_l17.txt]
set -u
if [ -z "${SAGE_BIN:-}" ]; then SAGE="$(command -v sage || true)"; else SAGE="$SAGE_BIN"; fi
[ -x "$SAGE" ] || { echo "family_negctl: sage not found (set SAGE_BIN)"; exit 2; }
SRC="$1"; HERE="$(cd "$(dirname "$0")" && pwd)"; TMP="$(mktemp -d)"
SRC2="${2:-$HERE/../certificates/experiments/n2_floor_control/witness_n2_l17.txt}"
python3 - "$SRC" "$TMP" "$SRC2" <<'PY'
import sys, re
src, tmp, src2 = sys.argv[1], sys.argv[2], sys.argv[3]
L = open(src).read().splitlines()
wl = [i for i, s in enumerate(L) if s.startswith("f = ")]
# (1) one witness coefficient altered (+1)
A = L[:]; s = A[wl[0]]; head, co = s.rsplit("| coeffs ", 1); c = co.split(","); c[5] = str(int(c[5]) + 1); A[wl[0]] = head + "| coeffs " + ",".join(c)
open(tmp + "/nc1_coeff_altered.txt", "w").write("\n".join(A) + "\n")
# (2) factor identifier swapped to another component (witness kept)
B = L[:]; f0 = re.match(r'f = ([-0-9,]+) ', L[wl[0]]).group(1); f1 = re.match(r'f = ([-0-9,]+) ', L[wl[2]]).group(1)
B[wl[0]] = L[wl[0]].replace("f = " + f0 + " ", "f = " + f1 + " ", 1)
open(tmp + "/nc2_factor_swapped.txt", "w").write("\n".join(B) + "\n")
# (3) claimed bound altered (halved)
C = L[:]; s = C[wl[1]]; m = re.search(r'\| claimed ([-0-9.eE+]+) ', s); C[wl[1]] = s.replace("| claimed " + m.group(1) + " ", "| claimed %s " % (float(m.group(1)) / 2), 1)
open(tmp + "/nc3_claim_altered.txt", "w").write("\n".join(C) + "\n")
# (4) one bit of l corrupted in the header (l -> l xor 2)
D = L[:]; m = re.search(r'l = (\d+) ;', D[0]); lv = int(m.group(1)); D[0] = D[0].replace("l = %d ;" % lv, "l = %d ;" % (lv ^ 2), 1)
open(tmp + "/nc4_l_bitflip.txt", "w").write("\n".join(D) + "\n")
# (5) duplicate component line
E = L[:]; E.insert(wl[3] + 1, L[wl[3]])
open(tmp + "/nc5_duplicate.txt", "w").write("\n".join(E) + "\n")
# (6) header ncomp decremented (r11)
F = L[:]; F[0] = re.sub(r'ncomp = (\d+)', lambda m: "ncomp = %d" % (int(m.group(1)) - 1), F[0], count=1)
open(tmp + "/nc6_header_ncomp.txt", "w").write("\n".join(F) + "\n")
# (7) header bar_T incremented (r11)
G = L[:]; G[0] = re.sub(r'bar_T = (\d+)', lambda m: "bar_T = %d" % (int(m.group(1)) + 1), G[0], count=1)
open(tmp + "/nc7_header_barT.txt", "w").write("\n".join(G) + "\n")
# (8) r13 E13-1: n >= 3 header claiming the n = 2 floor 17*2^n (the verifier recomputes bar_T from n and must reject)
H = L[:]; nn = int(re.search(r'n = (\d+) ;', H[0]).group(1)); assert nn >= 3
H[0] = re.sub(r'bar_T = (\d+)', "bar_T = %d" % (17 * 2**nn), H[0], count=1)
open(tmp + "/nc8_header_17floor_n%d.txt" % nn, "w").write("\n".join(H) + "\n")
# (9) r13 E13-1: n = 2 header claiming the uniform 33*2^n = 132 (must be rejected; the true n = 2 floor is 68)
L2 = open(src2).read().splitlines(); n2 = int(re.search(r'n = (\d+) ;', L2[0]).group(1)); assert n2 == 2, n2
assert re.search(r'bar_T = 68 ;', L2[0]), L2[0]
I = L2[:]; I[0] = I[0].replace("bar_T = 68 ;", "bar_T = 132 ;", 1)
open(tmp + "/nc9_n2_header_uniform132.txt", "w").write("\n".join(I) + "\n")
PY
# positive control for (9): the untouched n = 2 file (bar_T = 68) must be EXCLUDED
pos="$("$SAGE" "$HERE/family_verify.sage" "$SRC2" 2>&1 | tail -2 | tr '\n' ' ')"
if echo "$pos" | grep -q "FAMILY VERIFY PASS"; then echo "n2 positive control (bar_T = 68): EXCLUDED (correct) :: $pos"; else echo "n2 positive control (bar_T = 68): NOT ACCEPTED (WRONG) :: $pos"; rc_pos=1; fi
rc_all=${rc_pos:-0}
for f in "$TMP"/nc*.txt; do
  out="$("$SAGE" "$HERE/family_verify.sage" "$f" 2>&1 | tail -2 | tr '\n' ' ')"
  if echo "$out" | grep -q "FAMILY VERIFY FAIL"; then v="REJECTED (correct)"; else v="ACCEPTED (WRONG)"; rc_all=1; fi
  echo "$(basename "$f"): $v :: $out"
done
echo "NEGATIVE CONTROLS $( [ $rc_all -eq 0 ] && echo ALL_REJECTED || echo SOME_ACCEPTED )"
rm -rf "$TMP"; exit $rc_all
