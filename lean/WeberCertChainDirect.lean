import Mathlib
/-!
# weber_general_n: direct KY certificate chain (r11; GPT r10 homework 39-45)

Replaces the Horie/P4 layer of `WeberChain.lean` (r5) by the chain the paper actually uses:
KY Prop. 4.1 gives a saturated component directly when `l | k_n`; an accepted RHO witness or an
accepted T witness on a component refutes its saturation. No `axiom`; every literature input is a
hypothesis (METHODOLOGY sect 5).

WHAT IS AND IS NOT VERIFIED HERE (hw 44). These theorems verify the propositional and
order-theoretic content of the certificate soundness argument, relative to the hypotheses named in
their statements. They do NOT verify the implementation of the read-only checker
(`scripts/family_verify.sage`): the correspondence between "the checker printed EXCLUDED" and the
predicate `accepted` below is a specification (hw 43), stated as the hypothesis `hSpec` of
`exclusion_of_checker_spec`, not a Lean fact. Trust label of the paper's Certificate Soundness
Theorem: C + L, F-core (hw 45).
-/

namespace WeberCert

/-- hw 39: the direct chain. `qDiv` = "l divides k_n"; `saturated f` = KY saturation of the
component `f`; `rhoWitness f` / `tWitness f` = an accepted RHO / T line on `f`. -/
theorem exclusion_chain_direct {Comp : Type} (qDiv : Prop)
    (saturated rhoWitness tWitness : Comp → Prop)
    (hSat : qDiv → ∃ f, saturated f)
    (hRho : ∀ f, rhoWitness f → ¬ saturated f)
    (hT   : ∀ f, tWitness f → ¬ saturated f)
    (hCover : ∀ f, rhoWitness f ∨ tWitness f) :
    ¬ qDiv := by
  intro hq
  obtain ⟨f, hf⟩ := hSat hq
  rcases hCover f with h | h
  · exact hRho f h hf
  · exact hT f h hf

/-- hw 41: a RHO witness refutes saturation. On a saturated component every nonzero lattice
vector is the log vector of a relative unit `≠ ±1` (Lemma E + Lemma A), whose MO height is at
least `L` (MO 2016 Lemma 2.5(1)); this is the hypothesis `floorRho`. A RHO witness is a nonzero
vector of height `< L`. -/
theorem rho_witness_refutes_saturation {Comp : Type} {Vec : Comp → Type}
    (saturated : Comp → Prop) (nonzero : ∀ f, Vec f → Prop) (ht : ∀ f, Vec f → ℝ) (L : ℝ)
    (floorRho : ∀ f, saturated f → ∀ v, nonzero f v → L ≤ ht f v)
    (f : Comp) (v : Vec f) (hv : nonzero f v) (hlt : ht f v < L) : ¬ saturated f := by
  intro hs
  exact absurd (floorRho f hs v hv) (not_le.mpr hlt)

/-- hw 42: a T witness refutes saturation. The trace floor of KY Thm 2.3 (`33·2^n` for `n ≥ 3`;
MO3 Prop 6.6 for `n = 2`) bounds `T` from below on the same units; hypothesis `floorT`. -/
theorem t_witness_refutes_saturation {Comp : Type} {Vec : Comp → Type}
    (saturated : Comp → Prop) (nonzero : ∀ f, Vec f → Prop) (T : ∀ f, Vec f → ℝ) (bar : ℝ)
    (floorT : ∀ f, saturated f → ∀ v, nonzero f v → bar ≤ T f v)
    (f : Comp) (v : Vec f) (hv : nonzero f v) (hlt : T f v < bar) : ¬ saturated f := by
  intro hs
  exact absurd (floorT f hs v hv) (not_le.mpr hlt)

/-- hw 43: specification theorem. `accepted f` is the mathematical predicate the checker is
specified to decide: "there is a nonzero vector on `f` with `ht < L`, or one with `T < bar`".
`hSpec` (the checker's EXCLUDED verdict on every component implies `accepted` on every component)
is the implementation correspondence and is NOT proven here (hw 44). -/
theorem exclusion_of_checker_spec {Comp : Type} {Vec : Comp → Type} (qDiv : Prop)
    (saturated : Comp → Prop) (nonzero : ∀ f, Vec f → Prop)
    (ht T : ∀ f, Vec f → ℝ) (L bar : ℝ)
    (hSat : qDiv → ∃ f, saturated f)
    (floorRho : ∀ f, saturated f → ∀ v, nonzero f v → L ≤ ht f v)
    (floorT : ∀ f, saturated f → ∀ v, nonzero f v → bar ≤ T f v)
    (checkerExcluded : Prop)
    (hSpec : checkerExcluded →
      ∀ f, (∃ v, nonzero f v ∧ ht f v < L) ∨ (∃ v, nonzero f v ∧ T f v < bar))
    (hEx : checkerExcluded) : ¬ qDiv := by
  refine exclusion_chain_direct qDiv saturated
    (fun f => ∃ v, nonzero f v ∧ ht f v < L) (fun f => ∃ v, nonzero f v ∧ T f v < bar)
    hSat ?_ ?_ (hSpec hEx)
  · rintro f ⟨v, hv, hlt⟩
    exact rho_witness_refutes_saturation saturated nonzero ht L floorRho f v hv hlt
  · rintro f ⟨v, hv, hlt⟩
    exact t_witness_refutes_saturation saturated nonzero T bar floorT f v hv hlt

end WeberCert

#print axioms WeberCert.exclusion_chain_direct
#print axioms WeberCert.rho_witness_refutes_saturation
#print axioms WeberCert.t_witness_refutes_saturation
#print axioms WeberCert.exclusion_of_checker_spec
