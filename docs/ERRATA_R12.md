# ERRATA_R12 — corrections to the r11 package (2026-08-25, after the GPT r11 review)

All items below are corrections of PROSE or of self-reported gate status in the r11 package
(weber_general_n_r11_20260825.zip, SHA256 9de2831288281fdc2822a32ff1cbc16074457cdf40d9118cc3d5fb8cc974af68).
No theorem statement, certificate, Lean file or number of r11 is withdrawn. Earlier errata:
docs/ERRATA_R11.md (E11-1, E11-2), ERRATA_R9/R8/R7/R6.

## E12-1  "the constant C_n grows super-exponentially with n (Cor. A')" — WITHDRAWN (GPT r11 sect 4; hw 127/128)
r11 sect 3 (main_R11.tex line 112) asserted an asymptotic growth of C_n and drew from it that the
range covered by Theorem A and not by MO16 is "a bounded band" for every n. Cor. A' gives
C_n = 2 (4/pi)^{m/2} Gamma(2+m/2) prod|L(1,chi)| / log(2+sqrt5)^m and no lower bound on the
L-product is proved for n >= 10; the Gamma factor alone gives no lower growth rate of C_n. The
sentence contradicted Remark 1.11 ("nothing is claimed for n >= 10"). Replaced by the numerical
statement for 2 <= n <= 9 (Table tab:Cn) with an explicit "nothing is claimed for n >= 10".
Consequence: our r11 self-report "gate 3 PASS" was wrong (the L-product claim was deleted but
this second asymptotic claim remained); we record gate 3 as PARTIAL for r11.

## E12-2  "the verification replays from a clean checkout" (abstract) — WITHDRAWN (GPT sect 2; hw 129)
No clean-checkout replay has been executed (docker absent on every author machine; the GitHub
Actions workflow has never run, and as written it would fail: see E12-6). The abstract now makes
no replay claim; sect 8 describes the Dockerfile and workflow as "not yet executed".

## E12-3  "All non-literature finite and discrete claims are kernel- or certificate-checked" — WITHDRAWN (GPT sect 3; hw 130-132)
Lemma B (factor degrees), Lemma C pullback bookkeeping, Lemma D (rank/discreteness/covolume),
Lemma E', Prop F, Prop D (group determinant, character normalisation), Cor A' and the old/new
decomposition are proved in the manuscript and not machine-checked. The taxonomy gains the label
M (manuscript/Blueprint proof); CLAIMS_R12.yaml reclassifies these claims; the abstract and
sect 8 say "designated finite computations and selected discrete cores".

## E12-4  Table 2 header "range covered here and by no published theorem" — WITHDRAWN (GPT sect 5; hw 133/134)
A novelty claim while hw 122 (post-2021 literature reading) is open; replaced by "range not
covered by the comparison theorems listed here". Sect 6.3 "reached by no uniform theorem" is
likewise restricted to the theorems compared in Table 2.

## E12-5  old/new decomposition lemma: "l | h_L/h_K" — REWORDED (GPT sect 8; hw 137)
For a general cyclic extension L/K the quotient h_L/h_K need not be an integer. The lemma's own
conclusion |Cl(L)_l| = |Cl(K)_l| |ker(N)_l| gives v_l(h_L) - v_l(h_K) = v_l(|ker(N)_l|) >= 0, so
the statement is now "v_l(h_L) > v_l(h_K) iff ker(N)_l != 0". In the Weber tower k_n = h_n/h_{n-1}
is an integer (KY index formula) and the specialisation is the usual divisibility. Mathematics unchanged.

## E12-6  Self-reported gate 12 "PASS with a stated limit" — RETRACTED (GPT sect 6; hw 171-190)
blueprint/src/content.tex (184 lines) contains 41 statement environments and 0 proof environments;
check_graph.py tests only dangling \uses and \leanok-without-\lean. It is a dependency map, not a
proof document. r11 gate 12 is recorded as NO-GO. Also confirmed after the review (GPT sect 1,
hw 142): .github/workflows/verify.yml creates the Lean workspace at repo-root ws/ (line 43) while
tools/gen_manifest.py does not exclude ws/, so manifest step 01 would fail with UNLISTED ws/...
on the first run — a deterministic bug, corrected in r12 (LEAN_WORKSPACE under $RUNNER_TEMP).

## Wording restricted (not errata): Cor S1 / abstract "congruence-depth refinements" -> "direct
filtered-lattice refinements at depths 4, 8, 16"; abstract "Below these thresholds the same
components admit finite certificates" -> "For selected primes below these thresholds, finite
certificates ... can be supplied"; "about 4 x 10^9 primes" marked as an estimate.

## E12-7  r11 verifier step 09 (Lean axiom gate) did not parse primed declaration names — GATE HOLE, fixed r12
The r11 regex `'([^']+)' depends on axioms` could not match names containing a prime (ineq_t2', ineq_t3',
ineq_t4' in lean/WeberScalingS0.lean), so those three declarations were counted neither as checked nor as
failing; the r11 step passed on the other three. No axiom was actually wrong (the four files were kernel-run
by hand at every session start, all 18 declarations std-3 — HANDOFF, lean/README_lean.md), but the *gate*
covered 15 of 18 declarations. r12 anchors the regex at line start, matches up to the last quote, and asserts
the declaration count per file (3 / 5 / 4 / 6). Found during the r12 seal run by comparing the gate's
declaration count with the boot-ritual count.
