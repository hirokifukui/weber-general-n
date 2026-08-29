# PHASE_MINUS1_INTEGRATED_AUDIT_R10 - bin 1 of the R10 paper pivot (2026-08-25, node <LOCAL_HOST>)

Gate for bins 3-7 (HANDOFF R10 NEXT ACTION 1a-1d). Every source line below was
re-read THIS session from the on-disk primary text (pdftotext -layout scratch of
paper/MO2016_height_weber_jtnb965.pdf and paper/KY_2107.08587_weber.pdf;
paper/sources/MO3_2020_clean.txt). Independent numerics: sage/r10_bin1_constant_audit.py
(md5 7f8bd9dfbf8804bbd63f8aa419ed92ce) -> .log (md5 3749abaff174ed09aa41333e96a65a36);
inputs are the KY definitions only, no project data is read.

## (a) HEIGHT-CONSTANT AUDIT - the three bounds are three different objects

| bound | source (verbatim location) | group / hypotheses | functional | value at n=7 | where it enters OUR chain |
|---|---|---|---|---|---|
| Tr eps^2 >= 2^n * 17 | MO3 2020, Prop 6.6 (p.1075): "Let n be an integer greater than 1 and eps a relative unit in RE+_n \ {+-1}. Then Tr_{V_n/Q}(eps^2) >= 2^n * 17." | RE+_n \ {+-1}, n >= 2 | TRACE OF SQUARE, T(eps) = sum_a sigma_a(eps)^2 = sum_j e^{2 y_j} | 2176 | nowhere (dominated by KY 33 for n >= 3) |
| Tr eps^2 >= 2^n * 33 | KY 2022, Thm 2.3 (p.4): "We have for n >= 3  min{Tr eps^2 : +-1 != eps in RE+_n} >= 2^n * 33." Proof uses [MO3, Lemma 6.2] parity (a_0 odd, a_i even) on the orthogonal basis b_i with Tr eps^2 = 2^n(a_0^2 + 2 sum_{i>=1} a_i^2) [KY (7) = MO3 (6.2)+Lemma 6.3]. KY p.2 verbatim: "Morisawa and Okazaki [MO3, Proposition 6.6] showed ... >= 2^n * 17 (n >= 2) ... We generalize these results ... >= 2^n * 33 (n >= 3)." | RE+_n \ {+-1} (relative norm EXACTLY 1), n >= 3 | same TRACE functional | 4224 | T-route ONLY (flagship_T input (3)). Never inside C_n. |
| ht(eps) >= sqrt(2^n) log(2+sqrt5) | MO 2016, Lemma 2.5(1) (p.817): "Let eps be a unit in E_n \ E_{n-1} with Nr_{B_n/B_{n-1}}(eps) = 1. (1) If p = 2, then ht(eps) >= sqrt(2^n) log(2+sqrt5)." ht = Def 2.2 (p.815) = sqrt(sum_{i=1}^{N} (log|eps_i|)^2) over ALL N conjugates. Derivation printed: Lemma 2.3 (Schinzel/Mahler, C = |Nr(eps^2-1)|) + Lemma 2.4(1) (eps = 1 mod 2, so C >= 4^{2^n}); (C^{1/N} + sqrt(C^{2/N}+4))/2 >= (4+sqrt20)/2 = 2+sqrt5. | E_n \ E_{n-1}, relative norm 1 (= RE+_n \ {+-1} by Lemma A of BLICHFELDT_SATURATION_THEOREM_R7) | L2-HEIGHT of the log vector, |y|_2 with y_j = log|sigma^j eps| | 16.3329 | THE L_n of C_n = (2/pi)^{m/2} Gamma(1+(m+2)/2) D_n / L_n^m, m = 2^{n-1} |

Second independent source for the third row [P, verbatim]: MO3 2020 Thm 5.3 (p.1074)
"If eps is in RE_{n,1} with eps != 1, then M(eps) >= (2+sqrt5)^{2^{n-1}}" (Mahler measure),
with RE+_n = +-RE_{n,1} (MO3 Lemma 3.2(3)(4), p.1070-71), and MO 2016 eq. (2.4)
(sqrt(N)/2) ht(eps) >= log M(eps) (Cauchy-Schwarz, proof of Lemma 2.3) give
ht >= 2 * 2^{n-1} log(2+sqrt5) / sqrt(2^n) = sqrt(2^n) log(2+sqrt5): identical constant
by two routes (2016 valuation proof; 2020 filtration theorem). [MC] 16.332870944966409676
both ways (log).

