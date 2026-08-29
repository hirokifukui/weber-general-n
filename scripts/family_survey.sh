#!/bin/bash
# family_survey.sh - detached survey driver (r10 bin 5): first K primes > 1e9 in classes 65 / 63 / 127 mod 128 at n = 7.
# Writes one witness file per prime (family_gen) and a one-line ledger entry; never touches existing files elsewhere.
SAGE="${SAGE_BIN:-$(command -v sage || true)}"  # r11: no author-machine fallback (hw 85)
[ -x "$SAGE" ] || { echo "$0: sage not found (set SAGE_BIN)"; exit 2; }
HERE="$(cd "$(dirname "$0")" && pwd)"; OUT="$HERE/../sage/family_survey"; mkdir -p "$OUT"
LEDGER="$OUT/SURVEY_LEDGER.txt"
PRIMES="$("$SAGE" -c '
K65,K63,K127=24,8,8
out=[]
for cls,K in ((65,K65),(63,K63),(127,K127)):
    p=next_prime(10**9); c=0
    while c<K:
        if p%128==cls: out.append(str(p)); c+=1
        p=next_prime(p)
print(" ".join(out))' 2>/dev/null | tail -1)"
echo "# survey started $(date) ; primes: $PRIMES" >> "$LEDGER"
for l in $PRIMES; do
  [ -f "$OUT/KILL" ] && { echo "# KILL seen $(date)" >> "$LEDGER"; break; }
  "$SAGE" "$HERE/family_gen.sage" 7 "$l" 40 > "$OUT/gen_n7_l$l.log" 2>&1
  grep 'FAMILY GEN n=' "$OUT/gen_n7_l$l.log" >> "$LEDGER" || echo "FAMILY GEN n=7 l=$l : ERROR (no summary line)" >> "$LEDGER"
done
echo "# survey finished $(date)" >> "$LEDGER"
echo "R10 FAMILY SURVEY DONE" >> "$LEDGER"
