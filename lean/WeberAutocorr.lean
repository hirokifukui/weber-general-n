import Mathlib
open Finset
/-!
# weber_general_n: reversal invariance of the correlation quadratic form
`Q(a, lam) = sum_j (sum_i a i * lam (i+j))^2` over `ZMod N` is invariant under
`lam -> lam ∘ neg`. This is the exact statement behind the inverse-pairing rho-transport
(components paired by c*c' = 1 mod l share their minimum Q; DAGGER/r4b, GPT-r1 ask (B)).
Proof: expand to the autocorrelation form; the autocorrelation of a real vector on a finite
abelian group is reversal-invariant. No Fourier analysis needed.
-/

variable {N : ℕ} [NeZero N]

theorem autocorr_reversal (a lam : ZMod N → ℝ) :
    ∑ j : ZMod N, (∑ i : ZMod N, a i * lam (i + j))^2
    = ∑ j : ZMod N, (∑ i : ZMod N, a i * lam (-(i + j)))^2 := by
  have expand : ∀ (μ : ZMod N → ℝ),
      ∑ j : ZMod N, (∑ i : ZMod N, a i * μ (i + j))^2
      = ∑ i : ZMod N, ∑ i' : ZMod N, (a i * a i') * ∑ j : ZMod N, μ (i + j) * μ (i' + j) := by
    intro μ
    have h1 : ∀ j : ZMod N, (∑ i : ZMod N, a i * μ (i + j))^2
        = ∑ i : ZMod N, ∑ i' : ZMod N, (a i * a i') * (μ (i + j) * μ (i' + j)) := by
      intro j
      rw [sq, Finset.sum_mul_sum]
      exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun i' _ => by ring
    simp_rw [h1]
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun i' _ => ?_
    rw [← Finset.mul_sum]
  rw [expand lam, expand (fun t => lam (-t))]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun i' _ => ?_
  congr 1
  -- reduce to: autocorrelation is reversal invariant at shift (i, i')
  have step1 : ∑ j : ZMod N, lam (-(i + j)) * lam (-(i' + j))
      = ∑ j : ZMod N, lam (j - i) * lam (j - i') := by
    have := Equiv.sum_comp (Equiv.neg (ZMod N))
      (fun j : ZMod N => lam (j - i) * lam (j - i'))
    rw [← this]
    refine Finset.sum_congr rfl fun j _ => ?_
    have a1 : (Equiv.neg (ZMod N)) j - i = -(i + j) := by
      simp [Equiv.neg_apply]; ring
    have a2 : (Equiv.neg (ZMod N)) j - i' = -(i' + j) := by
      simp [Equiv.neg_apply]; ring
    rw [a1, a2]
  have step2 : ∑ j : ZMod N, lam (j - i) * lam (j - i')
      = ∑ j : ZMod N, lam (i + j) * lam (i' + j) := by
    have := Equiv.sum_comp (Equiv.addRight (i + i'))
      (fun j : ZMod N => lam (j - i) * lam (j - i'))
    rw [← this]
    refine Finset.sum_congr rfl fun j _ => ?_
    have a1 : (Equiv.addRight (i + i')) j - i = i' + j := by
      simp [Equiv.coe_addRight]; ring
    have a2 : (Equiv.addRight (i + i')) j - i' = i + j := by
      simp [Equiv.coe_addRight]; ring
    rw [a1, a2]; ring
  rw [step1, step2]

#print axioms autocorr_reversal
