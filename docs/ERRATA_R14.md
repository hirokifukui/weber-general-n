# ERRATA_R14 — corrections to the r13 package (2026-08-26, after the GPT r13 review)

The r13 package is weber_general_n_r13_20260825.zip (SHA256 a80c26e20740505d54a646c415c0cc4512d19c97bc69227478da686b9d24b991).
Earlier errata: docs/ERRATA_R13.md (E13-1), ERRATA_R12 (E12-1..E12-7), ERRATA_R11 (E11-1, E11-2), ERRATA_R9/R8/R7/R6.
No theorem statement changes in r14. No new mathematics.

## E14-1  A truncated 35-digit display of C_7 carried the 2.2e-115 ball radius — DISPLAY / CERTIFICATE-REPRESENTATION ERROR, fixed r14 (GPT r13 sect 2, hw 387-406)

What was wrong (r12 and r13, verbatim sites):
- main_R13.tex l.67 (Cor 7) and l.357 (Lemma C7), blueprint/src/content.tex l.214 (lem:C7), theory/STATEMENT_FREEZE_R13.md item 5,
  docs/CLAIMS_R13.yaml C7_ENCLOSURE, CORRESPONDENCE.csv: "C_7 = 1.7273421630363529579743237623519834 x 10^30, error at most 2.2 x 10^-115".
  The displayed mantissa is a 35-digit TRUNCATION; the certified value continues ...834054033045619... The displayed number lies
  5.4033 x 10^-6 OUTSIDE the ball of radius 2.17 x 10^-115 (re-derived on <LOCAL_HOST> 2026-08-26 from the 500-bit balls; sage/r14_cn_interval.log).
  A display value and a certification radius of different scales were combined into one false assertion.
- certificates/constants/Cn_digamma_r12.json (now certificates/superseded/): C_lo == C_hi as strings in ALL 8 rows (n = 2..9), because
  sage/r11_propD_audit.sage printed the endpoints through RealField(80) (n != 7) / RealField(120) (n = 7); the trailing digits of those
  strings ("...834061" at n = 7; "...274995" at n = 4) are binary-rounding artifacts, not digits of the decimal expansion. The JSON could
  not reconstruct the enclosure; rigour rested on re-running the Sage source.

What was NOT wrong:
- The 500-bit ball itself (radius 2.1671821868e-115 at n = 7) and every integer comparison. The frozen integer thresholds
  T1 = 1727342163036353095979941756929 (deg 1) and 1314283897427172 (deg 2) are unchanged since r6 (lean/WeberR6.lean,
  lean/WeberExternalResults.lean, std-3); margins C_7^+ -> T1: 1.38e14, -> 1314283897427173^2: 6.84e15.
- Theorem A, Cor A', Cor T, the KY1000 family and every Lean file.

Fix (r14):
- certificates/constants/Cn_interval_r14.json (format 2) from sage/r14_cn_interval.sage (same arithmetic as r11 part (e); output only):
  both endpoints from the EXACT binary endpoints of the ball, rounded OUTWARD to 160 significant digits (lower ROUND_FLOOR, upper
  ROUND_CEILING), midpoint, radius upper bound, precision bits and rounding convention as separate fields, certified common-prefix
  digits (145 at n = 7), and the paper display = truncation of that prefix to 38 digits carrying ONLY its truncation bound (< 1e-7).
  The script asserts: endpoint strings differ, lo < hi, prefix >= display digits, C_7^+ < T1 and < 1314283897427173^2 (frozen
  integers, NOT regenerated). Every medium now prints C_7 = 1.7273421630363529579743237623519834054... x 10^30 and refers to the
  certificate for the enclosure (width < 5e-115 as a property of the certificate, never attached to the display).
