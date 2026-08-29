import Mathlib
/-!
# WeberP3Rel — discrete parts of the R17 repair of Theorem P3 (cyclotomic Z_3-tower)

Five statements used by the repaired Theorem P3 (paper Section "The cyclotomic Z_3-tower", proofs/lem_normone.tex,
proofs/thm_rank3.tex). Everything here is elementary; the analytic inputs (MO2016 Lemma 2.5(2), Dirichlet's L(1,chi) ≠ 0,
Washington Thm 4.9) stay outside as L inputs.

* `a_cube_modEq_one`      : (1 + 3^n)^3 ≡ 1 (mod 3^(n+1)) for n ≥ 1  (a = 1 + 3^n has order 3 in (Z/3^(n+1))^x).
* `four_pow_three_pow`    : 4^(3^k) = 1 + 3^(k+1) + 3^(k+2) t for some t, hence 4^(3^(n-1)) ≡ 1 + 3^n (mod 3^(n+1)):
                            the element tau = sigma^(3^(n-1)) of the Galois group acts by k ↦ (1+3^n) k.
* `telescope_three`       : the three-term telescoping product of the Horie unit under tau: eta · tau eta · tau^2 eta = 1.
* `eq_one_of_odd_pow_eq_one` : in an ordered field a real number with x^l = 1, l odd, is 1 (the norm-one transfer
                            Nr(eps)^l = Nr(eta^alpha) = 1 ⇒ Nr(eps) = 1, and eps ∈ B_{n-1}, Nr eps = eps^3 = 1 ⇒ eps = 1).
* `dft_vanish_of_relnorm` : the finite Fourier coefficient at a multiple of 3 vanishes when the three-term coset sums vanish.
* `eq_zero_of_vanish_on_primitiveRoots` : a polynomial of degree < phi(m) vanishing on all primitive m-th roots of unity is 0
                            (the Parseval step of the spectral rank theorem, Phi_m | A ⇒ A = 0).
-/
namespace WeberP3Rel

open Finset Polynomial

/-- (1 + 3^n)^3 - 1 = 3^(n+1) (1 + 3^n + 3^(2n-1)) for n ≥ 1. -/
theorem a_cube_modEq_one (n : ℕ) (hn : 1 ≤ n) :
    ((1 + 3 ^ n : ℤ) ^ 3) ≡ 1 [ZMOD 3 ^ (n + 1)] := by
  obtain ⟨m, rfl⟩ : ∃ m, n = m + 1 := ⟨n - 1, by omega⟩
  apply Int.ModEq.symm
  rw [Int.modEq_iff_dvd]
  exact ⟨1 + 3 ^ (m + 1) + 3 ^ (2 * m + 1), by ring⟩

/-- 4^(3^k) = 1 + 3^(k+1) + 3^(k+2) t for an explicit t (induction on k). -/
theorem four_pow_three_pow (k : ℕ) : ∃ t : ℤ, (4 : ℤ) ^ (3 ^ k) = 1 + 3 ^ (k + 1) + 3 ^ (k + 2) * t := by
  induction k with
  | zero => exact ⟨0, by norm_num⟩
  | succ k ih =>
    obtain ⟨t, ht⟩ := ih
    refine ⟨t + 3 ^ k * (1 + 3 * t) ^ 2 + 3 ^ (2 * k) * (1 + 3 * t) ^ 3, ?_⟩
    have h : (4 : ℤ) ^ (3 ^ (k + 1)) = ((4 : ℤ) ^ (3 ^ k)) ^ 3 := by
      rw [← pow_mul, pow_succ]
    rw [h, ht]
    ring

/-- 4^(3^(n-1)) ≡ 1 + 3^n (mod 3^(n+1)) for n ≥ 1. -/
theorem four_pow_modEq (n : ℕ) (hn : 1 ≤ n) :
    ((4 : ℤ) ^ (3 ^ (n - 1))) ≡ 1 + 3 ^ n [ZMOD 3 ^ (n + 1)] := by
  obtain ⟨m, rfl⟩ : ∃ m, n = m + 1 := ⟨n - 1, by omega⟩
  obtain ⟨t, ht⟩ := four_pow_three_pow m
  simp only [Nat.add_sub_cancel]
  rw [ht, Int.modEq_iff_dvd]
  exact ⟨-t, by ring⟩

