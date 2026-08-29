# TRACK B — p = 3 exact-covolume kill test: Gates 1–3 (R16, 2026-08-26, node <LOCAL_HOST>)   STATUS: report for ruling point (2)

Claim tags: [V] verbatim from the cited text; [hand] my derivation; [MC] machine-computed (pilot numerics, NOT a certificate);
[OPEN] not yet verified. Nothing below is a theorem of the paper until frozen and proved.

## Gate 1 — algebraic saturation at odd p (does the component / height-floor mechanism apply?)  → PASSES IN PRINCIPLE [hand]

Inputs (theory/PHASE_MINUS1_R16_LITERATURE.md sect 2; paper/MO2013_Tohoku_oddp.pdf; paper/Horie2005_PJA_typical_inert.pdf):
- Saturation [L]: MO2013 Lemma 1.3 (attributed to Horie [9] = Proc. Japan Acad. 81 (2005) 40–43, whose Lemma 2 in turn cites
  "Lemmas 2, 3 and 8 of [1]" = Horie, J. London Math. Soc. 66 (2002) 257–275). Same statement quoted independently in Horie–Horie,
  Tohoku 61 (2009), proof of their Prop.: "there exists a prime ideal l of F dividing l such that, for any β ∈ l l^{-1}, η^{βσ} is an
  l-th power in E" [V, search snippet of the Euclid PDF]. The ORIGINAL (Horie 2002, JLMS, paywalled) is [OPEN] for verbatim reading.
  Statement used: ℓ ≠ p, F ⊆ Q(ζ_{p^n}) containing the decomposition field of ℓ; ℓ | h_n/h_{n−1} ⟺ ∃ prime L | ℓ of F with
  η_n^{α_σ} ∈ E_n^ℓ for every α ∈ ℓL^{−1}. (α ↦ α_σ = the coordinate lift Σ a_i ζ^i ↦ Σ a_i σ^i, exponents i < (p−1)p^{n−1}.)
- With r = min(n, s), p^s ∥ ℓ^{p−1} − 1: F = Q(ζ_{p^r}) contains the decomposition field (f = 1: it IS Q(ζ_{p^s}) ∩ Q(ζ_{p^n});
  f = 2 at p = 3: the decomposition field is Q(ζ_{p^r})^+ ⊂ Q(ζ_{p^r})) [hand]; L has residue degree f = ord of ℓ mod p, so
  [Z[ζ_{p^r}] : ℓL^{−1}] = ℓ^{c_r − f}, c_r = (p−1)p^{r−1}   (the (Index) hypothesis of Theorem SH with d = f) [hand].
- Log lattice: u_α := η_n^{α_σ} for α ∈ Z[ζ_{p^r}] ⊂ Z[ζ_{p^n}] (ζ_{p^r} = ζ_{p^n}^{p^{n−r}}; lift exponents p^{n−r} j, j < c_r).
  α ↦ H(u_α) is Z-linear on coordinates; injective iff the Gram determinant D_r^{(n)} ≠ 0 [MC below]. The paper's Theorem SH
  assumes "A/{±1} cyclic R-module"; the LEAN form WeberSH.theoremSH assumes only additivity of a ↦ H(ι a) — that weaker form is
  exactly what Track B needs (Nr_{B_n/B_{n−1}} η_n need not be 1). → propose to state the p = 3 theorem from the Lean form.
- Height floor [L]: MO2013 Thm 2.2 with C = 1: M(ε) ≥ φ^{deg ε /2}, φ = (1+√5)/2, for every totally real unit ε ≠ ±1. Summing
  |log|ε_i|| over the N = p^n embeddings of B_n (multiplicity N/deg ε): Σ_i |log|ε_i|| = (N/deg ε)·2 log M(ε) ≥ N log φ, and
  Cauchy–Schwarz gives ht(ε) ≥ √N · log φ =: L_{p,n}  [hand]. Needs no norm condition on ε (unlike MO16 Lemma 2.5 at p = 2).
  (At p = 3: 3 log φ = log(2+√5), so L_{3,n} = L_{2,·}-shape /3 relative to the p = 2 floor — a weaker floor; Lemma 9.1/9.2 of
  MO2013 would improve it for Nr ε = 1, not used.)
