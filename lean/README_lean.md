# README_lean — weber_general_n Lean substrate (r15, 2026-08-26)

Toolchain: leanprover/lean4:v4.31.0-rc1; mathlib pin d568c8c09630de097a046763c17b9ea99f95f950
(environment/lean_version.txt). Compile mechanism on node <LOCAL_HOST> (author side):
`cd <LOCAL_LEAN_WORKSPACE> && ~/.elan/bin/lake env lean <workspace copy>` — one file per call; the
run_lean MCP tool routes to <LOCAL_HOST> (same pin) and is not used on <LOCAL_HOST>. Reviewer side: step 09 of
scripts/verify_all_portable.sh with LEAN_WORKSPACE set, or the `lean` job of
.github/workflows/verify.yml (`lake exe cache get` on the pinned mathlib).

Gate (same in every log and in CI): exit 0 AND a `#print axioms` line for every declaration AND
every axiom set within [propext, Classical.choice, Quot.sound] AND none of sorryAx / native_decide /
ofReduceBool / trustCompiler. `compile exit=0` alone never implies sorry-free — only the axiom
lines do. Every compile log ends with `EXIT=<rc>`.

What the Lean layer is and is not. It certifies the DISCRETE reasoning only: group / quotient /
index / coset steps, real inequalities, and the propositional chain from accepted certificates
to non-divisibility, with the literature theorems (KY (17) + Prop 4.1, Blichfeldt, MO Lemma
2.5(1), KY Thm 2.3) as NAMED HYPOTHESES (fields of a structure), never as axioms. It does not
formalise Blichfeldt's theorem, heights, L-values, KY's saturation, the interval arithmetic of
C_7, or the checker implementation (hw 44). Labels: TRUST.md.

## File registry (13 files; md5 of the vault copy)

