import Mathlib
/-!
# weber_general_n R16: Track B (p = 3) — the discrete steps of Theorem P3

* `l1_sq_le_card_mul_l2_sq` : Cauchy–Schwarz, `(∑ |v_i|)^2 ≤ N ∑ v_i^2` on `Fin N → ℝ`.
* `height_floor_of_l1_floor` : if `∑ |v_i| ≥ N a` with `a ≥ 0` then `√(∑ v_i^2) ≥ √N a` — the passage from the
  Mahler-measure floor (MO2013 Thm 2.2: `∑_i |log|ε_i|| ≥ N log φ`) to the Euclidean height floor `L_{3,n} = √N log φ`.
* `theoremP3_core` : Theorem SH's core with the p = 3 names: (Sat) = Horie / MO2013 Lemma 1.3 on the ideal lattice,
  (Floor) = the height floor, `bl` = Blichfeldt's short vector on the scaled lattice of covolume `D/ℓ^f`; conclusion
  `L^c ≤ K D / ℓ^f`. (Wrapper of `WeberSH.theoremSH` — restated here so that this file imports only Mathlib.)

Footprint: std-3.
-/

namespace WeberP3

/-- Cauchy–Schwarz: `(∑ |v i|)^2 ≤ N * ∑ (v i)^2`. -/
theorem l1_sq_le_card_mul_l2_sq (N : ℕ) (v : Fin N → ℝ) :
    (∑ i, |v i|) ^ 2 ≤ (N : ℝ) * ∑ i, (v i) ^ 2 := by
  have h := Finset.sum_mul_sq_le_sq_mul_sq (Finset.univ : Finset (Fin N)) (fun _ => (1 : ℝ)) (fun i => |v i|)
  simpa [Finset.sum_const, Finset.card_univ, Fintype.card_fin, sq_abs] using h

/-- From an ℓ¹ floor `∑ |v i| ≥ N a` (`a ≥ 0`) to the Euclidean floor `√(∑ v_i^2) ≥ √N a`. -/
theorem height_floor_of_l1_floor (N : ℕ) (v : Fin N → ℝ) (a : ℝ) (ha : 0 ≤ a)
    (h : (N : ℝ) * a ≤ ∑ i, |v i|) :
    Real.sqrt (N : ℝ) * a ≤ Real.sqrt (∑ i, (v i) ^ 2) := by
  have hN : (0 : ℝ) ≤ N := Nat.cast_nonneg N
  have h1 : ((N : ℝ) * a) ^ 2 ≤ (N : ℝ) * ∑ i, (v i) ^ 2 :=
    le_trans (pow_le_pow_left₀ (mul_nonneg hN ha) h 2) (l1_sq_le_card_mul_l2_sq N v)
  have hsum : 0 ≤ ∑ i, (v i) ^ 2 := Finset.sum_nonneg (fun i _ => sq_nonneg (v i))
  -- (√N a)^2 = N a^2 ≤ ∑ v_i^2 : divide h1 by N when N > 0; trivial when N = 0
  rcases Nat.eq_zero_or_pos N with hN0 | hNpos
  · subst hN0; simp
  · have hNpos' : (0 : ℝ) < N := by exact_mod_cast hNpos
    have h2 : (N : ℝ) * a ^ 2 ≤ ∑ i, (v i) ^ 2 := by
      have : ((N : ℝ) * a) ^ 2 = (N : ℝ) * ((N : ℝ) * a ^ 2) := by ring
      rw [this] at h1
      exact le_of_mul_le_mul_left h1 hNpos'
    have h3 : (Real.sqrt (N : ℝ) * a) ^ 2 = (N : ℝ) * a ^ 2 := by
      rw [mul_pow, Real.sq_sqrt hN]
    have h4 : 0 ≤ Real.sqrt (N : ℝ) * a := mul_nonneg (Real.sqrt_nonneg _) ha
    calc Real.sqrt (N : ℝ) * a = Real.sqrt ((Real.sqrt (N : ℝ) * a) ^ 2) := (Real.sqrt_sq h4).symm
      _ ≤ Real.sqrt (∑ i, (v i) ^ 2) := Real.sqrt_le_sqrt (by rw [h3]; exact h2)

variable {U V : Type*} [CommGroup U] [NormedAddCommGroup V] [NormedSpace ℝ V]

/-- Theorem P3, discrete core (Theorem SH with the p = 3 names). -/
theorem theoremP3_core {c : ℕ} (H : U → V) (ι : (Fin c → ℤ) → U)
    (Lat : AddSubgroup (Fin c → ℤ)) (ℓ : ℕ) (hℓ : 0 < ℓ) (L₀ K D lf : ℝ)
    (horie : ∀ a ∈ Lat, ∃ u : U, ℓ • H u = H (ι a))
    (floor : ∀ u : U, H u ≠ 0 → L₀ ≤ ‖H u‖)
    (bl : ∃ a ∈ Lat, (ℓ : ℝ)⁻¹ • H (ι a) ≠ 0 ∧ ‖(ℓ : ℝ)⁻¹ • H (ι a)‖ ^ c ≤ K * D / lf)
    (hL₀ : 0 < L₀) :
    L₀ ^ c ≤ K * D / lf := by
  obtain ⟨a, ha, hv, hbl⟩ := bl
  obtain ⟨u, hu⟩ := horie a ha
  have hℓR : (ℓ : ℝ) ≠ 0 := by exact_mod_cast hℓ.ne'
  have hv' : (ℓ : ℝ)⁻¹ • H (ι a) = H u := by
    rw [← hu, ← Nat.cast_smul_eq_nsmul ℝ, smul_smul, inv_mul_cancel₀ hℓR, one_smul]
  rw [hv'] at hv hbl
  exact le_trans (pow_le_pow_left₀ hL₀.le (floor u hv) c) hbl

end WeberP3

#print axioms WeberP3.l1_sq_le_card_mul_l2_sq
#print axioms WeberP3.height_floor_of_l1_floor
#print axioms WeberP3.theoremP3_core
