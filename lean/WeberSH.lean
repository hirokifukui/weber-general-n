import Mathlib
/-!
# weber_general_n R16: Theorem SH (componentwise saturation–height bound) — the abstract group-level core

Types: `U` a commutative group (the units allowed to carry roots; `RE` in the paper), `V` a real normed
space (the log space `ℝ^N`), `H : U → V` additive on products (the logarithmic map), `ι : (Fin m → ℤ) → U`
the coordinate map `a ↦ u_a` with `H ∘ ι` additive (the sign ambiguity `u_{a+b} = ± u_a u_b` is invisible
to `H`). `L : AddSubgroup (Fin m → ℤ)` the pullback of a component.

* `H_pow`, `Hι_nsmul`  : `H (u^k) = k • H u` and `H (ι (k • a)) = k • H (ι a)`.
* `base_branch`         : for `a = ℓ • b` the root is `ι b` itself (Lemma E' of the paper, abstract form).
* `sat_root_log`        : a root `u^ℓ = ι a` has `ℓ • H u = H (ι a)` (the typed bridge of Lemma E).
* `short_vector_ge_floor`: any nonzero scaled log vector `ℓ⁻¹ H(ι a)`, `a ∈ L`, carried by a root in `U`, has
                           norm `≥ L₀` (the two branches of Theorem SH).
* `theoremSH`            : Blichfeldt's output (a nonzero `v = ℓ⁻¹ H(ι a)` with `‖v‖^m ≤ K D / ℓ^d`) plus
                           (Sat) and (Floor) give `L₀^m ≤ K D / ℓ^d`, i.e. `ℓ^d ≤ K D / L₀^m`.
* `theoremSH_contra`     : the contrapositive used by Theorem A: `K D / L₀^m < ℓ^d` refutes saturation.

Blichfeldt's theorem and the covolume computation `covol(ℓ⁻¹ H(ι L)) = D/ℓ^d` are NOT formalised: they
enter as the hypothesis `bl`. Footprint: std-3.
-/

namespace WeberSH

variable {U V : Type*} [CommGroup U] [NormedAddCommGroup V] [NormedSpace ℝ V]

/-- `H` additive on products gives `H (u ^ k) = k • H u`. -/
theorem H_pow (H : U → V) (hH : ∀ u v, H (u * v) = H u + H v) (u : U) (k : ℕ) :
    H (u ^ k) = k • H u := by
  induction k with
  | zero =>
    have h1 : H 1 = H 1 + H 1 := by simpa using hH 1 1
    have : H 1 = 0 := by
      have := congrArg (fun x => x - H 1) h1
      simpa using this.symm
    simpa using this
  | succ k ih =>
    rw [pow_succ, hH, ih, succ_nsmul]

/-- `H ∘ ι` additive gives `H (ι (k • a)) = k • H (ι a)`. -/
theorem Hι_nsmul {m : ℕ} (Hι : (Fin m → ℤ) → V) (hadd : ∀ a b, Hι (a + b) = Hι a + Hι b)
    (a : Fin m → ℤ) (k : ℕ) : Hι (k • a) = k • Hι a := by
  induction k with
  | zero =>
    have h1 : Hι 0 = Hι 0 + Hι 0 := by simpa using hadd 0 0
    have : Hι 0 = 0 := by
      have := congrArg (fun x => x - Hι 0) h1
      simpa using this.symm
    simpa using this
  | succ k ih =>
    rw [succ_nsmul, hadd, ih, succ_nsmul]

/-- Base branch (Lemma E', abstract): if `a = ℓ • b`, the unit `ι b` satisfies `ℓ • H (ι b) = H (ι a)`. -/
theorem base_branch {m : ℕ} (H : U → V) (ι : (Fin m → ℤ) → U)
    (hHι : ∀ a b, H (ι (a + b)) = H (ι a) + H (ι b)) (ℓ : ℕ) (b : Fin m → ℤ) :
    ℓ • H (ι b) = H (ι (ℓ • b)) :=
  (Hι_nsmul (fun a => H (ι a)) hHι b ℓ).symm

/-- The typed bridge (Lemma E, abstract): a root `u ^ ℓ = ι a` in `U` has `ℓ • H u = H (ι a)`. -/
theorem sat_root_log {m : ℕ} (H : U → V) (hH : ∀ u v, H (u * v) = H u + H v)
    (ι : (Fin m → ℤ) → U) (ℓ : ℕ) (a : Fin m → ℤ) (u : U) (hu : u ^ ℓ = ι a) :
    ℓ • H u = H (ι a) := by
  rw [← hu, H_pow H hH]

/-- Every nonzero scaled log vector `ℓ⁻¹ • H (ι a)`, `a ∈ L`, that is carried by a root in `U`
(hypothesis `sat`, which covers both branches) has norm at least the floor `L₀`. -/
theorem short_vector_ge_floor {m : ℕ} (H : U → V) (ι : (Fin m → ℤ) → U)
    (L : AddSubgroup (Fin m → ℤ)) (ℓ : ℕ) (hℓ : 0 < ℓ) (L₀ : ℝ)
    (sat : ∀ a ∈ L, ∃ u : U, ℓ • H u = H (ι a))
    (floor : ∀ u : U, H u ≠ 0 → L₀ ≤ ‖H u‖)
    (a : Fin m → ℤ) (ha : a ∈ L) (hv : (ℓ : ℝ)⁻¹ • H (ι a) ≠ 0) :
    L₀ ≤ ‖(ℓ : ℝ)⁻¹ • H (ι a)‖ := by
  obtain ⟨u, hu⟩ := sat a ha
  have hℓR : (ℓ : ℝ) ≠ 0 := by exact_mod_cast hℓ.ne'
  have hv' : (ℓ : ℝ)⁻¹ • H (ι a) = H u := by
    rw [← hu, ← Nat.cast_smul_eq_nsmul ℝ, smul_smul, inv_mul_cancel₀ hℓR, one_smul]
  rw [hv'] at hv ⊢
  exact floor u hv

/-- Theorem SH (abstract core). `bl` is the output of Blichfeldt's theorem on `ℓ⁻¹ H(ι L)` of
covolume `D/ℓ^d` (`ld = ℓ^d` as a real): a nonzero `v = ℓ⁻¹ • H (ι a)`, `a ∈ L`, with `‖v‖^m ≤ K D / ld`. -/
theorem theoremSH {m : ℕ} (H : U → V) (ι : (Fin m → ℤ) → U)
    (L : AddSubgroup (Fin m → ℤ)) (ℓ : ℕ) (hℓ : 0 < ℓ) (L₀ K D ld : ℝ)
    (sat : ∀ a ∈ L, ∃ u : U, ℓ • H u = H (ι a))
    (floor : ∀ u : U, H u ≠ 0 → L₀ ≤ ‖H u‖)
    (bl : ∃ a ∈ L, (ℓ : ℝ)⁻¹ • H (ι a) ≠ 0 ∧ ‖(ℓ : ℝ)⁻¹ • H (ι a)‖ ^ m ≤ K * D / ld)
    (hL₀ : 0 < L₀) :
    L₀ ^ m ≤ K * D / ld := by
  obtain ⟨a, ha, hv, hbl⟩ := bl
  have h1 : L₀ ≤ ‖(ℓ : ℝ)⁻¹ • H (ι a)‖ :=
    short_vector_ge_floor H ι L ℓ hℓ L₀ sat floor a ha hv
  exact le_trans (pow_le_pow_left₀ hL₀.le h1 m) hbl

/-- Contrapositive form used by Theorem A: `K D / L₀^m < ℓ^d` is incompatible with (Sat)+(Floor)+(Bl). -/
theorem theoremSH_contra {m : ℕ} (H : U → V) (ι : (Fin m → ℤ) → U)
    (L : AddSubgroup (Fin m → ℤ)) (ℓ : ℕ) (hℓ : 0 < ℓ) (L₀ K D ld : ℝ)
    (sat : ∀ a ∈ L, ∃ u : U, ℓ • H u = H (ι a))
    (floor : ∀ u : U, H u ≠ 0 → L₀ ≤ ‖H u‖)
    (bl : ∃ a ∈ L, (ℓ : ℝ)⁻¹ • H (ι a) ≠ 0 ∧ ‖(ℓ : ℝ)⁻¹ • H (ι a)‖ ^ m ≤ K * D / ld)
    (hL₀ : 0 < L₀) (hld : 0 < ld) (hC : K * D / L₀ ^ m < ld) : False := by
  have h := theoremSH H ι L ℓ hℓ L₀ K D ld sat floor bl hL₀
  have hLm : 0 < L₀ ^ m := pow_pos hL₀ _
  rw [div_lt_iff₀ hLm] at hC
  rw [le_div_iff₀ hld] at h
  linarith [mul_comm ld (L₀ ^ m)]

end WeberSH

#print axioms WeberSH.H_pow
#print axioms WeberSH.Hι_nsmul
#print axioms WeberSH.base_branch
#print axioms WeberSH.sat_root_log
#print axioms WeberSH.short_vector_ge_floor
#print axioms WeberSH.theoremSH
#print axioms WeberSH.theoremSH_contra
