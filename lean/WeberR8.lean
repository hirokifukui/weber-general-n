import Mathlib
/-!
# weber_general_n r8: the filtered-index lemmas (homework 147-149)

Scope (hw 150): Blichfeldt itself is NOT formalized. This file certifies the
group-theoretic skeleton of theory/FILTERED_SATURATION_THEOREM.md /
FILTER_INDEX_OBSTRUCTION.md: (147) the index-transfer [L : ker] = [G : J] via the
first isomorphism theorem, with the kernel identified as J cap L; (148) odd
multiplication is injective (hence bijective) on a finite group of coprime order
- the mechanism behind lR + J_t = R; (149) the index [R : J_t] = 2^{64(t-1)} as
the cardinality of (Z/2^{t-1})^64.
-/

/-- Kernel of `L → G⧸J` (inclusion followed by projection) is `J ∩ L` viewed in `L`. -/
theorem ker_mk_comp_subtype {G : Type*} [AddCommGroup G] (L J : AddSubgroup G) :
    ((QuotientAddGroup.mk' J).comp L.subtype).ker = J.addSubgroupOf L := by
  ext x
  simp [AddMonoidHom.mem_ker,
        QuotientAddGroup.eq_zero_iff, AddSubgroup.mem_addSubgroupOf]

/-- (147) Index transfer: if every class of `G⧸J` meets `L`, then
`[L : J ∩ L] = [G : J]`. Instantiation: `G = R = Z^64`, `J = J_t`, `L = L_f`;
surjectivity is supplied by `lR ⊆ L_f` plus (148). -/
theorem index_transfer {G : Type*} [AddCommGroup G] (L J : AddSubgroup G)
    (hsur : Function.Surjective ((QuotientAddGroup.mk' J).comp L.subtype)) :
    Nat.card (↥L ⧸ J.addSubgroupOf L) = Nat.card (G ⧸ J) := by
  rw [← ker_mk_comp_subtype L J]
  exact Nat.card_congr
    (QuotientAddGroup.quotientKerEquivOfSurjective _ hsur).toEquiv

/-- (148) On a finite additive group whose cardinality is coprime to `l`
(e.g. a 2-group and odd `l`), multiplication by `l` is injective. -/
theorem odd_smul_injective {Q : Type*} [AddCommGroup Q] [Finite Q] (l : ℕ)
    (h : Nat.Coprime l (Nat.card Q)) :
    Function.Injective (fun x : Q => l • x) := by
  intro x y hxy
  have hz : l • (x - y) = 0 := by
    rw [smul_sub, sub_eq_zero]
    exact hxy
  have hd1 : addOrderOf (x - y) ∣ l := addOrderOf_dvd_of_nsmul_eq_zero hz
  have hd2 : addOrderOf (x - y) ∣ Nat.card Q := addOrderOf_dvd_natCard (x - y)
  have hone : addOrderOf (x - y) = 1 := by
    have hdvd := Nat.dvd_gcd hd1 hd2
    rw [Nat.Coprime] at h
    rw [h] at hdvd
    exact Nat.dvd_one.mp hdvd
  have : x - y = 0 := AddMonoid.addOrderOf_eq_one_iff.mp hone
  exact sub_eq_zero.mp this

/-- (148 corollary) ... hence bijective, which is `lR + J_t = R` in quotient form. -/
theorem odd_smul_bijective {Q : Type*} [AddCommGroup Q] [Finite Q] (l : ℕ)
    (h : Nat.Coprime l (Nat.card Q)) :
    Function.Bijective (fun x : Q => l • x) :=
  Finite.injective_iff_bijective.mp (odd_smul_injective l h)

/-- (149) The index arithmetic: `#((Z/2^k)^64) = 2^(64 k)` - the exact value of
`[R : J_{k+1}]` once `J_{k+1} = 2^k R` is known (rank certificates). -/
theorem card_index_pow (k : ℕ) :
    Nat.card (Fin 64 → ZMod (2 ^ k)) = 2 ^ (64 * k) := by
  rw [Nat.card_fun, Nat.card_zmod, Nat.card_eq_fintype_card, Fintype.card_fin,
      ← pow_mul, mul_comm]

#print axioms ker_mk_comp_subtype
#print axioms index_transfer
#print axioms odd_smul_injective
#print axioms odd_smul_bijective
#print axioms card_index_pow
