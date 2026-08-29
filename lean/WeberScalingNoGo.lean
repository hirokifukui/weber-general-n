import Mathlib
/-!
# WeberScalingNoGo (r9): homework 170-174

(170/172 abstract core) `smul_mem_iff_of_coprime`: for L <= G of finite index
coprime to m, `m • y ∈ L ↔ y ∈ L` - equivalently L ∩ mG = mL, hence
L_f ∩ J_t = 2^{t-1} L_f once J_t = 2^{t-1} R is known (rank certificates).
(171) odd/coprime multiplication is an automorphism: `coprime_smul_injective`
(inlined; same proof as WeberR8's odd_smul_injective).
(173/174) The scale-law numeric gates in algebraic form: the mod-2^t route
improves iff (2+sqrt 5)^{2^{t-1}} < 2^t + sqrt(4^t+1); we prove the REVERSE
strict inequality for t = 2, 3, 4, closing the route (the arcsinh reduction is
the hand proof in SCALING_NO_GO_THEOREM.md sect 4; ratios in ball arithmetic in
sage/r9_scaling_no_go.log).
-/

/-- (171) On a finite additive group of cardinality coprime to `m`,
multiplication by `m` is injective (hence bijective). -/
theorem coprime_smul_injective {Q : Type*} [AddCommGroup Q] [Finite Q] (m : ℕ)
    (h : Nat.Coprime m (Nat.card Q)) :
    Function.Injective (fun x : Q => m • x) := by
  intro x y hxy
  have hz : m • (x - y) = 0 := by
    rw [smul_sub, sub_eq_zero]
    exact hxy
  have hd1 : addOrderOf (x - y) ∣ m := addOrderOf_dvd_of_nsmul_eq_zero hz
  have hd2 : addOrderOf (x - y) ∣ Nat.card Q := addOrderOf_dvd_natCard (x - y)
  have hone : addOrderOf (x - y) = 1 := by
    have hdvd := Nat.dvd_gcd hd1 hd2
    rw [Nat.Coprime] at h
    rw [h] at hdvd
    exact Nat.dvd_one.mp hdvd
  have : x - y = 0 := AddMonoid.addOrderOf_eq_one_iff.mp hone
  exact sub_eq_zero.mp this

/-- (170) If `[G:L]` is finite and coprime to `m`, then `m • y ∈ L ↔ y ∈ L`.
This is the content of `L ∩ mG = mL`: any `x = m•y ∈ L` has `y ∈ L`, so `x ∈ mL`. -/
theorem smul_mem_iff_of_coprime {G : Type*} [AddCommGroup G] (L : AddSubgroup G)
    [Finite (G ⧸ L)] (m : ℕ) (h : Nat.Coprime m (Nat.card (G ⧸ L))) (y : G) :
    m • y ∈ L ↔ y ∈ L := by
  constructor
  · intro hmy
    have h0q : m • (QuotientAddGroup.mk' L) y = 0 := by
      rw [← map_nsmul, QuotientAddGroup.mk'_apply]
      exact (QuotientAddGroup.eq_zero_iff _).mpr hmy
    have hinj := coprime_smul_injective (Q := G ⧸ L) m h
    have h0 : (QuotientAddGroup.mk' L) y = 0 := hinj (by simpa using h0q)
    rw [QuotientAddGroup.mk'_apply] at h0
    exact (QuotientAddGroup.eq_zero_iff _).mp h0
  · intro hy
    exact AddSubgroup.nsmul_mem L hy m

/-- (174, t = 2) `(2+√5)^2 > 4 + √17` - the mod-4 route does not improve. -/
theorem ineq_t2 : (2 + Real.sqrt 5) ^ 2 > 4 + Real.sqrt 17 := by
  have s5 : Real.sqrt 5 ^ 2 = 5 := Real.sq_sqrt (by norm_num)
  have s17 : Real.sqrt 17 ^ 2 = 17 := Real.sq_sqrt (by norm_num)
  have p5 : 0 ≤ Real.sqrt 5 := Real.sqrt_nonneg 5
  have p17 : 0 ≤ Real.sqrt 17 := Real.sqrt_nonneg 17
  nlinarith [sq_nonneg (Real.sqrt 5 - 2), sq_nonneg (Real.sqrt 17 - 5),
             mul_nonneg p5 p17]

/-- (174, t = 3) `(2+√5)^4 > 8 + √65`. -/
theorem ineq_t3 : (2 + Real.sqrt 5) ^ 4 > 8 + Real.sqrt 65 := by
  have s5 : Real.sqrt 5 ^ 2 = 5 := Real.sq_sqrt (by norm_num)
  have s65 : Real.sqrt 65 ^ 2 = 65 := Real.sq_sqrt (by norm_num)
  have p5 : 0 ≤ Real.sqrt 5 := Real.sqrt_nonneg 5
  have p65 : 0 ≤ Real.sqrt 65 := Real.sqrt_nonneg 65
  nlinarith [sq_nonneg (Real.sqrt 5 - 2), sq_nonneg (Real.sqrt 65 - 9),
             sq_nonneg ((2 + Real.sqrt 5) ^ 2 - 16)]

/-- (174, t = 4) `(2+√5)^8 > 16 + √257`. -/
theorem ineq_t4 : (2 + Real.sqrt 5) ^ 8 > 16 + Real.sqrt 257 := by
  have s5 : Real.sqrt 5 ^ 2 = 5 := Real.sq_sqrt (by norm_num)
  have s257 : Real.sqrt 257 ^ 2 = 257 := Real.sq_sqrt (by norm_num)
  have p5 : 0 ≤ Real.sqrt 5 := Real.sqrt_nonneg 5
  have p257 : 0 ≤ Real.sqrt 257 := Real.sqrt_nonneg 257
  nlinarith [sq_nonneg (Real.sqrt 5 - 2), sq_nonneg (Real.sqrt 257 - 17),
             sq_nonneg ((2 + Real.sqrt 5) ^ 2 - 16),
             sq_nonneg ((2 + Real.sqrt 5) ^ 4 - 256)]

#print axioms coprime_smul_injective
#print axioms smul_mem_iff_of_coprime
#print axioms ineq_t2
#print axioms ineq_t3
#print axioms ineq_t4
