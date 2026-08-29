import Mathlib
/-!
# weber_general_n H2: the finite-group core of Luo's Lemma 3.2, kernel-verified
Luo (arXiv:2604.15858v2) Lemma 3.2: for k >= 4 and odd l with l != +-1 (mod 2^(k-1)),
the order of l in (Z/2^k)^* is >= 4. Equivalently (order is a power of 2): l^2 != 1 in Z/2^k.
We kernel-verify the k = 8 and k = 9 instances (the ones relevant to n = 7 territory).
NOTE (quarantine): this sublemma being true does NOT un-quarantine Luo's Theorem 3.1(ii);
the theorem-level chain runs through section 3 of the paper, where Lemma 3.3(iii) was
refuted by three independent methods (weber track, 2026-06). Quarantine of the strong
congruence l = +-1 (mod 2^(k-1)) REMAINS until Luo's chain is repaired.
-/

set_option maxRecDepth 8192 in
/-- Luo Lemma 3.2, finite core, k = 8: odd `a` mod 256 with `a != +-1 (mod 128)`
has `a^2 != 1` in `ZMod 256` (hence multiplicative order >= 4). -/
theorem luo_lemma32_k8 :
    ∀ a : ZMod 256, a.val % 2 = 1 → a.val % 128 ≠ 1 → a.val % 128 ≠ 127 →
      a ^ 2 ≠ 1 := by decide

set_option maxRecDepth 8192 in
/-- Luo Lemma 3.2, finite core, k = 9: odd `a` mod 512 with `a != +-1 (mod 256)`
has `a^2 != 1` in `ZMod 512`. -/
theorem luo_lemma32_k9 :
    ∀ a : ZMod 512, a.val % 2 = 1 → a.val % 256 ≠ 1 → a.val % 256 ≠ 255 →
      a ^ 2 ≠ 1 := by decide

/-- Order bridge: in a group, if `a^2 != 1` and `a^(2^m) = 1` for some m (order a power
of two), the order is at least 4. Stated arithmetically: any divisor f of 2^m with
f != 1 and f != 2 satisfies 4 <= f. -/
theorem pow_two_divisor_ge_four (m f : ℕ) (hf : f ∣ 2^m) (h1 : f ≠ 1) (h2 : f ≠ 2) :
    4 ≤ f := by
  obtain ⟨j, hj, hfe⟩ := (Nat.dvd_prime_pow Nat.prime_two).mp hf
  subst hfe
  match j, hj with
  | 0, _ => simp at h1
  | 1, _ => simp at h2
  | (j+2), _ => calc (4:ℕ) = 2^2 := rfl
                _ ≤ 2^(j+2) := Nat.pow_le_pow_right (by norm_num) (by omega)

#print axioms luo_lemma32_k8
#print axioms luo_lemma32_k9
#print axioms pow_two_divisor_ge_four
