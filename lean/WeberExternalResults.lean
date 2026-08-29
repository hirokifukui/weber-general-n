import Mathlib
/-!
# weber_general_n: ExternalResults — Theorem A with every literature input as a named hypothesis

No `axiom` anywhere (METHODOLOGY §5: conjectures/literature never as bare axioms). The literature
theorems are FIELDS of a structure over an abstract carrier; `theoremA_of_inputs` is the discrete
core of Theorem A (STATEMENT_FREEZE_R10 §1 / BLICHFELDT_SATURATION_THEOREM_R7 Prop F):

* `ky41`        : KY Eq.(17) + Prop 4.1 (via Lemma E): if l | k_n then some component is saturated.
* `blichfeldt`  : Blichfeldt 1914 Thm II (as MO 2016 Thm 2.7) applied to Λ_f = (1/l) H_n L_f whose
                  covolume is D_n / l^d (Lemmas C, D), written in the power-m/2 form
                  ht^m ≤ K · D / l^d with K = (2/π)^{m/2} Γ(2 + m/2)   (equivalent to the 2/m-exponent
                  form by monotonicity of x ↦ x^{m/2} on x ≥ 0).
* `floor`       : MO 2016 Lemma 2.5(1) + Lemma A: on a saturated component the Blichfeldt vector is
                  the log vector of a relative unit ≠ ±1, hence ht ≥ L_n = √(2^n) log(2+√5).

Then C_n := K · D / L^m and  C_n < l^d  ⇒  ¬ (l | k_n).  Footprint: std-3.
-/

/-- The inputs of Theorem A over an abstract carrier `Comp` (the irreducible factors of x^m+1 mod l). -/
structure TheoremAInputs where
  Comp : Type
  qDiv : Prop
  saturated : Comp → Prop
  ht : Comp → ℝ
  L : ℝ
  K : ℝ
  D : ℝ
  ld : ℝ
  m : ℕ
  hL : 0 < L
  hld : 0 < ld
  hm : 0 < m
  ky41 : qDiv → ∃ f, saturated f
  blichfeldt : ∀ f, ht f ^ m ≤ K * D / ld
  floor : ∀ f, saturated f → L ≤ ht f

namespace TheoremAInputs

/-- The constant of Theorem A. -/
noncomputable def C (I : TheoremAInputs) : ℝ := I.K * I.D / I.L ^ I.m

/-- Theorem A (discrete core): `C_n < l^d` excludes `l | k_n`. -/
theorem theoremA_of_inputs (I : TheoremAInputs) (hC : I.C < I.ld) : ¬ I.qDiv := by
  intro hq
  obtain ⟨f, hf⟩ := I.ky41 hq
  have hLm : 0 < I.L ^ I.m := pow_pos I.hL _
  -- floor raised to the m-th power
  have h1 : I.L ^ I.m ≤ I.ht f ^ I.m :=
    pow_le_pow_left₀ (le_of_lt I.hL) (I.floor f hf) _
  -- Blichfeldt
  have h2 : I.ht f ^ I.m ≤ I.K * I.D / I.ld := I.blichfeldt f
  -- the hypothesis C < l^d unfolds to K D / l^d < L^m
  have h3 : I.K * I.D / I.ld < I.L ^ I.m := by
    unfold C at hC
    rw [div_lt_iff₀ hLm] at hC
    rw [div_lt_iff₀ I.hld]
    linarith [hC]
  linarith [h1, h2, h3]

/-- Threshold form (Corollary T): if `l ≥ B` and `d` is large enough that `B^d > C_n`, exclusion follows.
Stated with `ld = l^d` supplied as a real number and the comparison `C < B^d ≤ l^d`. -/
theorem theoremA_threshold (I : TheoremAInputs) (B : ℝ) (d : ℕ) (hB : I.C < B ^ d)
    (hl : B ^ d ≤ I.ld) : ¬ I.qDiv :=
  I.theoremA_of_inputs (lt_of_lt_of_le hB hl)

end TheoremAInputs

/-- The n = 7 numerical instance of the comparison (deg-2 threshold), tying the certified integer
upper bound of C_7 to the threshold 1314283897427172 (as in WeberR6.deg2_threshold_valid). -/
theorem c7_deg2_instance (l : ℕ) (hl : 1314283897427172 < l) :
    (1727342163036353095979941756929 : ℝ) < (l : ℝ) ^ 2 := by
  have h : (1727342163036353095979941756929 : ℕ) < l ^ 2 := by
    have h1 : (1314283897427173:ℕ)^2 ≤ l^2 := Nat.pow_le_pow_left hl 2
    have h2 : (1727342163036353095979941756929:ℕ) < 1314283897427173^2 := by norm_num
    omega
  exact_mod_cast h

#print axioms TheoremAInputs.theoremA_of_inputs
#print axioms TheoremAInputs.theoremA_threshold
#print axioms c7_deg2_instance
