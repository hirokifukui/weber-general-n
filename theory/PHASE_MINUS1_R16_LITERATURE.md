# PHASE −1 — R16 literature inputs, verbatim findings (Track A: U(q); Track B: odd-p Morisawa–Okazaki)

Date 2026-08-26 (R16, node <LOCAL_HOST>). Read from the primary texts, not from summaries. Claim tags: [V] = read verbatim
in the cited text; [hand] = my derivation from [V]; [MC] = machine-checked; [OPEN] = not yet verified against the
version stated.

## 1. U(q): Ramaré, "Approximate formulae for L(1,χ), II", Acta Arith. 112 (2004), no. 2, 141–149

Source read: the author's own PDF at https://ramare-olivier.github.io/Maths/LOneChi2.pdf (header "ACTA ARITHMETICA
* (200*)", received 20.9.2002, revised 26.6.2003) — the accepted manuscript, not the journal typesetting.
[OPEN] the journal version (Acta Arith. 112 (2004) 141–149) has not been compared; any numeric constant used
from this source is to be re-read there before the final release (hw 660 exception check).

- **Corollary 1 [V].** χ primitive Dirichlet character mod q, h an integer prime to q, q divisible by a square-free k;
  κ_χ = 0 if χ is even, κ_χ = 5 − 2 log 6 if χ is odd. Then
  |∏_{p|h}(1 − χ(p)/p) L(1,χ)| − (φ(hk)/(2hk)) (log q + 2 Σ_{p|hk} log p/(p−1) + ω(h) log 4 + κ_χ)
  is bounded from above, if χ is even and q ≥ k² 4^{ω(h)}, by (φ(h) 2^{ω(k)−1}/(h √q)) · log(q 4^{−ω(h)+1})
  (and by (φ(h) 2^{ω(k)−1}/(h √q)) · (1.81 + ω(h) log 4 − log q) when k = 1).
- **Our specialisation [hand].** h = 1, k = 2 (our q = 2^{n+2} is divisible by the square-free 2), χ even primitive:
  ω(h) = 0, φ(hk)/(2hk) = 1/4, Σ_{p|2} log p/(p−1) = log 2, φ(h) 2^{ω(k)−1}/h = 1, condition q ≥ 4. Hence
      **|L(1,χ)| ≤ U(q) := (1/4)(log q + 2 log 2) + log(4q)/√q   for every even primitive χ of conductor q, 2 | q, q ≥ 4.**
  For q = 2^{n+2}, n ≥ 2, the condition holds. (Coarser fallbacks, for cross-checking only: Ramaré 2001 gives
  |L(1,χ)| ≤ (1/2) log q for even primitive χ, q > 1 — quoted in Saad Eddin, arXiv:1503.08365, intro; Louboutin
  C. R. Acad. Sci. 323 (1996) / 332 (2001): (1/2) log q + 0.009 for even χ — same secondary source.)
