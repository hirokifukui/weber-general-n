import Mathlib
/-!
# weber_general_n: scaling no-go, general-t analytic half (r11; GPT r10 homework 1-5, 49, 77)

Theorem S of r10 is split (GPT r10 review sect 3):
* **S0** (all `t ≥ 2`, abstract): IF the depth-`t` congruence filtration of the exponent lattice is
  the sublattice `J_t = 2^{t-1} R_n` (hypothesis; certified for `t = 2, 3, 4` in
  `sage/r9_scaling_no_go.log`, [C]) and the depth-`t` floor is `L_t = √(2^n)·arcsinh(2^t)`
  (literature input), THEN the depth-`t` route is strictly weaker than Theorem A. The lattice half
  is `smul_mem_iff_of_coprime` (WeberScalingNoGo.lean); the analytic half is `ineq_t_general`
  below: `(2+√5)^(2^(t-1)) > 2^t + √(4^t+1)` for EVERY `t ≥ 2`.
* **S1** (`t = 2, 3, 4`): S0 with the certified `J_t`.
Nothing here proves `J_t = 2^{t-1} R_n` for general `t`; that is the open general-t statement.
-/

open Real

/-- `√(4^t + 1) < 2^t + 1` over ℝ. -/
theorem sqrt_four_pow_add_one_lt (t : ℕ) : Real.sqrt ((4:ℝ)^t + 1) < (2:ℝ)^t + 1 := by
  have h2 : (0:ℝ) < (2:ℝ)^t + 1 := by positivity
  rw [Real.sqrt_lt' h2]
  have h4 : ((4:ℝ)^t) = ((2:ℝ)^t)^2 := by
    rw [← pow_mul, show (4:ℝ) = 2^2 by norm_num, ← pow_mul, mul_comm]
  rw [h4]
  have : (0:ℝ) < (2:ℝ)^t := by positivity
  nlinarith

/-- `t ≤ 2^(t-1)` for `t ≥ 1`. -/
theorem le_two_pow_pred {t : ℕ} (ht : 1 ≤ t) : t ≤ 2 ^ (t - 1) := by
  obtain ⟨s, rfl⟩ : ∃ s, t = s + 1 := ⟨t - 1, by omega⟩
  simp only [Nat.add_sub_cancel]
  have := Nat.lt_two_pow_self (n := s)
  omega

/-- hw 1-5 / 49 (analytic half of S0, all `t ≥ 2`):
`(2+√5)^(2^(t-1)) > 2^t + √(4^t+1)`. -/
theorem ineq_t_general {t : ℕ} (ht : 2 ≤ t) :
    (2 + Real.sqrt 5) ^ (2 ^ (t - 1)) > (2:ℝ)^t + Real.sqrt ((4:ℝ)^t + 1) := by
  -- step 1: 2^t + √(4^t+1) < 2^(t+1) + 1
  have s1 : (2:ℝ)^t + Real.sqrt ((4:ℝ)^t + 1) < (2:ℝ)^(t+1) + 1 := by
    have := sqrt_four_pow_add_one_lt t
    rw [pow_succ]; linarith
  -- step 2: 2^(t+1) + 1 ≤ 4^t  (t ≥ 2)
  have s2 : (2:ℝ)^(t+1) + 1 ≤ (4:ℝ)^t := by
    have h4 : ((4:ℝ)^t) = ((2:ℝ)^t)^2 := by
      rw [← pow_mul, show (4:ℝ) = 2^2 by norm_num, ← pow_mul, mul_comm]
    have h4le : (4:ℝ) ≤ (2:ℝ)^t := by
      calc (4:ℝ) = (2:ℝ)^2 := by norm_num
        _ ≤ (2:ℝ)^t := pow_le_pow_right₀ (by norm_num) ht
    rw [h4, pow_succ]; nlinarith
  -- step 3: 4^t ≤ 4^(2^(t-1))
  have s3 : (4:ℝ)^t ≤ (4:ℝ)^(2^(t-1)) :=
    pow_le_pow_right₀ (by norm_num) (le_two_pow_pred (by omega))
  -- step 4: 4^(2^(t-1)) < (2+√5)^(2^(t-1))  since 4 < 2+√5
  have s4 : (4:ℝ)^(2^(t-1)) < (2 + Real.sqrt 5)^(2^(t-1)) := by
    have h5 : (2:ℝ) < Real.sqrt 5 := by
      rw [show (2:ℝ) = Real.sqrt 4 by rw [show (4:ℝ) = 2^2 by norm_num, Real.sqrt_sq (by norm_num)]]
      exact Real.sqrt_lt_sqrt (by norm_num) (by norm_num)
    have hpos : 0 < 2 ^ (t - 1) := by positivity
    exact pow_lt_pow_left₀ (by linarith) (by norm_num) (by omega)
  linarith

/-- The three r10 instances, now corollaries of the general statement (consistency check with
`WeberScalingNoGo.ineq_t2/3/4`, which stay in force unchanged). -/
theorem ineq_t2' : (2 + Real.sqrt 5) ^ 2 > (2:ℝ)^2 + Real.sqrt ((4:ℝ)^2 + 1) := ineq_t_general (le_refl 2)
theorem ineq_t3' : (2 + Real.sqrt 5) ^ 4 > (2:ℝ)^3 + Real.sqrt ((4:ℝ)^3 + 1) := ineq_t_general (by norm_num)
theorem ineq_t4' : (2 + Real.sqrt 5) ^ 8 > (2:ℝ)^4 + Real.sqrt ((4:ℝ)^4 + 1) := ineq_t_general (by norm_num)

#print axioms sqrt_four_pow_add_one_lt
#print axioms le_two_pow_pred
#print axioms ineq_t_general
#print axioms ineq_t2'
#print axioms ineq_t3'
#print axioms ineq_t4'