| file | round | content | log | axioms |
|------|-------|---------|-----|--------|
| WeberExternalResults.lean | r10 | Theorem A discrete core: `TheoremAInputs.theoremA_of_inputs`, threshold form `theoremA_threshold` (Cor T), n=7 deg-2 instance `c7_deg2_instance` | compile10_external.log; re-run r11 (<LOCAL_HOST>, EXIT=0) | std-3 (md5 7b02ece11eeb2230dd1aae58b4e51223) |
| WeberCertFloor.lean | r13 | E13-1 piecewise trace threshold: `WeberCert.barT` (17*2^n at n=2, 33*2^n for n>=3), `barT_two` (=68), `barT_of_ge_three`, `barT_seven` (=4224), `barT_two_lt_uniform`, `barT_le_uniform`, instantiation `t_witness_refutes_saturation_barT` | compile13_webercertfloor.log (EXIT=0, <LOCAL_HOST>) | std-3 (md5 cfcaaf03498365857aa23067a19975c8) |
| WeberCertChainDirect.lean | r11 | direct KY certificate chain (hw 39-43): `WeberCert.exclusion_chain_direct` (no axioms), `rho_witness_refutes_saturation`, `t_witness_refutes_saturation`, `exclusion_of_checker_spec` | compile11_webercertchaindirect.log (EXIT=0) | std-3 (md5 be5e7e921bc70db69d59ad365cc95ef2) |
| WeberScalingNoGo.lean | r9/r10 | Thm S0 discrete core: `coprime_smul_injective`, `smul_mem_iff_of_coprime`; Cor S1 inequalities `ineq_t2/t3/t4` | r10 vault audit (weber_r10_vault_audit.jsonl); re-run r11 (EXIT=0) | std-3 (md5 8a26286b788c7e5d7fd19cf12ad9394c) |
| WeberHatC.lean | r16 | discrete part of Cor A-hat (computation-free criterion, Track A): `WeberHatC.prod_le_pow_card_of_le`, `C_le_hatC`, `theoremA_of_hat` | compile16_weberhatc.log (EXIT=0) | std-3 (md5 c339c0f8) |
| WeberSH.lean | r16 | Theorem SH abstract core (Track A): `WeberSH.H_pow`, `Hι_nsmul`, `base_branch` (Lemma E' abstract), `sat_root_log` (Lemma E typed bridge), `short_vector_ge_floor`, `theoremSH`, `theoremSH_contra` | compile16_webersh.log (EXIT=0) | std-3 (md5 57e5d0bf) |
| WeberLemmaB.lean | r16 | Lemma B (equal factor degrees) fully in Lean: `WeberLemmaB.X_pow_add_one_eq_cyclotomic` (x^{2^n}+1 = Φ_{2^{n+1}}), `coprime_two_pow_of_odd_prime`, `factor_degree` (degree = orderOf ℓ in (Z/2^{n+1})^x, via Mathlib natDegree_of_dvd_cyclotomic_of_irreducible), `factor_degree_eq` | compile16_weberlemmab.log (EXIT=0) | std-3 |
| WeberRoots.lean | r16 | real formal roots / cosets / representative change (hw 675-676): `WeberRoots.odd_pow_injective`, `root_change_rep`, `coset_eq_of_change_rep`, `root_of_pow` | compile16_weberroots.log (EXIT=0) | std-3 |
| WeberP3.lean | r16 | Track B (p = 3) discrete steps: `WeberP3.l1_sq_le_card_mul_l2_sq` (Cauchy–Schwarz), `height_floor_of_l1_floor` (Mahler floor -> Euclidean floor), `theoremP3_core` (Theorem SH core with the p=3 names) | compile16_weberp3.log (EXIT=0) | std-3 (md5 f4ef09a1) |
| WeberP3Rel.lean | r17 | Track B repair (p = 3): `WeberP3Rel.a_cube_modEq_one` ((1+3^n)^3 ≡ 1 mod 3^{n+1}), `four_pow_three_pow` / `four_pow_modEq` (4^{3^{n-1}} ≡ 1+3^n), `telescope_three` + `sin_telescope_step` (relative norm of the Horie unit = 1), `eq_one_of_odd_pow_eq_one` (norm-one transfer), `dft_vanish_of_relnorm` (Fourier coefficient at 3k vanishes), `eq_zero_of_vanish_on_primitiveRoots` (Phi_m | A, deg A < phi(m) ⇒ A = 0), `totient_three_pow`, `pow_val_add_mul` / `twisted_sum_shift` / `twisted_sum_shift_diff` / `twisted_sum_shift_diff_ne_zero` (finite Fourier algebra of Theorem rank3 Step 2 on ZMod N), `pow_third_eq_one_iff` (ω^(Nk/3) = 1 ⇔ 3 | k) | 13 | std-3 (two declarations propext+Quot.sound only) | lean/compile17_weberp3rel.log |
| WeberOddTransfer.lean | r16 | odd-power depth transfer, group core of Lemma oddtransfer (E15-1): `WeberOddTransfer.coprime_two_pow_of_odd`, `pow_odd_eq_one_iff_of_two_pow_card`, `pow_odd_injective_of_two_pow_card`, `pow_odd_eq_iff_of_two_pow_card`, `isUnit_pow_odd_eq_one_iff` (5 decl) | compile15_weberoddtransfer.log (EXIT=0) | std-3 (md5 0c4c8f31f6e05715492fe6e6ba2a65a4) |
| WeberScalingS0.lean | r11 | general-t inequality of Thm S0: `ineq_t_general`, `sqrt_four_pow_add_one_lt`, `le_two_pow_pred`; instances `ineq_t2'/t3'/t4'` | compile11_weberscalings0.log (EXIT=0) | std-3 (md5 54d930c04fe1965e0de565cee323e7d1) |
| WeberR7.lean | r7 | Lemma A (`bridge_fixed_norm_sq`, `torsion_pm_one`), Lemma C (`component_card_quotient`), Lemma E coset step (`coset_absorb`) | compile7.log (EXIT=0); verify_all_lean.log | std-3 (md5 02df070f3414774e40d8d5a8dfaee2a6) |
| WeberR6.lean | r6 | covol bookkeeping; abstract saturation contradiction; `deg1_threshold_valid`, `deg2_threshold_valid` | compile6.log; r10 vault audit | std-3 (md5 1a492e5bcfaf8f4edcfe4e41d54b144b) |
| WeberR8.lean | r8 | index transfer, `odd_smul_bijective`, `card_index_pow` | compile8.log (EXIT=0) | std-3 (md5 c692367af3a1addc4346f0a34af30dc5) |
| WeberChain.lean | r5 | RETIRED from the certificate DAG (Horie / P4 layer, hw 40); kept as a record | compile5.log; r10 vault audit | std-3 (md5 a23d49c6ac2535be6842e1df21f5381c) |
| WeberLuoFiniteGroup.lean | r5 | finite group step of the Luo refutation (`luo_lemma32_k8/k9`); companion note only | compile5.log; r10 vault audit | std-3 (md5 4b17cccdf35821adf31a8c116c9b3e33) |
| WeberCongruence.lean | r5 | congruence bookkeeping | compile4.log; r10 vault audit | std-3 (md5 a721918c004675107b9d49119d6dded3) |
| WeberAntiperiodic.lean | r4 | lambda antiperiodicity skeleton | compile2.log; r10 vault audit | std-3 (md5 1bb5a8e807a3ba49cc6e4cd4b6e55248) |
| WeberAutocorr.lean | r4 | autocorrelation identities | compile2.log; r10 vault audit | std-3 (md5 c4b5880d22ec876e8a71e62d510afa07) |

Load-bearing for the paper: the first twelve rows (these are the files step 09 of the portable
verifier compiles; WeberCertFloor added r13, WeberOddTransfer added r15, WeberHatC, WeberSH, WeberLemmaB, WeberRoots and WeberP3 added r16; WeberP3Rel added r17; in WeberP3.lean the Cauchy–Schwarz lemmas served the r16 Schinzel floor and are no longer load-bearing, `theoremP3_core` is). WeberR6/R7/R8 supply the App A lemmas cited in CORRESPONDENCE.csv. The
remaining five are historical and appear in no claim.

Audit records: weber_r10_vault_audit.jsonl (lean_audit on <LOCAL_HOST>, 9/9 PASS, r10 vault);
compile10_external.log, compile11_*.log (EXIT=0); the r11 boot re-runs of the four load-bearing
files are recorded in HANDOFF.md (STATE AT SEAL R11).

## Correspondence: Lean declaration <-> paper statement (hw 22-23, 45-49)

| Lean declaration | paper | what is formal | what is not |
|------------------|-------|----------------|-------------|
| TheoremAInputs.theoremA_of_inputs | Thm A (sect 4.5) | the inequality contradiction from the three named inputs | the inputs themselves (L) |
| TheoremAInputs.theoremA_threshold | Cor T | threshold arithmetic | — |
| c7_deg2_instance, deg1/deg2_threshold_valid | Cor 7 | integer comparisons against the enclosure bound | the enclosure (C) |
| bridge_fixed_norm_sq, torsion_pm_one | Lemma A | u in RE+_n cap E_{n-1} => u = +-1 (abstract Galois hom) | Gal(B_n/B_{n-1}) = <tau> as instantiation |
| component_card_quotient | Lemma C | [R_n : L_f] = l^{m-d_f} as an F_l-quotient count | the pullback identification (hw 22, bookkeeping) |
| coset_absorb | Lemma E steps 2-3 | every representative of the coset lies in RE+_n | — |
| WeberCert.exclusion_chain_direct | Thm 1.9 (cert. soundness) | saturation-exists + witnesses-refute-saturation + cover => not divisible | KY Prop 4.1, MO floors, KY Thm 2.3 (L); checker code |
| WeberCert.rho/t_witness_refutes_saturation | Thm 1.9 | witness predicate vs saturation predicate | the height / trace floors (L) |
| WeberCert.exclusion_of_checker_spec | Thm 1.9 | "checker spec accepted" => the chain's hypotheses | that the implementation meets the spec (C, read-only checker) |
| coprime_smul_injective, smul_mem_iff_of_coprime | Thm S0 | the exact scaling Lambda_{f,t} = 2^{t-1} Lambda_f under (i) | hypothesis (i) for t >= 5 (OPEN) |
| ineq_t_general (+ t2'..t4') | Thm S0 / Cor S1 | (2+sqrt5)^{2^{t-1}} > 2^t + sqrt(4^t+1), every t >= 2 | the depth-t floor (Lemma depthfloor, L-relative) |
| WeberOddTransfer.pow_odd_eq_one_iff_of_two_pow_card, pow_odd_eq_iff_of_two_pow_card, isUnit_pow_odd_eq_one_iff | Lemma oddtransfer (App E) / Thm S0 both branches | in a group of order 2^k an odd power map is a bijection: x^l = 1 iff x = 1 | that (O_n/2^t O_n)^x is a group of order 2^{2^n t - 1} (2 totally ramified in B_n, residue field F_2): M, proved in the manuscript |

Lemma B (factor degrees) is a hand proof, not formalised (hw 23: declared out of F).
