import Mathlib
/-!
# weber_general_n r7: the three reviewer-mandated auxiliary lemmas (homework 86-89)

Scope discipline (homework 90-91): the Blichfeldt geometry itself and the
transcendental determinant are NOT formalized here (explicitly out of scope per the
r6 review). This file adds exactly the three abstract lemmas whose natural-language
counterparts are Lemma A, Lemma C, and Lemma E steps 2-3 of
theory/BLICHFELDT_SATURATION_THEOREM_R7.md. Correspondence table: lean/README_lean.md.
-/

/-- (87a) Bridge lemma, group part (= Lemma A, first half): in a commutative group,
if `u` is fixed by `τ` and the `τ`-norm `u * τ u` is `1`, then `u ^ 2 = 1`.
Instantiation: `G = units of B_n`, `τ = the generator of Gal(B_n/B_{n-1})` acting on
units, fixedness = `u ∈ E_{n-1}`, norm condition = `u ∈ RE+_n`. -/
theorem bridge_fixed_norm_sq {G : Type*} [CommGroup G] (τ : G →* G) (u : G)
    (hfix : τ u = u) (hnorm : u * τ u = 1) : u ^ 2 = 1 := by
  rw [hfix] at hnorm
  rw [pow_two]
  exact hnorm

/-- (87b) Bridge lemma, torsion part (= Lemma A, second half): in a field,
`u ^ 2 = 1` forces `u = 1 ∨ u = -1`. Instantiation: `K = B_n ⊆ ℝ` (totally real),
so the only torsion units are `±1`. -/
theorem torsion_pm_one {K : Type*} [Field K] (u : K) (h : u ^ 2 = 1) :
    u = 1 ∨ u = -1 := by
  have h2 : (u - 1) * (u + 1) = 0 := by linear_combination h
  rcases mul_eq_zero.mp h2 with h3 | h3
  · exact Or.inl (sub_eq_zero.mp h3)
  · exact Or.inr (eq_neg_of_add_eq_zero_left h3)

/-- (88) Component index lemma (= Lemma C, cardinality form): for a finite field `K`
and finite-dimensional `K`-vector space `V` with subspace `W`,
`|V/W| = |K| ^ (dim V - dim W)`. Instantiation: `K = F_l`, `V = F_l[x]/(x^m + 1)`,
`W = M_f` of dimension `d_f`, giving index `l ^ (m - d_f)`. -/
theorem component_card_quotient {K V : Type*} [Field K] [Fintype K]
    [AddCommGroup V] [Module K V] [FiniteDimensional K V] (W : Submodule K V) :
    Nat.card (V ⧸ W) = Nat.card K ^ (Module.finrank K V - Module.finrank K W) := by
  have h := Submodule.finrank_quotient_add_finrank W
  rw [Module.natCard_eq_pow_finrank (K := K) (V := V ⧸ W)]
  congr 1
  omega

/-- (89) Coset absorption (= Lemma E, steps 2-3): if `A ≤ B` are subgroups and the
coset of `x` modulo `A` meets `B` (i.e. `x = b·a` with `b ∈ B`, `a ∈ A`), then
`x ∈ B` itself. Instantiation: `A = A_n`, `B = RE+_n`, `x = r_a` the formal root:
a coset in `RE+_n/A_n` has all its representatives in `RE+_n`. -/
theorem coset_absorb {G : Type*} [Group G] {A B : Subgroup G} (hAB : A ≤ B)
    (x : G) (h : ∃ b ∈ B, b⁻¹ * x ∈ A) : x ∈ B := by
  obtain ⟨b, hb, ha⟩ := h
  have hx : x = b * (b⁻¹ * x) := by group
  rw [hx]
  exact B.mul_mem hb (hAB ha)

#print axioms bridge_fixed_norm_sq
#print axioms torsion_pm_one
#print axioms component_card_quotient
#print axioms coset_absorb