/-- Three-term telescoping: s 3 = s 0 and s 0, s 1, s 2 nonzero give (s 1 / s 0) (s 2 / s 1) (s 3 / s 2) = 1. -/
theorem telescope_three (s : ℕ → ℝ) (h0 : s 0 ≠ 0) (h1 : s 1 ≠ 0) (h2 : s 2 ≠ 0) (h3 : s 3 = s 0) :
    (s 1 / s 0) * (s 2 / s 1) * (s 3 / s 2) = 1 := by
  rw [h3]; field_simp

/-- The sine step of the telescoping: sin(2π a^3 / q) = sin(2π / q) when a^3 = 1 + m q. -/
theorem sin_telescope_step (q : ℕ) (hq : q ≠ 0) (a m : ℤ) (ha : a ^ 3 = 1 + m * q) :
    Real.sin (2 * Real.pi * (a ^ 3 : ℝ) / q) = Real.sin (2 * Real.pi / q) := by
  have hq' : (q : ℝ) ≠ 0 := by exact_mod_cast hq
  have : (2 * Real.pi * (a ^ 3 : ℝ) / q) = 2 * Real.pi / q + (m : ℤ) * (2 * Real.pi) := by
    have h : ((a ^ 3 : ℤ) : ℝ) = 1 + (m : ℝ) * q := by exact_mod_cast ha
    push_cast at h ⊢
    rw [h]; field_simp
  rw [this, Real.sin_add_int_mul_two_pi]

/-- Norm-one transfer: x^l = 1 with l odd forces x = 1 in a linearly ordered field (the relative norm lives in the
totally real field B_{n-1}, so this applies to every real embedding). -/
theorem eq_one_of_odd_pow_eq_one {x : ℝ} {l : ℕ} (hl : Odd l) (h : x ^ l = 1) : x = 1 :=
  (Odd.strictMono_pow hl).injective (by simpa using h)

/-- Finite Fourier coefficient at index 3k vanishes if the three coset sums lam j + lam (j+M) + lam (j+2M) vanish
(ω^(3M) = 1; the DFT of length N = 3M of the log vector of a relative-norm-one unit). -/
theorem dft_vanish_of_relnorm (M k : ℕ) (lam : ℕ → ℂ) (ω : ℂ) (hω : ω ^ (3 * M) = 1)
    (hrel : ∀ j < M, lam j + lam (j + M) + lam (j + 2 * M) = 0) :
    ∑ j ∈ range (3 * M), lam j * ω ^ (j * (3 * k)) = 0 := by
  have h3 : 3 * M = M + M + M := by ring
  rw [h3, sum_range_add, sum_range_add]
  have hM : ∀ j, ω ^ ((M + j) * (3 * k)) = ω ^ (j * (3 * k)) := by
    intro j
    have : (M + j) * (3 * k) = j * (3 * k) + (3 * M) * k := by ring
    have hk : ω ^ (3 * M * k) = 1 := by rw [pow_mul, hω, one_pow]
    rw [this, pow_add, hk, mul_one]
  have hM2 : ∀ j, ω ^ ((M + M + j) * (3 * k)) = ω ^ (j * (3 * k)) := by
    intro j
    have : (M + M + j) * (3 * k) = j * (3 * k) + (3 * M) * (2 * k) := by ring
    have hk : ω ^ (3 * M * (2 * k)) = 1 := by rw [pow_mul, hω, one_pow]
    rw [this, pow_add, hk, mul_one]
  simp only [hM, hM2]
  rw [← sum_add_distrib, ← sum_add_distrib]
  apply sum_eq_zero
  intro j hj
  have hj' := mem_range.mp hj
  have := hrel j hj'
  have e1 : M + j = j + M := by ring
  have e2 : M + M + j = j + 2 * M := by ring
  rw [e1, e2, ← add_mul, ← add_mul, this, zero_mul]

