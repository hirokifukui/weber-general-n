# ERRATA_R15 — corrections to the r14 package (2026-08-26, after the GPT r14 review)

The r14 package is weber_general_n_r14_20260826.zip (SHA256 94b239d27015a6ff16bd0757091072b0c6a0d65e6db46bd6f1dc0ae7aeac45d8).
Earlier errata: docs/ERRATA_R14.md (E14-1..E14-4), ERRATA_R13 (E13-1), ERRATA_R12 (E12-1..E12-7), ERRATA_R11 (E11-1, E11-2), ERRATA_R9/R8/R7/R6.
One theorem statement change in r15 (Theorem S0, E15-1). One new lemma (Lemma oddtransfer). No new primes, no new experiments.

## E15-1  Theorem S0/S1: the proof passed from the depth of u_a = r_a^l to the depth of r_a without a lemma — PROOF GAP in a method-limit theorem, fixed r15 (GPT r14 sect 4, hw 525-538)

What was wrong (r11..r14, verbatim site): proofs/thm_S0.tex (r14 text, 789 characters) — "The depth-t variant needs a nonzero v in
Lambda_{f_0,t} with |v| < L_{n,t} (hypothesis (ii))". The filtration J_t = {a : u_a == 1 (mod 2^t)} is a condition on u_a = r_a^l
(non-base branch) or u_a = u_b^l (base branch, a = l b), while the depth-t floor (hypothesis (ii) of the r14 statement, Lemma depthfloor)
is applied to the unit whose height is |v|: r_a, resp. u_b. That r_a == 1 (mod 2^t) follows from r_a^l == 1 (mod 2^t) is true but is
NOT automatic; it needs that the l-th power map is injective on (O_n/2^t O_n)^x. This step was not written in any round.
- Re-derived on <LOCAL_HOST> 2026-08-26 before the fix: thm_S0.tex names neither the unit nor its depth [MC]; the needed lemma holds because 2 is
  totally ramified in B_n with residue field F_2 (every unit is == 1 mod p, so 1+x+...+x^(l-1) == l == 1 mod p is a p-unit and
  v_p(x^l - 1) = v_p(x - 1); equivalently (O_n/2^t O_n)^x is a group of order 2^(2^n t - 1) and an odd power map on it is a bijection).

What was NOT wrong: Theorem A, Proposition D, C_n, Corollary 7, Certificate Soundness, the KY1000 Family Theorem and every certificate.
None of them uses J_t, the depth-t floor or an l-th root modulo 2^t. The inequality (2+sqrt5)^{2^{t-1}} > 2^t + sqrt(4^t+1) (F) and the
group lemma L cap 2^{t-1}R = 2^{t-1}L (F) are unchanged. The conclusion of S0/S1 (the depth-4/8/16 routes are strictly weaker) is unchanged.

Fix (r15):
- NEW Lemma oddtransfer (odd-power depth transfer), Appendix E, proofs/lem_oddtransfer.tex: for t >= 1, l odd and units x, y of O_n,
  x^l == 1 (mod 2^t O_n) iff x == 1, and x^l == y^l iff x == y. Proof in four steps (2 totally ramified in B_n, residue field F_2, stated and
  proved from 2 = unit * (1-zeta)^{2^{n+1}}; |(O_n/2^t O_n)^x| = 2^{2^n t - 1}; odd power map is a bijection [F]; transfer), plus the
  valuation form as a remark. Lean group core: lean/WeberOddTransfer.lean, 5 declarations
  (coprime_two_pow_of_odd, pow_odd_eq_one_iff_of_two_pow_card, pow_odd_injective_of_two_pow_card, pow_odd_eq_iff_of_two_pow_card,
  isUnit_pow_odd_eq_one_iff), #print axioms std-3, lean/compile15_weberoddtransfer.log.
- Theorem S0 restated with hypothesis (i) only (GPT r14 answer (2): yes). The r14 hypothesis (ii) is Lemma depthfloor (unchanged proof,
  its closing sentence reworded). proofs/thm_S0.tex rewritten (3285 characters): lattice half; what the depth-t variant needs, with BOTH
  branches explicit (non-base: r_a^l = u_a, Lemma oddtransfer, Lemma depthfloor; base: u_b^l = u_{lb} = u_a, same two lemmas); comparison.
- Blueprint: new node lem:oddtransfer [M, F-core] with \lean{...} (no \leanok: the number-field part is M); thm:S0 \uses lem:E, lem:Eprime,
  lem:depthfloor, lem:oddtransfer; cor:S1 \uses lem:oddtransfer. Graph 49 nodes / 63 edges (r14: 48 / 58).
- CLAIMS_R15: THM_S0 restated (label "M relative to (i); F-core"), NEW claim LEM_ODDTRANSFER (28 claims, r14: 27); CORRESPONDENCE.csv
  regenerated; STATEMENT_FREEZE_R15 item 6.
- Trust label of Theorem S0: r14 "F-relative to (i),(ii)" -> r15 "M relative to (i); F-core". The r14 label over-stated the kernel
  coverage: only the group lemma and the inequality were F; the floor application was never F.

## E15-2  "verified in three independent systems" over-described the 2-adic rank certificates — WORDING, fixed r15 (GPT r14 sect 5, hw 539)

What was wrong (r9..r14): proofs/cor_S1.tex and blueprint lem:Jt ("three-way verified"). The three systems are Sage
(sage/r8_twoadic_depth_exact.sage, exact construction), Magma (sage/r8_twoadic_rank_magma.m, independent exact construction) and
scripts/verify_twoadic_rank.py, which does NOT construct anything: it reads the saved F_2 bit matrices of certificates/twoadic_rank/
and recomputes their rank and pivot columns (its header says so; re-read on <LOCAL_HOST> 2026-08-26 [MC]).
Fix: "constructed independently in Sage and in Magma, and replayed by a standalone Python rank checker (a replay of the stored bit
matrices, not a third construction)" in proofs/cor_S1.tex, blueprint lem:Jt, CLAIMS_R15 COR_S1, STATEMENT_FREEZE_R15.

## E15-3  Self-referential release protocol withdrawn — RELEASE ENGINEERING, fixed r15 (GPT r14 sect 7, question (1), hw 551-561)

What was wrong (r13, r14): RELEASE_STATUS.md proposed to append a "Sealed: r<n>" block (run id / URL / commit SHA of the CI run) to the
repository AFTER the verifier and CI had run on the tree — the verified tree and the released tree would differ, and the commit that
carries the run id needs a run of its own. Fix: RELEASE_STATUS.md rewritten (r15 candidate block; no post-verification edit of any
tracked file; the CI attestation ci_attestation.json is a release ASSET generated by the aggregator job, never committed); the
Blueprint PDF and the paper carry the round only, no commit SHA; verify.yml uploads the attestation as an artifact for the release.

## E15-4  Record errors (HANDOFF only, not in the package): the r14 SEAL record wrote "paper 20 pp"; the r14 PDF has 21 pages (pypdf,
GPT r14 sect 9). Corrected in the vault HANDOFF; no package file carried the wrong count.
