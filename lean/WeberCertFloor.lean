import Mathlib
/-!
# weber_general_n: the piecewise trace floor `barT n` (r13; GPT r12 P0, hw 257-266 / tracker 266)

Erratum E13-1: the certificate-soundness prose of r12 wrote the T-route threshold uniformly as
`33 * 2^n`, while the read-only verifier (`scripts/family_verify.sage` line 28) and the literature
use `17 * 2^n` for `n = 2` (MO3 Prop 6.6, valid for every `n >= 2`) and `33 * 2^n` for `n >= 3`
(KY Thm 2.3, stated for `n >= 3` only). This file fixes the threshold as a function of `n`,
records the elementary facts the prose relies on, and instantiates the abstract refutation theorem
`WeberCert.t_witness_refutes_saturation` (WeberCertChainDirect.lean, unchanged) at `barT n`.

No `axiom` declaration and no hole. The literature floors themselves remain hypotheses (`floorT`), as in
WeberCertChainDirect.lean; nothing here verifies the checker implementation (hw 44).
-/

namespace WeberCert

/-- The T-route threshold used by the verifier: `17·2^n` for `n = 2`, `33·2^n` for `n ≥ 3`
(and, by the same formula, for `n ≤ 1`, where no certificate is ever produced). -/
def barT (n : ℕ) : ℕ := if n = 2 then 17 * 2 ^ n else 33 * 2 ^ n

theorem barT_two : barT 2 = 68 := by decide

theorem barT_of_ge_three {n : ℕ} (h : 3 ≤ n) : barT n = 33 * 2 ^ n := by
  unfold barT; rw [if_neg]; omega

theorem barT_seven : barT 7 = 4224 := by decide

/-- The uniform constant `33·2^n` is NOT the verifier's threshold at `n = 2`: the r12 prose
would have accepted a T value in `[68, 132)` there. -/
theorem barT_two_lt_uniform : barT 2 < 33 * 2 ^ 2 := by decide

/-- `barT n ≤ 33·2^n` for every `n`: a line accepted by the verifier's piecewise test is also
accepted by the uniform test; the converse fails exactly at `n = 2`. -/
theorem barT_le_uniform (n : ℕ) : barT n ≤ 33 * 2 ^ n := by
  unfold barT; split_ifs <;> omega

/-- Instantiation of the abstract T-refutation at the piecewise floor: if saturation of a
component forces `T ≥ barT n` on its nonzero vectors (the literature floor as a hypothesis),
then a nonzero vector with `T < barT n` refutes saturation. -/
theorem t_witness_refutes_saturation_barT {Comp : Type} {Vec : Comp → Type} (n : ℕ)
    (saturated : Comp → Prop) (nonzero : ∀ f, Vec f → Prop) (T : ∀ f, Vec f → ℝ)
    (floorT : ∀ f, saturated f → ∀ v, nonzero f v → ((barT n : ℕ) : ℝ) ≤ T f v)
    (f : Comp) (v : Vec f) (hv : nonzero f v) (hlt : T f v < ((barT n : ℕ) : ℝ)) :
    ¬ saturated f := by
  intro hs
  exact absurd (floorT f hs v hv) (not_le.mpr hlt)

end WeberCert

#print axioms WeberCert.barT_two
#print axioms WeberCert.barT_of_ge_three
#print axioms WeberCert.barT_seven
#print axioms WeberCert.barT_two_lt_uniform
#print axioms WeberCert.barT_le_uniform
#print axioms WeberCert.t_witness_refutes_saturation_barT