/-- A polynomial over ℂ of degree < φ(m) which vanishes on all primitive m-th roots of unity is zero. -/
theorem eq_zero_of_vanish_on_primitiveRoots (m : ℕ) (hm : 0 < m) (A : ℂ[X])
    (hdeg : A.natDegree < Nat.totient m) (h : ∀ ξ ∈ primitiveRoots m ℂ, A.eval ξ = 0) : A = 0 := by
  have hprim : IsPrimitiveRoot (Complex.exp (2 * Real.pi * Complex.I / m)) m :=
    Complex.isPrimitiveRoot_exp m hm.ne'
  have hcard : (primitiveRoots m ℂ).card = Nat.totient m := hprim.card_primitiveRoots
  refine Polynomial.eq_zero_of_natDegree_lt_card_of_eval_eq_zero A
    (f := fun ξ : (primitiveRoots m ℂ) => (ξ : ℂ)) Subtype.val_injective ?_ ?_
  · intro ξ; exact h ξ ξ.2
  · rw [Fintype.card_coe, hcard]; exact hdeg

/-- Specialisation m = 3^r: φ(3^r) = 2·3^(r-1), the number c of the paper. -/
theorem totient_three_pow (r : ℕ) (hr : 1 ≤ r) : Nat.totient (3 ^ r) = 2 * 3 ^ (r - 1) := by
  rw [Nat.totient_prime_pow Nat.prime_three hr]
  ring

/-! ### The finite Fourier algebra of Theorem rank3, Step 2 (hw 733)

On `ZMod N` (so that shifts are automatic), with `ω ^ N = 1` and the twisted sum
`Σ_j Γ(j) ω^(j.val * k)`: a shift of the argument multiplies the sum by a root of unity, and the
difference `λ_j = Γ(j + t + s) - Γ(j + t)` has transform `(ω^(t·k) - ω^((t+s)·k)) Γ̂_k` up to a unit;
so `λ̂_k ≠ 0` as soon as `Γ̂_k ≠ 0` and `ω^(s·k) ≠ 1`. For `s = N/3` and `ω` a primitive `N`-th root,
`ω^(s·k) ≠ 1` iff `3 ∤ k`. What remains outside Lean in Step 2 is only `Γ̂_k ≠ 0` (Washington + Dirichlet). -/
section DFT
variable {N : ℕ} [NeZero N] (ω : ℂ)

/-- `ω ^ ((a + b).val * k) = ω ^ (a.val * k) * ω ^ (b.val * k)` when `ω ^ N = 1`. -/
theorem pow_val_add_mul (hω : ω ^ N = 1) (a b : ZMod N) (k : ℕ) :
    ω ^ ((a + b).val * k) = ω ^ (a.val * k) * ω ^ (b.val * k) := by
  rw [ZMod.val_add, ← pow_add, ← add_mul]
  have h1 : ω ^ ((a.val + b.val) % N * k) = ω ^ (((a.val + b.val) % N * k) % N) := pow_eq_pow_mod _ hω
  have h2 : ω ^ ((a.val + b.val) * k) = ω ^ (((a.val + b.val) * k) % N) := pow_eq_pow_mod _ hω
  rw [h1, h2, Nat.mul_mod, Nat.mod_mod, ← Nat.mul_mod]

/-- Shift rule of the twisted sum: `ω^(u·k) Σ_j Γ(j+u) ω^(j·k) = Σ_j Γ(j) ω^(j·k)`. -/
theorem twisted_sum_shift (hω : ω ^ N = 1) (Γ : ZMod N → ℂ) (u : ZMod N) (k : ℕ) :
    ω ^ (u.val * k) * ∑ j : ZMod N, Γ (j + u) * ω ^ (j.val * k) = ∑ j : ZMod N, Γ j * ω ^ (j.val * k) := by
  rw [Finset.mul_sum]
  have : ∀ j : ZMod N, ω ^ (u.val * k) * (Γ (j + u) * ω ^ (j.val * k)) = Γ (j + u) * ω ^ ((j + u).val * k) := by
    intro j; rw [pow_val_add_mul ω hω]; ring
  simp only [this]
  exact Fintype.sum_equiv (Equiv.addRight u) _ _ (fun j => rfl)

