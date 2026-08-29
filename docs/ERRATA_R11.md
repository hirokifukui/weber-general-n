# ERRATA_R11 — corrections to the r10 package (2026-08-25)

Both items below are corrections of STATEMENTS or of prose in the r10 package
(weber_general_n_r10_20260825.zip, SHA256 9836ae80...). No certificate, no Lean file and no
number of r10 is affected. Earlier errata: docs/ERRATA_R9.md, ERRATA_R8.md, ERRATA_R7.md, ERRATA_R6.md
(E10-1 .. E10-5 are recorded in docs/LETTER_R10.md and docs/HANDOFF_R11_start_snapshot.md).

## E11-1  "Theorem S" (r10 sect 7.1 / STATEMENT_FREEZE_R10 sect 6) — WITHDRAWN as stated

r10 claimed: "any congruence-depth variant of Theorem A ... is strictly worse than Theorem A for
every t >= 2 (certified t = 2,3,4; monotone thereafter)", and the abstract said congruence-depth
refinements cannot improve the criterion.

What was actually proven: (a) the abstract scale law Lambda_{f,t} = 2^{t-1} Lambda_f under the
hypothesis J_t = 2^{t-1} R_n (Lean, std-3); (b) J_t = 2^{t-1} R_n for t = 2, 3, 4 at n = 7 (exact
rank certificates); (c) the real inequality (2+sqrt5)^{2^{t-1}} > 2^t + sqrt(4^t+1) for
t = 2, 3, 4 (Lean). Not proven: J_t = 2^{t-1} R_n for any t >= 5. "Monotone thereafter" was
therefore a statement about the inequality only, not about the congruence filtration.

Correction (paper sect 1.2, sect 7.1, App E; STATEMENT_FREEZE_R11 sect 6): Theorem S0 = the
abstract scale law + the strict-weakness inequality for EVERY t >= 2, stated with (i) J_t =
2^{t-1} R_n and (ii) the depth-t floor as explicit hypotheses (lean/WeberScalingS0.lean adds
ineq_t_general, std-3); Corollary S1 = the mod 4 / 8 / 16 routes are strictly weaker (t = 2, 3, 4,
where (i) is certified). General t >= 5: OPEN, and the paper says so. The abstract sentence is
replaced accordingly. GPT r10 review sect 3, hw 1-5.

## E11-2  r10 sect 3 ("Comparison"), classes at n = 7 — incomplete and wrong mechanism for class 63

r10 said: "Theorem A is sharper when s > n (classes 1 and 127)", implying that classes 65 and 63
are covered at least as well by the published theorem of MO 2016.

Correction (theory/RESIDUE_CLASS_TABLE.md, sect "per class at n = 7"; paper sect 3.2, Table 2):
three regimes, s compared with n, where 2^s || l - 1 or l + 1 (the class parameter of MO 2016):
- s < n (class 65): the published theorem of MO 2016 is SHARPER than Cor 7 (factor 170); no new band.
- s = n (class 63): the d -> c substitution of MO's proof costs nothing, and Cor 7 is sharper than
  the published G(2,7,2) = 4.52e16 by the constant alone (factor 34: exact covolume + component
  lattice). New band (1.315e15, 4.52e16]. This class was omitted in r10.
- s > n (classes 127, 1): Cor 7 is sharper both by the constant (34x, 1183x against the layer-7
  values) and by not paying the d -> c substitution. New bands (1.315e15, G(2,s,2)], (1.727e30, G(2,s,1)].
The values G(2,s,f) are evaluated from the formula of MO 2016 sect 3.3 (mpmath 30 digits, [MC]) and
are labelled so in the paper. GPT r10 review hw 12.

## Not errata, but withdrawals of r10 prose recorded for completeness

- "The L-product is bounded, so the growth of C_n is that of the Gamma factor alone" (r10 sect 1.2
  and sect 5): deleted; replaced by Remark 1.11 (numerical observation for 2 <= n <= 9 only). hw 9-11.
- "the only lattice vectors available to the T route are the (l-1) centered scalars per component"
  (r10 sect 7.2, class 1): false (non-centered lifts a + l z exist); deleted; the section is an
  E-labelled box describing the implemented search only. hw 6-8.
- CRT_CARRY_IDENTITY_R10 "no bound can be obtained from the factor data and character values alone":
  withdrawn; the document now claims only that Luo-type separable product descent fails. hw 13-14.
- "all load-bearing claims are machine-verified" (r10 sect 8): replaced by "all non-literature finite
  and discrete claims are kernel- or certificate-checked; published inputs are isolated explicitly". hw 112-114.
