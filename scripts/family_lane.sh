#!/bin/bash
# family_lane.sh <primefile> <laneid> [n] [bkz] - one lane of the family run; ledger per lane; KILL file stops it.
SAGE="${SAGE_BIN:-$(command -v sage || true)}"  # r11: no author-machine fallback (hw 85)
[ -x "$SAGE" ] || { echo "$0: sage not found (set SAGE_BIN)"; exit 2; }
HERE="$(cd "$(dirname "$0")" && pwd)"; PF="$1"; LANE="$2"; N="${3:-7}"; BKZ="${4:-40}"
OUT="$(dirname "$PF")"; LEDGER="$OUT/LEDGER_$LANE.txt"
echo "# lane $LANE started $(date)" >> "$LEDGER"
while read -r l; do
  [ -z "$l" ] && continue
  [ -f "$OUT/KILL" ] && { echo "# KILL seen $(date)" >> "$LEDGER"; break; }
  if [ -f "$HERE/../certificates/family/witness_n${N}_l${l}.txt" ] && grep -q '# summary' "$HERE/../certificates/family/witness_n${N}_l${l}.txt"; then
    echo "$(grep '# summary' "$HERE/../certificates/family/witness_n${N}_l${l}.txt") (reused)" >> "$LEDGER"; continue
  fi
  "$SAGE" "$HERE/family_gen.sage" "$N" "$l" "$BKZ" > "$OUT/gen_n${N}_l$l.log" 2>&1
  grep 'FAMILY GEN n=' "$OUT/gen_n${N}_l$l.log" >> "$LEDGER" || echo "FAMILY GEN n=$N l=$l : ERROR (no summary line)" >> "$LEDGER"
done < "$PF"
echo "# lane $LANE finished $(date)" >> "$LEDGER"; echo "LANE $LANE DONE" >> "$LEDGER"
