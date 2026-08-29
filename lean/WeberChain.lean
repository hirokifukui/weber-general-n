import Mathlib
/-!
# weber_general_n: dependency-minimal exclusion chain (H1)
The propositional skeleton of the per-prime exclusion, with EVERY analytic/arithmetic input
as a hypothesis (hexagon hypotheses-theorem precedent; no axioms, std-3 footprint).
Confirms GPT-r1 H1: only the FORWARD directions are needed —
Horie forward (l | q -> some component satisfies the Horie condition) and
P4 forward (Horie condition at f -> M_f saturated). No converse is consumed.
A rho-witness at f refutes the Horie condition at f; a T-witness at f refutes saturation of f.
-/

/-- Per-prime exclusion from per-component witnesses.
`Comp` = the components (primes above l); `ellDividesQ` = "l divides q_n". -/
theorem exclusion_chain
    (Comp : Type) (ellDividesQ : Prop)
    (saturated horie rhoWitness tWitness : Comp → Prop)
    (hHorieFwd : ellDividesQ → ∃ f, horie f)
    (hP4Fwd : ∀ f, horie f → saturated f)
    (hRho : ∀ f, rhoWitness f → ¬ horie f)
    (hT : ∀ f, tWitness f → ¬ saturated f)
    (hCover : ∀ f, rhoWitness f ∨ tWitness f) :
    ¬ ellDividesQ := by
  intro h
  obtain ⟨f, hf⟩ := hHorieFwd h
  rcases hCover f with hr | ht
  · exact hRho f hr hf
  · exact hT f ht (hP4Fwd f hf)

/-- Variant without full coverage: a single component known to carry the Horie condition
is enough if THAT component has a witness (used when the component is identified). -/
theorem exclusion_at_component
    (Comp : Type) (ellDividesQ : Prop)
    (saturated horie rhoWitness tWitness : Comp → Prop)
    (f : Comp)
    (hHorieAt : ellDividesQ → horie f)
    (hP4Fwd : horie f → saturated f)
    (hRho : rhoWitness f → ¬ horie f)
    (hT : tWitness f → ¬ saturated f)
    (hW : rhoWitness f ∨ tWitness f) :
    ¬ ellDividesQ := by
  intro h
  rcases hW with hr | ht
  · exact hRho hr (hHorieAt h)
  · exact hT ht (hP4Fwd (hHorieAt h))

#print axioms exclusion_chain
#print axioms exclusion_at_component