- Blichfeldt [L] on the rank-c_r lattice Λ = ℓ^{−1}H(u_{ℓL^{−1}}) of covolume D_r^{(n)}/ℓ^f in its span; root ε with ε^ℓ = η^{α_σ}
  has H(ε) = v ≠ 0, so ε ≠ ±1 and the floor applies. Conclusion (Theorem SH shape):
      ℓ | h_{3,n}/h_{3,n−1}  ⟹  ℓ^f ≤ C^{(3)}_{n,r} := (2/π)^{c_r/2} Γ(2 + c_r/2) D_r^{(n)} / L_{3,n}^{c_r}.
  Every step is an instance of WeberSH.theoremSH_contra with (Sat) = Horie/MO Lemma 1.3, (Floor) = Thm 2.2 + C–S, bl = Blichfeldt.

## Gate 2 — exact covolume  → COMPUTED NUMERICALLY [MC], formula route not yet derived
sage/r16_trackB/p3_gate2_pilot.sage (2400-bit floats, Gram determinant of the c_r log vectors H(σ^{3^{n−r} j} η_n), j < c_r):
η_n = sin(2(1+3^n)π/3^{n+1})/sin(2π/3^{n+1}) (MO2013 sect 1, p = 3: η_n = δ(1)); Horie 2005 uses the inverse unit (same lattice).
Certification route for the paper: interval determinant in ball arithmetic (as certificates/blichfeldt/r6 at p = 2) — no L-value
formula needed for a C-label; the Prop-D-type character-product formula is a separate (later) item.

| n | r | N=3^n | c_r | D_r^{(n)} | L_{3,n} | C^{(3)}_{n,r} | G_1(3,r,f)^f | G_cyclo^f | Morisawa Thm 0.3 (s=r) | C/Thm0.3 |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 1 | 3 | 2 | 1.471 | 0.8335 | 2.70 | 27 | 18 | 4 | 0.67 |
| 2 | 1 | 9 | 2 | 10.82 | 1.4436 | 6.61 | 27 | 18 | 4 | 1.65 |
| 2 | 2 | 9 | 6 | 978.3 | 1.4436 | 669.2 | 1.77e6 | 5.25e5 | 5760 | 0.116 |
| 3 | 1 | 27 | 2 | 42.92 | 2.5005 | 8.74 | 27 | 18 | 4 | 2.19 |
| 3 | 2 | 27 | 6 | 7.80e4 | 2.5005 | 1.976e3 | 1.77e6 | 5.25e5 | 5760 | 0.343 |
| 3 | 3 | 27 | 18 | 6.05e13 | 2.5005 | 2.584e11 | 9.54e25 | 2.48e24 | 3.28e18 | 7.9e-8 |
| 4 | 1 | 81 | 2 | 143.4 | 4.3309 | 9.73 | 27 | 18 | 4 | 2.43 |
| 4 | 2 | 81 | 6 | 2.95e6 | 4.3309 | 2.764e3 | 1.77e6 | 5.25e5 | 5760 | 0.480 |
| 4 | 3 | 81 | 18 | 2.39e19 | 4.3309 | 5.179e12 | 9.54e25 | 2.48e24 | 3.28e18 | 1.6e-6 |
| 4 | 4 | 81 | 54 | 3.26e54 | 4.3309 | 2.120e44 | 7.63e101 | 1.34e97 | 3.10e79 | 6.8e-36 |
| 5 | 1..4 | 243 | 2..54 | see log | 7.5014 | 10.2 / 3.15e3 / 7.99e12 / 1.48e48 | — | — | 4 / 5760 / 3.28e18 / 3.10e79 | 2.5 / 0.55 / 2.4e-6 / 4.8e-32 |
| 5 | 5 | 243 | 162 | 2.37e202 | 7.5014 | 2.477e167 | 4.4e380 | 2.4e366 | 2.97e313 | 8.3e-147 |
(n = 5, r = 5 competitors evaluated in mpmath; the Sage log prints inf for them in the %e format.) Competitors verbatim: G_1(3,r,f)^f = (√6·3/2)^c c!; G_cyclo^f = √6^c (3/2)^{c/2} c!; Morisawa
Thm 0.3 (Acta Arith 153 (2012), as quoted in MO2013 Thm 0.3): ℓ^f > 2^{c/2} c!, c = 2·3^{s−1}, uniform in n. Sanity: MO2013's
printed G_1(5,1,1) = 33750 is reproduced by the formula ((√6·5/2)^4·4! = 33750) [MC].

