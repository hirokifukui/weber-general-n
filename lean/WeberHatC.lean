import Mathlib
/-!
# weber_general_n R16: the discrete part of Corollary A-hat (computation-free criterion)

`hatC` is the constant with the analytic bound `U` in place of the product of `|L(1,χ)|`.
The three declarations below are the discrete steps of proofs/cor_Ahat.tex:

* `prod_le_pow_card_of_le` : a product of `card s` real factors, each in `[0, U]`, is `≤ U ^ card s`;
* `C_le_hatC`              : the constant of Cor. A' with the product replaced by `U ^ m` dominates it;
* `theoremA_of_hat`        : `C ≤ hatC` and `hatC < l^d` give `C < l^d`, which is the hypothesis of the
                             discrete core of Theorem A (`TheoremAInputs.theoremA_of_inputs`, restated here
                             over an abstract carrier so that this file imports only Mathlib).

The analytic input `|L(1,χ)| ≤ U(q)` (Ramaré 2004, Cor. 1) is NOT formalised: it enters only as the
hypothesis `hU`. Footprint: std-3.
-/

namespace WeberHatC

open Finset

/-- A product of real factors, each in `[0, U]`, is at most `U ^ (number of factors)`. -/
theorem prod_le_pow_card_of_le {ι : Type*} (s : Finset ι) (f : ι → ℝ) (U : ℝ)
    (h0 : ∀ i ∈ s, 0 ≤ f i) (hU : ∀ i ∈ s, f i ≤ U) :
    ∏ i ∈ s, f i ≤ U ^ s.card := by
  calc ∏ i ∈ s, f i ≤ ∏ i ∈ s, U := Finset.prod_le_prod h0 hU
    _ = U ^ s.card := Finset.prod_const U

/-- `C_le_hatC`: with `K = 2 (4/π)^{m/2} Γ(2+m/2) ≥ 0`, `Lg = log(2+√5) > 0`, and `m = card s` factors
`|L(1,χ)|` in `[0, U]`,  `K * (∏ |L|) / Lg^m ≤ K * U^m / Lg^m`. -/
theorem C_le_hatC {ι : Type*} (s : Finset ι) (f : ι → ℝ) (U K Lg : ℝ)
    (hK : 0 ≤ K) (hLg : 0 < Lg)
    (h0 : ∀ i ∈ s, 0 ≤ f i) (hU : ∀ i ∈ s, f i ≤ U) :
    K * (∏ i ∈ s, f i) / Lg ^ s.card ≤ K * U ^ s.card / Lg ^ s.card := by
  have hprod := prod_le_pow_card_of_le s f U h0 hU
  have hpos : 0 < Lg ^ s.card := pow_pos hLg _
  exact div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_left hprod hK) hpos.le

/-- The transfer: `C ≤ hatC` and `hatC < ld` give `C < ld` (the hypothesis `hC` of
`TheoremAInputs.theoremA_of_inputs`). Stated as the discrete core itself over an abstract carrier. -/
theorem theoremA_of_hat {Comp : Type} (qDiv : Prop) (saturated : Comp → Prop) (ht : Comp → ℝ)
    (L K D ld hatC : ℝ) (m : ℕ) (hL : 0 < L) (hld : 0 < ld) (_hm : 0 < m)
    (ky41 : qDiv → ∃ f, saturated f)
    (blichfeldt : ∀ f, ht f ^ m ≤ K * D / ld)
    (floor : ∀ f, saturated f → L ≤ ht f)
    (hle : K * D / L ^ m ≤ hatC) (hhat : hatC < ld) : ¬ qDiv := by
  intro hq
  obtain ⟨f, hf⟩ := ky41 hq
  have hLm : 0 < L ^ m := pow_pos hL _
  have h1 : L ^ m ≤ ht f ^ m := pow_le_pow_left₀ (le_of_lt hL) (floor f hf) _
  have h2 : ht f ^ m ≤ K * D / ld := blichfeldt f
  have hC : K * D / L ^ m < ld := lt_of_le_of_lt hle hhat
  have h3 : K * D / ld < L ^ m := by
    rw [div_lt_iff₀ hLm] at hC
    rw [div_lt_iff₀ hld]
    linarith [hC]
  linarith [h1, h2, h3]

end WeberHatC

#print axioms WeberHatC.prod_le_pow_card_of_le
#print axioms WeberHatC.C_le_hatC
#print axioms WeberHatC.theoremA_of_hat
