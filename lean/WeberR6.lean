import Mathlib
/-!
# weber_general_n r6: the three reviewer-mandated Lean items (P3)
1. Index/covolume arithmetic actually consumed by the Blichfeldt-saturation proof.
2. The abstract saturation -> short-unit contradiction theorem.
3. Certified rational threshold comparisons (the numbers the theorem quotes).
-/

/-- (1) Covolume bookkeeping: index l^(m-d) sublattice, scaled by 1/l in an m-dim space:
covolume D * l^(m-d) / l^m = D / l^d  (for l > 0, d <= m). -/
theorem covol_bookkeeping (D : ℝ) (l : ℝ) (hl : 0 < l) (m d : ℕ) (hdm : d ≤ m) :
    D * l^(m-d) / l^m = D / l^d := by
  have hlm : l^m = l^(m-d) * l^d := by
    rw [← pow_add]
    congr 1
    omega
  rw [hlm]
  have h1 : l^(m-d) ≠ 0 := pow_ne_zero _ (ne_of_gt hl)
  field_simp

/-- (2) Abstract saturation criterion: if divisibility forces a saturated component, and a
short witness at any saturated component is contradictory, and every component carries a
short witness, then divisibility fails. (The r6 flagship shape: no Horie, no coverage
subtlety — the witness set covers all components.) -/
theorem saturation_short_unit
    (Comp : Type) (qDiv : Prop)
    (saturated shortWitness : Comp → Prop)
    (hSat : qDiv → ∃ f, saturated f)
    (hContra : ∀ f, saturated f → shortWitness f → False)
    (hCover : ∀ f, shortWitness f) :
    ¬ qDiv := by
  intro h
  obtain ⟨f, hf⟩ := hSat h
  exact hContra f hf (hCover f)

/-- (3a) The certified deg-2 threshold: every natural l with l > 1314283897427172 satisfies
l^2 > 1727342163036353095979941756929 (the certified integer upper bound for C_7). -/
theorem deg2_threshold_valid (l : ℕ) (hl : 1314283897427172 < l) :
    1727342163036353095979941756929 < l^2 := by
  have h1 : (1314283897427173:ℕ)^2 ≤ l^2 := Nat.pow_le_pow_left hl 2
  have h2 : (1727342163036353095979941756929:ℕ) < 1314283897427173^2 := by norm_num
  omega

/-- (3b) The certified deg-1 threshold statement is the tautological comparison; recorded
so the quoted integer lives in a kernel-checked statement. -/
theorem deg1_threshold_valid (l : ℕ) (hl : 1727342163036353095979941756929 < l) :
    1727342163036353095979941756929 < l^1 := by
  simpa using hl

#print axioms covol_bookkeeping
#print axioms saturation_short_unit
#print axioms deg2_threshold_valid
#print axioms deg1_threshold_valid
