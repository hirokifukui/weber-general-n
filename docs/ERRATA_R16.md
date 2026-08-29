# ERRATA_R16 — corrections made in r16 against the sealed r15 (2026-08-26)

No mathematical erratum: the GPT r15 review found no new gap ("新しい致命的gapは見つかりませんでした"). The following are the
corrections of its section 2, all presentational or explicitness fixes; none changes a frozen statement except E16-6.

- E16-1 Lemma D used "all archimedean absolute values 1 ⇒ root of unity" without citation. Replaced by the elementary totally-real
  argument (conjugates in {±1} ⇒ minimal polynomial x∓1); Kronecker's theorem named, not needed. (proofs/lem_D.tex)
- E16-2 Lemma E typing residue: the trust-table row "M_{f0} ⊆ RE/A_n" rewritten in coset form; the Blueprint KY node names the
  subgroup of cosets explicitly. Lean: WeberRoots (uniqueness of the real root, representative change), WeberSH.sat_root_log.
- E16-3 Washington's effectivity: "effective in principle, with no numerical bound" → "effective in the sense that a computable
  stabilization bound can be extracted; no numerical specialization of that bound is used here".
- E16-4 Prop D: "contains no new mathematics and is not counted as a contribution" → the role statement (exact normalization).
- E16-5 Magma cross-check: the 57-digit agreement is reported as an observation without an accuracy claim (paper and Blueprint).
- E16-6 Cor T: f_n(B) = max{1, 1 + ⌊log C_n / log B⌋} (statement); the r15 proof already covered C_n < 1 (hypothesis vacuous).
- E16-7 Theorem S0 / Cor S1: the object of "weaker" fixed as the direct filtered-lattice criterion (never "every 2-adic refinement").
- E16-8 Public documents: "the kernel is the arbiter" → trust-boundary wording (which claim is checked by what).
- E16-9 Title: "exclusion for the class-number growth" → "bounds for relative class-number growth"; Z_3 added after Track B.
- E16-10 Abstract: S0 compressed to one clause; Theorem SH / Cor A-hat / Theorem P3 added.
Additions (not errata): Theorem SH, Cor A-hat, Cor order, Theorem P3, Cor P3n4, Lemma B in Lean — see theory/STATEMENT_FREEZE_R16.md.