Mapping to the Blichfeldt norm [P]: the lattice of Prop F is Lambda = (1/l) H_n L_f in
R^{2m} = R^{2^n}; its vectors are exactly the log vectors (log|sigma^j r_a|)_{j<2^n} of the
real formal roots, so |v|_2 = ht(r_a) in MO's Def 2.2 metric, with NO change of
normalisation (all 2^n embeddings, not the m = 2^{n-1} "half"). D_n = covol of the
rank-m lattice inside R^{2m} = sqrt(det(H_n^T H_n)) = 2^{m/2}|det W_n| (Lemma D(iii)).
Blichfeldt as printed by MO Thm 2.7 (p.818, verbatim): "|v|^2 <= (2/pi)(Gamma(1+(d+2)/2))^{2/d}
vol^{(d)}(Lambda)^{2/d}" - d-dimensional volume of a rank-d lattice, which is what D_n / l^{d_f}
is. Gamma(1+(m+2)/2) = Gamma(2+m/2) = 33! at n = 7 [MC].

Certificate re-derivation [MC, r10_bin1_constant_audit.log]: from KY's definitions alone,
ln D_7 = 177.7838170179114859595893988312 (cert 177.78381701791148595958939883121411...),
ln C_7 = 69.6241366950340814513293024675 (cert 69.62413669503408145132930246749633...),
C_7 = 1.727342163036352958e30 (cert upper 1.7273421630363529579743e30). Agreement to
all 30 printed digits. So the r6/r7/r8/r9 constant chain used the HEIGHT form 16.3329,
never 4224 or 2176. VERDICT (a): NO CONSTANT MIX-UP. The Gamma-constant re-audit
demanded at freeze (bin 3) is discharged here for n = 7 and its general-n formula is
transcribed verbatim above.

Scale of the mix-ups that did NOT happen (for the referee-defence paragraph): substituting
a trace floor for L_7 would give C_7 = 1.8e-106 (17*2^n) or 6.7e-125 (33*2^n) - i.e.
"exclude every odd prime", an absurdity visible at once; substituting the Mahler floor
2^{n-1} log(2+sqrt5) without Cauchy-Schwarz gives C_7 = 1.2e-18, also absurd. The two
functionals (trace of square vs L2 log-height) are NOT interchangeable: Jensen gives only
T >= 2^n from a height floor, and a trace floor gives no height floor beyond the
trivial one. The T-route and the Q/height-route are therefore two distinct exclusion
mechanisms sharing only the KY saturation trunk (Eq.(17) + Prop 4.1) - as FLAGSHIP_T_ONLY /
FLAGSHIP_Q_ONLY already state.

## (b) DAGGER-ITEM (Horie lemma normalisation) - status corrected

ON-DISK FACT (artifact primacy): the dagger item was CLOSED on 2026-08-23 in
docs/archive/r6_theory/DAGGER_VERDICT_20260823.md (numeric arbitration
sage/r3b_dagger_check.log), and archived in r8 as off the critical path (ERRATA_R8 item 8),
because the flagship proofs (FLAGSHIP_T_ONLY.md, FLAGSHIP_Q_ONLY.md) enter through KY
Prop 4.1 and never use Horie's lemma. The HANDOFF R10 line "open since Round 3" and the
project-memory line "cannot be claimed until the dagger item is resolved" are DRIFT from
the Round-3 state; the class-65 rho = 0.989 witness has been superseded by the full
32/32-component flagship certificates (T primary, RHO secondary), status
[P-cite-cert-prp] in CLAIMS_R9.yaml. -> PK correction queued for session end.

Re-verified this session from MO 2016 p.816 (verbatim): "Lemma 2.1 (K. Horie, [8]). Let l
be a prime number different from p and F an intermediate field of Q(zeta_n) and the
decomposition field of l for Q(zeta_n)/Q. Then l divides the integer h_n/h_{n-1} if and
only if there exists a prime ideal L of F dividing l such that eta_n^alpha is an l-th power
in E_n for every element alpha of the integral ideal l L^{-1} of F." ([8] = Horie, Tohoku
57 (2005), zbMATH 5001916, doi 10.2748/tmj/1128703003.) The DAGGER verdict's three
findings stand: condition on eta^alpha (no twist) as l-th power in E_n; F may be taken
to be Q(zeta_{2^n}) itself (endpoint of the intermediate range), which dissolves the
s < n small-ring bookkeeping; the (1-zeta) twist is MO's own device (sect 3.3) forcing
relative norm exactly 1. What Horie contributes to the PAPER: one row of the comparison
table (c) and the identity "Horie component L_f <-> KY saturation component M_f"
(ROUND1 P4 + DAGGER sect 4, [P]) as a remark; nothing load-bearing.

