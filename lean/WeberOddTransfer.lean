import Mathlib

/-!
# WeberOddTransfer -- odd-power depth transfer, finite-group core (r15; GPT r14 sect 4, hw 525-534)

Group core of Lemma oddtransfer of the manuscript (Appendix E): in a group of 2-power order an odd
power map is injective, so `x ^ l = 1 <-> x = 1` and `x ^ l = y ^ l <-> x = y`.  The manuscript applies
this with `G = (O_n / 2^t O_n)^x`, a group of order `2^(N t - 1)` because 2 is totally ramified in `B_n`
with residue field `F_2`; that arithmetic identification is proved in the manuscript (label M) and is
NOT stated here.  Nothing below mentions number fields.  The proofs use Mathlib's `powCoprime`
(the `n`-th power map of a finite group is a bijection when `n` is coprime to the order).
-/

namespace WeberOddTransfer

/-- `2^k` is coprime to every odd natural number. -/
theorem coprime_two_pow_of_odd {k l : ℕ} (hl : Odd l) : (2 ^ k).Coprime l :=
  Nat.Coprime.pow_left k (Nat.coprime_two_left.mpr hl)

/-- In a group of order `2^k`, an odd power of `x` is `1` iff `x = 1`. -/
theorem pow_odd_eq_one_iff_of_two_pow_card {G : Type*} [Group G] {k l : ℕ}
    (hG : Nat.card G = 2 ^ k) (hl : Odd l) (x : G) : x ^ l = 1 ↔ x = 1 := by
  have hcop : (Nat.card G).Coprime l := by rw [hG]; exact coprime_two_pow_of_odd hl
  constructor
  · intro h
    exact (powCoprime hcop).injective (a₁ := x) (a₂ := 1) (by simpa [powCoprime_apply] using h)
  · rintro rfl; simp

/-- In a group of order `2^k`, the odd power map `x ↦ x ^ l` is injective. -/
theorem pow_odd_injective_of_two_pow_card {G : Type*} [Group G] {k l : ℕ}
    (hG : Nat.card G = 2 ^ k) (hl : Odd l) : Function.Injective (fun x : G => x ^ l) := by
  have hcop : (Nat.card G).Coprime l := by rw [hG]; exact coprime_two_pow_of_odd hl
  intro x y hxy
  exact (powCoprime hcop).injective (by simpa [powCoprime_apply] using hxy)

/-- In a group of order `2^k`: `x ^ l = y ^ l` iff `x = y` for odd `l`. -/
theorem pow_odd_eq_iff_of_two_pow_card {G : Type*} [Group G] {k l : ℕ}
    (hG : Nat.card G = 2 ^ k) (hl : Odd l) (x y : G) : x ^ l = y ^ l ↔ x = y :=
  ⟨fun h => pow_odd_injective_of_two_pow_card hG hl h, fun h => h ▸ rfl⟩

/-- Ring form: in a commutative ring whose unit group has order `2^k` (the manuscript's
`O_n / 2^t O_n`), an odd power of a unit `x` is `1` iff `x = 1`. -/
theorem isUnit_pow_odd_eq_one_iff {R : Type*} [CommRing R] {k l : ℕ}
    (hR : Nat.card Rˣ = 2 ^ k) (hl : Odd l) {x : R} (hx : IsUnit x) : x ^ l = 1 ↔ x = 1 := by
  obtain ⟨u, rfl⟩ := hx
  have h := pow_odd_eq_one_iff_of_two_pow_card hR hl u
  constructor
  · intro h1
    have : u ^ l = 1 := Units.ext (by simpa using h1)
    simpa using h.mp this
  · intro h1
    have : u = 1 := Units.ext (by simpa using h1)
    subst this; simp

end WeberOddTransfer

#print axioms WeberOddTransfer.coprime_two_pow_of_odd
#print axioms WeberOddTransfer.pow_odd_eq_one_iff_of_two_pow_card
#print axioms WeberOddTransfer.pow_odd_injective_of_two_pow_card
#print axioms WeberOddTransfer.pow_odd_eq_iff_of_two_pow_card
#print axioms WeberOddTransfer.isUnit_pow_odd_eq_one_iff
