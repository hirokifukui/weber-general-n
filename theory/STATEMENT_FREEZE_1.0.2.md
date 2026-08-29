# STATEMENT_FREEZE_1.0.2 — frozen statements (2026-08-29, the pre-submission repair round; opened on the GPT audit of the v1.0.1 submission package)

Status: FROZEN. NO statement change in 1.0.2: the 38 single-source files proofs/statements/*.tex are byte-identical to the r21..v1.0.1 seals (md5 list digest 9c7b3f5775341416eb756c5dd4e6472f unchanged). The 1.0.2 content: 'published input' corrected to 'external literature input' throughout (the Kashio-Yoshizaki input is a preprint, arXiv:2107.08587v3); the CI paragraph rewritten in mechanism form (each tagged release carries its own attestation; latest executed run named); the bibliography alphabetized with citation keys unchanged; Morisawa (Acta Arith 2012) now cited in the introduction; the French resume polished per the external review; README / CITATION stale version strings fixed. The v1.0.1 file follows below.

---- v1.0.1 file (history) ----
# STATEMENT_FREEZE_1.0.1 — frozen statements (2026-08-29, the post-publication repair round; opened after the GPT audit of the PUBLISHED v1.0.0)

Status: FROZEN. NO statement change in 1.0.1: the 38 single-source files proofs/statements/*.tex are byte-identical to the r21..v1.0.0 seals (md5 list digest 9c7b3f5775341416eb756c5dd4e6472f unchanged). The 1.0.1 content: the paper CI paragraph updated to the executed green run (run 33227660844, commit b23ddc7a), the author block completed (addresses, ORCID, email), a French resume added, TRUST / claims-ledger prose cleaned of internal tracker tokens (status and notes fields only), the README verifier sentence made precise, the CI actions re-pinned to Node-24-era commits, and the creator metadata (ORCID, affiliations) written into .zenodo.json and CITATION.cff. The v1.0.0 file follows below.

---- v1.0.0 file (history) ----
# STATEMENT_FREEZE_1.0.0 — frozen statements (2026-08-28, node <LOCAL_HOST>; the PUBLIC release round, opened after the GPT audit of the sealed r23 zip)

Status: FROZEN. NO statement change in 1.0.0 (no N-block): the 38 single-source files proofs/statements/*.tex are byte-identical to the r21, r22 and r23 seals (md5 list digest 9c7b3f5775341416eb756c5dd4e6472f unchanged). The 1.0.0 content is release engineering only: the completed author sign-off (docs/human_review_1.0.0.json, 31/31 SIGNED, KEY 11/11 — the r23 ledger generator had dropped prop:F), the licenses and repository metadata, the literature index, the public README, and the package-round rename r23 -> 1.0.0. The R23 file follows in full below (its header kept as history).

---- R23 file (history) ----
# STATEMENT_FREEZE_R23 — frozen statements (2026-08-28, node <LOCAL_HOST>; the RELEASE round, opened after the author's sign-off session)

Status: FROZEN. NO statement change in R23 (no N13): the 38 single-source files proofs/statements/*.tex are byte-identical to the r21 and r22 seals (md5 list digest 9c7b3f5775341416eb756c5dd4e6472f unchanged). The R23 content is non-mathematical: the author's sign-off transcription (docs/human_review_r23.json, 30/30 SIGNED, KEY 11) and the release metadata (license, repository URL, release date; CITATION.cff / .zenodo.json). The R22 file follows in full below (its header kept as history).

---- R22 file (history) ----
# STATEMENT_FREEZE_R22 — frozen statements (2026-08-27, node <LOCAL_HOST>; opened after the GPT r21 review; Dr. Fukui's ruling: P1 sign-off and P3 release separately, every other repair here)

Status: FROZEN. NO statement change in R22 (no N13): the 38 single-source files proofs/statements/*.tex are byte-identical to the r21 seal (their concatenated md5 9c7b3f5775341416eb756c5dd4e6472f at the R22 boot == after the repairs). The three R22 repairs are PROOF PROSE (proofs/prop_D.tex references, proofs/cor_T.tex logarithm base, proofs/thm_family.tex negative-control enumeration) and one Blueprint node demotion (lem:mo22 -> historical paragraph); see docs/ERRATA_R22.md. The R21 file follows in full below (its header kept as history).

---- R21 file (history) ----
# STATEMENT_FREEZE_R21 — frozen statements (2026-08-27, node <LOCAL_HOST>; opened after the GPT r20 review; Dr. Fukui's ruling of R21: "GO" on the plan, then "すべてGPTに合わせて" = statement scope aligned with the proofs and with the Blueprint's explicit quantifiers; no new mathematics, no new Lean)

Status: FROZEN. R21 re-hosts every shared statement (38) in proofs/statements/ (single source, GPT r20 P1) with the PAPER wording as canonical; three statement-text changes below (N12), none mathematical in substance. The R20 file follows in full below (its header kept as history).

## N12 (R21). Three statement texts corrected while single-sourcing (ERRATA_R21 E21-1..E21-3); every other statement is byte-preserved from the paper wording of r20 except for (a) the four medium-specific pointers now written through the macros \refConst / \refCert / \refAppF / \refDefH, (b) trust labels and Lean pointers moved out of the theorem environments into a Note paragraph (GPT item 16: cor:S1, lem:C7int, lem:oddtransfer), (c) lem:ky1000 [C] naming its certificate directory \path{certificates/family/KY1000/} inside the statement (evidence-presence gate of check_graph).
- lem:A (paper Lemma A, "bridge"): NARROWED to "If u in RE+_n cap E_{n-1} then u = +-1." The r20 paper text carried a second sentence
  ("Consequently u in RE+_n minus {+-1} implies ... ht(u) >= L_n") which is the statement of Lemma A+ (proved separately, proofs/lem_Aplus.tex);
  the shared proof proofs/lem_A.tex proves the bridge only, and the Lean declarations of the node (bridge_fixed_norm_sq, torsion_pm_one) are the
  bridge only. The Blueprint and docs/CLAIMS LEM_A already stated the bridge only. Mathematics unchanged (the consequence remains Lemma A+).
- thm:A: "Let n >= 2, l an odd prime ..." — the layer range n >= 2 (the paper's global setting, sect 2 "Throughout, n >= 2") is now explicit
  in the statement, as the Blueprint's r20 wording had it ("For every n >= 2 and odd prime l"). No mathematical change.
- lem:D3: the Blueprint's r20 statement had dropped the hypotheses "chi even and primitive of conductor f > 1"; the single-source text (paper
  wording, matching the shared proof) restores them in the Blueprint. No mathematical change; the paper was correct.
Also (not a statement change): the meaning of "l | h_{3,n}/h_{3,n-1}" in the Z_3-tower is now DEFINED (paper sect 9 setting paragraph and
Blueprint def:p3) as v_l(h_{3,n}) > v_l(h_{3,n-1}), equivalently ker(N)_l != 0 by Lemma oldnew with p = 3, l != 3 (GPT r20 items 25-26 =
hw 1084-1085; ERRATA_R21 E21-4); the statement of Theorem P3 (N11) is unchanged. Machine gates: tools/check_statement_sync.py r21
(38/38 single-sourced, conditions single-sourced in the statement file headers, five in-memory variants rejected by --negctl).
Verbatim statements: proofs/statements/*.tex are the single source; the text is not duplicated here.

---- R20 file (history) ----
# STATEMENT_FREEZE_R20 — frozen statements (2026-08-27, node <LOCAL_HOST>; opened after the GPT r19 review; Dr. Fukui's ruling of R20: "すべてあなたの推奨で OK / GO" = the two mathematical-text fixes of the review, no new Lean, ledgers at chapter level, P4 polish deferred; no new mathematics)

Status: FROZEN. ONE statement change in R20 (N11 below). The R19 file follows in full below (its header kept as history).

## N11 (R20). Theorem P3: the prime is restricted to ODD primes l != 3 (GPT r19 item 1 = hw 985-999; ERRATA_R20 E20-1).
Statement (paper sect 9 / Blueprint thm:P3, byte-identical in both media, checked by tools/check_statement_sync.py):
  Let n >= 1, l != 3 AN ODD PRIME, f in {1,2} the order of l modulo 3, 3^s || l^2 - 1, r = min(n,s), c = 2*3^{r-1}, Lrel_{3,n} as in
  Lemma mo25-z3, D_r^{(n)} > 0 the covolume of Theorem rank3, C^{(3)}_{n,r} = (2/pi)^{c/2} Gamma(2+c/2) D_r^{(n)} / (Lrel_{3,n})^c.
  If l^f > C^{(3)}_{n,r} then l does not divide h_{3,n}/h_{3,n-1}.
Why: the R17-R19 wording "l != 3 a prime" admitted l = 2, which the proof never covered -- Lemma normone (iv) (Nr(eps)^l = 1 with Nr(eps)
real => Nr(eps) = 1) uses l odd through WeberP3Rel.eq_one_of_odd_pow_eq_one (hypothesis Odd l), and Theorem SH (N1) is stated for an odd
prime. The proof text (proofs/thm_P3.tex) now opens with "Since l is odd and l != 3 ..." naming both places. The Lean core
WeberP3.theoremP3_core is the generic carrier (0 < l) and does NOT carry the odd-prime condition (recorded in TRUST.md and in
docs/CLAIMS_R20.yaml THM_P3.conditions = {n_ge_1, ell_prime, ell_ne_3, ell_odd}; no new Lean in R20 by ruling, hw 995 -> R21+).
Unchanged: Cor P3n4 (its hypothesis l == +-1 (mod 81) already forces l odd: 2 !== +-1 (mod 81) and 81k +- 1 is even for odd k), every
printed number (1.0728e33 / 3.2753e16 / 3.4594e4 / 1.8599e2), the certificate certificates/p3/D3_cert_r19.json (ships unchanged),
Lemma normone, Theorem rank3, Theorem SH, and every other statement of N1-N10.
Proof-text correction, NOT a statement change (E20-2; GPT r19 items 16-24 = hw 1000-1008): proofs/thm_rank3.tex Step 2 wrote
"a = 1+N = 4^{N/3}" and "Since a = 4^{N/3}" as integer equalities; false for n >= 2 (n = 2: 64 vs 10). Now: a = 1+N and
a == 4^{N/3} (mod q), q = 3N (= Lemma normone (ii) = WeberP3Rel.four_pow_modEq), likewise -2 == 4^{j_0} (mod q); the arguments of g and
of chi_k are residue classes modulo q. The n = 1 coincidence 4 = 1+3 is not used.
Citation status (unchanged in substance, wording aligned with the body): Washington GTM 83 is cited at CHAPTER level everywhere
(body, TRUST.md, claims, this block); the theorem numbers are an OPEN tracker item (hw 29/984) and are asserted nowhere. The
historical wording "to be confirmed against a physical copy" survives only in the verbatim history blocks below.

---- R19 file, verbatim ----
# STATEMENT_FREEZE_R19 — frozen statements (2026-08-27, node <LOCAL_HOST>; opened after the GPT r18 review; Dr. Fukui's ruling of R19: "すべてOK go" = certificate semantics, evidence synchronisation, Blueprint label, submission-body decontamination; no new mathematics)

Status: FROZEN. NO theorem statement changes in R19. The R18 file follows in full below (its header kept as history).

## N10 (R19). No statement changes. What changed is the EVIDENCE BASIS of CERT_D3 / Cor P3n4 (ERRATA_R19 E19-1): the p = 3 certificate is now
certificates/p3/D3_cert_r19.json, format v3 -- every certified quantity is the EXACT dyadic outward hull of two independent 4000-bit ball
enclosures (producer balls sage/r19_trackB/p3_covol_balls_r19.json; read-only recomputation sage/r19_trackB/p3_readonly_recomputed_r19.json),
widened about its centre to twice its half-width (hw 981), generated by tools/gen_p3_cert_r19.py -- and the read-only replay
scripts/verify_p3_readonly.sage requires CONTAINMENT of its recomputation in every certified interval (120/120; the r18 replay accepted
overlap, under which 65/120 shipped intervals failed containment) and rejects 12 planted certificates; coverage is re-decided by
tools/check_p3_containment.py; consistency + print strings by tools/check_p3_cert.py. The printed values of Cor P3n4 and Table tab:p3
(C_{4,4} in [1.072749779e33, 1.072749780e33], sqrt in [3.275285910e16, 3.275285911e16]; thresholds 1.0728e33 / 3.2753e16; gains 3.4594e4 /
1.8599e2) are UNCHANGED by the widening (5 / 10 significant digits). Blueprint: the duplicated label lem:mo25 is split into lem:mo25-z2
(Z_2 height floor, used by Lemma A+) and lem:mo25-z3 (Z_3 relative-norm-one floor, used by Theorem P3); the paper's single lemma is
lem:mo25-z3 (ERRATA_R19 E19-3). Lemma disc still cites Wash at chapter level; the statement numbers remain an OPEN homework item
(hw 29 / 984) and the submission body no longer says so (the note lives here and in the tracker).

---- R18 file, verbatim ----
# STATEMENT_FREEZE_R18 — frozen statements (2026-08-26, node <LOCAL_HOST>; opened after the GPT r17 review; Dr. Fukui's ruling of R18: "OK 進めて" = artifact hardening, no new mathematics)

Status: FROZEN. NO theorem statement changes in R18 except the two listed in N9. The R17 file follows in full below (its header kept as history).

## N9 (R18). (a) Lemma normone gains a clause: for eps in E_{3,n-1}, Nr_{B_{3,n}/B_{3,n-1}}(eps) = eps^3, so a lower-layer unit of relative norm 1
equals 1; hence a unit of relative norm 1 with H(eps) != 0 is not in E_{3,n-1} (proof part (v), applied in the floor paragraph of Theorem P3
in place of the r17 reading of part (iv)); and "a = 1+3^n has EXACT order 3 modulo 3^{n+1}" is stated. (b) NEW Lemma disc [L]:
|disc Q(zeta_{p^r})| = p^{p^{r-1}(pr-r-1)}, Z[zeta_{p^r}] integral; at p = 3 the exponent 3^{r-1}(2r-1) equals the Vandermonde product over
the primitive 3^r-th roots of unity (Wash, Chapter 2; statement numbers to be confirmed, hw 29); Theorem rank3 Step 4 cites it.
Everything else (Theorem SH, Cor SH-mod, Theorem A, Prop D, Cor A', Cor T, Cor A-hat, Cor order, Cor 7, S0/S1, Theorem cert, Family,
Theorem rank3, Lemma mo25, Theorem P3, Cor P3n4, CERT_D3 statement) is UNCHANGED from R17; CERT_D3's evidence and label basis changed
(format v2 + read-only replay), not its statement. B_{3,0} = Q, h_{3,0} = 1 is now written in the notation paragraph (no change of meaning).

---- R17 file, verbatim ----
# STATEMENT_FREEZE_R17 — frozen statements (2026-08-26, node <LOCAL_HOST>; opened after the GPT r16 review; Dr. Fukui's ruling of R17: "続ける" = the plan as presented: claim reset, then the P3 repair)

Status: FROZEN 2026-08-26 for N8 below after the three Track B gates (spectral rank theorem proved; strong floor applies; MO2016 improved in both classes, certificate) passed. N1-N5 unchanged from R16 (N1 prose is aligned to the Lean carrier form, see the N1 note); N7 of R16 is SUPERSEDED by N8.

## N1 note (Theorem SH, R17). The prose statement is now the CARRIER form = WeberSH.theoremSH verbatim: R free abelian of rank m, h : R -> R^N
additive and injective (Rank), L <= R with lR <= L and [R:L] = l^{m-d} (Index), U any set of units, (Car) every a in L has u in U with
l H(u) = h(a), (Floor) every u in U with H(u) != 0 has ht(u) >= L_0, (Bl) Blichfeldt => l^d <= K_m D / L_0^m. The R16 module form
(G, R = quotient of Z[G], A/{+-1} cyclic over R, (Sat) on L \ lR) is Corollary SH-mod (cor:SHmod; claim COR_SHMOD; proofs/cor_SHmod.tex):
it produces (Car) by the base branch (WeberSH.base_branch) and the saturation branch (WeberSH.sat_root_log). Theorem A = Prop F applies
Cor SH-mod (unchanged content); Theorem P3 applies Theorem SH directly with U = U_{3,n} (Lemma normone). Answer to LETTER_R16 question (4):
weakened, as GPT r16 items 56-61 prescribe.

## N8. Theorem P3 (repaired), Lemma normone, Theorem rank3, Cor P3n4 (cyclotomic Z_3-tower)   [F-core; L-relative; C for the corollary]
                        FROZEN 2026-08-26 after the three gates of GPT r16 sect 7 (768-770) passed: spectral rank theorem proved for every
                        n, r; strong floor applies (relative norm 1 transfers to the saturation root); MO2016 Thm A improved in both classes
                        (certificate, 15/15 rows). Claim ids LEM_NORMONE, THM_RANK3, THM_P3, COR_P3N4, CERT_D3 (COR_SHMOD, THM_SH: see N1 note).
Notation. N = 3^n, q = 3^{n+1}, sigma induced by zeta_q -> zeta_q^4, tau = sigma^{3^{n-1}}, eta_n = sin(2(1+3^n)pi/q)/sin(2pi/q) (MO13 sect 1),
lambda_j = log|sigma^j eta_n|, hat lambda_k = sum_j lambda_j e^{-2 pi i jk/N}; for l != 3: f = ord_3(l) in {1,2}, 3^s || l^2-1, r = min(n,s),
c = 2*3^{r-1}; D_r^{(n)} = covolume of the lattice spanned by H(sigma^{3^{n-r} j} eta_n), j < c; U_{3,n} = {eps in E_{3,n} : Nr eps = 1};
Lrel_{3,n} = sqrt(3^n) log((3^{(3^n-1)/(2 3^n)} + sqrt(3^{(3^n-1)/3^n}+4))/2); C^{(3)}_{n,r} = (2/pi)^{c/2} Gamma(2+c/2) D_r^{(n)} / Lrel_{3,n}^c.
Lemma normone. a = 1+3^n has a^3 == 1 (mod q); tau acts by zeta -> zeta^a; Nr_{B_{3,n}/B_{3,n-1}}(eta_n) = 1; eta_n^{alpha_sigma} = eps^l
(l odd prime) => Nr(eps) = 1, and H(eps) != 0 => eps not in E_{3,n-1}.  [F: WeberP3Rel.a_cube_modEq_one, four_pow_modEq, telescope_three,
sin_telescope_step, eq_one_of_odd_pow_eq_one; M: the Galois-theoretic sentences]
Theorem rank3. hat lambda_k = 0 iff 3 | k (for 3 !| k: lambda_j = Gamma(j+j_0+N/3) - Gamma(j+j_0) with Gamma(j) = log|1-zeta_q^{4^j}|,
hat lambda_k = omega^{j_0 k}(e^{2 pi i k/3} - 1) hat Gamma_k, |hat Gamma_k| = (sqrt q / 2)|L(1,chi_k)| for the primitive even chi_k of
conductor q with chi_k(4^j) = omega^{-jk}, and L(1,chi_k) != 0). Hence for every n >= 1, 1 <= r <= n the c vectors H(sigma^{3^{n-r} i} eta_n)
are linearly independent (Parseval: hat v_k = A(omega^{3^{n-r} k}) hat lambda_k, so v = 0 forces A to vanish on all primitive 3^r-th roots
and deg A < c gives A = 0), and (D_r^{(n)})^2 = 3^{3^{r-1}(2r-1)} prod_{b in (Z/3^r)^x} W_{n,r}(b), W_{n,r}(b) = N^{-1} sum_{k == b (3^r)}
|hat lambda_k|^2 > 0 (Gram = V diag(W) V^*, |det V|^2 = |disc Q(zeta_{3^r})|).  [F: WeberP3Rel.dft_vanish_of_relnorm,
eq_zero_of_vanish_on_primitiveRoots, totient_three_pow; L: Wash Thm 4.9, Dirichlet; M: the rest]
Lemma mo25 [L]. eps in E_{3,n} \ E_{3,n-1}, Nr eps = 1 => ht(eps) >= Lrel_{3,n} (MO16 Lemma 2.5(2) = Lemma 2.3 + Lemma 2.4(2) = MO13 Lemma 9.1).
Theorem P3 (every n >= 1). l^f > C^{(3)}_{n,r} => l does not divide h_{3,n}/h_{3,n-1}. Proof = Theorem SH (carrier form) with R = Z[zeta_{3^r}],
h(alpha) = H(eta_n^{alpha_sigma}), (Rank) by Theorem rank3, L = l L^{-1} (MO13 Lemma 1.3, index l^{c-f}), U = U_{3,n}, (Car) from the l-th
roots (Lemma normone (iv)) and the base branch (A <= U_{3,n} since Nr eta_n = 1), (Floor) = Lemma mo25, (Bl) Blichfeldt.  [F-core:
WeberP3.theoremP3_core = WeberSH.theoremSH_contra]
Cor P3n4. l == 1 (mod 81), l > 1.0728e33  or  l == -1 (mod 81), l > 3.2753e16  =>  l does not divide h_{3,4}/h_{3,3}; C^{(3)}_{4,4} in
[1.072749779e33, 1.072749780e33], sqrt in [3.275285910e16, 3.275285911e16]; MO16 Thm A: G(3,4,1) >= 3.7111e37, G(3,4,2) >= 6.0919e18;
gains 3.4594e4 (f=1), 1.8599e2 (f=2) in the classes 81 || l -+ 1. [C: certificates/p3/D3_cert_r17.json; gate tools/check_p3_cert.py]
Superseded: N7 of R16 (Schinzel floor sqrt(3^n) log phi; (Rank) by certificate for n <= 5; comparison with MO13 only) -- ERRATA_R17 E17-1/E17-2.


---- R16 file kept in full for the diff (moved to archive/rounds/r16/STATEMENT_FREEZE_R16.md; C_7 display and KY1000 numbers unchanged in R17) ----
# STATEMENT_FREEZE_R16 — frozen statements (2026-08-26, node <LOCAL_HOST>; opened after the GPT r15 review; Dr. Fukui's ruling of R16: all 72 items, "last push"; ruling on N6 (1)-(3): "GPTに合わせて。GO" = G-module setting stated in the theorem, Ramaré II Cor.1 as the single L input, N4 kept with Robbins)

Status: FROZEN 2026-08-26 (ruling "GPTに合わせて。GO"). The DRAFT questions N6 are answered in the header. Frozen R15 statements (theory/STATEMENT_FREEZE_R15.md) are
unchanged except item 4 (Cor T: f_n(B) = max{1, 1 + floor(log C_n/log B)}, hw 642; presentational — the R15 proof already
covered C_n < 1). Names, claim ids and proofs/ file names of R15 are not renamed. New items carry new names.

Notation of the paper (Section 2): n >= 2, m = 2^{n-1}, q = 2^{n+2}, G_n, sigma, tau, E_n, RE = RE_n^+ = {eps in E_n : Nr eps = 1},
eps_n, A_n = <+-1, eps_n>_{Z[G_n]}, R_n = Z[x]/(x^m+1), u_a (a in R_n), H_n : Z^m -> R^{2^n} the log map, ht = Euclidean norm
of the log vector over all 2^n real embeddings (MO16 Def 2.2), L_n = sqrt(2^n) log(2+sqrt5), d_n(l) = ord_{2^n}(l),
L_f = pi^{-1}(M_f) of index l^{m-d_f}, Lambda_f = (1/l) H_n(L_f), D_n = covolume of H_n(Z^m), C_n = (2/pi)^{m/2} Gamma(2+m/2) D_n / L_n^m.

---------------------------------------------------------------------------------------------------------------------
## N1. Theorem SH (componentwise saturation–height bound; abstract)   [M; discrete core F = TheoremAInputs.theoremA_of_inputs]
                                                        claim id THM_SH; proofs/thm_SH.tex; label thm:SH

Setting (finite abelian module).  K a totally real number field of degree N with real embeddings sigma_1..sigma_N;
H : K^x -> R^N, H(u)_j = log|sigma_j u|; ht(u) = |H(u)| (Euclidean norm; in a totally real field H(u) = 0 iff u = +-1 for units).
G a finite abelian group acting on K by field automorphisms; R a commutative quotient ring of Z[G] that is free of rank m as a
Z-module (the "module ring"; for Weber: R_n = Z[G_n]/(1+tau) = Z[x]/(x^m+1)).  U a G-stable subgroup of O_K^x.  A a G-stable
subgroup of U containing +-1 such that A/{+-1} is a cyclic R-module generated by the class of one unit eps in A: write
u_a := eps^a for a in R (well defined up to sign; H(u_a) is well defined and Z-linear in a), and assume
   (Rank)  a |-> H(u_a) is injective on R  (equivalently H(A) is a lattice of rank m).
D := covolume of the rank-m lattice H(u_R) in its R-span (the "log covolume of A").
l an odd prime.  A simple component of dimension d: a nonzero ideal M of the F_l-algebra R/lR with dim_{F_l} M = d
(for Weber: M = M_f = w * F_l[x]/(x^m+1), d = deg f).  Its pullback L := pi^{-1}(M) subset R, pi : R -> R/lR.
   (Index)  l R <= L and [R : L] = l^{m-d}   (a consequence of R/L = (R/lR)/M; stated as a hypothesis so that the theorem
            can be applied to any L with this index).
Lfloor > 0 a real number.

Hypotheses.
  (Sat)   [saturation of the component M in U] for every a in L \ lR there is u in U with u^l = u_a.
  (Floor) [height floor of U] for every u in U with u != +-1: ht(u) >= Lfloor.
  (Bl)    [L: Blichfeldt 1914 Thm II, in the form MO16 Thm 2.7] every lattice Lambda of rank m in R^N contains v != 0 with
          |v|^m <= K_m covol(Lambda), K_m := (2/pi)^{m/2} Gamma(2+m/2).

Conclusion.   l^d <= K_m D / Lfloor^m.

Proof shape (M), in the two branches of the paper.
  Covolume. Lambda := (1/l) H(u_L) (= {(1/l) H(u_a) : a in L}). By (Rank) H(u_L) is a sublattice of index [R:L] = l^{m-d} in
  H(u_R), of covolume l^{m-d} D; scaling by 1/l in the m-dimensional span divides the covolume by l^m: covol(Lambda) = D/l^d.
  Short vector. By (Bl) there is a in L with v := (1/l) H(u_a) != 0 and |v|^m <= K_m D / l^d.
  Base branch (a in lR). a = l b with b in R; then u_b in A <= U, u_b^l = +- u_a, so H(u_b) = v != 0, u_b != +-1, and (Floor)
  gives |v| = ht(u_b) >= Lfloor.
  Saturation branch (a in L \ lR). By (Sat) there is u in U with u^l = u_a; then l H(u) = H(u_a), H(u) = v != 0, u != +-1, and
  (Floor) gives |v| = ht(u) >= Lfloor.
  In both branches Lfloor^m <= |v|^m <= K_m D / l^d.
Discrete core in Lean: TheoremAInputs.theoremA_of_inputs (ky41 = existence of a component satisfying (Sat), blichfeldt = (Bl)
on the component, floor = (Floor)). New Lean work (hw 671-680): (Index) => covolume D/l^d (Lemma C-general), the base branch
(Lemma E'-general), the typed saturation bridge (Lemma E-general: (Sat) + (Floor) => every nonzero v in Lambda has |v| >= Lfloor),
Prop F as one theorem. The word "principle" is not used (hw 658); the novelty audit (hw 657) records that the theorem is
Blichfeldt's theorem applied to the scaled pullback lattice of one simple component against a height floor, and that its role
is to separate the four inputs (Rank, Index, Sat, Floor) from the Z_2-tower notation.

## N2. Theorem A as a corollary of Theorem SH   (statement of Theorem A UNCHANGED from R15; proof re-routed)
Apply N1 with K = B_n, N = 2^n, G = G_n, R = R_n, U = RE, A = A_n, eps = eps_n (KY sect 4: A_n/{+-1} free on sigma^i eps_n, so
cyclic over R_n), (Rank) = Lemma D, D = D_n (Lemma D, Prop D), m = 2^{n-1}, M = M_{f_0}, L = L_{f_0}, (Index) = Lemma C,
d = d_{f_0} = d_n(l) (Lemma B), Lfloor = L_n.
(Sat) for f_0: if l | k_n, Lemma E gives r_a in RE with r_a^l = u_a for a in L_{f_0} \ l R_n (KY Prop 4.1).  The base branch is
Lemma E' (u_b in A_n <= RE).  (Floor): Lemma A+ (MO16 Lemma 2.5(1)).  Hence l | k_n => l^{d_n(l)} <= C_n.  Prop F is kept as
the named statement "l | k_n => l^{d_{f_0}} <= C_n" with the proof "Theorem SH with the data above".

## N3. Corollary A-hat (computation-free criterion)   [M relative to Theorem A's inputs + L: Ramaré II Cor. 1]
                                                        proposed claim id COR_AHAT; proofs/cor_Ahat.tex; label cor:Ahat
Input (L) [Ramaré, Acta Arith. 112 (2004) 141-149, Corollary 1 with h = 1, k = 2; theory/PHASE_MINUS1_R16_LITERATURE.md §1]:
  for every even primitive Dirichlet character chi of conductor q with 2 | q and q >= 4,
      |L(1,chi)| <= U(q) := (1/4)(log q + 2 log 2) + log(4q)/sqrt(q).
Definition.  hat C_n := 2 (4/pi)^{m/2} Gamma(2+m/2) ( U(2^{n+2}) / log(2+sqrt5) )^m.
Statement.   For every n >= 2:  C_n <= hat C_n;  and for every odd prime l,  l^{d_n(l)} > hat C_n  =>  l does not divide k_n.
Proof shape. Cor A' writes C_n = 2 (4/pi)^{m/2} Gamma(2+m/2) prod_chi |L(1,chi)| / log(2+sqrt5)^m, the product over the m even
characters of conductor exactly q = 2^{n+2} (these are primitive, even, 2 | q, q >= 16); each factor is <= U(q), so the product
is <= U(q)^m (m non-negative factors), giving C_n <= hat C_n; then Theorem A. Discrete part for Lean (hw 669): prod of m
reals in [0, U] is <= U^m, and C <= hat C < l^d => C < l^d => theoremA_of_inputs. The analytic bound U(q) is an L input (hw 670).
Numbers [MC, sage/r16_hatCn/r16_hatCn_pilot.sage, 2026-08-26]: hat C_n / C_n = 6.2, 23.4, 437, 1.5e5, 7.6e10, 4.1e22, 1.7e47
for n = 2..8; hat C_7 = 7.016e52 (so at n = 7: d = 2 needs l > 2.65e26, d = 1 needs l > 7.02e52). Coarse; per GPT item 34 the
paper carries this as ONE corollary and the explicit table only in the Blueprint/appendix.

## N4. Corollary (explicit order threshold)   [M relative to N3 + L: Robbins' bound]   proposed claim id COR_ORDER; label cor:order
Input (L) [Robbins, "A remark on Stirling's formula", Amer. Math. Monthly 62 (1955) 26-29; read 2026-08-26 from the scanned
text (theory/PHASE_MINUS1_R16_LITERATURE.md sect 1b): for n = 1, 2, ...  n! = sqrt(2 pi) n^{n+1/2} e^{-n} e^{r_n} with
1/(12n+1) < r_n < 1/(12n)]. We use the upper half: for every integer k >= 1,  k! <= sqrt(2 pi k) (k/e)^k e^{1/(12k)}.
Since m/2 = 2^{n-2} is an integer, Gamma(2+m/2) = (1+m/2)!.
Statement.  Put k = 1 + m/2 and
      T_n := log 2 + (m/2) log(4/pi) + (1/2) log(2 pi k) + k (log k - 1) + 1/(12 k) + m log( U(2^{n+2}) / log(2+sqrt5) ).
  Then log hat C_n <= T_n, and for every odd prime l:  d_n(l) log l > T_n  =>  l does not divide k_n.
Remark (shape, not a claim): T_n = (m/2) log m + m ( log U(2^{n+2}) - log log(2+sqrt5) + (1/2) log(4/pi) - 1 - (1/2) log 2 ) + O(log m),
and U(2^{n+2}) = ((n+2) log 2)/4 + (1/2) log 2 + O(n/2^{n/2}), so T_n = (m/2) log m + m log(n+2) + O(m). All constants are printed
in the statement; nothing is hidden in an O(.) in the claim itself (hw 666).

R17 OPENING NOTE (2026-08-26, after the GPT r16 review; ruling "続ける"): N7 (Theorem P3, Cor P3n4) is UNFROZEN — repair pending.
Two defects: (A) the statement is for every n >= 1 while the positivity (Rank) of D_r^{(n)} is certified only for 1 <= r <= n <= 5
(N7 does not state (Rank) as a hypothesis); (B) the comparison in Cor P3n4 and in the paper's abstract used MO2013 Thm 0.3 (3.1e79)
only, whereas MO2016 Theorem A (paper/MO2016_height_weber_jtnb965.pdf, Example 1.6 checked) gives G(3,4,1) = 3.71e37 and
G(3,4,2) = 6.09e18, both below the R16 constants 2.12e44 / 1.46e22 — the R16 result is NOT an improvement of the best published bound.
The abstract/title claims of R16 for the Z_3-tower are withdrawn; the repaired statement is frozen as N8 in theory/STATEMENT_FREEZE_R17.md
(this file is moved to archive/rounds/r16/ at the round bump). N1-N5 unchanged; N1 (Theorem SH) prose is weakened to the Lean carrier
form in R17 (question (4) answered by GPT r16 items 56-61).

## N7. Theorem P3 (layer-fixed componentwise bound in the cyclotomic Z_3-tower)   [L-relative; C for the covolume; F-core]
                        FROZEN 2026-08-26 after ruling point (2) "GO" (Gate 3 passed on GPT's criterion: strict improvement over
                        G_1 / Morisawa Thm 0.3 in the infinite classes 3^n | l^f - 1; certificate certificates/p3/D3_cert_r16.json)
                        claim ids THM_P3, COR_P3N4, CERT_D3; proofs/thm_P3.tex, proofs/cor_P3n4.tex; labels thm:P3, cor:P3n4, lem:D3cert
Statement. n >= 1, l != 3 prime, f = ord_3(l) in {1,2}, 3^s || l^2 - 1, r = min(n,s), c = 2*3^{r-1}, L_{3,n} = sqrt(3^n) log((1+sqrt5)/2);
eta_n = sin(2(1+3^n)pi/3^{n+1})/sin(2pi/3^{n+1}) the Horie unit of B_{3,n} (MO13 sect 1), sigma a generator of Gal(B_{3,n}/Q),
D_r^{(n)} = covolume of the lattice spanned by H(sigma^{3^{n-r} j} eta_n), 0 <= j < c, over the 3^n real embeddings;
C^{(3)}_{n,r} = (2/pi)^{c/2} Gamma(2+c/2) D_r^{(n)} / L_{3,n}^c.  If l^f > C^{(3)}_{n,r} then l does not divide h_{3,n}/h_{3,n-1}.
Inputs (L): MO13 Lemma 1.3 (Horie; via Ho05b <- Ho02, the original NOT compared verbatim — flagged in lem:horie13), MO13 Thm 2.2
(Schinzel), Blichfeldt. (C): certificates/p3/D3_cert_r16.json (4000-bit balls). (F): WeberP3.theoremP3_core (= WeberSH form),
WeberP3.height_floor_of_l1_floor (Cauchy–Schwarz floor), WeberP3.l1_sq_le_card_mul_l2_sq.
Corollary P3n4. l == 1 (mod 81), l > 2.1204e44  or  l == -1 (mod 81), l > 1.4562e22  =>  l does not divide h_{3,4}/h_{3,3}.
(C^{(3)}_{4,4} in [2.120399840e44, 2.120399841e44], sqrt in [1.456159e22, 1.456160e22].)
Note on Theorem SH: the p = 3 application uses SH in its LEAN form (additivity of a -> H(u_a) only; no R-module structure on the
units, since Nr eta_n is not assumed 1). The prose SH keeps the cyclic-R-module hypothesis; a remark in the paper says which form
is proved in Lean and used here. Comparison convention: layer-fixed vs. uniform-in-n, as in the paper's Section comp / Table classes.

## N5. What is NOT frozen here
Track B: decided GO at ruling point (2) — see N7. General odd p (hw 696) is NOT frozen: only p = 3. Title and abstract (hw 640, 646) are edited last (便6).

## N6. Questions for the ruling (ANSWERED 2026-08-26: "GPTに合わせて。GO" — (1) G-module setting in the theorem, (2) yes, (3) kept)
(1) N1 as stated — in particular WITHOUT G-module structure, with the module layer left to Lemmas B/C/E (the paper says so
    explicitly)? GPT's items 647-651 ask for the G-module setting to be "defined"; my proposal defines it in the corollary
    (N2), not in the theorem, because the theorem does not use it. Alternative: state N1 with the G-action and L = L_f as a
    hypothesis-shaped "component" (more words, same content).
(2) N3 with Ramaré's k = 2 bound (slope 1/4) as the single L input, journal version to be re-read before release (hw 660)?
(3) N4 kept (needs the Robbins input and a verbatim read), or dropped in favour of "T_n printed numerically"?

---- R15 file kept in full for the diff (moved to archive/rounds/r15/STATEMENT_FREEZE_R15.md; C_7 display and KY1000 numbers unchanged in R16) ----
# STATEMENT_FREEZE_R15 - frozen statements for the paper (2026-08-26, node <LOCAL_HOST>; opened after the GPT r14 review, Dr. Fukui ruling of R15 "その順でOK")

Change from R14: ONE theorem statement change, item 6 (Theorem S0). The r14 hypothesis (ii) (the depth-t floor)
is removed from the statement: it is Lemma depthfloor (Schinzel, MO3 Thm 5.1; proved for every t >= 1), and GPT r14
answered our question (2) "S0 with hypothesis (i) only" with YES. A NEW lemma, Lemma oddtransfer (odd-power depth
transfer), is added to Appendix E: for l odd and units x of O_n, x^l = 1 (mod 2^t O_n) iff x = 1 (mod 2^t O_n).
It closes the step that the r14 proof of S0 did not write (E15-1, GPT r14 sect 4): the filtration J_t is on
u_a = r_a^l, while the floor is applied to r_a (non-base branch) or to u_b with u_b^l = u_{lb} (base branch).
Corollary S1: wording only (E15-2): "verified in three independent systems" -> "constructed independently in Sage
and in Magma, and replayed by a standalone Python rank checker". Every other statement is unchanged from R14
(Theorem A, Prop D, Cor A', Cor T, Cor 7, Certificate Soundness, Family, E-material, word freeze).

## 6. Theorem S0 (abstract scale law)  [M relative to hypothesis (i); F-core]   — R15 restatement (supersedes the R14 item 6 below)

Let t >= 2, J_t = {a in R_n : u_a = 1 mod 2^t}, u_a = prod_i sigma^i(eps_n)^{a_i}, and L_{n,t} := sqrt(2^n) arcsinh(2^t).
Assume (i) J_t = 2^{t-1} R_n. Then Lambda_{f,t} := (1/l) H_n (L_f cap J_t) = 2^{t-1} Lambda_f for every
component f, and the depth-t variant of Theorem A (Blichfeldt on Lambda_{f,t} against the depth-t floor L_{n,t}
of Lemma depthfloor, applied to the unit that carries the short vector: r_a in the non-base branch, u_b in the base
branch, through Lemma oddtransfer) is strictly weaker than Theorem A, because (2+sqrt5)^{2^{t-1}} > 2^t + sqrt(4^t+1)
for every t >= 2.
Lean: coprime_smul_injective, smul_mem_iff_of_coprime (WeberScalingNoGo.lean); ineq_t_general,
sqrt_four_pow_add_one_lt, le_two_pow_pred (WeberScalingS0.lean); WeberOddTransfer.pow_odd_eq_one_iff_of_two_pow_card
(WeberOddTransfer.lean). All std-3.

Lemma depthfloor  [M, L-relative]. For t >= 1 and u in RE+_n \ {+-1} with u = 1 mod 2^t O_n: ht(u) >= L_{n,t}.
(Schinzel's inequality as quoted in MO3 Thm 5.1; MO16 eq. (2.4).)

Lemma oddtransfer  [M, F-core]  — NEW in R15. For t >= 1, l odd and units x, y of O_n:
x^l = 1 (mod 2^t O_n) iff x = 1 (mod 2^t O_n), and x^l = y^l iff x = y (mod 2^t O_n).
Proof shape: 2 is totally ramified in B_n with residue field F_2 (2 = unit * (1-zeta)^{2^{n+1}} in Q(zeta_{2^{n+2}});
ramification indices multiply in the tower), so 2^t O_n = p^{2^n t} and |(O_n/2^t O_n)^x| = 2^{2^n t - 1}; an odd
power map on a group of 2-power order is a bijection (Lean: WeberOddTransfer.pow_odd_eq_one_iff_of_two_pow_card,
pow_odd_injective_of_two_pow_card, pow_odd_eq_iff_of_two_pow_card, isUnit_pow_odd_eq_one_iff, coprime_two_pow_of_odd;
5 declarations, std-3, lean/compile15_weberoddtransfer.log). The number-field part is M.

Corollary S1  [C + F]. Hypothesis (i) holds for t = 2, 3, 4 at n = 7 (exact rank certificates,
certificates/twoadic_rank/, constructed independently in Sage (sage/r8_twoadic_depth_exact.sage) and Magma
(sage/r8_twoadic_rank_magma.m), replayed by scripts/verify_twoadic_rank.py — a replay, not a third construction).
Hence the mod 4, mod 8 and mod 16 congruence-depth routes are strictly weaker than Theorem A
(ineq_t2/t3/t4, ineq_t2'/t3'/t4'). OPEN and NOT claimed: J_t = 2^{t-1} R_n for t >= 5.

---- R14 file kept in full for the diff ----
# STATEMENT_FREEZE_R14 (superseded by R15 above) - frozen statements for the paper (2026-08-26, node <LOCAL_HOST>; opened after the GPT r13 review, Dr. Fukui ruling of R14)

Change from R13: NO theorem statement changes. Item 5 (Corollary 7): the C_7 enclosure is restated from the
full-precision interval certificate certificates/constants/Cn_interval_r14.json (E14-1: the r12/r13 display attached
the 2.2e-115 ball radius to a 35-digit truncated value that lies 5.4e-6 outside the ball); the frozen integer thresholds
are unchanged and are now asserted inside the certificate. Item 9 (KY1000): "9 negative controls" (E14-2, the r13 text
below still said 7 in this file).

---- R13 header kept for the diff ----
# STATEMENT_FREEZE_R13 - frozen statements for the paper (2026-08-25, node <LOCAL_HOST>; opened after the GPT r12 review, Dr. Fukui ruling R1 of R13)

Change from R12: NO theorem statement changes. Item 7 (Certificate Soundness) has its proof shape and
the verifier-specification wording corrected (E13-1): the T-route threshold is the piecewise bar_T_n
(17 * 2^n for n = 2 by MO3 Prop 6.6; 33 * 2^n for n >= 3 by KY Thm 2.3), as the verifier has always
computed it (scripts/family_verify.sage line 28, sha256 0f38bb0d unchanged). The R12 prose used the
n >= 3 constant 33 * 2^n uniformly, which is wrong at n = 2.

Supersedes STATEMENT_FREEZE_R12.md (kept). Freeze scope: the STATEMENTS below are frozen and are
the ones printed in paper/draft/main_R13.tex sect 1.2; proofs live in the paper (sect 4-7 and
Appendices A-E) and in the theory/ documents named per item. Every constant was re-derived from
the KY definitions alone (sage/r10_bin3_fidelity_gate.log) and, this round, enclosed rigorously
(sage/r11_propD_audit.log). Trust labels: F = Lean std-3; C = certificate + read-only checker;
L = literature theorem as explicit hypothesis; M = proved in the manuscript and Blueprint, not
machine-checked (introduced r12, GPT hw 131); E = experiment (never used in a theorem);
[MC] = CAS-confirmed numerics; [H] = unproven; [OPEN] = not decided. Composite labels: TRUST.md.

Changes from R11 (docs/ERRATA_R12.md; no theorem statement is weakened or withdrawn):
- Sect 8: the Family Theorem is stated additionally in the equivalent interval form
  P = {l prime : 10^9 < l <= 1001287361, l = 65 mod 128} (GPT hw 169), and the defining property
  "first 1000 primes" becomes a C-labelled claim (KY1000_TARGET, scripts/verify_ky1000_target.py).
- Label M added to the taxonomy; Lemmas B, C (bookkeeping), D, E, E', Prop F, Prop D, Cor A',
  the old/new decomposition lemma and the CRT-carry note now carry M where they were unlabelled
  or labelled by prose ("hand proof", "elementary", "follows", "classical").
- The old/new decomposition lemma is restated in valuation form v_l(h_L) > v_l(h_K) (E12-5).
- Prose withdrawn (E12-1..E12-4): "C_n grows super-exponentially"; "replays from a clean
  checkout"; "all non-literature finite and discrete claims are kernel- or certificate-checked";
  Table 2 header "by no published theorem". Cor S1 restricted in wording to the direct
  filtered-lattice routes (no change of statement content).
- Cor T (sect 4) is unchanged: f_n(B) = 1 + floor(log C_n / log B) is correct as stated since
  d_n(l) >= 1 (re-derived r12 against GPT hw 198; C_n > 1 numerically for 2 <= n <= 9).

Changes from R10 (recorded in STATEMENT_FREEZE_R11; both are errata, docs/ERRATA_R11.md):
- E11-1: "Theorem S" is WITHDRAWN as stated; replaced by Theorem S0 (sect 6) + Corollary S1.
- E11-2: the comparison sentence of r10 sect 3 (classes 1, 127 only) replaced by three regimes.
- The r10 sentence "the growth of C_n is that of the Gamma factor alone" is deleted; sect 5
  below carries only the numerical observation (Remark 1.11 of the paper), no asymptotic claim.

## 0. Standing notation (frozen, unchanged from R10)

B_n = Q(X_n), X_n = 2cos(2pi/2^{n+2}) (KY Def 2.1), sigma: X_n -> 2cos(3*2pi/2^{n+2}),
G_n = <sigma> = Gal(B_n/Q), tau = sigma^{2^{n-1}} the generator of Gal(B_n/B_{n-1}).
E_n units of B_n; RE+_n = {eps in E_n : N_{n/n-1} eps = 1}; eps_n = (X_n+1)/(X_n-1);
A_n = <+-1, eps_n>_{Z[G_n]} (KY Def 2.1); k_n = h_n/h_{n-1} = [RE+_n : A_n] (KY Eq.(17), L).
m = m_n = 2^{n-1}; q = 2^{n+2}; lambda_j = log|sigma^j(eps_n)| (j mod 2^n), lambda_{j+m} = -lambda_j.
W_n = (lambda_{i+j})_{0<=i,j<m};  D_n := 2^{m/2} |det W_n| = covol_m( lambda(A_n) ) in R^{2^n}.
ht(eps) = (sum over all 2^n real embeddings of (log|eps_i|)^2)^{1/2} (MO 2016 Def 2.2).
L_n := sqrt(2^n) log(2+sqrt5)  (MO 2016 Lemma 2.5(1): height floor on RE+_n \ {+-1}, L).
d_n(l) := ord_{2^n}(l) for an odd prime l (= common degree of all irreducible factors of
x^m + 1 over F_l; Lemma B).
C_n := (2/pi)^{m/2} * Gamma(2 + m/2) * D_n / L_n^m.

## 1. Theorem A (componentwise saturation-height exclusion, every layer)  [L-relative, F-core]

For every n >= 2 and every odd prime l:   l^{d_n(l)} > C_n  ==>  l does not divide k_n.
Disclosed inputs (all L, all proven literature, Table 1 of the paper): KY Eq.(17); KY sect 4
freeness of A_n/{+-1} and the identification R_n/lR_n = A_n^{1/l}/A_n; KY Prop 4.1 with
display (23); MO 2016 Lemma 2.5(1); Blichfeldt 1914 Thm II (as MO 2016 Thm 2.7); Dirichlet's
unit theorem. NOT inputs: KY Conj 2.2, Horie's lemma, Luo, GRH.
Lean: TheoremAInputs.theoremA_of_inputs (lean/WeberExternalResults.lean) checks the discrete
implication with the inputs as NAMED HYPOTHESES of a structure; F-core, not a full formalisation.
Proof: paper sect 4 + Appendix A (Lemmas A-E, E', Prop F), written in R10/R11 notation.

## 2. Proposition D (evaluation of D_n)  [classical; not a contribution]

(i) D_n = 2^{-m/2} prod_chi |S(chi)|, S(chi) = sum_{g in G_n} chi(g) log|g(eps_n)|, chi over the
    m characters of G_n with chi(tau) = -1 (= even Dirichlet characters of conductor exactly q).
    [MC n = 2..7 to >= 40 digits; second route (Gram eigenvector residual <= 2.4e-143) in
    sage/r11_propD_audit.log (b).]
(ii) D_n = 2^{m(n+1)/2 + 1} prod_{chi even, cond chi = q} |L(1,chi)|.
    Ingredients (Appendix D): eps_n = (1-z^3)^2 (1-z^2) / ((1-z)^2 (1-z^6)), z = zeta_q; the z^2, z^6
    factors have vanishing character sums for primitive chi mod q; Washington Thm 4.9 (with
    |tau(chi)| = sqrt(q)) gives |sum_{a mod q} chi(a) log|1-z^a|| = 2^{(n+2)/2} |L(1,chi)|; the
    G_n-sum is half the a-sum (sage/r11_propD_audit.log (a), hw 30); prod_chi |1-chi(3)| =
    Phi_{2^n}(1) = 2 exactly (audit (c), n = 2..12, hw 32); D_n > 0 from L(1,chi) != 0 (Dirichlet;
    numerical witnesses min|L(1,chi)| in audit (d)).
Citation status: Washington GTM 83 theorem numbers are to be confirmed against a physical copy
(hw 29 OPEN); the mathematics does not depend on the numbering.

## 3. Corollary A' (closed form of the constant)  [follows from Thm A + Prop D(ii)]

C_n = 2 * (4/pi)^{m/2} * Gamma(2 + m/2) * prod_{chi even, cond q} |L(1,chi)| / (log(2+sqrt5))^m.

## 4. Corollary T (threshold form)  [F relative to the core hypotheses: theoremA_threshold]

For B > 1 put f_n(B) := 1 + floor( log C_n / log B ).  If l >= B and d_n(l) >= f_n(B), then
l does not divide k_n.

## 5. Corollary 7 (n = 7)  [C for the enclosure; F for the integer comparison]

C_7 in [C_7^-, C_7^+]: both endpoints recorded to 160 significant digits, rounded outward, in
certificates/constants/Cn_interval_r14.json (digamma route, 500-bit balls, sage/r14_cn_interval.sage/.log;
width < 5 x 10^{-115}; first 145 digits common). Display: C_7 = 1.7273421630363529579743237623519834054... x 10^30
(truncation of the common prefix to 38 digits, truncation error < 10^{-7}; NO ball radius is attached to the
display). The r6 three-precision interval claim C_7 <= 1.7273421630363531e30, the Magma value (60 printed digits,
L-series at 40 digits) and the PARI Gauss-sum route are consistent with the enclosure (numerical cross-checks).
  l = 1 mod 128,           l > 1727342163036353095979941756929   =>  l does not divide h_7/h_6;
  l = 63, 65, 127 mod 128, l > 1314283897427172                  =>  l does not divide h_7/h_6.
Integer comparisons: c7_deg2_instance (WeberExternalResults.lean), deg1/deg2_threshold_valid (WeberR6.lean).
Rigorous enclosures of C_n for n = 2..9 (audit (e)); log10 C_8 = 77.524, log10 C_9 = 190.583.
Numerical observation only (paper Remark 1.11; E): for 2 <= n <= 9, sum_chi log|L(1,chi)| lies in
[-0.37, 0.03]. NOTHING is claimed about the L-product for n >= 10.

## 6. Theorem S0 (abstract scale law)  [F-relative to hypotheses (i), (ii)]   — replaces Theorem S

Let t >= 2 and J_t = {a in R_n : u_a = 1 mod 2^t}, u_a = prod_i sigma^i(eps_n)^{a_i}. Assume
(i) J_t = 2^{t-1} R_n, and (ii) the depth-t floor: every u in RE+_n, u != +-1, u = 1 mod 2^t has
ht(u) >= L_{n,t} := sqrt(2^n) arcsinh(2^t). Then Lambda_{f,t} := (1/l) H_n (L_f cap J_t) =
2^{t-1} Lambda_f for every component f, and the depth-t variant of Theorem A (Blichfeldt on
Lambda_{f,t} against L_{n,t}) is strictly weaker than Theorem A, because
(2+sqrt5)^{2^{t-1}} > 2^t + sqrt(4^t + 1) for every t >= 2.
Lean: coprime_smul_injective, smul_mem_iff_of_coprime (WeberScalingNoGo.lean); ineq_t_general,
sqrt_four_pow_add_one_lt, le_two_pow_pred (WeberScalingS0.lean). All std-3.

Corollary S1  [C + F]. Hypothesis (i) holds for t = 2, 3, 4 at n = 7 (exact rank certificates,
certificates/twoadic_rank/, scripts/verify_twoadic_rank.py). Hence the mod 4, mod 8 and mod 16
congruence-depth routes are strictly weaker than Theorem A (ineq_t2/t3/t4, ineq_t2'/t3'/t4').
OPEN and NOT claimed: J_t = 2^{t-1} R_n for t >= 5. The r10 wording "every congruence-depth
variant ... for every t >= 2" / "all deeper" is withdrawn (E11-1).

## 7. Certificate Soundness Theorem  [C+L, F-core]

If the read-only verifier (scripts/family_verify.sage, spec FAMILY_CERTIFICATE_SPEC_R10 sect 4)
returns EXCLUDED for (n, l), then l does not divide k_n.
Proof shape: every component has an accepted witness; if l | k_n then (KY Prop 4.1) some component
is saturated; a RHO witness contradicts MO 2016 Lemma 2.5(1) / MO3 Prop 6.6 on that component, a
T witness contradicts the trace floor bar_T_n = 33 * 2^n for n >= 3 (KY Thm 2.3) / 17 * 2^n for n = 2
(MO3 Prop 6.6); the verifier recomputes bar_T_n from n (line 28) and rejects any other header value
(line 29). Lean: WeberCert.exclusion_chain_direct
(propositional chain, no axioms), rho_witness_refutes_saturation, t_witness_refutes_saturation,
exclusion_of_checker_spec (WeberCertChainDirect.lean); the piecewise floor is WeberCert.barT with
barT_two / barT_of_ge_three / barT_seven / barT_two_lt_uniform / barT_le_uniform and the instantiation
t_witness_refutes_saturation_barT (WeberCertFloor.lean, r13, std-3). The Lean layer verifies the mathematics of
an ACCEPTED certificate, not the checker implementation (hw 44). The old Horie/P4 layer
(WeberChain.lean) is not in this DAG.

## 8. Family Theorem (KY1000)  [C+L, F-core]

Let P be the set of the first 1000 primes l with l > 10^9 and l = 65 mod 128; min P = 1000000321,
max P = 1001287361; P is the list of KY sect 4.2 (regenerated independently, element by element).
Equivalently (r12, hw 169): P = {l prime : 10^9 < l <= 1001287361, l = 65 mod 128}.
For every l in P: l does not divide h_7/h_6.
The defining property of P (1000 entries, distinct, ascending, all prime, all = 65 mod 128, and
equal elementwise to the first 1000 qualifying primes regenerated from 10^9) is the C-claim
KY1000_TARGET, checked by scripts/verify_ky1000_target.py as an independent step of the verifier.
Evidence: certificates/family/KY1000/ (1000 witness files, 32 components each);
sage/family_ky1000_r11_clean/VERIFY_LEDGER.txt EXCLUDED 1000/1000 (T certificates 32000, RHO 31987,
T-only 13, max T 4164.4897 < 4224, margin 59.5103, median T 2352.0117); 9 negative controls
REJECTED and the n = 2 positive control EXCLUDED (sage/negctl_r13/negctl_r13.log). KY sect 4.2 excludes the same primes conditionally on Conjecture 2.2;
here no conjecture is used.

## 9. E-material (no theorem depends on it)

Class 1 (l = 1 mod 128): centered representatives + local +-l descent at l = 1000000513, 64
components, no witness; NOT a full CVP; open by the implemented search, not by the method.
Classes 63/127: exact-SVP near misses ht/L_7 in [1.009, 1.011] at l = 10000003199.
C_n for n >= 10 not computed. CRT carry identity and the Luo gap: companion note, not the paper.

## 10. Word freeze

BANNED until hw 122 (novelty reading of the post-2021 literature) is closed: "first" (as a priority
claim), "new principle", "effective complement", "tower-wide", "breakthrough". "The first 1000 primes"
is the definition of P (hw 106) and is not a priority claim. Prop D and Cor A' are presented as
classical evaluations, not as results.