- tools/gen_cn_certs.py v2 reads the certificate (not the log), re-validates it, and generates Table tab:Cn (radius column for every n).
- tools/check_constant_sync.py (verifier step 00c) requires the certificate's display string in every medium and forbids the r12/r13
  forms; tools/negctl_tools_r14.py (step 00d) plants 13 defects (altered digit, equal endpoints, lo > hi, changed threshold, sha
  mismatch, inflated prefix, stale prose) and requires each to be caught.

## E14-2  "Seven negative controls" survived in four places of a synchronisation round — PROSE DESYNC, fixed r14 (GPT r13 sect 4, hw 417-434)

Sites (r13): blueprint/src/content.tex l.297 "negative controls 7/7 rejected"; main_R13.tex l.246 "seven planted corruptions"
(while l.259, Table 5, said 9/9 — the paper disagreed with itself); TRUST.md l.21 "Seven planted negative controls";
theory/STATEMENT_FREEZE_R13.md l.145 "7 negative controls". The r13 run had 9 negative controls + the n = 2 positive control
(sage/negctl_r13/negctl_r13.log). RELEASE_STATUS.md "Sealed: r11/r12" blocks say 7/7 and are historically correct (not edited).
Fix: certificates/negctl/negctl_ledger_r14.json (tools/gen_negctl_ledger.py, parsed from the log; --check) is the single source;
step 00c requires "9/9" / "nine" / "9 negative" in paper, Blueprint, README, TRUST, FREEZE and the r14 RELEASE_STATUS block and
forbids every other count in negative-control context (the KY1000 target-list verifier's own 5 planted corruptions, step 03c,
are a different control set and exempt by context).

## E14-3  Magma "inside ball" test used a tolerance of 1e10 — MEANINGLESS AUDIT CODE, withdrawn r14 (GPT r13 sect 3, hw 407-416)

Site: sage/r11_propD_audit.sage l.83: inside := (lo <= v <= up) or |v - up| < 1e10, printed as "Magma 40-digit value ... inside ball: True".
With a ball radius of 1e-115 this is a cross-check of leading digits, not an inclusion test; the phrase "inside ball" was false.
Fix: sage/r14_cross_cas_audit.sage -> certificates/constants/C7_cross_cas_r14.json. Each route becomes an interval with its own trust
level: r6 interval determinant at 256/512/1024 bits (rigorous; the four rigorous enclosures must intersect and the narrower must lie
inside the wider — all nested; the 256-bit upper endpoint + 1 is the origin of T1), Magma (heuristic interval v(1 -+ 1e-37) from the
vendor's 40-digit L-series precision, 64 factors; intersection checked; 57 leading digits agreeing with the certified prefix REPORTED
separately), PARI (200-bit ln D_7 inside the 256-bit rigorous interval; the 60-digit run's discrepancy 4.6e-17 recorded, trust LOW).
Cross-CAS routes are numerical audits (E) of the C-labelled certificate, not part of it. The r11 script/log stay in place because
their parts (a)-(d) remain live evidence for lem:D0 / lem:prod13 / prop:D; only part (e) is superseded.

## E14-4  verify_all_portable.sh printed "VERIFY_ALL_PORTABLE r13: PASS" when Sage and Lean steps were skipped — VERIFIER SEMANTICS, fixed r14 (GPT r13 sect 5, hw 435-454)

Site: scripts/verify_all_portable.sh l.300 (r13): PASS iff FAIL == 0; SKIP (l.197 Sage, l.232 Lean, l.241/253 PDFs) never set FAIL.
A run with SKIP_SAGE=1 and no LEAN_WORKSPACE therefore ended with the same PASS line as a full run. Fix: VERIFY_PROFILE=full|sage|lean
(see the script header and docs/LETTER_R14.md); in profile full every skip is a FAIL; partial profiles print SAGE_PROFILE / LEAN_PROFILE
PASS and never the FULL line; skip counts are in the structured summary; tools/verifier_profile_tests.sh plants SKIP_SAGE=1 / no
LEAN_WORKSPACE under profile full and requires FAIL.
