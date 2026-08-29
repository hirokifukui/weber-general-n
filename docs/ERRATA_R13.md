# ERRATA_R13 — corrections to the r12 package (2026-08-25, after the GPT r12 review)

The r12 package is weber_general_n_r12_20260825.zip (SHA256 be3c11ddc65b8463e1e1f412f012d8f71fdd18d7c71dfe2ef0922e9009a43052).
Earlier errata: docs/ERRATA_R12.md (E12-1..E12-7), ERRATA_R11 (E11-1, E11-2), ERRATA_R9/R8/R7/R6.

## E13-1  Certificate-soundness prose used the uniform T-threshold 33·2^n; the verifier and the literature use 17·2^n at n = 2 — PROSE / SPEC-DEFINITION ERROR, fixed r13 (GPT r12 sect 3, hw 257-272)

What was wrong (r12, verbatim sites):
- proofs/thm_cert.tex (single source, \input by paper sect 6.2 and Blueprint thm:cert): "a T line asserts ... < 33·2^n,
  contradicting KY Thm 2.3 (or MO3 Prop 6.6 at n = 2)". At n = 2 a value 68 <= T < 132 satisfies the written inequality
  and contradicts nothing: MO3 Prop 6.6 gives Tr(eps^2) >= 17·2^n = 68 there, and KY Thm 2.3 (33·2^n) is stated for n >= 3 only.
- blueprint/src/content.tex def:verifier: "(T) sum e^{2y_j} < 33·2^n" as the definition of what the verifier accepts.
  Read with this definition, the Blueprint theorem thm:cert is false at n = 2 (for a hypothetical verifier accepting T < 132).
- theory/STATEMENT_FREEZE_R12.md item 7 proof shape: "trace floor 33 * 2^n".
- paper main_R12.tex l.35 (intro: KY "prove an unconditional trace floor 33·2^n", without "n >= 3") and l.92 (Table 1, "floor 33·2^n").

What was NOT wrong:
- scripts/family_verify.sage l.28: `BAR = 33*2**n if n >= 3 else 17*2**n`, and l.29 rejects a header whose bar_T differs from this
  recomputation. sha256 0f38bb0d unchanged since r11; the verifier is not modified in r13.
- The paper's theorem statement thm:cert ("if the read-only verifier of Section 6 returns EXCLUDED then l does not divide k_n")
  refers to the script and is true as stated; its proof text was wrong.
- KY1000 (n = 7): bar_T = 33·2^7 = 4224 on both readings; every certificate, ledger line and negative control is unaffected.
- Blueprint lem:ky23, FAMILY_CERTIFICATE_SPEC_R10 sect 4, main_R12 l.230 (generator paragraph), family_gen/escalate.sage,
  the docstring of WeberCert.t_witness_refutes_saturation: all piecewise already. The Lean theorem takes `bar : R` as a parameter.

Fix (r13): bar_T_n := 17·2^n (n = 2), 33·2^n (n >= 3) defined once in the paper (sect 1.2 before Thm 1.9, macro \barT) and used in
sect 6; proofs/thm_cert.tex rewritten with the piecewise floor and the explicit remark that the uniform constant fails at n = 2;
Blueprint def:verifier states the piecewise floor and points to lem:ky23; STATEMENT_FREEZE_R13 item 7; CLAIMS_R13 THM_CERT status;
Lean: lean/WeberCertFloor.lean (new file; the four frozen files untouched) with `WeberCert.barT`, barT_two (= 68), barT_of_ge_three,
barT_seven (= 4224), barT_two_lt_uniform, barT_le_uniform and t_witness_refutes_saturation_barT, all std-3 (kernel run on <LOCAL_HOST>
2026-08-25). Negative control nc8 (an n >= 3 witness whose header claims the 17-floor) added to scripts/family_negctl.sh; the n = 2
negative control (header claiming 132) is recorded in docs/N2_FLOOR_AUDIT_R13.md with its pilot status. A constant-sync check
(tools/check_floor_sync.py) compares the verifier line, the Lean definition, the Blueprint lemma and the paper macro.

Found by GPT (r12 review sect 3), not by us. The self-audit lesson is recorded in TRUST.md sect "known limits": the r12 seal checked
that code, Lean and prose each pass their own gates, not that they state the same constant.