## (c) COMPARISON TABLE (Phase -1 source status marked per row)

Columns: fixed / moving / uniformity / effectivity / componentwise / certificate-producing /
GRH / source status. "n-uniform" = one statement covering every layer n; "layer-fixed" =
statement at a given n.

| work | fixed | moving | uniformity | effective | componentwise | certificate | GRH | source status |
|---|---|---|---|---|---|---|---|---|
| Washington 1975 (Math. Ann. 214) / 1978 (Invent. Math. 49, 87-97; GDZ scan OCR on disk: paper/sources/Washington1978_Invent49_OCR.txt) | prime l | layer n | 1978 Theorem (verbatim): "Let k be an abelian number field and K/k the cyclotomic Z_p-extension of k. Let l != p be a prime and let l^{e_n} be the exact power of l dividing h_n. Then e_n is bounded independent of n (in fact e_n is constant for large n)." | 1978 p.87 (verbatim): "It should be noted that the ideas of [1] show that the above theorem is effective; that is, it is possible to give computable bounds for when e_n stops increasing." CAVEAT: the 1978 paper proves the theorem for p >= 3 ("Since the theorem has been proved for p = 2 in [2] we shall assume p >= 3"); the p = 2 case is the 1975 Math. Ann. paper, and the effectivity remark is made for the 1978 argument - for the Z_2-tower cite effectivity only as "effective in principle by the Ferrero-Washington ideas" and never with a number. | no | no | no | PRIMARY READ 2026-08-25 (tesseract OCR of the GDZ scan at 300 dpi; the quoted sentences are clean in the OCR, page image not separately inspected). RESOLVED. |
| Horie 2002-2007; Horie-Horie 2009 (Tohoku 61, 551-570; PRIMARY on disk: paper/sources/HorieHorie2009_Tohoku61_text.txt) | congruence class of l (fixes the decomposition field F, nu) | all n | HH2009 Theorem 1 (verbatim): "Assume that l does not divide h_{nu-1}. Then the l-class group of B_infty is trivial if l does not divide h_{n0} or l >= Theta (phi(q)/2 log(q p^{n0}/pi sin(pi/p) + cos(pi/p)))^{[F:Q]}." - i.e. n-uniform only ABOVE the explicit threshold; below it the layers up to n0 must be checked (n0 = 36 for l = 9 mod 16, 39 for l = 7 mod 16). Prop 2 (verbatim): "Assume that p = 2, l = 9 (mod 16), and either l does not divide h_36 or l > 7150001069. Then the l-class group of B_infty is trivial." Prop 3: l = 7 (mod 16), l does not divide h_39 or l > 17324899980. Intro: "[6] ... if p = 2 and if l = 3 (mod 8) or l = 5 (mod 8), then the l-class group of B_infty is trivial." (Horie 2007 Tohoku 59 abstract, verbatim: "if p is 2 or 3 and l is a prime number not congruent to 1 or -1 modulo 2p^2, then l does not divide the class number of the cyclotomic field of p^u-th roots of unity for any positive integer u.") | yes (Theta explicit; Minkowski on the ideal lattice l L^{-1} of F + the analytic height bound [5, Lemma 4] + the floor l log 2 < log||eta^{alpha sigma}|| [5, Lemma 3]) | no (one ideal lattice of F, not the components of x^m+1 mod l) | no | no | PRIMARY READ 2026-08-25 (HH2009). Horie's criterion itself = Horie 2005 Tohoku 57 Lemma 2 (paywalled; quoted by the authors in HH2009 Lemma 1's proof "there exists a prime ideal l of F dividing l such that, for any beta in l l^{-1}, eta^{beta sigma} is an l-th power in E" and by MO 2016 Lemma 2.1 - two independent quotations by insiders; sufficient for citation, DAGGER verdict unchanged). RESOLVED. |
| Fukuda-Komatsu I-III (2010, 2010, 2011) | none | all n | n-uniform: l < 10^9 or l != +-1 mod 32 => l does not divide h_n, all n | computational (Horie's criterion evaluated) | no | computational, not certificate-separated | no | SECONDARY: MO 2016 Thm 1.4 verbatim; KY (3) (FK3 Thm 1.3) verbatim. Primary NOT on disk. zbMATH 2026-08-24: series ends at III. |
| Morisawa-Okazaki 2016 (JTNB 28) | class D(2,s,f) | all n | n-uniform via d -> c substitution: l > G(2,s,f) explicit; Cor B: l != +-1 mod 64 all n | yes, analytic covolume bound ht(eta_n) <= (pi/2)sqrt(2^n) | no | no | no | PRIMARY ON DISK, verbatim (Thm A, Cor B, Lemma 2.1/2.3/2.4/2.5, Thm 2.7, sect 3.3 fixed-layer display (*)). |
| Kashio-Yoshizaki 2022 (arXiv 2107.08587v3) | layer n | prime l | layer-fixed component criterion (extended trace on M_f); unconditional floor 33*2^n (n >= 3); n = 7 exclusions CONDITIONAL on Conj 2.2 | yes | YES (M_f decomposition, per-component lifts) | printed tables (n=4,5,7), no verifier | no | PRIMARY ON DISK, verbatim. |
| Miller 2014 (Acta Arith. 164, 381-397 = arXiv:1405.1094) | layer n | - | Thm 2.1 (verbatim): "The class number of the real cyclotomic field Q(zeta_256 + zeta_256^{-1}) is 1." (n = 6, unconditional). Thm 2.2 (verbatim): "Under the assumption of the generalized Riemann hypothesis, the class number of the real cyclotomic field Q(zeta_512 + zeta_512^{-1}) is 1." (n = 7, GRH). Proof of 2.2: explicit-formula bound h < 147 from ten principal split primes (Lemma 7.1), then "the results of [2]" (FK III) to reach h = 1 - i.e. Miller's GRH-conditional h_7 = 1 already CONSUMES FK's l < 10^9 exclusion. | n/a | n/a | n/a | n = 7: yes (GRH) | PRIMARY READ 2026-08-25 (arXiv text, verbatim above). RESOLVED. |
| Luo 2026 (arXiv 2604.15858v2) - QUARANTINED | - | - | claimed l = +-1 mod 256 territory; Lemma 3.3(iii) refuted (three-way, weber_kle12) | - | - | - | - | salvageable part = NONE on the critical path (LUO_AUDIT_R7 sect 2-3). Companion note only. |
| present work (Theorem A) | layer n (formula valid at EVERY n, constant C_n explicit) | prime l, all residue classes with d_n(l) = ord_{2^n}(l) | layer-fixed with explicit n-formula (no d -> c loss); thresholds 1.727e30 (deg 1) / 1.315e15 (deg 2) at n = 7 | yes (certified covolume; Gamma/Blichfeldt explicit) | YES (saturation component lattice (1/l)H_n L_f) | YES (flagship 32/32 T + RHO certificates, read-only verifier; bin-5 generator) | no | this repository. |

Reading of the table (feeds the word freeze): our shape is closest to KY (layer-fixed,
componentwise) with MO's engine (Blichfeldt + height floor) moved from the Horie-unit
ideal lattice to the saturation-component lattice, and with the covolume evaluated
exactly instead of bounded analytically. Horie/FK/MO are n-UNIFORM per congruence class
at the price of the d -> c cap; ours is sharper per layer exactly when s > n (classes 1 and
127 at n = 7, MO_FIXED_LAYER_DERIVATION sect 4) and loses to MO when s <= n (class 65,
170x). The Washington row is orthogonal (fix l, climb n). BANNED words stay banned:
"first" / "new principle" / "effective complement" / "tower-wide" - nothing in the table
licenses them; "orthogonal controls" is now licensed (Washington 1978 read): the sentence must attribute
eventual constancy to Washington 1975 (p = 2) / 1978 (p >= 3) and effectivity-in-principle to
the 1978 remark, and must say that Horie/FK/MO thresholds are per congruence class with a
finite-layer caveat (HH2009 Theorem 1's "l does not divide h_{n0}" clause).

## (d) SPECTRAL NOVELTY - four-way split, VERDICT: (i)(ii)(iii) KNOWN, (iv) is Theorem A itself

(i) Character / group-determinant product formula. KNOWN (Frobenius-Dedekind group
determinant for the cyclic group G_n; the eigenvector computation of
NEGACYCLIC_SPECTRUM_CORRECTION sect 3 is this). Exact statement, verified [MC] to 30
digits this session (r10_bin1_constant_audit.log, eigenvector residual 1.4e-36):
   D_n = 2^{-m/2} * prod_{r=0}^{m-1} | sum_{j=0}^{2m-1} lambda_j omega_r^j |,
   omega_r = zeta_{2^n}^{2r+1},  lambda_j = log|sigma^j(eps_n)|,  m = 2^{n-1},
i.e. the product over the 2^{n-1} characters chi of G_n with chi(tau) = -1 (the
characters of conductor exactly 2^{n+2} = the "relative" characters) of
|sum_g chi(g) log|g(eps_n)||. (Equivalently the eigenvalues of the Gram negacirculant are
mu_r = |Lhat(omega_r)|^2 / 2.) Nothing here is new; it is the standard regulator-index
calculus of Washington ch. 8.
(ii) Relative-unit A_n normalisation. KNOWN: [RE+_n : A_n] = h_n/h_{n-1} is KY Eq.(17)
with proof references Washington Thm 8.2 / Prop 8.11, Horie, Yoshizaki sect 4.1.
(iii) Tie to L(1,chi). KNOWN in principle (Washington Thm 4.9: for even primitive chi of
conductor f, L(1,chi) = -(tau(chi)/f) sum_a chibar(a) log|1-zeta_f^a|) once eps_n is
written as a cyclotomic-unit product. Derivation done this session, NOT yet CAS-checked
(bin 4 task): with zeta = zeta_{2^{n+2}}, X_n = zeta + zeta^{-1},
   eps_n = (X_n+1)/(X_n-1) = (1-zeta^3)^2 (1-zeta^2) / ((1-zeta)^2 (1-zeta^6)),
and for chi of conductor exactly 2^{n+2} the terms with zeta^2, zeta^6 drop out of the
character sum, giving  sum_g chi(g) log|g eps_n| = 2 (chibar(3) - 1) sum_a chi(a) log|1-zeta^a|,
hence |.| = 2 |1-chi(3)| sqrt(2^{n+2}) |L(1,chi)|, and since chi(3) runs over the primitive
2^n-th roots of unity, prod_chi |1-chi(3)| = Phi_{2^n}(1) = 2. Candidate closed form
(bin 4 must confirm or correct by direct L-value computation, e.g. PARI lfun at n = 4,5):
   D_n = 2^{m(n+3)/2 + 1} * prod_{chi: cond = 2^{n+2}} |L(1,chi)|.        [H - unverified]
   >>> BIN-3 CORRECTION (same day): the per-character factor is |1-chi(3)| sqrt(f) |L(1,chi)|
   (the G_n-sum is HALF the a-sum, which cancels the 2 from the squared factors), so the
   exponent is m(n+1)/2 + 1. CONFIRMED [MC] at n = 2..5 to 1e-16 by PARI L-values
   (sage/r10_bin3_fidelity_gate.log S4); frozen as Prop D(ii) in STATEMENT_FREEZE_R10.md.
(iv) Assembly into C_n and the connection to componentwise saturation. This is exactly
Theorem A (Prop F): Blichfeldt on the saturation lattice with the exact covolume. The
"spectral" content adds USABILITY (D_n computable at every n by 2^{n-1} character sums,
or by L-values) but no new theorem.

CONSEQUENCE FOR THE PAPER STRUCTURE (needs Dr. Fukui's ruling): "Theorem B (spectral
formula)" is DEMOTED to "Proposition (evaluation of D_n)" in sect 5, with a citation
audit in Appendix D (Frobenius group determinant; Washington Thm 4.9, 8.2, 8.11). The
L(1,chi) closed form, if bin 4 confirms it, is a Corollary of that proposition - it gives
the general-n table of C_n and makes the n-uniform statement of Theorem A concrete for
n = 8, 9, ... without any interval determinant. The JTNB-vs-MoC decision (HANDOFF
"spectral formula strong -> JTNB") should be re-read in this light: the spectral side is
classical, so the paper's weight shifts to the certificate family (bin 5) unless the
L-value corollary yields an unexpectedly clean C_n.

## Gate status

(a) closed [P + MC]; (b) closed (was already closed 08-23; HANDOFF/PK drift corrected);
(c) table built - ALL three PENDING rows RESOLVED from primaries (2026-08-25: Miller arXiv text;
Washington 1978 GDZ scan OCR; Horie-Horie 2009 Tohoku PDF). Word freeze may be lifted for the
"orthogonal controls" sentence with the attributions above; (d) split decided, one
[H] closed form handed to bin 4. Bins 3-7 may proceed under these markings.