/-- The transform of `λ_j = Γ(j+t+s) - Γ(j+t)` is a unit times `(ω^(t·k) - ω^((t+s)·k)) Γ̂_k`. -/
theorem twisted_sum_shift_diff (hω : ω ^ N = 1) (Γ : ZMod N → ℂ) (t s : ZMod N) (k : ℕ) :
    ω ^ ((t + s).val * k) * ω ^ (t.val * k) * ∑ j : ZMod N, (Γ (j + t + s) - Γ (j + t)) * ω ^ (j.val * k)
      = (ω ^ (t.val * k) - ω ^ ((t + s).val * k)) * ∑ j : ZMod N, Γ j * ω ^ (j.val * k) := by
  have h1 := twisted_sum_shift ω hω Γ (t + s) k
  have h2 := twisted_sum_shift ω hω Γ t k
  simp only [sub_mul, Finset.sum_sub_distrib, ← add_assoc] at *
  linear_combination (ω ^ (t.val * k)) * h1 - (ω ^ ((t + s).val * k)) * h2

/-- `λ̂_k ≠ 0` whenever `Γ̂_k ≠ 0` and `ω^(s·k) ≠ 1` (the two roots of unity in front differ). -/
theorem twisted_sum_shift_diff_ne_zero (hω : ω ^ N = 1) (Γ : ZMod N → ℂ) (t s : ZMod N) (k : ℕ)
    (hΓ : ∑ j : ZMod N, Γ j * ω ^ (j.val * k) ≠ 0) (hs : ω ^ (s.val * k) ≠ 1) :
    ∑ j : ZMod N, (Γ (j + t + s) - Γ (j + t)) * ω ^ (j.val * k) ≠ 0 := by
  intro h0
  have hd := twisted_sum_shift_diff ω hω Γ t s k
  rw [h0, mul_zero] at hd
  have hne : ω ^ (t.val * k) - ω ^ ((t + s).val * k) ≠ 0 := by
    rw [pow_val_add_mul ω hω, sub_ne_zero]
    intro h
    apply hs
    have hω0 : ω ^ (t.val * k) ≠ 0 := by
      intro hz
      have : ω ^ N = 0 := by
        rcases Nat.eq_zero_or_pos (t.val * k) with h' | h'
        · rw [h'] at hz; exact absurd hz one_ne_zero
        · rw [pow_eq_zero_iff (Nat.pos_iff_ne_zero.mp h')] at hz; simp [hz, NeZero.ne N]
      rw [hω] at this; exact one_ne_zero this
    exact mul_left_cancel₀ hω0 (by rw [mul_one]; exact h.symm)
  exact hΓ ((mul_eq_zero.mp hd.symm).resolve_left hne)

/-- For `N = 3M`, a primitive `N`-th root `ω` and `s = M`: `ω^(M·k) = 1 ↔ 3 ∣ k`. -/
theorem pow_third_eq_one_iff (M k : ℕ) (hM : 0 < M) (hprim : IsPrimitiveRoot ω (3 * M)) :
    ω ^ (M * k) = 1 ↔ 3 ∣ k := by
  rw [hprim.pow_eq_one_iff_dvd, mul_comm M k, Nat.mul_dvd_mul_iff_right hM]

end DFT

end WeberP3Rel

#print axioms WeberP3Rel.a_cube_modEq_one
#print axioms WeberP3Rel.four_pow_modEq
#print axioms WeberP3Rel.telescope_three
#print axioms WeberP3Rel.sin_telescope_step
#print axioms WeberP3Rel.eq_one_of_odd_pow_eq_one
#print axioms WeberP3Rel.dft_vanish_of_relnorm
#print axioms WeberP3Rel.eq_zero_of_vanish_on_primitiveRoots
#print axioms WeberP3Rel.totient_three_pow
#print axioms WeberP3Rel.pow_val_add_mul
#print axioms WeberP3Rel.twisted_sum_shift
#print axioms WeberP3Rel.twisted_sum_shift_diff
#print axioms WeberP3Rel.twisted_sum_shift_diff_ne_zero
#print axioms WeberP3Rel.pow_third_eq_one_iff
