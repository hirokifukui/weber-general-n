import Mathlib
/-!
# weber_general_n R16: real formal roots, cosets, and the representative change `a ↦ a + ℓ b` (hw 675/676)

The identification of KY (paper eq. (ident)) sends `ā ∈ R_n/ℓR_n` to the coset `[r_a] = r_a A_n` of the REAL
`ℓ`-th root `r_a` of `u_a` (ℓ odd, so the real root is unique). Two facts make it well defined:

* `odd_pow_injective`   : for odd `ℓ`, `x ^ ℓ = y ^ ℓ` forces `x = y` in `ℝ` — the real root is unique, so a
                          "formal root" is a real NUMBER, not a choice;
* `root_change_rep`     : if `r ^ ℓ = u`, `v ^ ℓ = w` and `r' ^ ℓ = u * w`, then `r' = r * v` — replacing `a` by
                          `a + ℓ b` multiplies the root by the unit `v = ± u_b`, i.e. does not change the coset;
* `coset_eq_of_change_rep` : the coset statement `r' ∈ r • A` for a multiplicative subgroup `A ∋ v`.

Types: roots and units are elements of `ℝ` (or `ℝˣ`); a coset is the set `r • A`; membership of a coset in a
subgroup of cosets is never written as a subset relation. Footprint: std-3.
-/

namespace WeberRoots

/-- Odd powers are injective on `ℝ`: the real `ℓ`-th root is unique. -/
theorem odd_pow_injective (ℓ : ℕ) (hodd : Odd ℓ) (x y : ℝ) (h : x ^ ℓ = y ^ ℓ) : x = y :=
  (hodd.strictMono_pow (R := ℝ)).injective h

/-- Representative change: roots multiply. -/
theorem root_change_rep (ℓ : ℕ) (hodd : Odd ℓ) (r v r' u w : ℝ)
    (hr : r ^ ℓ = u) (hv : v ^ ℓ = w) (hr' : r' ^ ℓ = u * w) : r' = r * v := by
  apply odd_pow_injective ℓ hodd
  rw [hr', mul_pow, hr, hv]

/-- The coset does not change: with `A` a subgroup of `ℝˣ` (as a set of reals) and `v ∈ A`, `r' ∈ r • A`. -/
theorem coset_eq_of_change_rep (ℓ : ℕ) (hodd : Odd ℓ) (A : Subgroup ℝˣ) (r r' u w : ℝ) (v : ℝˣ)
    (hvA : v ∈ A) (hr : r ^ ℓ = u) (hv : (v : ℝ) ^ ℓ = w) (hr' : r' ^ ℓ = u * w) :
    ∃ v' ∈ A, r' = r * (v' : ℝ) :=
  ⟨v, hvA, root_change_rep ℓ hodd r v r' u w hr hv hr'⟩

/-- The base case `a = ℓ b`: the real root of `u_b ^ ℓ` is `u_b` itself. -/
theorem root_of_pow (ℓ : ℕ) (hodd : Odd ℓ) (r u : ℝ) (hr : r ^ ℓ = u ^ ℓ) : r = u :=
  odd_pow_injective ℓ hodd r u hr

end WeberRoots

#print axioms WeberRoots.odd_pow_injective
#print axioms WeberRoots.root_change_rep
#print axioms WeberRoots.coset_eq_of_change_rep
#print axioms WeberRoots.root_of_pow