## Gate 3 — improvement over the published bounds in an infinite congruence class?  → PRIMA FACIE YES [MC, numerical]
- Regime s ≥ n (r = n): the class {ℓ : 3^n | ℓ^{f} − 1} is infinite, and for s > n the competitors GROW (c = 2·3^{s−1}) while
  C^{(3)}_{n,n} is fixed. At the first layer with unknown class number, n = 4 (h_{3,n} = 1 known for n ≤ 3; n = 4 only under
  GRH, van der Linden), the layer-4 relative exclusion reads ℓ^f > 2.12e44 versus Morisawa's ℓ^f > 3.10e79 (s = 4) and larger for
  s ≥ 5, and G_1: 7.6e101. Ratio 6.8e−36 at s = 4 — 35 orders of magnitude, in an infinite class, with the SAME f. Same at
  n = 3 (7.9e−8) and n = 5, r = 4 (4.8e−32).
- Regime s < n (r = s): r = 1 loses slightly to Morisawa (ratio 1.6–2.5), r = 2 wins by 2–9×, r = 3 wins by 10^5–10^6.
  This mirrors the p = 2 paper's three regimes (class 65: MO16 sharper by 170×; classes with s ≥ n: ours sharper).
- Caveat on the comparison: Morisawa / MO bounds are uniform in n ("for all n"); ours is layer-fixed ("h_{3,n}/h_{3,n−1}") — the
  same comparison convention as the p = 2 paper's Table tab:classes (stated there explicitly).
- Why the gain is much larger than at p = 2: at p = 2 the competitor (MO16) already used Blichfeldt with an analytic covolume; at
  odd p the competitor uses the ℓ¹ Minkowski body with Mahler measure (MO2013 sect 4–5), and the factor c!/Γ(2+c/2) of the two
  convex-body constants is ≈ c^{c/2} — e.g. 54!/28! ≈ 8e41 at n = 4. The gain is the geometry-of-numbers constant, not the
  arithmetic; the floor we use (√N log φ) is WEAKER than what the relative-unit theory could give.

## What Gate 3 does NOT yet establish
- All numbers are 2400-bit floating point (no balls); the n = 4 / n = 5 constants need an interval certificate before any claim.
- The Horie 2002 original has not been read; the L input is quoted through MO2013 Lemma 1.3 and Horie–Horie 2009.
- Nr_{B_n/B_{n−1}} η_n: not checked (irrelevant for the Lean-form SH, relevant only if the prose SH (cyclic R-module) is used).
- Whether the r < n regime with the weaker floor can be improved (Lemma 9.2, relative units) is left open; not needed for GO.

## Proposed statement for ruling point (2) (NOT frozen)
Theorem P3 (layer-fixed componentwise bound in the cyclotomic Z_3-tower; relative to [MO2013 Lemma 1.3 / Horie], [MO2013 Thm 2.2 /
Schinzel], [Blichfeldt], and a certified enclosure of D_r^{(n)}). Let n ≥ 1, ℓ ≠ 3 prime, f = ord of ℓ mod 3, 3^s ∥ ℓ^2 − 1,
r = min(n, s), c = 2·3^{r−1}, L_{3,n} = √(3^n) log((1+√5)/2), D_r^{(n)} the covolume of the lattice spanned by H(σ^{3^{n−r} j} η_n),
0 ≤ j < c, and C^{(3)}_{n,r} = (2/π)^{c/2} Γ(2+c/2) D_r^{(n)}/L_{3,n}^c. If ℓ^f > C^{(3)}_{n,r} then ℓ ∤ h_{3,n}/h_{3,n−1}.
Explicit corollary at n = 4 (subject to certification): ℓ ≡ 1 (mod 81), ℓ > 2.13×10^44 ⇒ ℓ ∤ h_{3,4}/h_{3,3};
ℓ ≡ −1 (mod 81), ℓ > 1.46×10^22 ⇒ same. (Morisawa 2012: 3.10×10^79 / 5.57×10^39.)
Work to freeze it: (a) interval certificate of D_4^{(4)} (and D_5^{(5)}); (b) Horie 2002 verbatim or an explicit "as quoted in
MO2013 Lemma 1.3" label; (c) re-state SH in the paper in the additive form (Lean form) or add a remark; (d) Lean: instance of
WeberSH.theoremSH_contra with the p = 3 data as hypotheses; (e) Phase −1 on Morisawa 2012 (Thm 0.3's source) for the comparison table.
