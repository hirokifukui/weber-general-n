import Mathlib
/-!
# weber_general_n R16: Lemma B (equal factor degrees) in Lean

`x^m + 1 = Φ_{2m}` with `m = 2^n`, and over `F_ℓ` (`ℓ` an odd prime) every irreducible factor of a
cyclotomic polynomial `Φ_N` has degree `orderOf ℓ` in `(ℤ/N)ˣ` (Mathlib:
`Polynomial.natDegree_of_dvd_cyclotomic_of_irreducible`). Hence every irreducible factor of
`x^{2^n} + 1` over `ZMod ℓ` has degree `d = ord_{2^{n+1}}(ℓ)` — the paper's `d_n(ℓ) = ord_{2^n}(ℓ)` with
the paper's `m = 2^{n-1}` (here the exponent is written `2^n` with `n ≥ 0`). Footprint: std-3.
-/

namespace WeberLemmaB

open Polynomial

/-- `x^{2^n} + 1 = Φ_{2^{n+1}}` over any commutative ring. -/
theorem X_pow_add_one_eq_cyclotomic (R : Type*) [CommRing R] (n : ℕ) :
    (X : R[X]) ^ (2 ^ n) + 1 = cyclotomic (2 ^ (n + 1)) R := by
  rw [cyclotomic_prime_pow_eq_geom_sum (by norm_num : Nat.Prime 2)]
  simp [Finset.sum_range_succ]
  ring

/-- An odd prime is coprime to every power of two. -/
theorem coprime_two_pow_of_odd_prime (ℓ n : ℕ) (hℓ : Nat.Prime ℓ) (hodd : Odd ℓ) :
    Nat.Coprime ℓ (2 ^ (n + 1)) := by
  apply Nat.Coprime.pow_right
  exact (Nat.coprime_primes hℓ Nat.prime_two).2 (by
    intro h; subst h; exact (Nat.not_even_iff_odd.mpr hodd) even_two)

/-- Lemma B. Every irreducible factor `P` of `x^{2^n} + 1` over `F_ℓ = ZMod ℓ`, `ℓ` an odd prime,
has degree `orderOf ℓ` in `(ℤ/2^{n+1})ˣ`. -/
theorem factor_degree (ℓ n : ℕ) [hℓ : Fact (Nat.Prime ℓ)] (hodd : Odd ℓ)
    (P : (ZMod ℓ)[X]) (hP : P ∣ (X ^ (2 ^ n) + 1)) (hirr : Irreducible P) :
    P.natDegree =
      orderOf (ZMod.unitOfCoprime (ℓ ^ 1)
        ((coprime_two_pow_of_odd_prime ℓ n hℓ.out hodd).pow_left 1)) := by
  have hcard : Fintype.card (ZMod ℓ) = ℓ ^ 1 := by simp [ZMod.card]
  have hP' : P ∣ cyclotomic (2 ^ (n + 1)) (ZMod ℓ) := by
    rwa [← X_pow_add_one_eq_cyclotomic]
  exact natDegree_of_dvd_cyclotomic_of_irreducible hcard
    (coprime_two_pow_of_odd_prime ℓ n hℓ.out hodd) hP' hirr

/-- All irreducible factors of `x^{2^n} + 1` over `F_ℓ` have the SAME degree (the form used by Prop. F:
`d_{f_0} = d_n(ℓ)` for the saturation component `f_0`). -/
theorem factor_degree_eq (ℓ n : ℕ) [Fact (Nat.Prime ℓ)] (hodd : Odd ℓ)
    (P Q : (ZMod ℓ)[X]) (hP : P ∣ (X ^ (2 ^ n) + 1)) (hPirr : Irreducible P)
    (hQ : Q ∣ (X ^ (2 ^ n) + 1)) (hQirr : Irreducible Q) :
    P.natDegree = Q.natDegree := by
  rw [factor_degree ℓ n hodd P hP hPirr, factor_degree ℓ n hodd Q hQ hQirr]

end WeberLemmaB

#print axioms WeberLemmaB.X_pow_add_one_eq_cyclotomic
#print axioms WeberLemmaB.coprime_two_pow_of_odd_prime
#print axioms WeberLemmaB.factor_degree
#print axioms WeberLemmaB.factor_degree_eq
