import Mathlib
/-!
# weber_general_n: the anti-periodic reduction (Lemma AP consequences)
Given the 128 log-coordinates with y_{j+64} = -y_j (from Nm_{B7/B6}(eps) = +-1),
the quadratic mass halves to 64 dims and the exponential mass has floor 128.
-/

/-- Split: if `y (j+64) = -y j` on `Fin 128` (lower-half indexing), then
`sum y^2 = 2 * (lower-half sum)`. -/
theorem antiperiodic_sq_split (y : Fin (64+64) → ℝ)
    (h : ∀ j : Fin 64, y (Fin.natAdd 64 j) = - y (Fin.castAdd 64 j)) :
    ∑ j : Fin (64+64), (y j)^2 = 2 * ∑ j : Fin 64, (y (Fin.castAdd 64 j))^2 := by
  have e := Fin.sum_univ_add (f := fun j : Fin (64+64) => (y j)^2)
  rw [e]
  have : ∀ j : Fin 64, (y (Fin.natAdd 64 j))^2 = (y (Fin.castAdd 64 j))^2 := by
    intro j; rw [h j]; ring
  rw [Finset.sum_congr rfl (fun j _ => this j)]
  ring

/-- Exponential-mass floor: `sum_j 2*cosh(2 y_j) >= 128` over the 64 reduced coordinates
(so T >= 128 for every vector, with equality only at y = 0). -/
theorem cosh_mass_floor (y : Fin 64 → ℝ) :
    (128:ℝ) ≤ ∑ j : Fin 64, 2 * Real.cosh (2 * y j) := by
  have h1 : ∀ j ∈ Finset.univ, (2:ℝ) ≤ 2 * Real.cosh (2 * y j) := by
    intro j _
    have := Real.one_le_cosh (2 * y j)
    linarith
  have h2 := Finset.sum_le_sum h1
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul] at h2
  norm_num at h2
  linarith

#print axioms antiperiodic_sq_split
#print axioms cosh_mass_floor
