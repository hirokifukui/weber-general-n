import Mathlib
/-!
# weber_general_n: the 2-adic congruence behind Nr(eta_n) = -1
`3^(2^(n-1)) = 1 + 2^(n+1) (mod 2^(n+2))` for all n >= 3 — the arithmetic input to
tau(eta_n) = tan(theta + pi/2) = -cot(theta), hence Nr_{B_n/B_{n-1}}(eta_n) = -1
(theory/DAGGER_VERDICT_20260823.md section 5). General theorem by LTE-style induction
(squaring step), plus kernel-computed concrete instances as cross-checks (n = 7 load-bearing).
-/

/-- Squaring step (LTE engine): if `x = 1 + 2^(j+4) (mod 2^(j+5))` then
`x^2 = 1 + 2^(j+5) (mod 2^(j+6))`. -/
theorem sq_step (j : ℕ) (x : ℤ) (h : x % 2^(j+4) = 1 + 2^(j+3)) :
    x^2 % 2^(j+5) = 1 + 2^(j+4) := by
  have hp : (0:ℤ) < 2^j := pow_pos (by norm_num) j
  obtain ⟨m, hm⟩ : ∃ m, x = 2^(j+4) * m + (1 + 2^(j+3)) := by
    refine ⟨x / 2^(j+4), ?_⟩
    have h0 := Int.ediv_add_emod x (2^(j+4))
    omega
  have e3 : (2:ℤ)^(j+3) = 2^j * 8 := by rw [pow_add]; norm_num
  have e4 : (2:ℤ)^(j+4) = 2^j * 16 := by rw [pow_add]; norm_num
  have e5 : (2:ℤ)^(j+5) = 2^j * 32 := by rw [pow_add]; norm_num
  have key : x^2 = (1 + 2^(j+4)) + 2^(j+5) * (8*(2^j)*m^2 + 8*(2^j)*m + m + 2*(2^j)) := by
    subst hm; rw [e3, e4, e5]; ring
  rw [key, Int.add_mul_emod_self_left, Int.emod_eq_of_lt (by rw [e4]; omega) (by rw [e4, e5]; omega)]

/-- The general congruence: `3^(2^(m+2)) = 1 + 2^(m+4) (mod 2^(m+5))` for all m,
i.e. `3^(2^(n-1)) = 1 + 2^(n+1) (mod 2^(n+2))` for all n = m+3 >= 3. -/
theorem three_pow_general (m : ℕ) : (3:ℤ)^(2^(m+2)) % 2^(m+5) = 1 + 2^(m+4) := by
  induction m with
  | zero => decide
  | succ k ih =>
      have hsq : ((3:ℤ)^(2^(k+2)))^2 = 3^(2^(k+3)) := by
        rw [← pow_mul]
        congr 1
      have step := sq_step (k+1) ((3:ℤ)^(2^(k+2))) ih
      rw [hsq] at step
      exact step

/-- Load-bearing instance n = 7: `3^64 = 257 (mod 512)`. -/
theorem three_pow_n7 : (3:ℤ)^(2^6) % 2^9 = 1 + 2^8 := three_pow_general 4

-- Kernel cross-checks for the range used in CAS anchors (n = 3..8).
theorem chk_n3 : (3:ℕ)^(2^2) % 2^5 = 1 + 2^4 := by decide
theorem chk_n4 : (3:ℕ)^(2^3) % 2^6 = 1 + 2^5 := by decide
theorem chk_n5 : (3:ℕ)^(2^4) % 2^7 = 1 + 2^6 := by decide
theorem chk_n6 : (3:ℕ)^(2^5) % 2^8 = 1 + 2^7 := by decide
theorem chk_n7 : (3:ℕ)^(2^6) % 2^9 = 1 + 2^8 := by decide
theorem chk_n8 : (3:ℕ)^(2^7) % 2^10 = 1 + 2^9 := by decide

#print axioms sq_step
#print axioms three_pow_general
#print axioms three_pow_n7
#print axioms chk_n7