- Note the slope: 1/4 rather than 1/2, because 2 divides the conductor. This is the k = 2 mechanism of the paper (it
  improves Louboutin's Theorem 5 of Acta Arith. 101 (2002) and extends it to odd characters).
- **Exceptions to check (hw 660) [OPEN→partly done]:** the corollary is stated for all primitive χ; parity enters only
  through κ_χ and the error term; the only range condition is q ≥ k² 4^{ω(h)} = 4. No small-modulus exception is stated
  for the even case. The paper uses GP/PARI checks for its Corollary 2 (h = 2, q odd — not our case).

## 1b. Robbins, "A remark on Stirling's formula", Amer. Math. Monthly 62 (1955), no. 1, 26–29

Source read: scanned text of the Monthly note (heuklyd.github.io/papers/pdf/Robbins-1955.pdf; JSTOR 2308012). [V] "We shall
prove Stirling's formula by showing that for n = 1, 2, ...  n! = √(2π) n^{n+1/2} e^{−n} e^{r_n}  where r_n satisfies the double
inequality 1/(12n+1) < r_n < 1/(12n)." Used in N4 as the upper half only (k! ≤ √(2πk)(k/e)^k e^{1/(12k)}, k ≥ 1 integer).

## 2. Track B: Morisawa–Okazaki, "Mahler measure and Weber's class number problem in the cyclotomic Z_p-extension of
Q for odd prime number p", Tohoku Math. J. 65 (2013), 253–272

Source read: J-STAGE PDF (open access), saved as paper/MO2013_Tohoku_oddp.pdf (20 pp.). Notation: B_{p,n} the degree-p^n
real subfield of Q(μ_{p^∞}); h_{p,n}; ℓ ≠ p; f = inertia degree of ℓ in Q(μ_p)/Q; p^s ∥ ℓ^{p−1} − 1; r = min{n, s};
c = (p−1) p^{r−1}; N = p^n; ζ_n = exp(2π√−1/p^n).

- **Theorem A [V].** G_1(p,r,f) = ((√6 p/2)^c · c!)^{1/f}. If ℓ > G_1(p,r,f) then ℓ ∤ h_{p,n}. (The proof, §5, derives
  a contradiction from ℓ | h_n/h_{n−1}; the abstract states the conclusion as "h_{p,n}/h_{p,n−1} is coprime with ℓ".)
- **Theorem B [V].** G_cyclo(p,r,f) = (√6^c (p^{p−2} ((p−1)/2)!² /(p−1)!)^{c/(p−1)} c!)^{1/f}; ℓ > G_cyclo ⇒ ℓ ∤ h_{p,n}.
  Example printed: H(5,1,1) > 6·10^12 (Horie–Horie), G_1(5,1,1) = 33750, G_cyclo(5,1,1) = 18000.
- **Theorem 0.3 (p = 3, from [21] = Morisawa) [V].** f = inertia degree of ℓ in Q(μ_3)/Q, 3^s ∥ ℓ^f − 1, c = 2·3^{s−1};
  ℓ > (2^{c/2} · c!)^{1/f} ⇒ ℓ ∤ h_{3,n} for all n. (Uniform in n; the competitor for Gate 3 at p = 3, together with
  Theorem A/B at p = 3.)
- **Horie unit [V].** δ(b) = sin(2b(1+p^n)π/p^{n+1})/sin(2bπ/p^{n+1}); η_n = ∏_{k=1}^{(p−1)/2} δ(ω(k)), ω = Teichmüller
  character mod p; η_n ∈ B_n is a norm of δ(1) from Q(ζ_{n+1}+ζ_{n+1}^{−1}) (Remark 1.1).
- **Lemma 1.3 (Horie) [V].** ℓ ≠ p, F an extension in Q(ζ_n) of the decomposition field of ℓ for Q(ζ_n)/Q. Then
  ℓ | h_n/h_{n−1} iff there exists a prime ideal L of F dividing ℓ such that η_n^{α_σ} is an ℓ-th power in E_n for every
  α ∈ ℓL^{−1}. (Here α ↦ α_σ is the Z[ζ_n] ≅ Z[Gal(Q(ζ_{n+1})/Q(ζ_1))]/(1+τ+…+τ^{p−1}) action on (B_{p,n}^×)^{1−τ}.)
  → this is the odd-p saturation statement: the "Horie-root lattice" ℓL^{−1} has index ℓ^{c−f} in Z[ζ_r]
  (ℓ unramified, L of residue degree f), i.e. the same shape as our L_f = π^{−1}(M_f) of index ℓ^{m−d} [hand].
  Difference from KY (p = 2): the module is CYCLIC (generated by the single unit η_n), not the full relative-unit
  module A_n; and the statement is "η^{α} is an ℓ-th power for all α in the ideal", not a coset containment.
- **Theorem 2.2 (Schinzel-type) [V].** ε totally real unit ≠ ±1, M an ideal of Q(ε) containing ε² − 1, C = absolute
  norm of M, d = deg ε: M(ε) ≥ ((C^{1/d} + √(C^{2/d}+4))/2)^{d/2}; in particular M(ε) ≥ ((1+√5)/2)^{d/2}.
- **Lemma 3.3 [V].** M(η_n) < exp(0.291560904 · pN)  (via Lobachevsky L(π/4) = Catalan's constant).
- **Lemma 4.1 / §5 [V].** Minkowski on the ℓ¹-ball X_1 = {Σ a_i ζ^i : Σ|a_i| ≤ 2ℓ/(√6 p)} in W ≅ R^c (coordinate volume,
  NOT the log-lattice), applied to μ(ℓL^{−1}); the contradiction 0.240605912 < 0.291560904·2/√6 = 0.238058481… closes.
  → Their engine is Mahler measure + ℓ¹ Minkowski with a Hadamard-free but coordinate-volume body; ours would be the
  ℓ² Blichfeldt ball on the LOG lattice of the cyclic module Z[ζ_r]·η_n with exact covolume (character product)
  against a height floor. This is the exact analogue of the p = 2 change "Horie's ideal lattice → component log-lattice,
  analytic covolume → exact covolume" (paper §comparison). Gate 1 is therefore not blocked in principle [hand]; the
  work is (i) the log-lattice covolume of Z[ζ_r]·η_n (a group determinant over Gal(Q(ζ_{n+1})/Q(ζ_1)) restricted to the
  characters of order dividing p^r? — to be derived), (ii) the height floor for ε ∈ E_n with Nr_{B_n/B_{n−1}} ε = 1.
- **Lemma 9.1 [V] (depth floor, odd p).** ε ∈ B_n unit with Nr_{B_n/B_{n−1}}(ε) = 1, ε ≠ 1: ord_𝔭(ε − 1) ≥ (N−1)/(p−1),
  𝔭 the prime of B_n above p. **Lemma 9.2 [V].** M(ε) ≥ ((p^{(N−1)/((p−1)N)} + √(p^{2(N−1)/((p−1)N)} + 4))/2)^{N/2}.
  → the odd-p analogue of our Lemma depthfloor; it converts to an ℓ² height floor by Cauchy–Schwarz
  (Σ|log|ε_i|| = 2 log M(ε) ≤ √N · ht(ε)) [hand].
- **Theorem 9.4 (p = 5) [V].** ℓ^f > (640/3)^q · c! ⇒ ℓ ∤ h_{5,n}/h_{5,n−1} (q = 5^{r−1}, c = 4q).

## 2b. Horie, Proc. Japan Acad. 81 (2005) 40–43 (the citation [9] of MO2013 for Lemma 1.3)

Read in full (paper/Horie2005_PJA_typical_inert.pdf, 4 pp.) [V]. It contains NO ideal-lattice lemma in the MO2013 form; its
Lemma 2 ("if p^n > M or l >= log‖η‖/log 2 then l ∤ h_n/h_{n−1}") is proved "from Lemmas 2, 3 and 8 of [1]" = Horie, J. London
Math. Soc. 66 (2002) 257–275. Its η is ∏_a sin(2πa/p^{n+1})/sin(2πta/p^{n+1}) over a < p^{n+1}/2 with a^{p−1} ≡ 1 mod p^{n+1}
(the inverse of MO2013's δ-product; same lattice). Consequence: the saturation input of Track B is Horie 2002 (JLMS, paywalled,
[OPEN] for verbatim), quoted through MO2013 Lemma 1.3 and, independently, through Horie–Horie, Tohoku 61 (2009) (Euclid PDF,
search snippet: "there exists a prime ideal l of F dividing l such that, for any β ∈ ll^{-1}, η^{βσ} is an l-th power in E").
The paper's trust table cites the input as "MO13 Lemma 1.3 (Ho05b, Ho02)" and the Blueprint node lem:horie13 states the OPEN flag.

## 3. Consequences for the R16 plan

- Track A (hw 659–670): U(q) chosen = Ramaré II Cor. 1 with (h,k) = (1,2). It is an L input (analytic), isolated as a
  named hypothesis; the discrete part (C_n ≤ Ĉ_n and the transfer of Theorem A's criterion) is elementary.
- Track B (hw 683–698): Gate 1 has a primary-source anchor (Horie's Lemma 1.3 as quoted in MO2013). The kill test is
  Gate 2/3: whether the exact log-covolume of Z[ζ_r]·η_n against the Cauchy–Schwarz height floor beats
  G_1(3,r,f) / G_cyclo(3,r,f) / Theorem 0.3 in an infinite class. Competitor values are explicit and can be tabulated
  before any new computation.


## R17 additions (2026-08-26, <LOCAL_HOST>)
- MO2016 (JTNB 28, paper/MO2016_height_weber_jtnb965.pdf), read verbatim via pdftotext (the "√" of the height bounds is displaced by the
  extraction; the (4.5) display and Lemma 2.3 fix the convention): Def. 2.2 ht = L2-height of the log vector; Lemma 2.3 ht(eps) >= sqrt(N)
  log((C^{1/N} + sqrt(C^{2/N}+4))/2), C = |Nr(eps^2-1)|; Lemma 2.4(2) (= MO13 Lemma 9.1) C >= p^{(p^n-1)/(p-1)} for eps in E_n \ E_{n-1} with
  Nr_{B_n/B_{n-1}} eps = 1; Lemma 2.5(2) the combination; Theorem A at p = 3: G(3,s,f) = ((sqrt(2 pi)/(3^{3/4} log((3^{40/81} +
  sqrt(3^{80/81}+4))/2)))^c ((c+2)/2)!)^{1/f}, c = 2 3^{s-1}, checked against Example 1.6 (G(3,3,2) = 42407.5 vs "4.3e4", G(2,5,1),
  (5,1,1) not recomputed); 4.3 concluding proof: the (4.3)-(4.5) chain (Blichfeldt on the ideal lattice of delta_n^{alpha}, Lemma 2.5(2)
  floor); Definition 2.6 / Theorem 2.7 (Blichfeldt) / Lemma 2.8 as in r16. Section 2.1: eta_n for p > 2 as the norm of
  (zeta - zeta^{-1})/(zeta_1 zeta - zeta_1^{-1} zeta^{-1}) to B_n (one factor at p = 3, inverse of our eta_n: sign/inversion irrelevant for
  the log lattice).
- Horie 2005 JMSJ 57, 827-857 "Triviality in ideal class groups of Iwasawa-theoretical abelian number fields" (open access, Project Euclid;
  paper/Horie2005_JMSJ_triviality.pdf, md5 42971101): Proposition 1 (p. 830): l prime not dividing g_chi, sigma a generator of
  Gal(K_chi/Q), k an extension in Q(zeta_{g_chi}) of the decomposition field of l; then l | bar h_chi iff there is a prime ideal l of k
  dividing l such that |eta_chi^{alpha sigma}| is an l-th power in E_chi for every alpha in the integral ideal l l^{-1} of k. Proof given
  (and "Another Proof of Proposition 1", p. 833). Lemma 1 (p. 834): eps in E_chi \ {+-1} a u-th power => ... (height/index consequence,
  not used). Proposition 2 (p. 837): Minkowski on l l^{-1} with the covolume sqrt(D_n) — the ancestor of MO2013 sect 4-5 and of our
  Theorem P3's convex-body step. MO2013 Lemma 1.3 is Proposition 1 with chi of order 3^n and conductor 3^{n+1}. Horie 2002 (JLMS 66,
  257-275; the primary source cited by MO2013 via Ho05b) remains paywalled (Cambridge); not compared verbatim.
- Not obtained: Ramaré 2004 journal version (Acta Arith. 112), Morisawa 2012 (Acta Arith. 153).
