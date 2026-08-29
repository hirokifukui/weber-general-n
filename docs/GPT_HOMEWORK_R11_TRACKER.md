# GPT_HOMEWORK_R11_TRACKER — the 126 items of the r10 review (Weberレビュー.txt, md5 4c82b4ce...), status at seal R11 (2026-08-25)

Status vocabulary: DONE = executed and evidenced on disk; PARTIAL = executed in part, remainder stated;
OPEN = not done, not claimed; DrF = needs Dr. Fukui (physical copy, external reader, push, release);
N/A = superseded by another item, with the reason. Evidence paths are relative to the package root.

Totals (counted by script over the 126 rows): DONE 105 ; PARTIAL 6 ; OPEN 6 (of which 4 need Dr. Fukui: 29, 86, 87, 122) ; DrF 8 ; N/A 1.

## P0 — claim boundary (1-15)

| # | item | status | evidence |
|---|------|--------|----------|
| 1 | withdraw Theorem S as stated | DONE | ERRATA_R11 E11-1; paper sect 1.2 |
| 2 | separate the exponent-lattice scale law from the congruence corollary | DONE | Thm S0 / Cor S1; STATEMENT_FREEZE_R11 sect 6 |
| 3 | congruence corollary limited to t = 2,3,4 | DONE | Cor S1 |
| 4 | delete "all deeper" until J_t = 2^{t-1}R_n is proven | DONE | grep: no "all deeper"; SCALING_NO_GO_THEOREM.md OPEN paragraph |
| 5 | abstract sentence on congruence-depth refinements narrowed | DONE | main_R11.tex abstract |
| 6 | delete "only centered scalars are available" | DONE | main_R11.tex sect 7.2 (E box) |
| 7 | separate centered/local scan from global optimal lift | DONE | sect 7.2; CLAIMS CLASS1_E |
| 8 | class-1 conclusion restricted to E | DONE | \lbl{E} box |
| 9 | delete "L-product is bounded" | DONE | Remark 1.11; ERRATA_R11 withdrawals |
| 10 | delete "Gamma factor alone determines the growth" | DONE | idem |
| 11 | state only the 2 <= n <= 9 numerical observation | DONE | Remark 1.11; CLAIMS LPROD_OBS |
| 12 | audit comparison classes as (1, 63, 127) | DONE | ERRATA_R11 E11-2; RESIDUE_CLASS_TABLE.md; paper Table 2 |
| 13 | delete "no bound can be obtained" in CRT carry doc | DONE | CRT_CARRY_IDENTITY_R10.md (grep 0) |
| 14 | limit to "separable descent fails" | DONE | idem sect on separable terms |
| 15 | CLAIMS yaml as the single source, csv generated | DONE | docs/CLAIMS_R11.yaml (23 claims); tools/gen_correspondence.py; verifier step 13 |

## P1 — Theorem A hardening (16-27)

| # | item | status | evidence |
|---|------|--------|----------|
| 16 | fill Appendix A | DONE | main_R11.tex app:A (Lemmas B, C, D, E, E', Prop F) |
| 17 | rewrite BST-R7 in R10 notation, not copy | DONE | app:A uses the sect 4 notation (m, q, L_f, Lambda_f) |
| 18 | KY identification R_n/lR_n = A_n^{1/l}/A_n explicit | DONE | sect 4.2 Lemma E; CLAIMS LEM_E status |
| 19 | typed map M_f -> formal roots | DONE | sect 4.2 (Lemma E, typed identification) |
| 20 | Lemma E coset inclusion -> representative in RE+_n fully written | DONE | sect 4.2 + coset_absorb (F) |
| 21 | a in l R_n branch as a separate lemma | DONE | Lemma E' (CLAIMS LEM_EPRIME) |
| 22 | component-index pullback isomorphism completed in Lean or blueprint | PARTIAL | blueprint node lem:C (quotient form F); pullback bookkeeping stated as not formalised (README_lean) |
| 23 | factor-degree lemma: Lean or declared out of F | DONE | Lemma B declared hand proof, not F (CLAIMS LEM_B; README_lean) |
| 24 | Gamma constant re-checked against MO original | DONE | PHASE_MINUS1_INTEGRATED_AUDIT_R10 (a); r11_propD_audit (e) reproduces the r6 interval |
| 25 | all Theorem A hypotheses in one trust table | DONE | paper Table 1 (tab:trust) |
| 26 | external algebraic number theorist reads Theorem A | DrF | LETTER_R11 sect "external readers" |
| 27 | store their comments + revision history | DrF | after 26 |

## P2 — Proposition D (28-38)

| # | item | status | evidence |
|---|------|--------|----------|
| 28 | complete Appendix D | DONE | app:D Lemmas 0-3 |
| 29 | Washington edition / theorem numbers / conjugation convention re-confirmed | OPEN | needs a physical copy of GTM 83 2nd ed. (DrF); TRUST.md L row says so |
| 30 | S(chi) half-sum normalisation independently computed | DONE | r11_propD_audit.log (a), n = 2..7, |S_G - S_half| <= 1e-144 |
| 31 | 2^{-m/2} proven by a second route | DONE | audit (b), Gram eigenvector residual <= 2.4e-143 |
| 32 | prod |1 - chi(3)| = 2 stated for general n | DONE | audit (c) exact in the cyclotomic field, n = 2..12; app:D Lemma 3 |
| 33 | D_n > 0 from L(1,chi) != 0 | DONE | app:D; CLAIMS LEM_D second proof; audit (d) witnesses |
| 34 | Prop D labelled classical, not a contribution | DONE | paper after Prop D; CLAIMS PROP_D_i/ii |
| 35 | C_n table with rigorous / non-rigorous columns | DONE | Table 3 (tab:Cn): "rigorous ball" column, n = 2..9 |
| 36 | PARI output turned into interval certificates | DONE (by a different route) | digamma ball enclosure of every L(1,chi) at 500 bits replaces the PARI floats (audit (e)); PARI/Magma values shown to lie inside |
| 37 | no all-n L-product boundedness claim | DONE | Remark 1.11 |
| 38 | asymptotics only with a separate analytic theorem | DONE (none claimed) | idem |

## P3 — certificate theorem and Lean (39-50)

| # | item | status | evidence |
|---|------|--------|----------|
| 39 | exclusion_chain_direct in Lean | DONE | lean/WeberCertChainDirect.lean (no axioms) |
| 40 | Horie/P4 removed from the certificate DAG | DONE | CLAIMS THM_CERT status; README_lean (WeberChain RETIRED) |
| 41 | RHO witness contradicts saturation, as a proposition | DONE | rho_witness_refutes_saturation |
| 42 | T witness contradicts saturation | DONE | t_witness_refutes_saturation |
| 43 | specification theorem checker-acceptance -> predicate | DONE | exclusion_of_checker_spec |
| 44 | state that Lean does not verify the checker implementation | DONE | TRUST.md; README_lean; paper sect 6.2 |
| 45 | certificate theorem label "C+L, F-core" | DONE | CLAIMS THM_CERT; paper thm:cert title |
| 46 | \leanok moved from paper theorems to abstract cores | DONE | blueprint: thm:Acore, thm:certcore carry \leanok; paper-level nodes do not |
| 47 | Cor 7 \leanok decomposed | DONE | blueprint lem:C7int (F) separate from cor:7 (C + F) |
| 48 | C_7 interval = C, integer comparison = F | DONE | CLAIMS C7_ENCLOSURE / C7_INTEGER |
| 49 | Theorem S \leanok re-attached to the limited theorem | DONE | blueprint lem:Sgroup, lem:Sineq (F); thm:S0 relative |
| 50 | CORRESPONDENCE.csv re-synchronised | DONE | generated from CLAIMS_R11.yaml; verifier step 13 diff |

## P4 — KY1000 release grade (51-68)

| # | item | status | evidence |
|---|------|--------|----------|
| 51 | certificates/family/KY1000/ | DONE | 1000 files |
| 52 | only the 1000 target files there | DONE | ls count 1000 = KY1000_primes.txt |
| 53 | class 63/127, extra primes, _esc moved to experiments/ | DONE | certificates/experiments/family_extra/ |
| 54 | clean ledger 1000/1000 only | DONE | sage/family_ky1000_r11_clean/VERIFY_LEDGER.txt |
| 55 | initial 993/1000 ledger archived | DONE | kept as the r10 record in sage/family_ky1000/ (not the release ledger) |
| 56 | MD5 -> SHA-256 | DONE | ledger columns; scripts use python3 hashlib |
| 57 | 1000 witnesses in the root manifest | DONE | MANIFEST_SHA256.txt (tools/gen_manifest.py) |
| 58 | target list in the manifest | DONE | sage/family_ky1000/KY1000_primes.txt listed |
| 59 | verifier source in the manifest | DONE | scripts/family_verify.sage listed |
| 60 | certificate spec in the manifest | DONE | theory/FAMILY_CERTIFICATE_SPEC_R10.md listed |
| 61 | family_verify.sage asserts header deg/ncomp/bar/L_n | DONE | r11 verifier; negctl nc6 (ncomp), nc7 (bar_T) REJECTED |
| 62 | (alternative to 61) | N/A | 61 chosen |
| 63 | all 1000 re-verified in a clean environment | PARTIAL | clean re-run on the author's node (verify_out/family_ky1000/, step 06); container run not yet executed (hw 86) |
| 64 | negative controls in the same clean run | DONE | negctl.log in the clean dir; verifier step 08 |
| 65 | verifier logs / their SHA-256 in the release | DONE | ledger column 5 = sha256(verifier log); verify_logs/ shipped |
| 66 | max T, median, RHO count auto-generated from the ledger | DONE | SUMMARY line written by family_verify_clean.sh |
| 67 | CI test: paper numbers == ledger numbers | DONE | verifier step 07 (ky1000_numbers) |
| 68 | corrupted witness rejection as a CI hard gate | DONE | verifier step 08 (7 REJECTED required) |

## P5 — R10/R11 CI and container (69-87)

| # | item | status | evidence |
|---|------|--------|----------|
| 69 | verify_all_portable.sh rewritten for this round | DONE | scripts/verify_all_portable.sh (13 steps) |
| 70 | manifest check first | DONE | step 01 |
| 71 | Prop D cross-CAS certificate checked | DONE | step 04 (r11_propD_audit) |
| 72 | C7 certificate checked | DONE | step 05 (dual route + flagship) |
| 73 | KY1000 all checked | DONE | step 06 |
| 74 | negative controls checked | DONE | step 08 |
| 75 | WeberExternalResults.lean compiled | DONE | step 09 |
| 76 | direct certificate chain compiled | DONE | step 09 |
| 77 | revised scaling theorem compiled | DONE | step 09 (ScalingNoGo + ScalingS0) |
| 78 | blueprint built | PARTIAL | step 10 builds the dependency graph and checks it (check_graph.py); plasTeX/leanblueprint rendering not installed (hw 99) |
| 79 | paper PDF built | DONE | step 11 |
| 80 | stale placeholder grep fails CI | DONE | step 12 |
| 81 | Sage pinned to 10.8 | DONE | Dockerfile FROM sagemath/sagemath:10.8 |
| 82 | Docker image pinned by digest | OPEN | requires a docker pull; CI step prints the digest (Dockerfile comment) |
| 83 | Lean + pinned mathlib in the container | DONE (by design as a separate job) | verify.yml `lean` job: elan + lake exe cache get on d568c8c0 |
| 84 | md5 -q replaced | DONE | grep 0 in scripts/ |
| 85 | Mac absolute-path fallbacks removed | DONE | grep 0 in scripts/ (family_lane/survey/verify_all patched) |
| 86 | GitHub Actions exit 0 from a clean clone | OPEN (DrF push) | never executed; no docker on any author machine |
| 87 | that log in the Zenodo release | OPEN | after 86 |

## P6 — Blueprint (88-100)

| # | item | status | evidence |
|---|------|--------|----------|
| 88 | scaffold state ended | DONE | 41 nodes, 47 edges (blueprint/src/content.tex) |
| 89 | App A lemmas as nodes | DONE | lem:A, lem:B, lem:C, lem:D, lem:E, lem:Eprime, prop:F |
| 90 | Prop D lemmas as nodes | DONE | app D Lemma 0-3 nodes |
| 91 | certificate soundness spec as nodes | DONE | thm:certcore + spec node (sha256 of the verifier shown) |
| 92 | literature inputs with number / page / hash | PARTIAL | numbers and sources per node; page numbers and file hashes only in PHASE_MINUS1_INTEGRATED_AUDIT_R10 / MANIFEST, not on every node |
| 93 | F/C/L/E on every node | DONE | node titles carry [F]/[C]/[L]/[E] |
| 94 | \leanok only for full formalisation | DONE | 8 leanok nodes = the std-3 declarations |
| 95 | \leanrelative for relative formalisation | DONE | macro used on the L-relative paper-level nodes |
| 96 | certificate id + checker version on certificate nodes | DONE | FAMILY_KY1000 node (id, sha256 0f38bb0d, r11) |
| 97 | dependency graph actually built | DONE | blueprint/dep_graph.dot (check_graph.py) |
| 98 | orphan / unmatched paper theorem detected in CI | DONE | check_graph.py exit code; step 10 |
| 99 | blueprint PDF as release artifact | OPEN | plasTeX toolchain not installed on author machines |
| 100 | paper-blueprint-Lean-certificate 4-way correspondence generated | PARTIAL | CORRESPONDENCE.csv (paper/Lean/certificate/literature) generated; blueprint labels aligned by hand |

## P7 — paper (101-117)

| # | item | status | evidence |
|---|------|--------|----------|
| 101 | comparison table real | DONE | Table 2 (tab:classes) + sect 3.1 |
| 102 | appendix placeholders removed | DONE | grep 0; step 12 |
| 103 | 12-18 pages proof guide | DONE | 16 pages |
| 104 | Theorem A proof capsule one level deeper | DONE | sect 4.5 + app:A |
| 105 | family target list defined exactly | DONE | thm:family |
| 106 | "the first 1000 primes" stated | DONE | thm:family, sect 6.3 |
| 107 | verifier soundness vs generator untrusted | DONE | sect 6.1 title |
| 108 | family table: min margin, max T, T-only | DONE | Table 5 |
| 109 | computation time with hardware and threads | DONE | Table 5: 10 min 42 s, 4 lanes, 1 BLAS thread, Apple M4 10 cores |
| 110 | class-1 section as E-labelled diagnostic box | DONE | sect 7.2 |
| 111 | Theorem S replaced by the limited version | DONE | Thm S0 + Cor S1 |
| 112 | "all load-bearing claims are machine-verified" deleted | DONE | grep 0 |
| 113 | replacement wording | DONE | sect 8 (grep 2) |
| 114 | abstract aligned | DONE | abstract |
| 115 | Blichfeldt 1914 in the bibliography | DONE | \bibitem{Bl14} |
| 116 | KY cited as arXiv v3 | DONE | \bibitem{KY} arXiv:2107.08587v3 |
| 117 | AI disclosure as architecture, not apology | DONE | sect 8 last paragraph |

## P8 — external audit before release (118-126)

| # | item | status | evidence |
|---|------|--------|----------|
| 118 | Theorem A to a number theorist | DrF | — |
| 119 | certificate spec to a computational / formal-verification researcher | DrF | — |
| 120 | Prop D to a cyclotomic-fields specialist | DrF | — |
| 121 | novelty matrix updated | PARTIAL | theory/NOVELTY_ASSESSMENT_R7.md not rewritten; PHASE_MINUS1_INTEGRATED_AUDIT_R10 (c) is the current comparison; full update waits for 122 |
| 122 | verbatim reading of the post-2021 literature citing KY / MO for a duplicate of Theorem A | OPEN (DrF) | zbMATH / library session; the word freeze stays until this is closed |
| 123 | "new" / "first" banned until then | DONE | word freeze in force (main_R11.tex line 4; TRUST.md) |
| 124 | arXiv submission release immutable | DrF | after push |
| 125 | GitHub release hash == Zenodo DOI content | DrF | after push |
| 126 | version DOI + commit SHA in the manuscript | DrF | after 125 |

## R12 — GPT r11 review (Weberレビュー.txt md5 67893ff499cf70637db2ba372e9f8b81, read 2026-08-25). GPT numbering 1-130 -> tracker 127-256. All OPEN at entry; nothing closed from memory.

### P0 claim boundaries (GPT 1-15 = hw 127-141)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 127 | 1 | delete "C_n grows super-exponentially" (main_R11.tex l.112) | DONE | main_R12.tex; ERRATA_R12; CLAIMS_R12.yaml |
| 128 | 2 | state only the numerical growth for 2<=n<=9 | DONE | main_R12.tex; ERRATA_R12; CLAIMS_R12.yaml |
| 129 | 3 | delete abstract "replays from a clean checkout" until CI is green | DONE | main_R12.tex; ERRATA_R12; CLAIMS_R12.yaml |
| 130 | 4 | delete abstract "All non-literature finite and discrete claims are kernel- or certificate-checked" (l.21, l.246) | DONE | main_R12.tex; ERRATA_R12; CLAIMS_R12.yaml |
| 131 | 5 | add trust label M = manuscript/Blueprint proof | DONE | main_R12.tex; ERRATA_R12; CLAIMS_R12.yaml |
| 132 | 6 | reclassify every claim into F/C/L/M/E | DONE | main_R12.tex; ERRATA_R12; CLAIMS_R12.yaml |
| 133 | 7 | delete Table 2 header "range covered here and by no published theorem" (l.104) | DONE | main_R12.tex; ERRATA_R12; CLAIMS_R12.yaml |
| 134 | 8 | replace by "range not covered by the comparison theorems listed here" | DONE | main_R12.tex; ERRATA_R12; CLAIMS_R12.yaml |
| 135 | 9 | abstract: "congruence-depth refinements" -> "direct filtered-lattice refinements at depths 4,8,16" | DONE | main_R12.tex; ERRATA_R12; CLAIMS_R12.yaml |
| 136 | 10 | abstract: "Below these thresholds the same components admit finite certificates" -> "For selected primes below these thresholds, finite certificates can be supplied" | DONE | main_R12.tex; ERRATA_R12; CLAIMS_R12.yaml |
| 137 | 11 | old/new lemma (l.118, l.268): "l divides h_L/h_K" -> valuation form v_l(h_L) > v_l(h_K) | DONE | main_R12.tex; ERRATA_R12; CLAIMS_R12.yaml |
| 138 | 12 | close "Washington numbering unconfirmed" entirely from the paper text (= hw 29) | OPEN | depends on hw 29 (physical copy); the paper keeps the citation note until then |
| 139 | 13 | root HANDOFF.md = final sealed status only | DONE | RELEASE_STATUS.md at the root; HANDOFF.md not shipped from r12 |
| 140 | 14 | pre-seal HANDOFF archived under docs/ | DONE | docs/archive/HANDOFF_R11_preseal_as_shipped.md |
| 141 | 15 | CLAIMS_R12.yaml becomes the source of truth | DONE | main_R12.tex; ERRATA_R12; CLAIMS_R12.yaml |

### P1 GitHub Actions (GPT 16-32 = hw 142-158)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 142 | 16 | do not create the Lean workspace at repo-root ws/ (manifest step 01 fails on UNLISTED ws/ ; confirmed: verify.yml l.43, gen_manifest SKIP_DIRS lacks ws) | DONE | verify.yml: LEAN_WORKSPACE=$RUNNER_TEMP/weber-lean-ws |
| 143 | 17 | use LEAN_WORKSPACE="$RUNNER_TEMP/weber-lean-ws" | DONE | verify.yml: LEAN_WORKSPACE=$RUNNER_TEMP/weber-lean-ws |
| 144 | 18 | confirm manifest step exit 0 in the Lean job | PARTIAL | cannot be confirmed without a run; ws/ no longer under the checkout, manifest excludes nothing new |
| 145 | 19 | actually run the Sage job on GitHub Actions | OPEN (DrF) | needs the push; never executed on any author machine |
| 146 | 20 | actually run the Lean job | OPEN (DrF) | needs the push; never executed on any author machine |
| 147 | 21 | no clean-replay claim until both jobs are green | OPEN (DrF) | needs the push; never executed on any author machine |
| 148 | 22 | save the Sage job KY1000 1000/1000 as an artifact log | DONE | sage job uploads verify_out (KY1000 ledger inside) |
| 149 | 23 | save the Lean 4-file axiom-gate log as an artifact | DONE | lean job prints + uploads 09_lean_*.log |
| 150 | 24 | record Actions URL, run id, commit SHA in release metadata | OPEN (DrF) | needs the push; never executed on any author machine |
| 151 | 25 | pin the Docker base image by digest | DONE | Dockerfile FROM sagemath/sagemath@sha256:e2e4747b... (registry API index digest, 2026-08-25) |
| 152 | 26 | pin actions/checkout and upload-artifact by commit SHA (now @v4) | DONE | checkout@11d5960a, upload-artifact@ea165f8d |
| 153 | 27 | pin the elan installer by version and hash (now releases/latest) | DONE | elan v4.2.4, sha256 42b94d42... checked with sha256sum -c |
| 154 | 28 | assert that sagemath/sagemath:10.8 really is Sage 10.8 | DONE | Dockerfile RUN assert + workflow step |
| 155 | 29 | compare PARI/FLINT/Arb actual versions with the recorded ones | DONE | verify_all_portable step 02: PARI (pari.version()) and FLINT (flint.h) vs environment/*.txt |
| 156 | 30 | environment step: real assertions instead of cat | DONE | step 02 = real assertions (Sage/PARI/FLINT; lean-toolchain + mathlib pin) |
| 157 | 31 | register the clean CI log in the SHA-256 manifest | OPEN (DrF) | after the first green run |
| 158 | 32 | include CI output in the Zenodo release assets | OPEN (DrF) | release assets |

### P2 KY1000 target theorem (GPT 33-44 = hw 159-170)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 159 | 33 | write scripts/verify_ky1000_target.py | DONE | scripts/verify_ky1000_target.py A1-A9; PASS (10058 candidates) |
| 160 | 34 | assert shipped list has 1000 entries | DONE | scripts/verify_ky1000_target.py A1-A9; PASS (10058 candidates) |
| 161 | 35 | assert no duplicates | DONE | scripts/verify_ky1000_target.py A1-A9; PASS (10058 candidates) |
| 162 | 36 | assert ascending order | DONE | scripts/verify_ky1000_target.py A1-A9; PASS (10058 candidates) |
| 163 | 37 | assert every entry prime | DONE | scripts/verify_ky1000_target.py A1-A9; PASS (10058 candidates) |
| 164 | 38 | assert every entry = 65 mod 128 | DONE | scripts/verify_ky1000_target.py A1-A9; PASS (10058 candidates) |
| 165 | 39 | regenerate the qualifying primes from 10^9 upward | DONE | scripts/verify_ky1000_target.py A1-A9; PASS (10058 candidates) |
| 166 | 40 | assert the first 1000 regenerated == shipped list elementwise (claude re-derived 2026-08-25: True, 10058 candidates scanned) | DONE | scripts/verify_ky1000_target.py A1-A9; PASS (10058 candidates) |
| 167 | 41 | assert witness filename set == target list | DONE | scripts/verify_ky1000_target.py A1-A9; PASS (10058 candidates) |
| 168 | 42 | make this an independent step of verify_all_portable.sh | DONE | scripts/verify_ky1000_target.py A1-A9; PASS (10058 candidates) |
| 169 | 43 | state the Family Theorem also in the interval form 10^9 < l <= 1001287361, l = 65 mod 128 | DONE | step 03b |
| 170 | 44 | add the first-1000 claim as a C-labelled claim | DONE | Thm Family interval form (paper, FREEZE_R12); claim KY1000_TARGET [C] |

### P3 Blueprint completion (GPT 45-64 = hw 171-190)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 171 | 45 | Blueprint must not stay a 184-line dependency scaffold (0 proof environments) | DONE | content.tex 47 nodes, 29 proof envs |
| 172 | 46 | move the full natural-language proof of Theorem A into the Blueprint | DONE | proofs/thm_A.tex + proofs/prop_F.tex |
| 173 | 47 | add the full proof of Lemma B | DONE | proofs/lem_B.tex |
| 174 | 48 | write the Lemma C pullback bookkeeping in full | DONE | proofs/lem_C.tex (M part) |
| 175 | 49 | write Lemma D real-rank / discreteness / covolume in full | DONE | proofs/lem_D.tex |
| 176 | 50 | write the Lemma E typed identification in full | DONE | proofs/lem_E.tex + lem_Eprime.tex |
| 177 | 51 | write the Prop D(i) group-determinant proof in full | DONE | proofs/lem_D0.tex |
| 178 | 52 | write the Prop D(ii) character normalisation in full | DONE | proofs/prop_D.tex + lem_D1..D3, lem_prod13 |
| 179 | 53 | write Certificate Soundness: mathematical proof and checker spec separately | DONE | def:verifier (spec) separate from thm:cert (proof, proofs/thm_cert.tex) |
| 180 | 54 | write the S0 depth-floor (arcsinh) derivation in full | DONE | proofs/lem_depthfloor.tex: MO3 Thm 5.1 (Schinzel) + MO16 (2.4) => L_{n,t}; (ii) holds for all t |
| 181 | 55 | add the full proof of the old/new lemma | DONE | proofs/lem_oldnew.tex |
| 182 | 56 | every node must carry one of: full proof / Lean theorem / certificate / exact literature citation | DONE | check_graph.py proof-completeness gate PASS |
| 183 | 57 | add a proof-completeness gate to check_graph.py | DONE | check_graph.py proof-completeness gate PASS |
| 184 | 58 | CI must fail on statement-only nodes | DONE | verifier step 10 fails on the gate line |
| 185 | 59 | do not double-edit proofs in paper and Blueprint | DONE | proofs/*.tex single source |
| 186 | 60 | single source proofs/*.tex included by both | DONE | \input{\proofsdir/...} from both documents |
| 187 | 61 | actually build the Blueprint PDF | DONE | blueprint/blueprint_r12.pdf (17 pages, 0 errors, 0 undefined) |
| 188 | 62 | Blueprint PDF as a CI artifact | DONE | verifier step 10b inside the sage job |
| 189 | 63 | check Blueprint PDF page count, dangling refs, missing nodes | DONE | step 10b: errors, undefined refs, page count >= 10 |
| 190 | 64 | auto-generate the paper-Blueprint-Lean-certificate correspondence table | DONE | tools/gen_blueprint_map.py -> docs/BLUEPRINT_MAP_R12.md; step 13b |

### P4 Theorem A hardening (GPT 65-73 = hw 191-199)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 191 | 65 | have a third party read the KY Prop 4.1 -> Lemma E translation | OPEN (DrF) | external reader |
| 192 | 66 | unify the types of formal root r_a and coset r_a A_n | PARTIAL | Blueprint eq:ident + lem:E state the types; a dedicated typing lemma not yet written |
| 193 | 67 | make the representative change by a + l b an independent lemma | PARTIAL | the a+lb step is inside proofs/lem_E.tex, not a separate lemma |
| 194 | 68 | derive r_a in RE+_n step by step | PARTIAL | proofs/lem_E.tex is stepwise but not numbered |
| 195 | 69 | make base / non-base branches explicit in the Blueprint too | DONE | proofs/prop_F.tex: both branches (E' base, E non-base) explicit |
| 196 | 70 | re-check the Blichfeldt Gamma constant against the 1914 paper and MO | OPEN | Blichfeldt 1914 primary not re-read this round |
| 197 | 71 | second independent proof of the covolume D_n / l^{d_f} | OPEN | second covolume proof not written |
| 198 | 72 | Cor T: assume C_n > 1 or set f_n(B) = max(0, 1 + floor(log C_n / log B)) [claude: current statement is correct as is since d >= 1; cosmetic] | DONE | re-derived: Cor T correct as stated (d >= 1); proofs/cor_T.tex says so; no change |
| 199 | 73 | keep the external number theorist's comments and the revision history | OPEN (DrF) | after hw 191 |

### P5 Proposition D (GPT 74-82 = hw 200-208)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 200 | 74 | fix the Washington theorem numbers from a physical copy (= hw 29, DrF) | OPEN (DrF) | = hw 29 |
| 201 | 75 | state the chi vs bar-chi convention | PARTIAL | proofs/lem_D3.tex: absolute value is convention-independent; explicit convention table not added |
| 202 | 76 | state the Gauss-sum convention | PARTIAL | proofs/lem_D3.tex: absolute value is convention-independent; explicit convention table not added |
| 203 | 77 | fix the factor 2 between half-sum and full Dirichlet sum in the proof text | DONE | half-sum factor in proofs/prop_D.tex |
| 204 | 78 | make prod abs(1 - chi(3)) = 2 a lemma for general n | DONE | proofs/lem_prod13.tex (Phi_{2^n}(1) = 2), every n |
| 205 | 79 | check the digamma-route formula against a primary source | OPEN | primary source for the digamma formula not re-read |
| 206 | 80 | turn the ball enclosures n = 2..9 into JSON certificates | PARTIAL | certificates/constants/Cn_digamma_r12.json from the audit log (sha256-bound); ball radius stated only for n = 7 |
| 207 | 81 | generate every table row from the certificates | DONE | tools/gen_cn_certs.py --check: 8/8 rows verbatim; step 04b |
| 208 | 82 | do not conjecture new asymptotics (super-exponential etc.) | DONE | E12-1; no new asymptotics |

### P6 Certificate verifier (GPT 83-96 = hw 209-222)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 209 | 83 | compare fresh vs shipped ledger per prime, not only the SUMMARY | DONE | step 07 keyed per-prime compare |
| 210 | 84 | compare prime, verdict, component count, witness hash for all 1000 | DONE | step 07 keyed per-prime compare |
| 211 | 85 | compare the verifier log hash too | DONE | step 07: verifier-log sha256 1000/1000 equal (r11 run vs shipped) |
| 212 | 86 | reduce non-load-bearing header fields | OPEN | certificate format unchanged in r12 (r11 verifier sha256 frozen); planned for r13 |
| 213 | 87 | generator version in a metadata schema, not a comment | OPEN | certificate format unchanged in r12 (r11 verifier sha256 frozen); planned for r13 |
| 214 | 88 | certificate format version in the header | OPEN | certificate format unchanged in r12 (r11 verifier sha256 frozen); planned for r13 |
| 215 | 89 | verifier rejects unknown formats | OPEN | certificate format unchanged in r12 (r11 verifier sha256 frozen); planned for r13 |
| 216 | 90 | negative control: corrupted target list | DONE | verify_ky1000_target.py --negctl: 5/5 REJECTED (step 03c) |
| 217 | 91 | negative control: missing prime | DONE | verify_ky1000_target.py --negctl: 5/5 REJECTED (step 03c) |
| 218 | 92 | negative control: duplicate prime | DONE | verify_ky1000_target.py --negctl: 5/5 REJECTED (step 03c) |
| 219 | 93 | negative control: unsorted list | DONE | verify_ky1000_target.py --negctl: 5/5 REJECTED (step 03c) |
| 220 | 94 | negative control: one factor missing in a certificate | OPEN | factor-missing negative control not added (verifier unchanged) |
| 221 | 95 | map the verifier specification theorem to implementation line numbers | OPEN | spec-to-line map not written |
| 222 | 96 | cross-check the verifier with a second implementation on at least a few primes | OPEN | second implementation not written |

### P7 paper (GPT 97-108 = hw 223-234)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 223 | 97 | rewrite the abstract fully after the boundary fixes | DONE | abstract rewritten |
| 224 | 98 | one conceptual diagram of the verification architecture | OPEN | diagram not drawn |
| 225 | 99 | larger font in Table 1 | OPEN | — |
| 226 | 100 | Table 2 last column: no novelty claim | DONE | Table 2 header |
| 227 | 101 | state that "about 4 x 10^9 primes" in the class-65 window is an estimate | DONE | estimate marked |
| 228 | 102 | state that 8-20 s per prime does not mean an exhaustive window | DONE | per-prime cost sentence |
| 229 | 103 | position S1 as the limit of the direct filtered-lattice route | DONE | Cor S1 wording |
| 230 | 104 | consider moving the class-1 E-box to an appendix or the artifact | OPEN | class-1 box still in sect 7.2 |
| 231 | 105 | explain proof capsule vs full Blueprint in the introduction | OPEN | introduction not yet updated |
| 232 | 106 | F/C/L/M/E legend as a table in the paper | DONE | Table tab:legend (F/C/L/M/E) |
| 233 | 107 | PDF metadata: title, author, keywords | OPEN | — |
| 234 | 108 | check letter/A4 before converting to the journal style | OPEN | — |

### P8 literature / novelty (GPT 109-120 = hw 235-246)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 235 | 109 | trace every paper citing KY on MathSciNet | OPEN (DrF) | novelty audit; freeze in force |
| 236 | 110 | same on zbMATH | OPEN (DrF) | novelty audit; freeze in force |
| 237 | 111 | Google Scholar citations as a supplement | OPEN (DrF) | novelty audit; freeze in force |
| 238 | 112 | check all post-2021 papers citing MO16 | OPEN (DrF) | novelty audit; freeze in force |
| 239 | 113 | check the 2022 survey (arXiv:2211.15201) | OPEN (DrF) | novelty audit; freeze in force |
| 240 | 114 | check the 2023 generalized Pell paper | OPEN (DrF) | novelty audit; freeze in force |
| 241 | 115 | check Morisawa 2024 | OPEN (DrF) | novelty audit; freeze in force |
| 242 | 116 | search for the same componentwise covolume formula as Theorem A | OPEN (DrF) | novelty audit; freeze in force |
| 243 | 117 | prioritise papers citing both KY and MO | OPEN (DrF) | novelty audit; freeze in force |
| 244 | 118 | update the novelty matrix | OPEN (DrF) | novelty audit; freeze in force |
| 245 | 119 | do not use "no published theorem" until novelty is settled (= hw 123 freeze) | OPEN (DrF) | novelty audit; freeze in force |
| 246 | 120 | if possible, send the preprint to the KY or MO authors | OPEN (DrF) | novelty audit; freeze in force |

### P9 release (GPT 121-130 = hw 247-256)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 247 | 121 | complete CITATION.cff | OPEN (DrF) | release; after push |
| 248 | 122 | sync .zenodo.json | OPEN (DrF) | release; after push |
| 249 | 123 | fix the GitHub release version naming | OPEN (DrF) | release; after push |
| 250 | 124 | commit SHA in the paper | OPEN (DrF) | release; after push |
| 251 | 125 | Zenodo DOI in the paper | OPEN (DrF) | release; after push |
| 252 | 126 | use an immutable tag | OPEN (DrF) | release; after push |
| 253 | 127 | release assets: source, paper PDF, Blueprint PDF, certificates, verifier, CI logs | OPEN (DrF) | release; after push |
| 254 | 128 | SHA-256 list of the release assets | OPEN (DrF) | release; after push |
| 255 | 129 | confirm GitHub and Zenodo content hashes agree | OPEN (DrF) | release; after push |
| 256 | 130 | one third-party clean-clone replay before Zenodo publication | OPEN (DrF) | release; after push |

Next-round hard gates (GPT r11, 15): 1 super-exponential deleted/proved; 2 clean-checkout sentence deleted; 3 verification-scope sentence deleted; 4 old/new valuation wording; 5 novelty freeze; 6 ws/ manifest bug fixed; 7 Sage job green; 8 Lean job green; 9 KY1000 target verifier green; 10 Blueprint full proofs; 11 Blueprint PDF build green; 12 Washington citation confirmed; 13 external number theorist read Theorem A; 14 final sealed HANDOFF; 15 release-candidate manifest exit 0.

## R13 — GPT r12 review (Weberレビュー.txt md5 7415614e4141821e35de715406826387, 30867 B, read 2026-08-25). GPT numbering 1-130 -> tracker 257-386. All OPEN at entry; nothing closed from memory. Overall: GO for the paper, NO-GO to seal/release r12 as is; new scope error = n=2 certificate floor (GPT sect 3).


### P0 (n=2) の緊急修正 (GPT 1-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 257 | 1 | 一般certificate floorを [ \bar T_n= \begin{cases} 17\cdot2^n,&n=2,\ 33\cdot2^n,&n\ge3 \end{cases} ] と定義する。 | DONE | main_R13.tex sect 1.2 (\barT def) / sect 1 l.35 / Table 1 / sect 6; proofs/thm_cert.tex; blueprint def:verifier; STATEMENT_FREEZE_R13 item 7; CLAIMS_R13 THM_CERT; CORRESPONDENCE.csv regenerated; FAMILY_CERTIFICATE_SPEC_R10 already piecewise (sect 4); ERRATA_R13 E13-1 |
| 258 | 2 | 本文のCertificate Soundness定理を修正する。 | DONE | main_R13.tex sect 1.2 (\barT def) / sect 1 l.35 / Table 1 / sect 6; proofs/thm_cert.tex; blueprint def:verifier; STATEMENT_FREEZE_R13 item 7; CLAIMS_R13 THM_CERT; CORRESPONDENCE.csv regenerated; FAMILY_CERTIFICATE_SPEC_R10 already piecewise (sect 4); ERRATA_R13 E13-1 |
| 259 | 3 | `proofs/thm_cert.tex`を修正する。 | DONE | main_R13.tex sect 1.2 (\barT def) / sect 1 l.35 / Table 1 / sect 6; proofs/thm_cert.tex; blueprint def:verifier; STATEMENT_FREEZE_R13 item 7; CLAIMS_R13 THM_CERT; CORRESPONDENCE.csv regenerated; FAMILY_CERTIFICATE_SPEC_R10 already piecewise (sect 4); ERRATA_R13 E13-1 |
| 260 | 4 | Blueprintのverifier specificationを修正する。 | DONE | main_R13.tex sect 1.2 (\barT def) / sect 1 l.35 / Table 1 / sect 6; proofs/thm_cert.tex; blueprint def:verifier; STATEMENT_FREEZE_R13 item 7; CLAIMS_R13 THM_CERT; CORRESPONDENCE.csv regenerated; FAMILY_CERTIFICATE_SPEC_R10 already piecewise (sect 4); ERRATA_R13 E13-1 |
| 261 | 5 | IntroductionのKY floorを (n\ge3) に限定する。 | DONE | main_R13.tex sect 1.2 (\barT def) / sect 1 l.35 / Table 1 / sect 6; proofs/thm_cert.tex; blueprint def:verifier; STATEMENT_FREEZE_R13 item 7; CLAIMS_R13 THM_CERT; CORRESPONDENCE.csv regenerated; FAMILY_CERTIFICATE_SPEC_R10 already piecewise (sect 4); ERRATA_R13 E13-1 |
| 262 | 6 | 比較表のKY floorを修正する。 | DONE | main_R13.tex sect 1.2 (\barT def) / sect 1 l.35 / Table 1 / sect 6; proofs/thm_cert.tex; blueprint def:verifier; STATEMENT_FREEZE_R13 item 7; CLAIMS_R13 THM_CERT; CORRESPONDENCE.csv regenerated; FAMILY_CERTIFICATE_SPEC_R10 already piecewise (sect 4); ERRATA_R13 E13-1 |
| 263 | 7 | `CLAIMS_R13.yaml`を修正する。 | DONE | main_R13.tex sect 1.2 (\barT def) / sect 1 l.35 / Table 1 / sect 6; proofs/thm_cert.tex; blueprint def:verifier; STATEMENT_FREEZE_R13 item 7; CLAIMS_R13 THM_CERT; CORRESPONDENCE.csv regenerated; FAMILY_CERTIFICATE_SPEC_R10 already piecewise (sect 4); ERRATA_R13 E13-1 |
| 264 | 8 | `CORRESPONDENCE.csv`を修正する。 | DONE | main_R13.tex sect 1.2 (\barT def) / sect 1 l.35 / Table 1 / sect 6; proofs/thm_cert.tex; blueprint def:verifier; STATEMENT_FREEZE_R13 item 7; CLAIMS_R13 THM_CERT; CORRESPONDENCE.csv regenerated; FAMILY_CERTIFICATE_SPEC_R10 already piecewise (sect 4); ERRATA_R13 E13-1 |
| 265 | 9 | Certificate format specificationを修正する。 | DONE | main_R13.tex sect 1.2 (\barT def) / sect 1 l.35 / Table 1 / sect 6; proofs/thm_cert.tex; blueprint def:verifier; STATEMENT_FREEZE_R13 item 7; CLAIMS_R13 THM_CERT; CORRESPONDENCE.csv regenerated; FAMILY_CERTIFICATE_SPEC_R10 already piecewise (sect 4); ERRATA_R13 E13-1 |
| 266 | 10 | Leanのabstract theoremをpiecewise floorでinstantiateする。 | DONE | lean/WeberCertFloor.lean: barT, barT_two=68, barT_of_ge_three, barT_seven=4224, barT_two_lt_uniform, barT_le_uniform, t_witness_refutes_saturation_barT — std-3 (compile13_webercertfloor.log, <LOCAL_HOST>) |
| 267 | 11 | (n=2) でBAR=132を主張するcertificateを拒否するnegative controlを作る。 | DONE | nc9 in scripts/family_negctl.sh on certificates/experiments/n2_floor_control/witness_n2_l17.txt (header 132) -> REJECTED; sage/negctl_r13/negctl_r13.log |
| 268 | 12 | (n=2) でBAR=68を認識するunit testを作る。 | DONE | n=2 positive control in family_negctl.sh: bar_T = 68 file EXCLUDED 2/2; same log; pilot n2_pilot_gen_verify.log (l = 17, 41, 97, < 1 s each) |
| 269 | 13 | (n=3) 以降で17-floorを使用するcertificateを拒否する。 | DONE | nc8: n=7 header bar_T = 2176 -> REJECTED (verifier l.29 recomputes); same log |
| 270 | 14 | repository全体をgrepし、誤った`33*2^n`の一般記述を全て列挙する。 | DONE | docs/N2_FLOOR_AUDIT_R13.md (classified grep of the whole package) |
| 271 | 15 | 本文・Blueprint・Lean・verifier間の定数同期テストをCIへ追加する。 | DONE | tools/check_floor_sync.py = verifier step 00b (runs in CI via verify_all_portable.sh); negative control recorded in N2_FLOOR_AUDIT_R13 |
| 272 | 16 | 修正後、Certificate Soundness theoremを再sealする。 | PARTIAL | statement unchanged; re-seal = the r13 seal (after the ruling on the final run) |

### P1 GitHub Actions (GPT 17-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 273 | 17 | elan installerを`$RUNNER_TEMP`内で実行する。 | DONE (unexecuted) | .github/workflows/verify.yml: elan in $RUNNER_TEMP/elan-install; nothing written to the checkout; still never run (no docker / no push) |
| 274 | 18 | checkout内へ`elan.tar.gz`を作らない。 | DONE (unexecuted) | .github/workflows/verify.yml: elan in $RUNNER_TEMP/elan-install; nothing written to the checkout; still never run (no docker / no push) |
| 275 | 19 | checkout内へ`elan-init`を展開しない。 | DONE (unexecuted) | .github/workflows/verify.yml: elan in $RUNNER_TEMP/elan-install; nothing written to the checkout; still never run (no docker / no push) |
| 276 | 20 | setup前後に`git status --porcelain`を検査する。 | DONE (unexecuted) | git status --porcelain asserted before and after setup and after the run in both jobs; manifest --check re-run after Lean setup |
| 277 | 21 | setupがcheckoutを変更した場合はfailさせる。 | DONE (unexecuted) | git status --porcelain asserted before and after setup and after the run in both jobs; manifest --check re-run after Lean setup |
| 278 | 22 | manifestをsetup後にも実行する。 | DONE (unexecuted) | git status --porcelain asserted before and after setup and after the run in both jobs; manifest --check re-run after Lean setup |
| 279 | 23 | Sage jobを実際にGitHub Actionsで走らせる。 | OPEN (DrF, after push) | first real GitHub Actions run; URL / run id / commit SHA -> RELEASE_STATUS.md |
| 280 | 24 | Lean jobを実際に走らせる。 | OPEN (DrF, after push) | first real GitHub Actions run; URL / run id / commit SHA -> RELEASE_STATUS.md |
| 281 | 25 | 両jobを同一commitでgreenにする。 | OPEN (DrF, after push) | first real GitHub Actions run; URL / run id / commit SHA -> RELEASE_STATUS.md |
| 282 | 26 | run URL・run ID・commit SHAを保存する。 | OPEN (DrF, after push) | first real GitHub Actions run; URL / run id / commit SHA -> RELEASE_STATUS.md |
| 283 | 27 | raw verifier log SHAのcross-platform必須比較をやめる。 | DONE | tools/ledger_summary.py (SUMMARY_NORMALIZED.json per run; --compare = verifier step 07b hard gate on verdict/components/witness sha/lines/failed/RHO+T counts/max T upper/min rho upper); raw-log sha256 demoted to forensic in step 07; negative control detected 3 planted differences |
| 284 | 28 | structured normalized summaryを作る。 | DONE | tools/ledger_summary.py (SUMMARY_NORMALIZED.json per run; --compare = verifier step 07b hard gate on verdict/components/witness sha/lines/failed/RHO+T counts/max T upper/min rho upper); raw-log sha256 demoted to forensic in step 07; negative control detected 3 planted differences |
| 285 | 29 | verdict・component count・witness hash・上端値を比較する。 | DONE | tools/ledger_summary.py (SUMMARY_NORMALIZED.json per run; --compare = verifier step 07b hard gate on verdict/components/witness sha/lines/failed/RHO+T counts/max T upper/min rho upper); raw-log sha256 demoted to forensic in step 07; negative control detected 3 planted differences |
| 286 | 30 | raw log hashは任意のforensic fieldへ降格する。 | DONE | tools/ledger_summary.py (SUMMARY_NORMALIZED.json per run; --compare = verifier step 07b hard gate on verdict/components/witness sha/lines/failed/RHO+T counts/max T upper/min rho upper); raw-log sha256 demoted to forensic in step 07; negative control detected 3 planted differences |
| 287 | 31 | Docker clean cloneでも同じverificationを行う。 | OPEN (DrF, after push) | docker absent on every author machine |
| 288 | 32 | working tree cleanをhard gateにする。 | DONE (unexecuted) | porcelain gate in verify.yml |
| 289 | 33 | CI成功後に一切編集しないrelease protocolを文書化する。 | DONE | RELEASE_STATUS.md r13 protocol block (freeze -> full verifier -> no edit -> tag); HANDOFF rule |
| 290 | 34 | 編集した場合は全verificationを再実行する。 | DONE | RELEASE_STATUS.md r13 protocol block (freeze -> full verifier -> no edit -> tag); HANDOFF rule |
| 291 | 35 | final green logsをrelease assetに含める。 | OPEN (DrF, after push) | CI logs and environment values exist only after the first run |
| 292 | 36 | CIのenvironment実測値をmetadataへ入れる。 | OPEN (DrF, after push) | CI logs and environment values exist only after the first run |

### P2 Blueprint (GPT 37-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 293 | 37 | kernel noteだけのFノードを全件列挙する。 | DONE | five nodes listed: lem:A, thm:Acore, lem:C7int, lem:Sineq, thm:certcore (blueprint/check_graph.py negative control shows the r12 state as HUMAN-PROOF MISSING) |
| 294 | 38 | bridge nodeに自然言語証明を追加する。 | DONE | proofs/lem_A.tex (existing) now \input by the Blueprint; new proofs/thm_Acore.tex, lem_C7int.tex, lem_Sineq.tex, thm_certcore.tex, each mirroring the Lean proof step by step |
| 295 | 39 | Theorem A discrete coreに自然言語証明を追加する。 | DONE | proofs/lem_A.tex (existing) now \input by the Blueprint; new proofs/thm_Acore.tex, lem_C7int.tex, lem_Sineq.tex, thm_certcore.tex, each mirroring the Lean proof step by step |
| 296 | 40 | (C_7) integer comparisonに自然言語証明を追加する。 | DONE | proofs/lem_A.tex (existing) now \input by the Blueprint; new proofs/thm_Acore.tex, lem_C7int.tex, lem_Sineq.tex, thm_certcore.tex, each mirroring the Lean proof step by step |
| 297 | 41 | S analytic inequalityに自然言語証明を追加する。 | DONE | proofs/lem_A.tex (existing) now \input by the Blueprint; new proofs/thm_Acore.tex, lem_C7int.tex, lem_Sineq.tex, thm_certcore.tex, each mirroring the Lean proof step by step |
| 298 | 42 | certificate direct chainに自然言語証明を追加する。 | DONE | proofs/lem_A.tex (existing) now \input by the Blueprint; new proofs/thm_Acore.tex, lem_C7int.tex, lem_Sineq.tex, thm_certcore.tex, each mirroring the Lean proof step by step |
| 299 | 43 | 各FノードにLean theoremと完全なprose proofの双方を要求する。 | DONE | check_graph.py human-proof gate: every F/M node must carry a real proof body (not a kernel note); PASS on 48 nodes; negative control FAILs |
| 300 | 44 | 各Mノードに完全なprose proofを要求する。 | DONE | check_graph.py human-proof gate: every F/M node must carry a real proof body (not a kernel note); PASS on 48 nodes; negative control FAILs |
| 301 | 45 | 各Lノードに文献・定理番号・ページ・source hashを要求する。 | PARTIAL | each L node cites source + theorem number + page; source hashes are in the SOURCES block of content.tex / PHASE_MINUS1_INTEGRATED_AUDIT_R10 part (c), not repeated per node |
| 302 | 46 | 各Cノードにcertificate schema・checker versionを要求する。 | PARTIAL | C nodes name the verifier sha256 0f38bb0d (r11); no certificate format version yet (hw 81-82 -> R14) |
| 303 | 47 | `proof-completeness gate`を`evidence-presence gate`へ改名する。 | DONE | check_graph.py output: EVIDENCE-PRESENCE + HUMAN-PROOF; verify step 10 string updated |
| 304 | 48 | human-proof completenessを別metadataで管理する。 | DONE | same gate (separate rule in check_graph.py; release FAILs on a kernel-note-only F/M proof) |
| 305 | 49 | proofが単なる“kernel-checked”一文ならreleaseをfailさせる。 | DONE | same gate (separate rule in check_graph.py; release FAILs on a kernel-note-only F/M proof) |
| 306 | 50 | Paperのproof capsuleとBlueprintのcomplete proofを明確に区別する。 | DONE (by design) | proofs/README.md: no separate capsule — the paper \inputs the same complete proof bodies (ruling R7) |
| 307 | 51 | Blueprint PDFにtrust legendを入れる。 | DONE | blueprint/src/print.tex: trust legend on p.1; commit/tag pointer to RELEASE_STATUS.md (a document cannot contain its own hash) |
| 308 | 52 | Blueprint PDFにcommit SHAを入れる。 | DONE | blueprint/src/print.tex: trust legend on p.1; commit/tag pointer to RELEASE_STATUS.md (a document cannot contain its own hash) |
| 309 | 53 | orphan experiment nodesを意図的non-theorem nodeとして明示する。 | DONE | content.tex header comment + node titles: exp:class1 / exp:svp intentional non-theorem nodes |
| 310 | 54 | Blueprint web版を作る場合も同じ正本から生成する。 | OPEN | web build (web.tex / plasTeX) not rebuilt this round; \path in proofs may need the url package under plasTeX — check before the next web build |
| 311 | 55 | Blueprintの全ノードを第三者がコードなしで追えるか人間レビューする。 | OPEN (DrF) | third-party Blueprint read (= hw 191 family) |

### P3 Theorem Aの最終監査 (GPT 56-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 312 | 56 | KY Proposition 4.1からLemma Eへの翻訳を独立数論家へ送る。 | OPEN (DrF) | Theorem A external audit: independent number theorist; per-lemma items 57-67 are claude candidates for R14 after the external reader is chosen |
| 313 | 57 | (A_n^{1/\ell}/A_n) の定義を明記する。 | OPEN (DrF) | Theorem A external audit: independent number theorist; per-lemma items 57-67 are claude candidates for R14 after the external reader is chosen |
| 314 | 58 | (M_f) からformal rootへの写像を型付きで書く。 | OPEN (DrF) | Theorem A external audit: independent number theorist; per-lemma items 57-67 are claude candidates for R14 after the external reader is chosen |
| 315 | 59 | formal rootとそのcosetを区別する。 | OPEN (DrF) | Theorem A external audit: independent number theorist; per-lemma items 57-67 are claude candidates for R14 after the external reader is chosen |
| 316 | 60 | (a\mapsto a+\ell b) によるrepresentative変更を独立補題にする。 | OPEN (DrF) | Theorem A external audit: independent number theorist; per-lemma items 57-67 are claude candidates for R14 after the external reader is chosen |
| 317 | 61 | cosetが (RE_n^+/A_n) に入ることから、代表元がrelative unitになる過程を完全に書く。 | OPEN (DrF) | Theorem A external audit: independent number theorist; per-lemma items 57-67 are claude candidates for R14 after the external reader is chosen |
| 318 | 62 | base branchを独立補題にする。 | OPEN (DrF) | Theorem A external audit: independent number theorist; per-lemma items 57-67 are claude candidates for R14 after the external reader is chosen |
| 319 | 63 | non-base branchを独立補題にする。 | OPEN (DrF) | Theorem A external audit: independent number theorist; per-lemma items 57-67 are claude candidates for R14 after the external reader is chosen |
| 320 | 64 | Blichfeldt原定理のGamma定数を再確認する。 | OPEN (DrF) | Theorem A external audit: independent number theorist; per-lemma items 57-67 are claude candidates for R14 after the external reader is chosen |
| 321 | 65 | MOで使用された正規化との一致を確認する。 | OPEN (DrF) | Theorem A external audit: independent number theorist; per-lemma items 57-67 are claude candidates for R14 after the external reader is chosen |
| 322 | 66 | (D_n/\ell^{d_f}) のcovolumeを第二経路で証明する。 | OPEN (DrF) | Theorem A external audit: independent number theorist; per-lemma items 57-67 are claude candidates for R14 after the external reader is chosen |
| 323 | 67 | (n=2,3) の小さいケースでindexとcovolumeを直接計算する。 | OPEN (DrF) | Theorem A external audit: independent number theorist; per-lemma items 57-67 are claude candidates for R14 after the external reader is chosen |
| 324 | 68 | 外部コメントと修正履歴をartifactへ保存する。 | OPEN (DrF) | Theorem A external audit: independent number theorist; per-lemma items 57-67 are claude candidates for R14 after the external reader is chosen |
| 325 | 69 | 外部監査完了まで定理を“fully audited”と呼ばない。 | OPEN (DrF) | Theorem A external audit: independent number theorist; per-lemma items 57-67 are claude candidates for R14 after the external reader is chosen |

### P4 Proposition D (GPT 70-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 326 | 70 | Washingtonの定理番号をphysical copyで確定する。 | OPEN (DrF) | Prop D items; 70 = Washington physical copy (hw 29) |
| 327 | 71 | (\chi)／(\bar\chi) の規約を記す。 | OPEN | Prop D items; 70 = Washington physical copy (hw 29) |
| 328 | 72 | Gauss sumの規約を記す。 | OPEN | Prop D items; 70 = Washington physical copy (hw 29) |
| 329 | 73 | half-sum normalizationを完全証明する。 | OPEN | Prop D items; 70 = Washington physical copy (hw 29) |
| 330 | 74 | conductorがexactly (2^{n+2}) である成分を明記する。 | OPEN | Prop D items; 70 = Washington physical copy (hw 29) |
| 331 | 75 | (\prod\|1-\chi(3)\|=2) を独立補題にする。 | DONE (evidence) | blueprint lem:prod13 + proofs/lem_prod13.tex (r12) — already an independent lemma |
| 332 | 76 | digamma公式の一次資料を引用する。 | OPEN | Prop D items; 70 = Washington physical copy (hw 29) |
| 333 | 77 | (n=2,\ldots,9) のball enclosureをJSON化する。 | OPEN | Prop D items; 70 = Washington physical copy (hw 29) |
| 334 | 78 | 数値表をcertificateから自動生成する。 | OPEN | Prop D items; 70 = Washington physical copy (hw 29) |
| 335 | 79 | 漸近主張を追加しない。 | OPEN | Prop D items; 70 = Washington physical copy (hw 29) |
| 336 | 80 | cyclotomic fieldの専門家へProp Dだけを読ませる。 | OPEN (DrF) | Prop D items; 70 = Washington physical copy (hw 29) |

### P5 Certificate verifier (GPT 81-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 337 | 81 | certificate format versionを導入する。 | OPEN (R14) | certificate format version / second verifier: touches scripts/family_verify.sage (sha256 0f38bb0d frozen through r13 by ruling R4) |
| 338 | 82 | 未知versionを拒否する。 | OPEN (R14) | certificate format version / second verifier: touches scripts/family_verify.sage (sha256 0f38bb0d frozen through r13 by ruling R4) |
| 339 | 83 | piecewise (\bar T_n) をderived fieldにする。 | OPEN (R14) | certificate format version / second verifier: touches scripts/family_verify.sage (sha256 0f38bb0d frozen through r13 by ruling R4) |
| 340 | 84 | certificate headerから任意のBARを信用しない。 | DONE (evidence) | family_verify.sage l.28-29: BAR recomputed from n; header bar_T != BAR is fatal (nc7/nc8/nc9 all REJECTED) |
| 341 | 85 | nからverifierがfloorを計算する。 | DONE (evidence) | same lines |
| 342 | 86 | malformed lineを無視せず拒否する。 | DONE (evidence) | malformed lines: verifier l.20 FATAL on a bad header; a line that fails any check is a failed line -> NOT_EXCLUDED (nc1-nc5) |
| 343 | 87 | factor数・route数・重複を検査する。 | OPEN (R14) | certificate format version / second verifier: touches scripts/family_verify.sage (sha256 0f38bb0d frozen through r13 by ruling R4) |
| 344 | 88 | witness line countを検査する。 | OPEN (R14) | certificate format version / second verifier: touches scripts/family_verify.sage (sha256 0f38bb0d frozen through r13 by ruling R4) |
| 345 | 89 | missing factor negative controlを追加する。 | OPEN (R14) | certificate format version / second verifier: touches scripts/family_verify.sage (sha256 0f38bb0d frozen through r13 by ruling R4) |
| 346 | 90 | duplicate factor negative controlを追加する。 | OPEN (R14) | certificate format version / second verifier: touches scripts/family_verify.sage (sha256 0f38bb0d frozen through r13 by ruling R4) |
| 347 | 91 | wrong target-list negative controlを追加する。 | OPEN (R14) | certificate format version / second verifier: touches scripts/family_verify.sage (sha256 0f38bb0d frozen through r13 by ruling R4) |
| 348 | 92 | n=2 threshold negative controlを追加する。 | DONE | = nc9 |
| 349 | 93 | structured JSON summaryを出力する。 | DONE | tools/ledger_summary.py SUMMARY_NORMALIZED.json (post-processor; verifier unchanged) |
| 350 | 94 | verifier version/hashをsummaryへ入れる。 | PARTIAL | ledger header carries the verifier sha256; the JSON summary does not yet repeat it (R14 with the format version) |
| 351 | 95 | 第二の単純verifierで少数primeをcross-checkする。 | OPEN (R14) | certificate format version / second verifier: touches scripts/family_verify.sage (sha256 0f38bb0d frozen through r13 by ruling R4) |
| 352 | 96 | specの各条項と実装行番号の対応表を作る。 | OPEN (R14) | certificate format version / second verifier: touches scripts/family_verify.sage (sha256 0f38bb0d frozen through r13 by ruling R4) |

### P6 主張・文章・視覚 (GPT 97-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 353 | 97 | AI disclosureを正確に書き直す。 | DONE | main_R13.tex sect 9 AI disclosure rewritten (M route named) |
| 354 | 98 | “clean verification”をlocal full read-only verificationへ変更する。 | DONE | Table 5: "local full read-only verification" |
| 355 | 99 | clean CI成功後だけclean-checkout replayと書く。 | DONE | sect 9: "no clean-checkout replay is claimed" until a real run exists |
| 356 | 100 | 任意有限区間への8–20秒外挿を削除する。 | DONE | sect 2.2: extrapolation deleted; 8-20 s stated for the tested interval only |
| 357 | 101 | 実測1000素数範囲だけの性能として記述する。 | DONE | sect 2.2: extrapolation deleted; 8-20 s stated for the tested interval only |
| 358 | 102 | Washingtonの“effective”の表現を正確にする。 | DONE (evidence) | main_R13 l.33 and Table 1 already say "effective in principle, no numerical bound" — nothing to change |
| 359 | 103 | novelty word freezeを維持する。 | DONE | word freeze line 4 of main_R13.tex still in force; hw 122 OPEN |
| 360 | 104 | stale R7–R11 filesをarchiveへ移す。 | DONE | archive/rounds/r6..r12 (48 files moved; archive/rounds/MOVE_LOG_R13.txt; archive/README.md) |
| 361 | 105 | submission rootを簡潔にする。 | DONE | archive/rounds/r6..r12 (48 files moved; archive/rounds/MOVE_LOG_R13.txt; archive/README.md) |
| 362 | 106 | hyperref boxを消す。 | DONE | \usepackage[hidelinks]{hyperref} |
| 363 | 107 | overfull hboxを修正する。 | PARTIAL | overfull hbox 37 -> 15 (paths via \path, two wide tables at \footnotesize, Lean names moved out of theorem titles); residue = Table 1 (85pt), the C_7 ball lemma (long number), one App D proof, one Table 4 row — listed for the polish pass |
| 364 | 108 | 長いpathを`\path`または対応表へ送る。 | DONE | \path{...} for every file path and Lean name in body text (not in captions / theorem titles) |
| 365 | 109 | 密な表を簡略化する。 | PARTIAL | Tables 1 and 4 reduced to \footnotesize; no column restructuring |
| 366 | 110 | PDF metadata、keywords、MSCを追加する。 | DONE | \subjclass[2020]{11R18, 11R29; 11H06, 11Y40}, \keywords, \hypersetup pdftitle/author/keywords (MSC codes to be confirmed by Dr. Fukui) |
| 367 | 111 | class 1 E資料を本文に残すかAppendixへ送るか再判断する。 | OPEN (DrF) | class-1 E material placement; proof-guide logic stays in the body (current state) |
| 368 | 112 | proof guideとしての主要論理は本文に残す。 | OPEN (DrF) | class-1 E material placement; proof-guide logic stays in the body (current state) |

### P7 seal・Zenodo・外部監査 (GPT 113-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 369 | 113 | MathSciNetでnovelty監査を完了する。 | OPEN (DrF) | MathSciNet (subscription) |
| 370 | 114 | zbMATHで監査する。 | OPEN (DrF) | release / external audit; 114 partly automatable with zbmath_search (proposed) |
| 371 | 115 | KYとMOの両方を引用する後続論文を確認する。 | OPEN (DrF) | release / external audit; 114 partly automatable with zbmath_search (proposed) |
| 372 | 116 | 可能ならKY／MO著者へpreprintを送る。 | OPEN (DrF) | release / external audit; 114 partly automatable with zbmath_search (proposed) |
| 373 | 117 | novelty matrixを最終化する。 | OPEN (DrF) | release / external audit; 114 partly automatable with zbmath_search (proposed) |
| 374 | 118 | `CITATION.cff`を完成する。 | OPEN | CITATION.cff draft — R13 candidate (not yet written) |
| 375 | 119 | `.zenodo.json`を同期する。 | OPEN | .zenodo.json draft — R13 candidate (not yet written) |
| 376 | 120 | version固有DOIを予約する。 | OPEN (DrF) | release / external audit; 114 partly automatable with zbmath_search (proposed) |
| 377 | 121 | 本文にDOIとcommit SHAを記載する。 | OPEN (DrF) | release / external audit; 114 partly automatable with zbmath_search (proposed) |
| 378 | 122 | exact final commitをfreezeする。 | OPEN (DrF) | release / external audit; 114 partly automatable with zbmath_search (proposed) |
| 379 | 123 | full verifierを実行する。 | OPEN (DrF) | release / external audit; 114 partly automatable with zbmath_search (proposed) |
| 380 | 124 | green CIを確認する。 | OPEN (DrF) | release / external audit; 114 partly automatable with zbmath_search (proposed) |
| 381 | 125 | third-party clean clone replayを行う。 | OPEN (DrF) | release / external audit; 114 partly automatable with zbmath_search (proposed) |
| 382 | 126 | 以後一切編集しない。 | OPEN (DrF) | release / external audit; 114 partly automatable with zbmath_search (proposed) |
| 383 | 127 | immutable tagを作る。 | OPEN (DrF) | release / external audit; 114 partly automatable with zbmath_search (proposed) |
| 384 | 128 | source・paper・Blueprint・certificates・verifier・CI logsをreleaseする。 | OPEN (DrF) | release / external audit; 114 partly automatable with zbmath_search (proposed) |
| 385 | 129 | GitHub／Zenodoのasset hashを一致させる。 | OPEN (DrF) | release / external audit; 114 partly automatable with zbmath_search (proposed) |
| 386 | 130 | old proof-search archiveは別assetまたは別recordにする。 | OPEN (DrF) | release / external audit; 114 partly automatable with zbmath_search (proposed) |

Next-round hard gates (GPT r12, 15): 1 n=2 certificate floor fixed in every medium; 2 n=2 negative control; 3 piecewise floor Lean/spec sync; 4 elan installer outside the checkout; 5 Sage CI green; 6 Lean CI green; 7 checkout mutation 0; 8 normalized log comparison; 9 human-readable proofs for all F/M nodes; 10 Washington citation fixed; 11 external number-theorist review of Thm A; 12 full verifier on the final commit; 13 no edit after the verifier; 14 submission PDF visual cleanup; 15 stale active files archived.

## R14 — GPT r13 review (Weberレビュー.txt md5 94c890e915a8d63fe3929daae97d5b68, 26773 B, read 2026-08-26). GPT numbering 1-138 -> tracker 387-524. All OPEN at entry; statuses set 2026-08-26 02:40 from on-disk artifacts (DONE 88 / PARTIAL 10 / OPEN(DrF) 32 / OPEN 8). Overall: GO for the paper (Thm A / KY1000 / general-n paper), NO-GO to fix/post r13 as is; no new mathematics; new scope error = C_7 display value (35 digits) carrying the 2.2e-115 ball radius (GPT sect 2), plus 7/9 negative-control desync (sect 4), Magma "inside ball" tolerance 1e10 (sect 3), verifier PASS on skip (sect 5). Re-derived on <LOCAL_HOST> 2026-08-26 before entry: C_7 true digits ...834054033045619... x 10^30 (500-bit ball, rad 2.167e-115), displayed value lies 5.4033e-6 outside the ball [MC]; 6 media carry the display (paper l.67/357, blueprint content.tex 214, FREEZE_R13 91, CLAIMS_R13 94, CORRESPONDENCE 14); JSON C_lo==C_hi in all 8 rows (RealField(120) print) [MC]; 1e10 clause at r11_propD_audit.sage l.83 [MC]; stale "7": content.tex 297, main_R13.tex 246 (l.259 says 9/9), TRUST.md 21, FREEZE_R13 145 [MC]; verify_all_portable.sh l.300 prints PASS iff FAIL==0 and SKIP never sets FAIL [MC].


### P0 (C_7) 緊急修正 (GPT 1-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 387 | 1 | 本文中の (C_7) 表示値と誤差半径を削除する。 | DONE | main_R14 Cor 7 / Lemma C7; content.tex lem:C7; CLAIMS_R14 C7_ENCLOSURE; STATEMENT_FREEZE_R14 item 5; CORRESPONDENCE.csv (r14); display = 38-digit truncation, no radius; step 00c forbids the old forms |
| 388 | 2 | Blueprint中の同じ表示を削除する。 | DONE | main_R14 Cor 7 / Lemma C7; content.tex lem:C7; CLAIMS_R14 C7_ENCLOSURE; STATEMENT_FREEZE_R14 item 5; CORRESPONDENCE.csv (r14); display = 38-digit truncation, no radius; step 00c forbids the old forms |
| 389 | 3 | `CLAIMS_R13.yaml`の同じ表示を修正する。 | DONE | main_R14 Cor 7 / Lemma C7; content.tex lem:C7; CLAIMS_R14 C7_ENCLOSURE; STATEMENT_FREEZE_R14 item 5; CORRESPONDENCE.csv (r14); display = 38-digit truncation, no radius; step 00c forbids the old forms |
| 390 | 4 | `STATEMENT_FREEZE_R13.md`を修正する。 | DONE | main_R14 Cor 7 / Lemma C7; content.tex lem:C7; CLAIMS_R14 C7_ENCLOSURE; STATEMENT_FREEZE_R14 item 5; CORRESPONDENCE.csv (r14); display = 38-digit truncation, no radius; step 00c forbids the old forms |
| 391 | 5 | `CORRESPONDENCE.csv`を修正する。 | DONE | main_R14 Cor 7 / Lemma C7; content.tex lem:C7; CLAIMS_R14 C7_ENCLOSURE; STATEMENT_FREEZE_R14 item 5; CORRESPONDENCE.csv (r14); display = 38-digit truncation, no radius; step 00c forbids the old forms |
| 392 | 6 | `C_lo`と`C_hi`をfull precisionでJSONへ保存する。 | DONE | certificates/constants/Cn_interval_r14.json (format 2): C_lo/C_hi 160 digits outward, C_mid, radius_upper, prec_bits 500, endpoint_rounding; asserted lo!=hi, lo<hi (sage/r14_cn_interval.sage + tools/gen_cn_certs.py --check) |
| 393 | 7 | midpointとradiusを別fieldにする。 | DONE | certificates/constants/Cn_interval_r14.json (format 2): C_lo/C_hi 160 digits outward, C_mid, radius_upper, prec_bits 500, endpoint_rounding; asserted lo!=hi, lo<hi (sage/r14_cn_interval.sage + tools/gen_cn_certs.py --check) |
| 394 | 8 | precision bitsを保存する。 | DONE | certificates/constants/Cn_interval_r14.json (format 2): C_lo/C_hi 160 digits outward, C_mid, radius_upper, prec_bits 500, endpoint_rounding; asserted lo!=hi, lo<hi (sage/r14_cn_interval.sage + tools/gen_cn_certs.py --check) |
| 395 | 9 | rounding modeを保存する。 | DONE | certificates/constants/Cn_interval_r14.json (format 2): C_lo/C_hi 160 digits outward, C_mid, radius_upper, prec_bits 500, endpoint_rounding; asserted lo!=hi, lo<hi (sage/r14_cn_interval.sage + tools/gen_cn_certs.py --check) |
| 396 | 10 | lower／upper endpointが異なる文字列になることをassertする。 | DONE | certificates/constants/Cn_interval_r14.json (format 2): C_lo/C_hi 160 digits outward, C_mid, radius_upper, prec_bits 500, endpoint_rounding; asserted lo!=hi, lo<hi (sage/r14_cn_interval.sage + tools/gen_cn_certs.py --check) |
| 397 | 11 | lower < upperをassertする。 | DONE | certificates/constants/Cn_interval_r14.json (format 2): C_lo/C_hi 160 digits outward, C_mid, radius_upper, prec_bits 500, endpoint_rounding; asserted lo!=hi, lo<hi (sage/r14_cn_interval.sage + tools/gen_cn_certs.py --check) |
| 398 | 12 | paper用の丸め値をcertificateから自動生成する。 | DONE | fields display / display_truncation_error_bound generated by sage/r14_cn_interval.sage; radius never attached to the display |
| 399 | 13 | 表示桁に対応した丸め誤差を自動計算する。 | DONE | fields display / display_truncation_error_bound generated by sage/r14_cn_interval.sage; radius never attached to the display |
| 400 | 14 | tiny ball radiusを短い表示値へ直接付けない。 | DONE | fields display / display_truncation_error_bound generated by sage/r14_cn_interval.sage; radius never attached to the display |
| 401 | 15 | safe integer thresholdをcertificateから再生成する。 | DONE | thresholds NOT regenerated (frozen std-3 integers in lean/WeberR6.lean); asserted C_7^+ < T1 and < 1314283897427173^2 inside the certificate; provenance T1 = r6 PREC-256 upper + 1 documented |
| 402 | 16 | thresholdが修正前後で不変であることをassertする。 | DONE | gen_cn_certs.py --check: frozen r6 thresholds unchanged (negative control NC4) |
| 403 | 17 | C7表示をgrepし、全媒体の一致を確認する。 | DONE | tools/check_constant_sync.py = verifier step 00c (every profile); --selftest 8/8; tools/negctl_tools_r14.py 13/13 (step 00d) |
| 404 | 18 | `check_constant_sync.py`を作る。 | DONE | tools/check_constant_sync.py = verifier step 00c (every profile); --selftest 8/8; tools/negctl_tools_r14.py 13/13 (step 00d) |
| 405 | 19 | CIでconstant syncをhard gateにする。 | DONE | tools/check_constant_sync.py = verifier step 00c (every profile); --selftest 8/8; tools/negctl_tools_r14.py 13/13 (step 00d) |
| 406 | 20 | R13の誤表記を`ERRATA_R14.md`に記録する。 | DONE | docs/ERRATA_R14.md E14-1 (all 8 rows of the r12 JSON, not only n=7) |

### P1 Magma／cross-CAS監査 (GPT 21-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 407 | 21 | `abs(Magma-up)<1e10`を削除する。 | DONE | sage/r14_cross_cas_audit.sage -> certificates/constants/C7_cross_cas_r14.json; step 04d; E14-3 |
| 408 | 22 | “inside ball”という表現を削除する。 | DONE | sage/r14_cross_cas_audit.sage -> certificates/constants/C7_cross_cas_r14.json; step 04d; E14-3 |
| 409 | 23 | Magma outputの保証桁数を明示する。 | DONE | sage/r14_cross_cas_audit.sage -> certificates/constants/C7_cross_cas_r14.json; step 04d; E14-3 |
| 410 | 24 | truncated decimal agreementとinterval inclusionを分離する。 | DONE | sage/r14_cross_cas_audit.sage -> certificates/constants/C7_cross_cas_r14.json; step 04d; E14-3 |
| 411 | 25 | Magma値の丸め区間を構成する。 | DONE | sage/r14_cross_cas_audit.sage -> certificates/constants/C7_cross_cas_r14.json; step 04d; E14-3 |
| 412 | 26 | Sage ballとMagma intervalのintersectionを検査する。 | DONE | sage/r14_cross_cas_audit.sage -> certificates/constants/C7_cross_cas_r14.json; step 04d; E14-3 |
| 413 | 27 | PARI routeについても同じ形式にする。 | PARTIAL | PARI: 200-bit ln D_7 inside the r6 256-bit rigorous interval; no PARI C_7 interval (only ln D_7 printed at 200 bits); 60-digit run discrepancy 4.6e-17 recorded, trust LOW |
| 414 | 28 | cross-CAS resultをstructured JSONにする。 | DONE | structured JSON per route with trust level; cross-CAS labelled numerical audit (E), not part of the C certificate (paper sect 5.2, CLAIMS_R14 status) |
| 415 | 29 | 各routeのtrust levelを明示する。 | DONE | structured JSON per route with trust level; cross-CAS labelled numerical audit (E), not part of the C certificate (paper sect 5.2, CLAIMS_R14 status) |
| 416 | 30 | cross-CASはCではなくindependent numerical auditであることを明記する。 | DONE | structured JSON per route with trust level; cross-CAS labelled numerical audit (E), not part of the C certificate (paper sect 5.2, CLAIMS_R14 status) |

### P2 全媒体同期 (GPT 31-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 417 | 31 | negative controlsの正本を単一JSONへ置く。 | DONE | certificates/negctl/negctl_ledger_r14.json (tools/gen_negctl_ledger.py); content.tex 297, TRUST 21, FREEZE_R14 145, main_R14 246 fixed; RELEASE_STATUS r14 block; E14-2 |
| 418 | 32 | 正しい件数9をそのJSONから取得する。 | DONE | certificates/negctl/negctl_ledger_r14.json (tools/gen_negctl_ledger.py); content.tex 297, TRUST 21, FREEZE_R14 145, main_R14 246 fixed; RELEASE_STATUS r14 block; E14-2 |
| 419 | 33 | Blueprintの7/7を修正する。 | DONE | certificates/negctl/negctl_ledger_r14.json (tools/gen_negctl_ledger.py); content.tex 297, TRUST 21, FREEZE_R14 145, main_R14 246 fixed; RELEASE_STATUS r14 block; E14-2 |
| 420 | 34 | `TRUST.md`のSevenを修正する。 | DONE | certificates/negctl/negctl_ledger_r14.json (tools/gen_negctl_ledger.py); content.tex 297, TRUST 21, FREEZE_R14 145, main_R14 246 fixed; RELEASE_STATUS r14 block; E14-2 |
| 421 | 35 | `STATEMENT_FREEZE_R13.md`の7を修正する。 | DONE | certificates/negctl/negctl_ledger_r14.json (tools/gen_negctl_ledger.py); content.tex 297, TRUST 21, FREEZE_R14 145, main_R14 246 fixed; RELEASE_STATUS r14 block; E14-2 |
| 422 | 36 | release statusの旧7表記を修正する。 | DONE | certificates/negctl/negctl_ledger_r14.json (tools/gen_negctl_ledger.py); content.tex 297, TRUST 21, FREEZE_R14 145, main_R14 246 fixed; RELEASE_STATUS r14 block; E14-2 |
| 423 | 37 | 本文、README、Blueprintを自動生成する。 | PARTIAL | not generated: checked against the ledger by step 00c (required forms + forbidden stale forms) |
| 424 | 38 | `check_claim_sync.py`を拡張する。 | DONE | realised as tools/check_constant_sync.py (new tool rather than an extension of check_claim_sync) |
| 425 | 39 | negative-control件数を同期対象にする。 | DONE | step 00c: negctl count, C_7 display digits, KY1000 1000/1000, T 32000, RHO 31987, max T 4164.4897, margin 59.5103, median 2352.0117 |
| 426 | 40 | C7 digits／radiusを同期対象にする。 | DONE | step 00c: negctl count, C_7 display digits, KY1000 1000/1000, T 32000, RHO 31987, max T 4164.4897, margin 59.5103, median 2352.0117 |
| 427 | 41 | KY1000件数を同期対象にする。 | DONE | step 00c: negctl count, C_7 display digits, KY1000 1000/1000, T 32000, RHO 31987, max T 4164.4897, margin 59.5103, median 2352.0117 |
| 428 | 42 | T certificate件数を同期対象にする。 | DONE | step 00c: negctl count, C_7 display digits, KY1000 1000/1000, T 32000, RHO 31987, max T 4164.4897, margin 59.5103, median 2352.0117 |
| 429 | 43 | RHO certificate件数を同期対象にする。 | DONE | step 00c: negctl count, C_7 display digits, KY1000 1000/1000, T 32000, RHO 31987, max T 4164.4897, margin 59.5103, median 2352.0117 |
| 430 | 44 | max Tとmarginを同期対象にする。 | DONE | step 00c: negctl count, C_7 display digits, KY1000 1000/1000, T 32000, RHO 31987, max T 4164.4897, margin 59.5103, median 2352.0117 |
| 431 | 45 | trust labelsを同期対象にする。 | PARTIAL | trust labels: claims step 13 + blueprint map 13b (r13); not in 00c |
| 432 | 46 | theorem numberingを同期対象にする。 | PARTIAL | theorem numbering: blueprint map 13b (r13); not in 00c |
| 433 | 47 | stale “7/7”が一件でもあればCIを失敗させる。 | DONE | step 00c forbids 7/7 in negative-control context; NC11 / selftest |
| 434 | 48 | `THM_CERT`の本文定理番号を再確認する。 | OPEN | THM_CERT paper location to re-read after the r14 PDF (not re-checked in r14) |

### P3 strict verifier (GPT 49-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 435 | 49 | `VERIFY_PROFILE=full`を導入する。 | DONE | scripts/verify_all_portable.sh r14: VERIFY_PROFILE=full/sage/lean, precheck + skip(); SUMMARY.json skips/fails; partial profiles print SAGE_PROFILE / LEAN_PROFILE only; E14-4 |
| 436 | 50 | full profileではSageのskipをFAILにする。 | DONE | scripts/verify_all_portable.sh r14: VERIFY_PROFILE=full/sage/lean, precheck + skip(); SUMMARY.json skips/fails; partial profiles print SAGE_PROFILE / LEAN_PROFILE only; E14-4 |
| 437 | 51 | full profileではLeanのskipをFAILにする。 | DONE | scripts/verify_all_portable.sh r14: VERIFY_PROFILE=full/sage/lean, precheck + skip(); SUMMARY.json skips/fails; partial profiles print SAGE_PROFILE / LEAN_PROFILE only; E14-4 |
| 438 | 52 | full profileではpaper／BlueprintのskipをFAILにする。 | DONE | scripts/verify_all_portable.sh r14: VERIFY_PROFILE=full/sage/lean, precheck + skip(); SUMMARY.json skips/fails; partial profiles print SAGE_PROFILE / LEAN_PROFILE only; E14-4 |
| 439 | 53 | `VERIFY_PROFILE=sage`を導入する。 | DONE | scripts/verify_all_portable.sh r14: VERIFY_PROFILE=full/sage/lean, precheck + skip(); SUMMARY.json skips/fails; partial profiles print SAGE_PROFILE / LEAN_PROFILE only; E14-4 |
| 440 | 54 | sage profileでは`SAGE_PROFILE PASS`だけを表示する。 | DONE | scripts/verify_all_portable.sh r14: VERIFY_PROFILE=full/sage/lean, precheck + skip(); SUMMARY.json skips/fails; partial profiles print SAGE_PROFILE / LEAN_PROFILE only; E14-4 |
| 441 | 55 | `VERIFY_PROFILE=lean`を導入する。 | DONE | scripts/verify_all_portable.sh r14: VERIFY_PROFILE=full/sage/lean, precheck + skip(); SUMMARY.json skips/fails; partial profiles print SAGE_PROFILE / LEAN_PROFILE only; E14-4 |
| 442 | 56 | lean profileでは`LEAN_PROFILE PASS`だけを表示する。 | DONE | scripts/verify_all_portable.sh r14: VERIFY_PROFILE=full/sage/lean, precheck + skip(); SUMMARY.json skips/fails; partial profiles print SAGE_PROFILE / LEAN_PROFILE only; E14-4 |
| 443 | 57 | partial runで`FULL PASS`を絶対に表示しない。 | DONE | scripts/verify_all_portable.sh r14: VERIFY_PROFILE=full/sage/lean, precheck + skip(); SUMMARY.json skips/fails; partial profiles print SAGE_PROFILE / LEAN_PROFILE only; E14-4 |
| 444 | 58 | skip数をstructured summaryに入れる。 | DONE | scripts/verify_all_portable.sh r14: VERIFY_PROFILE=full/sage/lean, precheck + skip(); SUMMARY.json skips/fails; partial profiles print SAGE_PROFILE / LEAN_PROFILE only; E14-4 |
| 445 | 59 | skip > 0ならfull statusをFAILにする。 | DONE | scripts/verify_all_portable.sh r14: VERIFY_PROFILE=full/sage/lean, precheck + skip(); SUMMARY.json skips/fails; partial profiles print SAGE_PROFILE / LEAN_PROFILE only; E14-4 |
| 446 | 60 | final aggregator jobを作る。 | DONE | verify.yml job full (needs sage, lean): FULL VERIFICATION only from both profile PASSes; written, NOT executed |
| 447 | 61 | Sage／Lean両jobのgreen証明をaggregatorが確認する。 | DONE | verify.yml job full (needs sage, lean): FULL VERIFICATION only from both profile PASSes; written, NOT executed |
| 448 | 62 | aggregatorだけが`FULL VERIFICATION PASS`を出す。 | DONE | verify.yml job full (needs sage, lean): FULL VERIFICATION only from both profile PASSes; written, NOT executed |
| 449 | 63 | raw log hashをhard gateから外す。 | DONE | r13 (07b normalized compare; raw-log sha forensic); unchanged |
| 450 | 64 | normalized JSON summaryをhard gateにする。 | DONE | r13 (07b normalized compare; raw-log sha forensic); unchanged |
| 451 | 65 | raw logはforensic assetに降格する。 | DONE | r13 (07b normalized compare; raw-log sha forensic); unchanged |
| 452 | 66 | verifier profileのunit testを作る。 | DONE | tools/verifier_profile_tests.sh 10/10 (SKIP_SAGE=1 under full -> FAIL; no LEAN_WORKSPACE under full -> FAIL; ...) |
| 453 | 67 | `SKIP_SAGE=1`でfull profileがFAILするtestを作る。 | DONE | tools/verifier_profile_tests.sh 10/10 (SKIP_SAGE=1 under full -> FAIL; no LEAN_WORKSPACE under full -> FAIL; ...) |
| 454 | 68 | `SKIP_LEAN=1`でfull profileがFAILするtestを作る。 | DONE | tools/verifier_profile_tests.sh 10/10 (SKIP_SAGE=1 under full -> FAIL; no LEAN_WORKSPACE under full -> FAIL; ...) |

### P4 GitHub Actions (GPT 69-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 455 | 69 | workflowを実際にpushする。 | OPEN (DrF) | push + first GitHub Actions run; ci_attestation.json (run id / URL / commit SHA / both summaries) is produced by the aggregator |
| 456 | 70 | Sage jobを実行する。 | OPEN (DrF) | push + first GitHub Actions run; ci_attestation.json (run id / URL / commit SHA / both summaries) is produced by the aggregator |
| 457 | 71 | Lean jobを実行する。 | OPEN (DrF) | push + first GitHub Actions run; ci_attestation.json (run id / URL / commit SHA / both summaries) is produced by the aggregator |
| 458 | 72 | aggregator jobを実行する。 | OPEN (DrF) | push + first GitHub Actions run; ci_attestation.json (run id / URL / commit SHA / both summaries) is produced by the aggregator |
| 459 | 73 | 三jobを同一commitでgreenにする。 | OPEN (DrF) | push + first GitHub Actions run; ci_attestation.json (run id / URL / commit SHA / both summaries) is produced by the aggregator |
| 460 | 74 | run URLを保存する。 | OPEN (DrF) | push + first GitHub Actions run; ci_attestation.json (run id / URL / commit SHA / both summaries) is produced by the aggregator |
| 461 | 75 | run IDを保存する。 | OPEN (DrF) | push + first GitHub Actions run; ci_attestation.json (run id / URL / commit SHA / both summaries) is produced by the aggregator |
| 462 | 76 | commit SHAを保存する。 | OPEN (DrF) | push + first GitHub Actions run; ci_attestation.json (run id / URL / commit SHA / both summaries) is produced by the aggregator |
| 463 | 77 | GitHub runnerの実測environmentを保存する。 | OPEN (DrF) | push + first GitHub Actions run; ci_attestation.json (run id / URL / commit SHA / both summaries) is produced by the aggregator |
| 464 | 78 | checkout setup前後で`git status --porcelain`を検査する。 | DONE | r13 workflow (porcelain before/after setup and after the run; $RUNNER_TEMP) kept in r14 |
| 465 | 79 | setupがcheckoutを変更したらfailする。 | DONE | r13 workflow (porcelain before/after setup and after the run; $RUNNER_TEMP) kept in r14 |
| 466 | 80 | `$RUNNER_TEMP`の利用を維持する。 | DONE | r13 workflow (porcelain before/after setup and after the run; $RUNNER_TEMP) kept in r14 |
| 467 | 81 | action dependenciesをcommit SHAでpinする。 | DONE | checkout / upload-artifact (r13) / download-artifact d3f86a10 (r14, GitHub API) pinned by commit SHA |
| 468 | 82 | Docker imageをdigestでpinする。 | DONE | sagemath/sagemath:10.8 by digest (Dockerfile FROM, r13) |
| 469 | 83 | Sage／PARI／FLINT／Arbの実測versionをassertする。 | DONE | verifier step 02 environment asserts (Sage/PARI/FLINT; lean-toolchain + mathlib pin) in both profiles |
| 470 | 84 | Lean／mathlib commitをassertする。 | DONE | verifier step 02 environment asserts (Sage/PARI/FLINT; lean-toolchain + mathlib pin) in both profiles |
| 471 | 85 | CI artifactsをreleaseへ含める。 | PARTIAL | ci_attestation.json artifact written by the aggregator; inclusion in the release / RELEASE_STATUS is Dr. Fukui's step after the run |
| 472 | 86 | CI summaryもmanifestまたはrelease attestationへ登録する。 | PARTIAL | ci_attestation.json artifact written by the aggregator; inclusion in the release / RELEASE_STATUS is Dr. Fukui's step after the run |

### P5 Blueprint (GPT 87-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 473 | 87 | `blueprint/README.md`のscaffold表現を更新する。 | DONE | blueprint/README.md rewritten (no scaffold wording; gates and their limits stated) |
| 474 | 88 | 全Fノードを列挙する。 | DONE | blueprint/check_graph.py --report -> docs/BLUEPRINT_PROOF_REPORT_R14.md (F 9, M 3, SHORT 5 as warnings); verifier step 10c |
| 475 | 89 | prose proofが短いFノードを列挙する。 | DONE | blueprint/check_graph.py --report -> docs/BLUEPRINT_PROOF_REPORT_R14.md (F 9, M 3, SHORT 5 as warnings); verifier step 10c |
| 476 | 90 | 全Mノードを列挙する。 | DONE | blueprint/check_graph.py --report -> docs/BLUEPRINT_PROOF_REPORT_R14.md (F 9, M 3, SHORT 5 as warnings); verifier step 10c |
| 477 | 91 | 各Fノードに完全自然言語証明を置く。 | PARTIAL | lem:A and lem:Sgroup expanded to full step-by-step prose; cor:T (558) complete; thm:Acore / lem:oldnew / thm:S0 / thm:family near 800 chars, review in r15 |
| 478 | 92 | 各Mノードに完全自然言語証明を置く。 | PARTIAL | lem:A and lem:Sgroup expanded to full step-by-step prose; cor:T (558) complete; thm:Acore / lem:oldnew / thm:S0 / thm:family near 800 chars, review in r15 |
| 479 | 93 | “Kernel-checked as stated”だけのproofを禁止する。 | DONE | r13 human-proof gate; Lean names auxiliary in titles |
| 480 | 94 | Lean declarationは証明の代替でなく補助として表示する。 | DONE | r13 human-proof gate; Lean names auxiliary in titles |
| 481 | 95 | `proof-completeness gate`を`evidence-presence gate`へ改名する。 | DONE | evidence-presence gate since r13; last "proof-completeness" occurrence (TRUST.md 35) reworded in r14 |
| 482 | 96 | prose completeness metadataを追加する。 | DONE | report = prose metadata; WARNING line printed by check_graph.py --report (step 10c; non-fatal) |
| 483 | 97 | prose proofが一定条件を満たさない場合はCI warningを出す。 | DONE | report = prose metadata; WARNING line printed by check_graph.py --report (step 10c; non-fatal) |
| 484 | 98 | Theorem Aをコードなしで第三者が追えるか人間レビューする。 | OPEN | code-free human review of Thm A / Prop D / Certificate Soundness (r15) |
| 485 | 99 | Proposition Dをコードなしで追えるかレビューする。 | OPEN | code-free human review of Thm A / Prop D / Certificate Soundness (r15) |
| 486 | 100 | Certificate Soundnessをchecker sourceなしで追えるかレビューする。 | OPEN | code-free human review of Thm A / Prop D / Certificate Soundness (r15) |
| 487 | 101 | Blueprint PDFへcommit SHAを入れる。 | PARTIAL | PDF carries the round (r14) and points to RELEASE_STATUS.md for the commit SHA / tag (the SHA cannot be inside the tree it hashes; LETTER_R14 question 5) |
| 488 | 102 | Blueprint PDFへversionを入れる。 | DONE | print.tex title r14; trust legend F/C/L/M/E (r13) |
| 489 | 103 | Blueprint PDFへF/C/L/M/E凡例を入れる。 | DONE | print.tex title r14; trust legend F/C/L/M/E (r13) |
| 490 | 104 | paper／Blueprintのshared proof sourceを再確認する。 | DONE | proofs/*.tex single-source, verified by both builds (10b, 11) |

### P6 Theorem A・文献監査 (GPT 105-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 491 | 105 | KY Proposition 4.1からLemma Eへの翻訳を外部数論家へ送る。 | OPEN (DrF) | external number theorist (hw 191/56); typed-map figure not drawn in r14 |
| 492 | 106 | typed mapの図を一枚作る。 | OPEN (DrF) | external number theorist (hw 191/56); typed-map figure not drawn in r14 |
| 493 | 107 | formal rootとcosetを図中でも分離する。 | OPEN (DrF) | external number theorist (hw 191/56); typed-map figure not drawn in r14 |
| 494 | 108 | base branch／non-base branchを図示する。 | OPEN (DrF) | external number theorist (hw 191/56); typed-map figure not drawn in r14 |
| 495 | 109 | 外部コメントを保存する。 | OPEN (DrF) | external number theorist (hw 191/56); typed-map figure not drawn in r14 |
| 496 | 110 | 修正履歴を保存する。 | OPEN (DrF) | external number theorist (hw 191/56); typed-map figure not drawn in r14 |
| 497 | 111 | Washingtonのphysical copyで定理番号を確定する。 | OPEN (DrF) | Washington physical copy (hw 29/70) |
| 498 | 112 | Proposition Dのcharacter規約を専門家へ確認する。 | OPEN (DrF) | character convention: expert confirmation |
| 499 | 113 | MathSciNet novelty監査を完了する。 | OPEN (DrF) | MathSciNet / zbMATH novelty audit (zbmath_search can pre-screen) |
| 500 | 114 | zbMATH novelty監査を完了する。 | OPEN (DrF) | MathSciNet / zbMATH novelty audit (zbmath_search can pre-screen) |
| 501 | 115 | KY・MOを両方引用する文献を重点確認する。 | OPEN (DrF) | MathSciNet / zbMATH novelty audit (zbmath_search can pre-screen) |
| 502 | 116 | “new”“first”を監査終了まで使わない。 | DONE | word freeze in force (README) |
| 503 | 117 | novelty matrixを最終化する。 | OPEN | novelty matrix |

### P7 paper／release (GPT 118-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 504 | 118 | Abstractの認証数値記述を修正する。 | DONE | abstract carries no certified-number claim with a radius (step 00c passes on main_R14.tex) |
| 505 | 119 | 本文のC7表をcertificateから自動生成する。 | DONE | Table tab:Cn rows generated from the certificate (tools/gen_cn_certs.py; verified verbatim, step 04b) |
| 506 | 120 | negative controls表をledgerから自動生成する。 | PARTIAL | negative-control row of Table 5 checked against the ledger (00c), not generated |
| 507 | 121 | submission PDFの全長pathを整理する。 | DONE | \path for every file path (r13); r14 paths added in the same form |
| 508 | 122 | overfull hboxを解消する。 | OPEN | overfull hboxes: 14 remaining in main_R14 (r13: 15) |
| 509 | 123 | stale R7–R12 filesをarchiveへ移す。 | DONE | archive/rounds/r13 (11 files, MOVE_LOG_R14.txt); active root = submission-facing files |
| 510 | 124 | active rootをsubmission-facing filesだけにする。 | DONE | archive/rounds/r13 (11 files, MOVE_LOG_R14.txt); active root = submission-facing files |
| 511 | 125 | `CITATION.cff`を完成する。 | OPEN | CITATION.cff / .zenodo.json not written in r14 |
| 512 | 126 | `.zenodo.json`を同期する。 | OPEN | CITATION.cff / .zenodo.json not written in r14 |
| 513 | 127 | exact final commitをfreezeする。 | OPEN (DrF) | freeze / push / CI / tag / release / Zenodo / DOI: Dr. Fukui, after the r14 zip |
| 514 | 128 | final commit上でfull profileを実行する。 | OPEN (DrF) | freeze / push / CI / tag / release / Zenodo / DOI: Dr. Fukui, after the r14 zip |
| 515 | 129 | green CIを確認する。 | OPEN (DrF) | freeze / push / CI / tag / release / Zenodo / DOI: Dr. Fukui, after the r14 zip |
| 516 | 130 | third-party clean clone replayを行う。 | OPEN (DrF) | freeze / push / CI / tag / release / Zenodo / DOI: Dr. Fukui, after the r14 zip |
| 517 | 131 | verification後は一切編集しない。 | OPEN (DrF) | freeze / push / CI / tag / release / Zenodo / DOI: Dr. Fukui, after the r14 zip |
| 518 | 132 | 編集した場合は全verificationを再実行する。 | OPEN (DrF) | freeze / push / CI / tag / release / Zenodo / DOI: Dr. Fukui, after the r14 zip |
| 519 | 133 | immutable tagを作る。 | OPEN (DrF) | freeze / push / CI / tag / release / Zenodo / DOI: Dr. Fukui, after the r14 zip |
| 520 | 134 | GitHub release assetを固定する。 | OPEN (DrF) | freeze / push / CI / tag / release / Zenodo / DOI: Dr. Fukui, after the r14 zip |
| 521 | 135 | Zenodo version DOIを発行する。 | OPEN (DrF) | freeze / push / CI / tag / release / Zenodo / DOI: Dr. Fukui, after the r14 zip |
| 522 | 136 | GitHub／Zenodoのasset hashを照合する。 | OPEN (DrF) | freeze / push / CI / tag / release / Zenodo / DOI: Dr. Fukui, after the r14 zip |
| 523 | 137 | paperにDOIとcommit SHAを記載する。 | OPEN (DrF) | freeze / push / CI / tag / release / Zenodo / DOI: Dr. Fukui, after the r14 zip |
| 524 | 138 | final sealed status文書を作る。 | OPEN (DrF) | freeze / push / CI / tag / release / Zenodo / DOI: Dr. Fukui, after the r14 zip |

Next-round hard gates (GPT r13, 15): 1 (C_7) の表示値・誤差半径修正; 2 full-precision interval certificate; 3 Magmaの偽inside-ball検査撤回; 4 negative controls 9/9の全媒体同期; 5 Sage／Lean skip時にFULL PASSを返さないこと; 6 Sage CI green; 7 Lean CI green; 8 aggregator green; 9 exact commit SHA付きCI記録; 10 Blueprint全F／Mノードの人間可読証明; 11 Theorem Aの外部数論家レビュー; 12 Washington citation確定; 13 novelty監査; 14 final frozen commit上でfull verifier PASS; 15 verifier後の編集ゼロ

## R15 — GPT r14 review (Weberレビュー.txt md5 f4ef806753dd53c628f3a68fb57af419, 27618 B, mtime 2026-08-26 11:29 JST, read 2026-08-26). GPT numbering 1-110 -> tracker 525-634. All OPEN at entry; nothing closed from memory. Overall: GO for the general-n paper (Thm A 95%, KY1000 96%, total 84%), NO-GO to fix/post r14 as is; NO NEW MATHEMATICS; new scope error = Thm S0/S1 silently pass from u_a = r_a^l == 1 (mod 2^t) to r_a == 1 (mod 2^t) (GPT sect 4; odd-power depth-transfer lemma missing; affects S0/S1 only), plus "three independent systems" in cor_S1.tex overstates the Python replay (sect 5), self-referential release protocol (sect 7), Table 1/2 overflow (sect 9), theory/ 27 docs at the active root (sect 10). Re-derived on <LOCAL_HOST> 2026-08-26 before entry: thm_S0.tex (789 chars) applies hypothesis (ii) to the Blichfeldt vector without naming the unit (r_a non-base, u_b base) or its depth [MC]; the lemma x^l == 1 <=> x == 1 (mod 2^t O_n), l odd, holds because 2 is totally ramified in B_n with residue field F_2 (every unit is == 1 mod p, so 1+x+...+x^(l-1) == l == 1 mod p is a p-unit and v_p(x^l-1) = v_p(x-1)), equivalently the l-th power map on the finite 2-group (O_n/2^t)^x is an automorphism [P, hand]; Python checker = scripts/verify_twoadic_rank.py replays saved bit rows (Sage r8_twoadic_depth_exact + Magma r8_twoadic_rank_magma are the two constructions) [MC]; paper 21 pp by pypdf (the r14 HANDOFF/SEAL record wrote 20 pp: my error), blueprint 18 pp; overfull main 14 (max 85.58 pt = tab:comp lines 93-103; l.97 Fukuda-Komatsu row +15.4 pt = "computationalno"), blueprint 11 (max 102.68 pt) [MC]; theory/ = 27 non-.bak files [MC]; blueprint PDF metadata title/author empty, paper metadata filled [MC]; KY1000 / manifest / negctl / profile-test numbers quoted by GPT all match the ledgers [MC].

Answers to the five LETTER_R14 questions (first time answered): (1) candidate-block protocol REJECTED - CI attestation must be an external release asset, no "Sealed" block appended to the verified tree; (2) S0 with hypothesis (i) only: YES, after depth floor + odd-power transfer are separate lemmas; (3) Luo companion note: AFTER the external review of the main paper, separate branch; (4) MSC 11R18/11R29 primary, 11H06/11Y40 secondary: accepted; (5) Blueprint PDF commit SHA: repository PDF carries round/version only, CI-built release asset injects the SHA at build time.

Next-round hard gates (GPT r14, 15): 1 odd-power depth-transfer lemma; 2 S0/S1 fully repaired; 3 Sage CI green; 4 Lean CI green; 5 aggregator green; 6 same-commit CI attestation; 7 zero tracked-file edits after verification; 8 external number-theorist review of Thm A; 9 Washington citation fixed; 10 novelty audit complete; 11 human review of the main F/M Blueprint nodes; 12 Table 1/2 visual fix; 13 overfull hboxes largely removed; 14 active root cleaned; 15 CITATION / Zenodo metadata complete.


### P0 Theorem S0／S1の修復 (GPT 1-... = hw 525-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 525 | 1 | 次の補題を独立に定理化する。 [ x^\ell\equiv1\pmod{2^t\mathcal O_n} \iff x\equiv1\pmod{2^t\mathcal O_n} \quad(\ell\text{ odd}). ] | DONE | proofs/lem_oddtransfer.tex (Lemma oddtransfer, App E); blueprint lem:oddtransfer; CLAIMS_R15 LEM_ODDTRANSFER |
| 526 | 2 | ((\mathcal O_n/2^t\mathcal O_n)^\times) 上のodd-power automorphismとして証明する。 | DONE | lem_oddtransfer Step 2-3: |(O_n/2^t O_n)^x| = 2^{2^n t-1}, odd power map bijective (powCoprime) |
| 527 | 3 | またはgeometric-seriesの第二因子が2-adic unitであることから証明する。 | DONE | lem_oddtransfer Remark: valuation form (geometric-series factor is a p-unit) |
| 528 | 4 | (2) が (B_n) でtotally ramifiedで、residue fieldが(\mathbf F_2)であることを明記する。 | DONE | lem_oddtransfer Step 1: 2 = unit*(1-zeta)^{2^{n+1}}, e(p/2) = 2^n, residue field F_2, stated and proved |
| 529 | 5 | non-base branchの (r_a^\ell=u_a) に補題を適用する。 | DONE | proofs/thm_S0.tex non-base branch: r_a^l = u_a, Lemma oddtransfer, Lemma depthfloor |
| 530 | 6 | base branchの (u_b^\ell=u_{\ell b}) に補題を適用する。 | DONE | proofs/thm_S0.tex base branch: u_b^l = u_{lb} = u_a, Lemma oddtransfer, Lemma depthfloor |
| 531 | 7 | `thm_S0.tex`へ両branchを明示する。 | DONE | proofs/thm_S0.tex (3285 chars) both branches explicit |
| 532 | 8 | Blueprintへ新ノードを追加する。 | DONE | blueprint/src/content.tex lem:oddtransfer [M, F-core] with \lean{} |
| 533 | 9 | dependency graphで新補題からS0へのedgeを追加する。 | DONE | thm:S0 \uses{..., lem:E, lem:Eprime, lem:depthfloor, lem:oddtransfer}; cor:S1 \uses lem:oddtransfer; 49 nodes / 63 edges |
| 534 | 10 | Leanで有限2群版を形式化する。 | DONE | lean/WeberOddTransfer.lean 5 decl std-3 (compile15_weberoddtransfer.log; verifier step 09, six files) |
| 535 | 11 | Theorem S0のtrust labelを修正後に再sealする。 | DONE | S0 label r14 "F-relative to (i),(ii)" -> r15 "M relative to (i); F-core"; STATEMENT_FREEZE_R15 item 6; CLAIMS_R15 THM_S0; ERRATA E15-1 |
| 536 | 12 | Corollary S1を再生成する。 | DONE | proofs/cor_S1.tex rewritten; CLAIMS_R15 COR_S1 |
| 537 | 13 | AbstractのS1記述が修正版に依存することを確認する。 | DONE | abstract sentence "A 2-adic scaling theorem shows that the direct filtered-lattice refinements at depths 4, 8 and 16 are strictly weaker" unchanged and true under the repaired S0 (checked 2026-08-26) |
| 538 | 14 | 修正前のS0を`ERRATA_R15.md`へ記録する。 | DONE | docs/ERRATA_R15.md E15-1 (r14 text quoted verbatim) |
| 539 | 15 | 「三独立系」を、 > Sage/Magmaで独立構成、Pythonで独立replay > へ変更する。 | DONE | proofs/cor_S1.tex; blueprint lem:Jt; CLAIMS_R15; STATEMENT_FREEZE_R15; ERRATA E15-2 |

### P1 Theorem Aの最終外部監査 (GPT 16-... = hw 540-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 540 | 16 | KY Proposition 4.1からLemma Eへの翻訳だけを抽出した3–5ページのnoteを作る。 | DONE | docs/audit_notes/THM_A_KY_TRANSLATION_NOTE_R15.tex/.pdf (3 pages; NOT SENT) |
| 541 | 17 | (A_n^{1/\ell}/A_n)、(M_f)、(RE_n^+/A_n)の型を図示する。 | DONE | note sect 1: type table (R_n, u_a, A_n^{1/l}, rho_a, [rho_a], M_f, L_f, RE/A_n) |
| 542 | 18 | formal rootとcosetを別記号にする。 | DONE | note: rho_a (number) vs [rho_a] (coset) |
| 543 | 19 | 「cosetがsubset」という表現を廃止する。 | DONE | note sect 3-4 and proofs/lem_E.tex Step 3 rewritten: membership of the coset in the image of RE cap A_n^{1/l} |
| 544 | 20 | representative変更 (a\mapsto a+\ell b) を図にも入れる。 | DONE | note sect 2 (well-definedness) and Lemma E proof |
| 545 | 21 | base branchとnon-base branchを別lemmaにする。 | DONE | note Lemma E (non-base) / Lemma E' (base) separate; paper Lemmas E / E' already separate |
| 546 | 22 | 独立の代数的数論家へ送る。 | DECLINED | author decision (a) 2026-08-26: no external reviewer; the kernel (F) and the checker (C) are the arbiters; M nodes are read by the author and the LLM reviewer |
| 547 | 23 | 質問事項を、 * KY命題の量化 * formal rootのwell-definedness * quotient inclusion * norm-one condition に限定する。 | DONE | note sect 5: four questions (quantification, formal root, quotient inclusion, norm-one) |
| 548 | 24 | コメントをrepositoryの`external_review/`へ保存する。 | DECLINED | author decision (a) 2026-08-26: no external reviewer; the kernel (F) and the checker (C) are the arbiters; M nodes are read by the author and the LLM reviewer |
| 549 | 25 | 修正履歴を記録する。 | DONE | ERRATA_R15; tracker; MOVE_LOG_R15 |
| 550 | 26 | 外部確認前は“fully audited”を使わない。 | DONE | grep "fully audited" = 0 in paper/proofs/blueprint/README/TRUST/RELEASE_STATUS |

### P2 CIとrelease protocol (GPT 27-... = hw 551-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 551 | 27 | final candidate commitを作る。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 552 | 28 | candidate commit後、tracked fileを一切変更しない。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 553 | 29 | Sage GitHub Actions jobを実行する。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 554 | 30 | Lean jobを実行する。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 555 | 31 | aggregator jobを実行する。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 556 | 32 | 三jobを同一commitでgreenにする。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 557 | 33 | run ID、URL、commit SHAを`ci_attestation.json`へ入れる。 | DONE | verify.yml full job: ci_attestation.json (run id, URL, commit SHA, image id, runner image, both summaries) |
| 558 | 34 | `ci_attestation.json`はrepositoryへ後からcommitしない。 | DONE | RELEASE_STATUS protocol step 3: NEVER committed |
| 559 | 35 | GitHub Release assetとして添付する。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 560 | 36 | repository内の`RELEASE_STATUS.md`へrun IDを追記しない。 | DONE | RELEASE_STATUS rewritten: no run id / SHA in the tree (protocol step 6); Sealed blocks abolished |
| 561 | 37 | source treeとattestationを分離する。 | DONE | protocol steps 3-6 |
| 562 | 38 | third-party clean clone replayを行う。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 563 | 39 | GitHub Actionsとthird-party replayのsummaryを比較する。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 564 | 40 | normalized summaryが一致することを確認する。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 565 | 41 | immutable tagを付ける。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 566 | 42 | tag後にsource treeを変更しない。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 567 | 43 | 変更が必要なら新versionへ進み、全verificationを再実行する。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 568 | 44 | CI logsをrelease assetsへ含める。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 569 | 45 | Docker image digestとGitHub runner情報をattestationへ含める。 | DONE | verify.yml sage job writes ci_environment.txt (image_id, base digests, runner image/os); aggregator embeds it |

### P3 Blueprint (GPT 46-... = hw 570-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 570 | 46 | 800文字未満のF/Mノード5件を再監査する。 | DONE | docs/BLUEPRINT_PROOF_REPORT_R15.md: SHORT 0 (r14: 5) |
| 571 | 47 | 短くても完全なものと、不足しているものを区別する。 | DONE | cor:T was complete but short (expanded with the floor computation); thm:Acore, lem:oldnew, thm:family expanded; thm:S0 rewritten |
| 572 | 48 | Theorem A coreをコードなしで追える文章へ拡張する。 | DONE | proofs/thm_Acore.tex 2744 chars (hypotheses spelled out, chain of inequalities, instantiation) |
| 573 | 49 | old/new lemmaを完全prose proofにする。 | DONE | proofs/lem_oldnew.tex 3180 chars (5 steps) |
| 574 | 50 | Family theoremの有限集合定義とtarget-list証明を詳述する。 | DONE | proofs/thm_family.tex 3083 chars (finite set, target-list certificate, witness certificates, chain, scope) |
| 575 | 51 | S0を修正後の補題込みで完全に書く。 | DONE | proofs/thm_S0.tex with Lemma oddtransfer in both branches |
| 576 | 52 | Corollary Tの整数床計算を明示する。 | DONE | proofs/cor_T.tex: floor property, monotonicity, the two Cor 7 thresholds worked out |
| 577 | 53 | “proof bodyあり”を“proof complete”と自動同一視しない。 | DONE | docs/BLUEPRINT_HUMAN_REVIEW_R15.md header; blueprint/README.md; TRUST.md |
| 578 | 54 | evidence-presence gateという名称を維持する。 | DONE | blueprint/check_graph.py name unchanged: "evidence-presence gate" |
| 579 | 55 | prose completenessはhuman sign-off fieldで管理する。 | DONE | docs/BLUEPRINT_HUMAN_REVIEW_R15.md (13 F/M nodes, all UNSIGNED) |
| 580 | 56 | 各重要nodeにreviewer initials／date欄を設ける。 | DONE | ledger fields reviewer / date / status / note; KEY nodes marked |
| 581 | 57 | Blueprint全体を、Leanを読まない数学者に読ませる。 | DECLINED | author decision (a) 2026-08-26: no external reviewer; the kernel (F) and the checker (C) are the arbiters; M nodes are read by the author and the LLM reviewer |
| 582 | 58 | その人がTheorem AとProp Dを再構成できるか確認する。 | DECLINED | author decision (a) 2026-08-26: no external reviewer; the kernel (F) and the checker (C) are the arbiters; M nodes are read by the author and the LLM reviewer |
| 583 | 59 | Blueprint PDF metadataへtitle、author、versionを追加する。 | DONE | blueprint/src/print.tex hyperref pdftitle / pdfauthor / pdfsubject (round r15) / pdfkeywords |
| 584 | 60 | commit SHAはtracked PDFへ自己参照的に埋め込まない。 | DONE | print.tex trust legend: commit SHA / tag outside the source tree; paper pdfsubject likewise |

### P4 Washington・文献・新規性 (GPT 61-... = hw 585-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 585 | 61 | Washingtonのphysical copyを確認する。 | OPEN (DrF) | physical copy / MathSciNet / zbMATH / authors: Dr. Fukui (hw 29/70/497, 122/113-115/499-503) |
| 586 | 62 | 正確な定理番号を固定する。 | OPEN (DrF) | physical copy / MathSciNet / zbMATH / authors: Dr. Fukui (hw 29/70/497, 122/113-115/499-503) |
| 587 | 63 | (\chi)／(\bar\chi)の規約を固定する。 | OPEN (DrF) | physical copy / MathSciNet / zbMATH / authors: Dr. Fukui (hw 29/70/497, 122/113-115/499-503) |
| 588 | 64 | Gauss sumの規約を固定する。 | OPEN (DrF) | physical copy / MathSciNet / zbMATH / authors: Dr. Fukui (hw 29/70/497, 122/113-115/499-503) |
| 589 | 65 | half-sum normalizationを再確認する。 | OPEN (DrF) | physical copy / MathSciNet / zbMATH / authors: Dr. Fukui (hw 29/70/497, 122/113-115/499-503) |
| 590 | 66 | physical-copy確認後にcitation noteを削除する。 | OPEN (DrF) | physical copy / MathSciNet / zbMATH / authors: Dr. Fukui (hw 29/70/497, 122/113-115/499-503) |
| 591 | 67 | MathSciNetでTheorem A類似結果を検索する。 | OPEN (DrF) | physical copy / MathSciNet / zbMATH / authors: Dr. Fukui (hw 29/70/497, 122/113-115/499-503) |
| 592 | 68 | zbMATHで検索する。 | OPEN (DrF) | physical copy / MathSciNet / zbMATH / authors: Dr. Fukui (hw 29/70/497, 122/113-115/499-503) |
| 593 | 69 | KYとMOを同時引用する後続文献を確認する。 | OPEN (DrF) | physical copy / MathSciNet / zbMATH / authors: Dr. Fukui (hw 29/70/497, 122/113-115/499-503) |
| 594 | 70 | Morisawa 2024を確認する。 | OPEN (DrF) | physical copy / MathSciNet / zbMATH / authors: Dr. Fukui (hw 29/70/497, 122/113-115/499-503) |
| 595 | 71 | novelty matrixを最終化する。 | OPEN (DrF) | physical copy / MathSciNet / zbMATH / authors: Dr. Fukui (hw 29/70/497, 122/113-115/499-503) |
| 596 | 72 | 可能ならKY／MO著者へpreprintを送る。 | DECLINED | author decision (a) 2026-08-26: no external reviewer; the kernel (F) and the checker (C) are the arbiters; M nodes are read by the author and the LLM reviewer |
| 597 | 73 | “new”“first”は監査完了まで使わない。 | DONE | word freeze in force (paper l.4; tools step 12); no "new"/"first" added |

### P5 PDF・視覚品質 (GPT 74-... = hw 598-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 598 | 74 | Table 1を二つへ分割する。 | DONE | main_R15.tex Table 1a (tab:comp) / 1b (tab:compb) |
| 599 | 75 | `computationalno`等の衝突をゼロにする。 | DONE | main_R15 build: Table 1 rows no longer overfull ("computationalno" gone: effective column 3.4 cm) |
| 600 | 76 | GRH列の縦崩れを直す。 | DONE | GRH column 1.1 cm in Table 1a; visual check at 100 % is hw 607 (DrF) |
| 601 | 77 | Table 2の長文列を本文へ移す。 | DONE | tab:classes: "range not covered" column removed, content in the paragraph after the table |
| 602 | 78 | 表中の数式を短縮する。 | PARTIAL | tab:classes widths reduced; formulas unchanged (short already) |
| 603 | 79 | mainのoverfull hboxを全て10pt未満にする。 | DONE | main_R15 overfull: 1 box, 4.68 pt (r14: 14 boxes, max 85.6 pt) |
| 604 | 80 | Blueprintのoverfull hboxを全て10pt未満にする。 | DONE | blueprint print.log overfull: 4 boxes, max 7.5 pt (r14: 11, max 102.7 pt) |
| 605 | 81 | 長いpathは`\path`またはAppendixへ送る。 | DONE | App F (Artifact index) lists every path once; body refers by name |
| 606 | 82 | artifact hashは本文から減らす。 | DONE | sect 8 and the family lemma: paths/hashes moved to App F |
| 607 | 83 | Table 1／2を100%表示で人間確認する。 | OPEN (DrF) | human visual check of Table 1a/1b/2 at 100 %: Dr. Fukui |
| 608 | 84 | PDF metadata、keywords、MSCを最終確認する。 | PARTIAL | \subjclass MSC 2020 in the paper since r13; pdfkeywords now carry MSC; MSC confirmation itself is DrF (question 4 accepted by GPT) |
| 609 | 85 | submission journalのpage size／styleへ変換する。 | OPEN (DrF) | journal not chosen; amsart 11pt as shipped |

### P6 repository整理 (GPT 86-... = hw 610-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 610 | 86 | active `theory/`の27文書を分類する。 | DONE | archive/proof_search/{class1,filtration,flagship_diagnostics,derivations_superseded_by_the_paper}; theory/ = 4 files |
| 611 | 87 | current theoremに直接必要なものだけ残す。 | DONE | theory/: STATEMENT_FREEZE_R15, PHASE_MINUS1_INTEGRATED_AUDIT_R10 (cited by the paper), PHASE_MINUS1_KY, FAMILY_CERTIFICATE_SPEC_R10 (cited by TRUST.md) |
| 612 | 88 | class 1 proof-search文書をarchiveへ移す。 | DONE | archive/proof_search/class1/ (4 files) |
| 613 | 89 | filtration旧案をarchiveへ移す。 | DONE | archive/proof_search/filtration/ (9 files) |
| 614 | 90 | old flagship diagnosticsをarchiveへ移す。 | DONE | archive/proof_search/flagship_diagnostics/ (5 files) |
| 615 | 91 | proof-search archiveを別Zenodo assetにするか検討する。 | OPEN (DrF) | decision: Dr. Fukui (archive/proof_search/ is separable; archive/README.md) |
| 616 | 92 | submission rootのREADMEを短くする。 | PARTIAL | docs/REVIEWER_GUIDE_R15.md added; README.md not shortened (72 lines; entry points block rewritten) |
| 617 | 93 | reviewer-facing navigationを作る。 | DONE | docs/REVIEWER_GUIDE_R15.md |
| 618 | 94 | stale request draftをactive rootから外す。 | DONE | docs/AUTHOR_REQUEST_DRAFT.md -> docs/audit_notes/ |
| 619 | 95 | archive文書がcurrent claims searchに混ざらないようにする。 | DONE | tools/check_constant_sync.py: active tree only (archive/ excluded, unchanged); archive/README.md states the rule |
| 620 | 96 | CIのgrep対象をcurrent treeへ限定する。 | DONE | verifier step 12 grep uses an explicit FILES list (root prose only); step 00c media list explicit |

### P7 Zenodo／release (GPT 97-... = hw 621-...)

| # | GPT# | item | status | evidence |
|---|---|------|--------|----------|
| 621 | 97 | `CITATION.cff`を完成する。 | DONE | CITATION.cff (license / repository URL left to the author: OPEN DrF) |
| 622 | 98 | `.zenodo.json`を完成する。 | DONE | .zenodo.json (same) |
| 623 | 99 | 両metadataを同期する。 | DONE | tools/check_release_metadata.py: RELEASE METADATA SYNC PASS |
| 624 | 100 | version namingを固定する。 | DONE | r<n>; zip weber_general_n_r<n>_<date>.zip; CITATION/zenodo version r15 |
| 625 | 101 | version DOIを予約する。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 626 | 102 | source commitとrelease assetsを明示する。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 627 | 103 | paper PDF、Blueprint PDF、certificates、checker、CI attestationを含める。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 628 | 104 | source archiveのSHA-256を記録する。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 629 | 105 | release asset全体のSHA-256一覧を作る。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 630 | 106 | GitHubとZenodoのasset hashを照合する。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 631 | 107 | exact artifact DOIを本文に入れる。 | DEFERRED (final release) | author decision (b) 2026-08-26: push / CI / tag / release / Zenodo once, at the end, all together |
| 632 | 108 | commit SHAは本文ではなくrelease metadata／生成PDF assetへ入れる。 | DONE | RELEASE_STATUS protocol step 5-6; print.tex; paper pdfsubject |
| 633 | 109 | immutable tag後の編集を禁止する。 | DONE | RELEASE_STATUS protocol step 4 |
| 634 | 110 | 最終release checklistを人間二名で確認する。 | DECLINED | author decision (a) 2026-08-26: no external reviewer; the kernel (F) and the checker (C) are the arbiters; M nodes are read by the author and the LLM reviewer |

## R16 — GPT r15 review (Weberレビュー.txt md5 627a38fb5c797f2f0ffdaa1e52bab232, 24184 B, mtime 2026-08-26 14:08 JST, read 2026-08-26). GPT numbering 1-72 -> tracker 635-706. All OPEN at entry except 704 DEFERRED / 705 DONE (the two standing decisions, which GPT r15 adopts as its own policy in sect 1). Overall: GO for the general-n paper, NO NEW FATAL GAP; sect 2 minor items (Kronecker in Lemma D; Lemma E typing residue; Washington wording; title "relative"; Prop D self-deprecation; Cor T floor; Magma 57-digit wording; S0 "weaker" scope; trust-boundary wording); sect 3-4 = two mathematical upgrades: Track A (abstract componentwise Saturation-Height theorem + computation-free all-n corollary from an explicit |L(1,chi)| <= U(q) bound; GPT 80-90%) and Track B (p=3 exact-covolume refinement, kill test against Morisawa-Okazaki G_1(3,r,f), GPT 20-35%); sect 5 = M->F formalization order (Lemma E first). Re-derived on <LOCAL_HOST> 2026-08-26 before entry: GPT's abstract inequality l^d <= (2/pi)^{m/2} Gamma(2+m/2) D/L^m is exactly the constant of Theorem A (main_R15.tex l.50) with Lambda_f = l^{-1} H_n(L_f) of covolume D_n/l^{d_f} (lem_D.tex; L_f index l^{m-d_f} in Z^m) [MC]; hat C_n follows from Cor A' (l.61) with prod over the m even characters of conductor q bounded by U(q)^m [hand]; Stirling shape (m/2) log m + O(m log n) consistent with log Gamma(2+m/2) and |L(1,chi)| = O(log q), q = 2^{n+2} [hand]; lem_D.tex l.1 uses "root of unity" without citation [MC]; main_R15.tex l.39 "effective in principle, with no numerical bound" [MC]; l.59 "no new mathematics and is not counted" [MC]; l.229 Magma 40 digits / 57-digit coincidence [MC]; title lacks "relative" (l.25) [MC]; cor_T.tex already proves the C_n<1 case (hypothesis vacuous) [MC]; lem_E.tex Step 2-3 already typed, residual "M_{f0} \subseteq RE/A_n" at main_R15.tex l.214 [MC]; "arbiter" wording in README.md, REVIEWER_GUIDE_R15.md, BLUEPRINT_HUMAN_REVIEW_R15.md, this tracker [MC]. Dr. Fukui's ruling 2026-08-26: ALL 72 items are done in R16 ("last push"); ordering by dependency only; no item dropped.

| hw | GPT | item | status | note |
|---|---|---|---|---|
| 635 | 1 | [P0] Lemma D: Kronecker's theorem is used silently ("all archimedean absolute values 1 => root of unity"); cite it | DONE | proofs/lem_D.tex l.1: totally-real elementary argument (conjugates in {±1} => minpoly x∓1), Kronecker named only, no citation needed |
| 636 | 2 | [P0] Kronecker: cite precisely, or place a short proof in the Blueprint | DONE | same edit; the short proof is in the shared proof body, hence in the Blueprint |
| 637 | 3 | [P0] Lemma E: unify coset / element / subgroup types across statement, Blueprint, Lean abstract hypothesis | DONE | lem_E.tex Step 2/3 (r15) + main_R15.tex tab:trust row (coset form) + content.tex lem:ky41 (subgroup of cosets defined); Lean abstract bridge WeberSH.sat_root_log |
| 638 | 4 | [P0] delete every "r_a A_n \subset RE^+/A_n"-shaped notation | DONE | note: lem_E.tex Step 2/3 already typed in r15; residual sweep = main_R15.tex l.214 (tab:inputs 'M_{f0} \subseteq RE/A_n') + blueprint ; grep sweep: no 'r_a A_n ⊂ RE/A_n'-shaped text remains in paper/proofs/blueprint (tab:trust row rewritten) |
| 639 | 5 | [P0] Washington effectivity sentence: "computable stabilization bound can be extracted; no numerical specialization used here" | DONE | main_R15.tex l.39 (GPT wording); Washington physical-copy check stays hw 29/70 |
| 640 | 6 | [P0] title: insert "relative" (relative class-number growth k_n = h_n/h_{n-1}); GPT suggests "...bounds for relative class-number growth..." | DONE | title = 'Componentwise saturation-height bounds for relative class-number growth in the cyclotomic Z_2- and Z_3-towers' (paper \\title, pdftitle, CITATION.cff x2, .zenodo.json; 'exclusion' -> 'bounds', 'relative' inserted, Z_3 added after Track B GO) |
| 641 | 7 | [P0] Prop D: replace "no new mathematics / not counted" by the role statement (exact normalization for a certifiable criterion) | DONE | main_R15.tex l.59 (GPT wording) |
| 642 | 8 | [P0] Cor T: f_n(B) = max{1, 1+floor(log C_n/log B)} | DONE | note: cor_T.tex l.3 already handles C_n<1 (hypothesis vacuous, d>=1); change is presentational ; main l.64, content.tex l.212, proofs/cor_T.tex: max{1, 1+floor}; Lean theoremA_threshold unchanged (takes C<B^d) |
| 643 | 9 | [P0] S0 "weaker": fix the object = the direct filtered-lattice criterion only; never "every 2-adic refinement" | DONE | proofs/thm_S0.tex l.8 + main l.70: object fixed = direct filtered-lattice criterion; l.73 / content 275 already scoped |
| 644 | 10 | [P0] Magma 57-digit agreement: phrase so it cannot be read as rigorous accuracy (or rerun Magma at >=100 digits and say 50 digits) | DONE | main l.229 + content.tex l.219: observation, no accuracy claim; only the Sage/Arb enclosure carries a trust label |
| 645 | 11 | [P0] public documents: "kernel is the arbiter" -> trust-boundary wording (which claim was checked by what) | DONE | README.md l.13, docs/REVIEWER_GUIDE_R15.md l.22, docs/BLUEPRINT_HUMAN_REVIEW_R15.md l.6: trust-boundary wording (GPT sect 2.9) |
| 646 | 12 | [P0] Abstract: drop S0 or compress to one sentence | DONE | note: abstract already has exactly one S0 sentence; decide drop vs keep ; abstract: S0 compressed to one clause; one sentence for Theorem SH / Cor A-hat / Theorem P3 with the n = 4 numbers |
| 647 | 13 | [P1] define the general finite-abelian-G-module setting | DONE | Theorem SH statement (main sec:results; content.tex thm:SH): G finite abelian, R quotient of Z[G] free of rank m |
| 648 | 14 | [P1] define A \subset U of rank m and the log embedding | DONE | A ⊆ U, A/{±1} cyclic over R, u_a = eps^a, (Rank), H log embedding — in the SH statement |
| 649 | 15 | [P1] define the simple-component dimension d | DONE | simple component = nonzero ideal M of R/lR, d = dim_{F_l} M — in the SH statement |
| 650 | 16 | [P1] isolate the pullback index l^{m-d} as a hypothesis | DONE | (Index) l R ⊆ L, [R:L] = l^{m-d} — stated as a hypothesis |
| 651 | 17 | [P1] isolate covolume D and height floor L as hypotheses | DONE | D (log covolume) and L_0 (floor) — hypotheses (Rank)/(Floor) of SH |
| 652 | 18 | [P1] prove the abstract Blichfeldt contradiction theorem l^d <= (2/pi)^{m/2} Gamma(2+m/2) D / L^m | DONE | proofs/thm_SH.tex (M) + Lean WeberSH.theoremSH / theoremSH_contra (std-3, 7 decl, lean/WeberSH.lean md5 57e5d0bf, compile16_webersh.log) |
| 653 | 19 | [P1] prove base branch and saturation branch in general form | DONE | proofs/thm_SH.tex base branch / saturation branch; Lean WeberSH.base_branch, sat_root_log, short_vector_ge_floor |
| 654 | 20 | [P1] state the abstract theorem in Main Results | DONE | main_R15.tex sec:results: Theorem SH placed before Theorem A |
| 655 | 21 | [P1] full proof in Appendix / Blueprint | DONE | proofs/thm_SH.tex \input by paper sec:proofA and Blueprint thm:SH (1778+ chars, not SHORT) |
| 656 | 22 | [P1] re-derive Weber Theorem A as a corollary of the abstract theorem | DONE | proofs/prop_F.tex rewritten: Prop F = Theorem SH with the Weber data (unfolded R15 argument kept as a paragraph); thm_A.tex unchanged |
| 657 | 23 | [P1] literature audit: does the abstraction coincide with a known general lemma | DONE | remark in thm_SH.tex + FREEZE_R16 N1; literature probe (zbMATH: Blichfeldt + saturation / relative units) still to run; word freeze in force ; zbMATH probes 2026-08-26 [MC]: ti:Blichfeldt & (class number | units) -> miss; saturation & cyclotomic units & class number -> miss; geometry of numbers & class number & Z_p-extension -> 1 hit = MO2013 (Minkowski on the ideal lattice, Mahler measure). No published statement of the component-lattice / height-floor packaging found; the theorem is presented as the organising form of Blichfeldt+floor, not as a new lemma (miss != absence recorded) |
| 658 | 24 | [P1] do not use the word "principle" before the novelty audit is finished | DONE | 'principle' not used for Theorem SH anywhere (grep at seal) |
| 659 | 25 | [P2] choose from a primary source an explicit bound |L(1,chi)| <= U(q) for primitive even characters | DONE | Ramaré, Acta Arith 112 (2004) Cor.1 with (h,k)=(1,2): |L(1,chi)| <= (1/4)(log q + 2 log 2) + log(4q)/sqrt q; theory/PHASE_MINUS1_R16_LITERATURE.md sect 1 |
| 660 | 26 | [P2] check every exception (conductor, parity, small modulus) of the chosen bound | PARTIAL | parity/conductor conditions read (even chi, 2|q, q >= 4 = k^2 4^{omega(h)}); read from the author's accepted manuscript — journal typesetting (Acta Arith 112) not yet compared |
| 661 | 27 | [P2] state the bound as a theorem U(q) (L input) | DONE | Blueprint lem:ramare [L]; paper tab:trust row; proofs cite Ram04 |
| 662 | 28 | [P2] define hat C_n = 2 (4/pi)^{m/2} Gamma(2+m/2) (U(2^{n+2})/log(2+sqrt5))^m | DONE | hat C_n defined in Cor A-hat (main + content.tex) and FREEZE_R16 N3 |
| 663 | 29 | [P2] prove C_n <= hat C_n | DONE | proofs/cor_Ahat.tex; Lean WeberHatC.C_le_hatC |
| 664 | 30 | [P2] derive the computation-free exclusion theorem l^{d_n(l)} > hat C_n => l does not divide k_n | DONE | Cor A-hat: l^{d_n(l)} > hat C_n => l does not divide k_n (paper + Blueprint + FREEZE_R16 N3) |
| 665 | 31 | [P2] Stirling upper/lower bounds -> fully explicit order threshold d log l > (m/2) log m + O(m log n) | DONE | Cor order (cor:order): T_n explicit via Robbins (Rob55 read verbatim, sect 1b of the Phase -1 note); proofs/cor_order.tex |
| 666 | 32 | [P2] record every constant, none omitted | DONE | T_n prints every constant; the O(.) remark is marked descriptive |
| 667 | 33 | [P2] compare exact C_n with hat C_n for n = 2..9 | DONE | sage/r16_hatCn/r16_hatCn_pilot.{sage,log}: n=2..8 done (ratios 6.2 .. 1.7e47); n=9 row still to add (200-bit digamma loop, q=2048) ; n = 9 row present after the second run: hat C_9 = 2.07e290, ratio 5.4e99 (sage/r16_hatCn/r16_hatCn_pilot.log) |
| 668 | 34 | [P2] if the bound is very coarse keep it to one corollary in the paper | DONE | paper carries Cor A-hat + Cor order only; the numeric table lives in the pilot log (Blueprint may cite it) |
| 669 | 35 | [P2] Lean-ize the discrete part | DONE | lean/WeberHatC.lean (3 decl, std-3, md5 c339c0f8, compile16_weberhatc.log); verifier step 09 extended to eight files |
| 670 | 36 | [P2] isolate the analytic L(1,chi) bound as L | DONE | |L(1,chi)| <= U(q) enters only as hypothesis hU / lemma lem:ramare [L] |
| 671 | 37 | [P3] Lean-ize Lemma B finite-field factor degree | DONE | lean/WeberLemmaB.lean (4 decl, std-3, md5 95b9bff4, compile16_weberlemmab.log): factor_degree via Mathlib natDegree_of_dvd_cyclotomic_of_irreducible + x^{2^n}+1 = cyclotomic(2^{n+1}); Blueprint lem:B now [F] leanok |
| 672 | 38 | [P3] Lean-ize Lemma C quotient index | DONE | already F since r7: component_card_quotient (WeberR7.lean, quotient form card(V/W) = |K|^{dim V - dim W}); confirmed on <LOCAL_HOST> 2026-08-26 |
| 673 | 39 | [P3] Lean-ize Lemma E typed quotient bridge as abstract group theory (GPT: top formalization priority) | DONE | abstract form: WeberSH.sat_root_log (u^l = u_a => l*H(u) = H(u_a)) + short_vector_ge_floor; the KY-side coset step is coset_absorb (r7, WeberR7.lean) |
| 674 | 40 | [P3] KY Prop 4.1 as a named axiom interface | DONE | named HYPOTHESIS (not a bare axiom, METHODOLOGY sect 5): `sat` in WeberSH.theoremSH / `ky41` in TheoremAInputs; KY Prop 4.1 is the [L] node lem:ky41 |
| 675 | 41 | [P3] formal root and coset as distinct Lean types | DONE | lean/WeberRoots.lean (4 decl, std-3, md5 f24bd4f1): roots are real numbers (odd_pow_injective), cosets are r*A (coset_eq_of_change_rep with A : Subgroup R^x); no subset relation between a coset and a subgroup anywhere |
| 676 | 42 | [P3] formalize well-definedness of the representative change a -> a + l b | DONE | WeberRoots.root_change_rep: r^l = u, v^l = w, r'^l = u w => r' = r v; cited in proofs/lem_E.tex Step 2 |
| 677 | 43 | [P3] Lean-ize the base branch | DONE | WeberSH.base_branch (l * H(iota b) = H(iota (l*b))) |
| 678 | 44 | [P3] Lean-ize the non-base branch | DONE | WeberSH.sat_root_log + short_vector_ge_floor (non-base branch) |
| 679 | 45 | [P3] Prop F as one Lean theorem | DONE | WeberSH.theoremSH_contra is Prop F in one theorem (abstract data); Weber instantiation remains M (prop_F.tex) |
| 680 | 46 | [P3] #print axioms: nothing but the L inputs may remain | DONE | #print axioms: std-3 for all 7 (WeberSH) + 3 (WeberHatC) declarations; no L axiom appears because every literature input is a hypothesis |
| 681 | 47 | [P3] update the Theorem A trust label to the achieved coverage | DONE | main_R15.tex sec:verif: coverage sentence (F: Lemmas A, B, C, E group core, base branch, SH core, Cor T, n=7; M: Lemma D covolume, SH instantiation, Prop D); Theorem A label stays L-relative, F-core |
| 682 | 48 | [P3] do not use "kernel-only" before gate 46 passes | DONE | grep 'kernel-only|kernel only' over README/TRUST/paper/blueprint/proofs/guide: 0 hits (2026-08-26); the claim is not made |
| 683 | 49 | [P4] extract Morisawa-Okazaki odd-p theorem: definitions, hypotheses, constants | DONE | theory/PHASE_MINUS1_R16_LITERATURE.md sect 2 (MO2013 verbatim: Thm A/B, Thm 0.3, Lemma 1.3, Thm 2.2, Lemma 3.3, Lemma 9.1/9.2, Thm 9.4); paper/MO2013_Tohoku_oddp.pdf; paper/Horie2005_PJA_typical_inert.pdf (Lemma 2 relays Horie 2002 Lemmas 2,3,8 — original NOT read, flagged) |
| 684 | 50 | [P4] reproduce G_1(p,r,f) exactly | DONE | G_1(p,r,f) = ((sqrt6 p/2)^c c!)^{1/f}; sanity: reproduces the printed G_1(5,1,1) = 33750 [MC] |
| 685 | 51 | [P4] define the p=3 relative-unit / Horie-unit module | DONE | Blueprint def:p3: Horie unit eta_n = delta(1), module Z[zeta_{3^r}] via the coordinate lift alpha -> alpha_sigma, lattice spanned by H(sigma^{3^{n-r} j} eta_n) |
| 686 | 52 | [P4] identify the root lattice obtained from l-divisibility | DONE | root lattice = Horie ideal lattice l L^{-1} of Z[zeta_{3^r}], index l^{c-f} (MO2013 Lemma 1.3) |
| 687 | 53 | [P4] decide whether it rewrites as simple-component saturation | DONE | it IS the pullback of a component with d = f: (Index) + (Sat) of Theorem SH; theory/TRACKB_P3_GATES_R16.md Gate 1 |
| 688 | 54 | [P4] if not, decide whether an ideal-lattice version of the abstract theorem exists | DONE | not needed (687 rewrites); the ideal-lattice form and the component form coincide |
| 689 | 55 | [P4] derive the exact log-covolume as a character product | PARTIAL | exact covolume certified as a ball-arithmetic Gram determinant (certificates/p3/D3_cert_r16.json, 4000 bits, radii < 1e-800); the character-product (Prop D-type) FORMULA is not derived — a C-label suffices for Theorem P3 |
| 690 | 56 | [P4] quantify the Hadamard loss | DONE | the loss is the convex-body constant c!/Gamma(2+c/2) ~ c^{c/2} (thm_P3.tex remark; TRACKB report Gate 3); numerically 54!/28! ~ 8e41 at n = 4 |
| 691 | 57 | [P4] compute the exact constant for p=3 at the two smallest layers | DONE | n = 1..5, r = 1..n (15 rows), rigorous (certificate) |
| 692 | 58 | [P4] compare with published G_1(3,r,f) in every congruence class | DONE | Table tab:p3 + TRACKB report: vs G_1, G_cyclo, Morisawa Thm 0.3 at s = r |
| 693 | 59 | [P4] decide: strict improvement in at least one infinite congruence class? | DONE | YES: class 3^n | l^f - 1 at layer n = 4: 2.12e44 vs 3.10e79 (Thm 0.3) / 7.6e101 (G_1); n = 5: 2.48e167 vs 2.97e313; r = 3 regime 1e-6; r = 1 regime LOSES (x1.6-2.5) — stated in the table caption |
| 694 | 60 | [P4] no improvement -> immediate NO-GO | DONE | not triggered (improvement found); ruling point (2): GO 2026-08-26 |
| 695 | 61 | [P4] single-prime improvement only -> not into the main paper | DONE | not a single-prime improvement: infinite classes |
| 696 | 62 | [P4] improvement -> proceed to the general-p statement | DEFERRED | general odd p NOT attempted in R16 (only p = 3 frozen, FREEZE_R16 N7); the mechanism is p-independent, a later round |
| 697 | 63 | [P4] Lean-ize the odd-p discrete core | DONE | lean/WeberP3.lean (3 decl, std-3, md5 f4ef09a1): l1_sq_le_card_mul_l2_sq, height_floor_of_l1_floor, theoremP3_core |
| 698 | 64 | [P4] state the existing odd-p theorem as L | DONE | Blueprint lem:horie13 [L] (MO13 Lemma 1.3 <- Ho05b <- Ho02), lem:mo22 [L] (MO13 Thm 2.2 / Sch73); paper tab:trust + 2 rows; bibliography Ho02, Ho05b, MO13, Mo12, Sch73 |
| 699 | 65 | [P5] Track A (abstract theorem + computation-free corollary) goes into the paper regardless of p=3 | DONE | Track A in the paper: Theorem SH, Cor A-hat, Cor order |
| 700 | 66 | [P5] Track B: no improvement of G_1 -> stop | DONE | Track B: improvement established -> Theorem P3 + Cor P3n4 in the paper (sec:p3) |
| 701 | 67 | [P5] no return to the class-1 search | DONE | observed: no class-1 search in R16 |
| 702 | 68 | [P5] no return to the n=7 complete proof | DONE | observed: no n = 7 complete-proof work in R16 |
| 703 | 69 | [P5] no new certificate family | DONE | observed: no new witness family; certificates/p3/D3_cert_r16.json is a constant enclosure (like Cn_interval), not a witness family |
| 704 | 70 | [P5] GitHub / Zenodo after the mathematical statement freeze only | DEFERRED | = decision (b): once, at the end |
| 705 | 71 | [P5] no external-researcher review as a gate | DONE | = decision (a); GPT r15 adopts it (sect 1) |
| 706 | 72 | [P5] Luo companion note stays deferred until the main paper is complete | DONE | Luo companion note untouched in R16 (deferred, decision unchanged) |

## R17 — GPT r16 review (Weberレビュー.txt md5 27bbe9c78ce2cd6ab3fe6a075f72fdf5, 24401 B, mtime 2026-08-26 19:35 JST, read 2026-08-26). GPT numbering 1-70 -> tracker 707-776. All OPEN at entry except 772 (= hw 696 policy, DEFERRED) and 776 (= decision (b), DEFERRED); nothing closed from memory. Overall: Track A GO (Thm SH conditional GO: weaken the prose statement to the Lean carrier form = answer to LETTER_R16 question (4)); Track B (Theorem P3 all-n, Cor P3n4) NO-GO AS STANDS on two grounds — (A) scope: (Rank) positivity of D_r^{(n)} is certified for n <= 5 only while the statement is for all n; (B) comparator: MO2016 (JTNB 28, in paper/MO2016_height_weber_jtnb965.pdf, in the repository since r7) Theorem A gives G(3,4,1) = 3.71e37 and G(3,4,2) = 6.09e18, both BETTER than our 2.12e44 / 1.46e22; R16 Gate 3 compared only with MO2013 Thm 0.3 / G_1 — a genuine omission of my Phase -1 at ruling point (2). GPT's repair route: (R1) Nr_{B_{3,n}/B_{3,n-1}}(eta_n) = 1 by the three-term telescoping of sin(2 a^i pi/q), a = 1+3^n, a^3 == 1 (mod 3^{n+1}) => the saturation root eps has relative norm 1 and degree 3^n => MO2016 Lemma 2.5(2) floor L^rel_{3,n} = sqrt(3^n) log((3^{(3^n-1)/(2 3^n)} + sqrt(3^{(3^n-1)/3^n}+4))/2) (= Lemma 2.3 with C >= 3^{(3^n-1)/2} from MO2013 Lemma 9.1 = MO2016 Lemma 2.4(2)) replaces the Schinzel floor; (R2) spectral rank: DFT hat lambda_k of lambda_j = log|sigma^j eta_n| vanishes for 3|k (relative norm) and is nonzero for 3∤k (primitive even chi_k of conductor 3^{n+1}, chi_k(1+3^n) != 1, Dirichlet L(1,chi) != 0), Parseval + Phi_{3^r} | A => rank c for all n, r; (R3) exact covolume (D_r^{(n)})^2 = 3^{3^{r-1}(2r-1)} prod_{a in (Z/3^r)^x} W_{n,r}(a), W = (1/N) sum_{k == a (3^r)} |hat lambda_k|^2. Re-derived on <LOCAL_HOST> 2026-08-26 BEFORE entry (all [MC], /tmp scripts, mpmath 60 dps, read-only): MO2016 Thm A at p = 3 parsed from the numdam PDF as G(3,s,f) = ((sqrt(2 pi)/(3^{3/4} log((3^{40/81}+sqrt(3^{80/81}+4))/2)))^c ((c+2)/2)!)^{1/f}, c = 2 3^{s-1}, two-point check: G(3,3,2) = 42407.5 vs the paper's own Example 1.6 "4.3e4" and G(3,4,1) = 3.711141e37 / G(3,4,2) = 6.091913e18 = GPT's numbers; ht = L2-height (Def 2.2) and Lemma 2.5(2) reads sqrt(p^n) log(...) (the "√" is displaced by pdftotext), same convention as our L_{3,n}; L^rel_{3,4} = 7.0107178918636976 (GPT's 17 digits reproduced), ratio to Schinzel 1.6187646; from the certified D_4^{(4)} (D3_cert_r16.json mid) C^{(3),rel}_{4,4} = 1.0727498e33, sqrt = 3.2753e16 (GPT 1.0727497797681584e33), improvement over MO2016 3.459e4 (f=1) / 186.0 (f=2); with the relative floor ALL 15 certified rows beat G(3,r,f) in both f (row (5,5): 1.74e133 vs 8.57e146), and the r < n regime turns from "r=1 loses" to "every row wins" (ratios 1.04-3.9); current C3 recomputed from D with the Schinzel floor agrees with the certificate to 1e-40; numerically with sigma = (zeta -> zeta^4) as in proofs/thm_P3.tex, 1 <= r <= n <= 4: max |log Nr_rel| < 1.5e-37, max |hat lambda_k| (3|k) < 4e-37, min |hat lambda_k| (3∤k) = 1.60/3.13/3.76/6.05, and disc * prod W / det Gram = 1.000000000000000000 with sqrt(det Gram)/D_cert = 1.0 in all 10 cases; a^3 == 1 (mod 3^{n+1}) and 4^{3^{n-1}} == 1+3^n (mod 3^{n+1}) checked by hand. Not yet done: Arb re-certification (hw 747-752), the L-function identity for hat lambda_k (hw 727-730), Lean of the discrete parts. GPT did NOT answer LETTER_R16 questions (1)-(3) (third time), (5) (Horie 2002 via MO2013) or (6) (r=1 regime); (4) answered by items 56-61. Decisions (a)(b): (a) not mentioned; (b) restated by GPT as item 70 — recorded, no argument.

| hw | GPT | item | status | note |
|---|---|---|---|---|
| 707 | 1 | [P0] Theorem P3: withdraw the all-n form (NO-GO as stated) | DONE | Theorem P3 restated for every n with (Rank) proved (Theorem rank3); STATEMENT_FREEZE_R17 N8 |
| 708 | 2 | [P0] Cor P3n4: withdraw the "published uniform bound" comparison wording (MO2013 only) | DONE | cor_P3n4.tex / tab:p3: comparator = MO2016 Thm A; MO2013 listed 'for the record, not as the comparator' |
| 709 | 3 | [P0] abstract: remove 2.13e44 / 1.46e22 for now | DONE | abstract reverted at 便0, then rewritten with the certified r17 numbers after the three gates passed (ruling 続ける) |
| 710 | 4 | [P0] title: revert to the Z_2-tower until the three Track B gates pass | DONE | title reverted at 便0, restored '... Z_2- and Z_3-towers' after the gates (hw 771) |
| 711 | 5 | [P0] CLAIMS_R17.yaml: THM_P3 / COR_P3N4 status "repair pending" | DONE | CLAIMS_R17.yaml: THM_P3 / COR_P3N4 REPAIR PENDING at 便0, then RESTATED; CERT_D3 new (r17 JSON) |
| 712 | 6 | [P0] state that the 15-row certificate proves (Rank) for n <= 5 only | DONE | lem:D3cert / CERT_D3 say n <= 5 explicitly; the theorem no longer depends on the certificate |
| 713 | 7 | [P0] withdraw the "all 72 homework items executed" self-assessment (689 formula not derived, rank not proved for all n, best-bound comparison incomplete, Morisawa 2012 unread) | DONE | ERRATA_R17 E17-3 withdraws the sentence |
| 714 | 8 | [P0] ERRATA_R17.md: record the R16 comparator omission (MO2016 Theorem A not compared at Gate 3) | DONE | docs/ERRATA_R17.md E17-1 |
| 715 | 9 | [P1] prove a = 1+3^n, a^3 == 1 (mod 3^{n+1}) | DONE | WeberP3Rel.a_cube_modEq_one (std-3); lem_normone.tex (i) (hand-checked at entry) |
| 716 | 10 | [P1] prove the relative Galois subgroup acts on exponents by k -> ka | DONE | WeberP3Rel.four_pow_modEq (induction four_pow_three_pow); lem_normone.tex (ii) (tau = sigma^{3^{n-1}}, 4^{3^{n-1}} == 1+3^n (mod 3^{n+1}) hand-checked) |
| 717 | 11 | [P1] prove the three-term telescoping product of the Horie unit | DONE | WeberP3Rel.telescope_three + sin_telescope_step; lem_normone.tex (iii) |
| 718 | 12 | [P1] Theorem: Nr_{B_{3,n}/B_{3,n-1}}(eta_n) = 1 | DONE | Lemma normone (lem:normone [F]); certificate relnorm_zero_all_j True in 15/15 rows (numerically [MC] n <= 4) |
| 719 | 13 | [P1] from eta_n^alpha = eps^l deduce Nr(eps) = 1 (l odd, totally real) | DONE | lem_normone.tex (iv), WeberP3Rel.eq_one_of_odd_pow_eq_one |
| 720 | 14 | [P1] H(eps) != 0 => eps not in E_{3,n-1} | DONE | lem_normone.tex (iv): eps in B_{3,n-1} => eps^3 = 1 => eps = 1 |
| 721 | 15 | [P1] state that MO2016 Lemma 2.5(2) applies (eps in E_n \ E_{n-1}, Nr = 1) | DONE | (r17 late addition: Horie 2005 JMSJ Prop. 1 = the general saturation lemma with proof, fetched open-access and read; lem:horie13 updated)  Lemma mo25 [L] stated in paper + Blueprint with the MO2016 chain Lemma 2.3 + 2.4(2) = MO13 Lemma 9.1; thm_P3.tex 'The floor' (Lemma 2.5(2) verbatim read at entry (= Lemma 2.3 + Lemma 2.4(2) = MO2013 Lemma 9.1)) |
| 722 | 16 | [P1] Lean: the discrete part (a^3, telescoping, norm-one transfer) | DONE | lean/WeberP3Rel.lean 8 decl std-3 (compile17_weberp3rel.log) |
| 723 | 17 | [P2] define lambda_j = log|sigma^j eta_n| | DONE | def:p3 / thm_rank3.tex |
| 724 | 18 | [P2] define the length-N DFT hat lambda_k | DONE | def:p3 / thm_rank3.tex |
| 725 | 19 | [P2] prove 3 | k => hat lambda_k = 0 from the relative norm | DONE | thm_rank3.tex Step 1; WeberP3Rel.dft_vanish_of_relnorm; certificate hat_zero_all_3divk True 15/15 (numerically [MC] n <= 4) |
| 726 | 20 | [P2] write the Horie unit as a cyclotomic-unit ratio | DONE | thm_rank3.tex Step 2: lambda_j = g(2a 4^j) - g(2 4^j), g(m) = log|1 - zeta_q^m| |
| 727 | 21 | [P2] derive hat lambda_k = (chi_k(1+N)^{-1} - 1) chi_k(2)^{-1} T(chi_k) for primitive chi_k | DONE | derived in the paper's own normalisation: hat lambda_k = omega^{j_0 k}(e^{2 pi i k/3} - 1) hat Gamma_k, |hat Gamma_k| = (sqrt q/2)|L(1,chi_k)| (GPT's constant chi_k(2)^{-1} T(chi_k) corresponds to omega^{j_0 k} with -2 = 4^{j_0}) (constant not yet re-derived; only the nonvanishing is [MC]) |
| 728 | 22 | [P2] prove chi_k(1+N) != 1 (faithful character, 1+N of order 3) | DONE | thm_rank3.tex Step 2: kernel of reduction = {1,a,a^2}, chi_k(a) != 1 => primitive of conductor q |
| 729 | 23 | [P2] connect T(chi_k) to L(1, bar chi_k) | DONE | Lemma D3 (Washington Thm 4.9 [L], already in the paper for Prop D) |
| 730 | 24 | [P2] Dirichlet nonvanishing => hat lambda_k != 0 for 3∤k | DONE | thm_rank3.tex Step 2; certificate min |hat lambda_k| lower bound > 0 in 15/15 rows (numerically [MC]: min 1.60/3.13/3.76/6.05 for n=1..4) |
| 731 | 25 | [P2] Parseval => rank c for all n, r | DONE | thm_rank3.tex Step 3 (Parseval + Phi_{3^r} | A) |
| 732 | 26 | [P2] Lean: the cyclotomic-polynomial degree argument (Phi_{3^r} | A, deg A < phi(3^r) => A = 0) | DONE | WeberP3Rel.eq_zero_of_vanish_on_primitiveRoots + totient_three_pow (std-3) |
| 733 | 27 | [P2] Lean: the finite Fourier / character part | PARTIAL | Lean: the coset-sum vanishing at 3 | k, the twisted-sum shift algebra of Step 2 (WeberP3Rel.twisted_sum_shift / _diff / _diff_ne_zero, pow_third_eq_one_iff: lambda_hat_k != 0 <= Gamma_hat_k != 0 and 3 !| k) and the polynomial step; Gamma_hat_k != 0 (character identification + Washington + Dirichlet) and the Parseval/Vandermonde step of Step 4 remain M |
| 734 | 28 | [P2] isolate L(1,chi) != 0 as an L input | DONE | thm:rank3 label 'L for L(1,chi) != 0'; \uses{lem:dirichlet}; CLAIMS inputs |
| 735 | 29 | [P3] define W_{n,r}(a) = (1/N) sum_{k == a (3^r)} |hat lambda_k|^2 | DONE | thm_rank3.tex Step 4; def:p3 |
| 736 | 30 | [P3] prove (D_r^{(n)})^2 = |disc Q(zeta_{3^r})| prod_a W_{n,r}(a) | DONE | thm_rank3.tex Step 4 (Gram = V diag(W) V^*); certificate route 2, D_gram/D_dft encloses 1 in 15/15 rows (numerically [MC] 1 <= r <= n <= 4, ratio 1.000000000000000000) |
| 737 | 31 | [P3] prove the cyclotomic Vandermonde determinant | DONE | M: |det V|^2 = |disc Phi_{3^r}| (Vandermonde), thm_rank3.tex Step 4 |
| 738 | 32 | [P3] |disc Q(zeta_{3^r})| = 3^{3^{r-1}(2r-1)} | DONE | 3^{3^{r-1}(2r-1)} = p^{p^{r-1}(pr-r-1)} at p = 3; in the theorem statement and the certificate script (= p^{p^{r-1}(pr-r-1)} at p=3, hand-checked) |
| 739 | 33 | [P3] cross-check against the current Gram determinants | DONE | p3_covol_cert_r17.sage: both routes as 4000-bit balls, assert (ratio - 1) contains 0 (done numerically at entry (mpmath); certificate-grade pending) |
| 740 | 34 | [P3] interval intersection on all 15 rows | DONE | 15/15 rows, radii <= 9.4e-1020 on the route quotient |
| 741 | 35 | [P3] make the character-product route the second certificate route | DONE | route 2 is in the certificate JSON (D_dft) and in lem:D3cert |
| 742 | 36 | [P3] promote positive rank from a numerical certificate to a general theorem | DONE | = 731 (Theorem rank3) (= 731) |
| 743 | 37 | [P4] define L^rel_{3,n} | DONE | Lrel_{3,n} in def:p3 / Lemma mo25 / STATEMENT_FREEZE_R17 N8; Lrel_{3,4} = 7.0107178918636975... (value at n=4: 7.0107178918636976 [MC]) |
| 744 | 38 | [P4] check the convention against MO2016 Lemma 2.5(2) letter by letter | DONE | MO2016 Def 2.2 (ht = L2), Lemma 2.3, Lemma 2.4(2), Lemma 2.5(2) read verbatim from the JTNB PDF (pdftotext displaces the sqrt sign; the (4.5) display and Lemma 2.3 fix the convention: sqrt(p^n) log(...)) (ht = L2 (Def 2.2); sqrt(p^n) log(...) read at entry) |
| 745 | 39 | [P4] replace the Schinzel floor by L^rel in Theorem P3 | DONE | thm:P3 restated (STATEMENT_FREEZE_R17 N8) |
| 746 | 40 | [P4] recompute C^{(3),rel}_{n,r} for all 15 rows in Arb | DONE | certificates/p3/D3_cert_r17.json (C3rel, 15 rows) (mpmath preview: all 15 rows beat G(3,r,f), both f) |
| 747 | 41 | [P4] regenerate the 4000-bit certificate | DONE | 4000-bit balls, script sha256 fecbbbd0..., RC=0, 15 rows |
| 748 | 42 | [P4] store full interval endpoints in the new JSON | DONE | lo / hi / mid / rad_upper per quantity |
| 749 | 43 | [P4] certify or correct C^{(3),rel}_{4,4} ~ 1.073e33 | DONE | C3rel_{4,4} in [1.072749779e33, 1.072749780e33] (GPT's 1.0727497797681584e33 confirmed) (mpmath from certified D: 1.0727498e33) |
| 750 | 44 | [P4] certify or correct sqrt ~ 3.276e16 | DONE | sqrt in [3.275285910e16, 3.275285911e16] (GPT's 3.276e16 confirmed; 3.2753e16 rounded up) (mpmath: 3.2753e16) |
| 751 | 45 | [P4] generate the thresholds from the certificate | DONE | tools/check_p3_cert.py generates every printed number from the JSON (ours up, comparators/gains down, 5 sig. digits) and greps them verbatim in paper + proofs + Blueprint |
| 752 | 46 | [P5] implement MO2016 Theorem A at p = 3 | DONE | G_mo16(s,f) in p3_covol_cert_r17.sage (balls) and tools/check_p3_cert.py (Decimal) (parsed + two-point checked at entry (Example 1.6)) |
| 753 | 47 | [P5] compute G(3,s,f) for s = 1..5, f = 1, 2 | DONE | all 15 rows carry G(3,r,1), G(3,r,2); s = r = 1..5 (mpmath table at entry: 3.99/1.997, 189.9/13.78, 1.80e9/4.24e4, 3.71e37/6.09e18, 8.57e146/2.93e73) |
| 754 | 48 | [P5] list MO2013 Thm 0.3, A, B alongside | DONE | tab:p3 caption + cor_P3n4.tex: MO13 Thm 0.3 and Thm A 'for the record' |
| 755 | 49 | [P5] mark what of Morisawa 2012 is used only as quoted in MO2016 | DONE | cor_P3n4.tex / RELEASE_STATUS: Morisawa 2012 quoted through MO2013 Thm 0.3 only, record column only |
| 756 | 50 | [P5] table with automatic best-published-comparator selection | DONE | tab:p3 = MO2016 columns (best published); check_p3_cert.py asserts the improvement per row |
| 757 | 51 | [P5] interval test: new C^{(3),rel}_{4,4} < 3.71114e37 (f=1) | DONE | certificate improved_f1 True at (4,4): C3rel.hi < G(3,4,1).lo; gate asserts it |
| 758 | 52 | [P5] interval test: new sqrt < 6.09191e18 (f=2) | DONE | improved_f2 True at (4,4); gate asserts it |
| 759 | 53 | [P5] if either fails, Track B ends | DONE | both classes improved in all 15 rows -> Track B continues (ruling 続ける at checkpoint 1) (ruling item) |
| 760 | 54 | [P5] generate the improvement factors from the certificate | DONE | improve_f1 / improve_f2 balls in the JSON; printed rounded down (3.4594e4, 1.8599e2) |
| 761 | 55 | [P5] drop the vague "published bounds grow" caption | DONE | caption rewritten: 'the comparator is G(3,s,f), which grows with c' |
| 762 | 56 | [P6] prose Theorem SH -> the weakest form Lean proves (carrier form) | DONE | thm:SH restated in the carrier form (= WeberSH.theoremSH); STATEMENT_FREEZE_R17 N1 note (= answer to LETTER_R16 question (4)) |
| 763 | 57 | [P6] move the cyclic R-module hypothesis to the application corollary | DONE | cyclic R-module hypothesis lives in Cor SH-mod (cor:SHmod, COR_SHMOD) |
| 764 | 58 | [P6] carrier hypothesis in the main theorem | DONE | (Car) is the hypothesis of the main theorem |
| 765 | 59 | [P6] Z_2 base/saturation dichotomy as a corollary | DONE | cor_SHmod.tex: base branch + saturation branch produce (Car) |
| 766 | 60 | [P6] P3 Horie carrier as a separate corollary | DONE | thm_P3.tex: (Car) from Lemma normone (iv) (roots) and (iii) (base branch, A <= U_{3,n}); P3 applies Theorem SH directly |
| 767 | 61 | [P6] paper / Blueprint / Lean statements literally identical | DONE | paper thm:SH / cor:SHmod, Blueprint thm:SH / cor:SHmod, Lean WeberSH.theoremSH: same hypotheses (Car)/(Floor)/(Bl); thm_SH.tex names h(a) = H(iota(a)) |
| 768 | 62 | [P7] gate 1: no spectral rank theorem => delete P3 | DONE | gate 1 passed: Theorem rank3 (ruling item) |
| 769 | 63 | [P7] gate 2: strong floor not applicable to the Horie roots => delete P3 | DONE | gate 2 passed: Lemma normone (iv) + Lemma mo25 (ruling item) |
| 770 | 64 | [P7] gate 3: no improvement over MO2016 in BOTH classes => delete P3 | DONE | gate 3 passed: certificate 15/15 rows, both f (ruling item) |
| 771 | 65 | [P7] all three gates pass => Z_3 back into the title | DONE | title and abstract carry the Z_3-tower again |
| 772 | 66 | [P7] no general odd p yet | DEFERRED | = hw 696 policy unchanged (= hw 696 policy unchanged) |
| 773 | 67 | [P7] no KY1000 additions | DONE | observed: no KY1000 addition in r17 (policy to observe) |
| 774 | 68 | [P7] no return to the class-1 search | DONE | observed: no class-1 work in r17 (policy to observe) |
| 775 | 69 | [P7] no return to the n = 7 complete proof | DONE | observed: no n = 7 work in r17 (policy to observe) |
| 776 | 70 | [P7] GitHub publication only after the mathematical statement freeze | DEFERRED | = decision (b): once, at the end (= decision (b): once, at the end) |

## R18 — GPT r17 review (Weberレビュー.txt md5 d44d83d7f313dfcb546d8352e1c4a3f4, 24134 B, mtime 2026-08-26 21:44 JST, read 2026-08-26). GPT numbering 1-100 -> tracker 777-876. All OPEN at entry; nothing closed from memory. Overall: Z_3-tower GO (three R17 gates accepted: norm-one, all-(n,r) spectral rank, MO2016 improvement; Track A GO, repaired Track B GO; Z_3 in the title justified); NO-GO for sealing/Zenodo/submission of the r17 zip AS IS, on two artifact grounds: (A) the P3 certificate is C-labelled while tools/check_p3_cert.py only checks JSON consistency / script hash / stored endpoints / improvement flags and does not recompute eta_n -> lambda_j -> hat lambda_k -> D -> C from the definitions (no read-only replay); (B) the uploaded zip lacks 12 files listed in MANIFEST_SHA256.txt. Absolute priority for R18 = read-only P3 verifier + staging-tree seal/zip/re-extract/manifest, before any general odd p / extra layers / extra primes / class-1 / Luo note. Re-derived on <LOCAL_HOST> 2026-08-26 BEFORE entry [MC]: (A) zip listing vs manifest: exactly 12 manifest entries absent from the zip = archive/rounds/r12/main_R12.{aux,out,toc}, sage/family_ky1000/driver_0{0..5}.out, sage/family_ky1000/verify_driver.out, sage/family_ky1000_r11_clean/driver.out, sage/family_survey/driver.out — cause: the zip exclusion list (/tmp/r16_zip.sh pattern) drops *.out/*.aux/*.toc globally, so nohup .out logs listed in the manifest were excluded after the manifest was generated; manifest header also still says "r11" (GPT did not see this); (B) tools/check_p3_cert.py is 83 lines: sha256 of the producer script, JSON internal consistency, verbatim print-string check — no recomputation [MC]; JSON rows carry mid / rad_upper / lo / hi at 40 significant digits and prec_bits 4000 at top level, no rounding-mode field: the enclosure reconstructible from the JSON is the 40-digit outward interval, not the 1e-800 ball (GPT's "40-digit only" overstated — radius and prec_bits ARE stored — but the substantive point holds); (C) metadata: CITATION.cff notes and .zenodo.json identifier say main_R16.pdf (tools/check_release_metadata.py syncs the version line only — gate gap); main_R17.tex line 1 header "main_R16.tex", line 25 pdfsubject "r16", line 381 BLUEPRINT_MAP_R16, line 506 CLAIMS_R16.yaml + BLUEPRINT_MAP_R16, line 514 blueprint_r16.pdf / STATEMENT_FREEZE_R15 / ERRATA_R15 (more than GPT listed); blueprint/src/print.tex pdftitle/pdfsubject "r15", legend "Package: weber_general_n r16"; README line 1 keeps the r16 header with 2.1204e44 / 1.4562e22; tab:p3 caption uses "best published uniform-in-n bound" verbatim and "two independent routes" [MC]; (D) numbers: C3rel(4,4) lo 1.072749779768158358e33 (GPT 1.0727497797681584e33), G(3,4,1) 3.7111e37, G(3,4,2) 6.0919e18, gains 3.4594e4 / 1.8599e2 (GPT 3.46e4 / 1.86e2), sqrt 3.2753e16 (GPT 3.276e16) — all consistent; |disc Q(zeta_{3^r})| = 3^{3^{r-1}(2r-1)} from p^{p^{r-1}(pr-r-1)} [hand]; (E) GPT's Step 2 formula hat lambda_k = (chi_k(1+3^n)^{-1} - 1) chi_k(2)^{-1} T(chi_k) is our omega^{j_0 k}(omega^{Nk/3}-1) hat Gamma_k rewritten (chi_k(a) = omega^{-Nk/3}, -2 = 4^{j_0}, T = the log-cyclotomic sum) — equivalent, no new mathematics [hand]; (F) B_{3,0} = Q, h_{3,0} = 1 absent from proofs/ and main_R17.tex [MC]; lem_normone (i) already states a^3 == 1, a != 1 (exact order 3 in substance); thm_P3.tex floor paragraph invokes normone(iv) on eps in U_{3,n} — correct through the definition of U_{3,n}, GPT's request is a presentational general lemma. LETTER_R17 questions: (1)-(3), (5) unanswered a fourth time -> DECLINED BY SILENCE, restatement stops; (6) touched only by item 79 (write the MO2016 comparison as layer-fixed vs uniform) — the s >= 5 sub-question unanswered -> declined by silence; (7) ANSWERED by sect 2 + items 86-87: finer granularity — isolate as separate L inputs the log-cyclotomic sum formula (Washington), the Gauss-sum normalisation, L(1,chi) != 0, and conductor exactly 3^{n+1}; (8) ANSWERED in part: the Lean DFT/character layer (items 82-85) ranks BELOW certificate/zip hardening (P1/P3), and the Track A M-steps are not mentioned, so no relative ranking of the two Lean directions was given. Decisions (a)(b): (a) not mentioned; (b) acknowledged in sect 7 ("GitHub final cleanup later, in one batch") — recorded, no argument.

| hw | GPT | item | status | note |
|---|---|---|---|---|
| 777 | 1 | [P0] state B_{3,0} = Q and h_{3,0} = 1 explicitly | DONE | main_R18.tex notation paragraph of sect 9 |
| 778 | 2 | [P0] state that a = 1+3^n has exact order 3 mod 3^{n+1} | DONE | lem:normone statement + proof (i) — lem_normone (i) states a^3 == 1, a != 1; wording "exact order 3" to be made explicit |
| 779 | 3 | [P0] P3 floor paragraph: do not apply Lemma normone(iv) to an arbitrary unit | DONE | proofs/thm_P3.tex floor paragraph via normone (v) |
| 780 | 4 | [P0] general lemma: a relative-norm-one unit with H != 0 is not in the lower layer (Nr eps = eps^3 = 1 => eps = 1) | DONE | lem:normone clause (v) (statement + proof) |
| 781 | 5 | [P0] write the conductor proof of the primitive character chi_k in full | DONE | proofs/thm_rank3.tex Step 2 "Conductor" |
| 782 | 6 | [P0] fix the Gauss-sum / L(1,chi) convention of the Fourier coefficient | DONE | Step 2 "Conventions": absolute-value form, no Gauss sum |
| 783 | 7 | [P0] unify the DFT sign convention across paper, Blueprint and code | DONE | Step 2 "Conventions": minus sign; certificate header conventions; Lean any omega^N=1 |
| 784 | 8 | [P0] re-check the 1/N normalisation of the Gram route vs the spectral route | DONE | Step 4 "Normalisation" paragraph |
| 785 | 9 | [P0] discriminant exponent 3^{r-1}(2r-1) as a separate lemma | DONE | lem:disc [L] (paper + Blueprint node; thm:rank3 uses it) |
| 786 | 10 | [P0] MO2016 comparison: name the bound, not "best published" | DONE | abstract, sect 9 intro, tab:p3 caption, cor:P3n4, cor_P3n4.tex, CLAIMS — tab:p3 caption line 361 "best published uniform-in-n bound" verbatim |
| 787 | 11 | [P0] "two independent routes" -> "two independent linear-algebraic routes from the same log profile" | DONE | tab:p3 caption + thm_rank3 Step 4 |
| 788 | 12 | [P1] create verify_p3_readonly.sage | DONE | scripts/verify_p3_readonly.sage; log sage/r18_trackB/verify_p3_readonly_r18.log (15/15, negctl 5/5, 12 s) |
| 789 | 13 | [P1] do not trust the shipped JSON as input | DONE | scripts/verify_p3_readonly.sage; log sage/r18_trackB/verify_p3_readonly_r18.log (15/15, negctl 5/5, 12 s) |
| 790 | 14 | [P1] construct eta_n from the definition | DONE | scripts/verify_p3_readonly.sage; log sage/r18_trackB/verify_p3_readonly_r18.log (15/15, negctl 5/5, 12 s) |
| 791 | 15 | [P1] regenerate all conjugate logs in Arb (ball arithmetic) | DONE | scripts/verify_p3_readonly.sage; log sage/r18_trackB/verify_p3_readonly_r18.log (15/15, negctl 5/5, 12 s) |
| 792 | 16 | [P1] recompute the Gram determinant route | DONE | scripts/verify_p3_readonly.sage; log sage/r18_trackB/verify_p3_readonly_r18.log (15/15, negctl 5/5, 12 s) |
| 793 | 17 | [P1] recompute the DFT / spectral product route | DONE | scripts/verify_p3_readonly.sage; log sage/r18_trackB/verify_p3_readonly_r18.log (15/15, negctl 5/5, 12 s) |
| 794 | 18 | [P1] check that the two intervals intersect | DONE | scripts/verify_p3_readonly.sage; log sage/r18_trackB/verify_p3_readonly_r18.log (15/15, negctl 5/5, 12 s) |
| 795 | 19 | [P1] recompute the strong floor Lrel_{3,n} | DONE | scripts/verify_p3_readonly.sage; log sage/r18_trackB/verify_p3_readonly_r18.log (15/15, negctl 5/5, 12 s) |
| 796 | 20 | [P1] recompute C^{(3)}_{n,r} | DONE | scripts/verify_p3_readonly.sage; log sage/r18_trackB/verify_p3_readonly_r18.log (15/15, negctl 5/5, 12 s) |
| 797 | 21 | [P1] recompute MO2016 G(3,s,f) | DONE | scripts/verify_p3_readonly.sage; log sage/r18_trackB/verify_p3_readonly_r18.log (15/15, negctl 5/5, 12 s) |
| 798 | 22 | [P1] re-check improvement in both classes on all 15 rows | DONE | scripts/verify_p3_readonly.sage; log sage/r18_trackB/verify_p3_readonly_r18.log (15/15, negctl 5/5, 12 s) |
| 799 | 23 | [P1] write a semantic normalized JSON to a temp directory | DONE | scripts/verify_p3_readonly.sage; log sage/r18_trackB/verify_p3_readonly_r18.log (15/15, negctl 5/5, 12 s) |
| 800 | 24 | [P1] compare semantic identity with the shipped summary | DONE | scripts/verify_p3_readonly.sage; log sage/r18_trackB/verify_p3_readonly_r18.log (15/15, negctl 5/5, 12 s) |
| 801 | 25 | [P1] never overwrite shipped files | DONE | scripts/verify_p3_readonly.sage; log sage/r18_trackB/verify_p3_readonly_r18.log (15/15, negctl 5/5, 12 s) |
| 802 | 26 | [P1] reject a malformed certificate (negative control) | DONE | scripts/verify_p3_readonly.sage; log sage/r18_trackB/verify_p3_readonly_r18.log (15/15, negctl 5/5, 12 s) |
| 803 | 27 | [P1] reject a certificate with one route missing (negative control) | DONE | scripts/verify_p3_readonly.sage; log sage/r18_trackB/verify_p3_readonly_r18.log (15/15, negctl 5/5, 12 s) |
| 804 | 28 | [P1] reject a wrong-discriminant certificate (negative control) | DONE | scripts/verify_p3_readonly.sage; log sage/r18_trackB/verify_p3_readonly_r18.log (15/15, negctl 5/5, 12 s) |
| 805 | 29 | [P1] reject a certificate swapped to the weak floor (negative control) | DONE | scripts/verify_p3_readonly.sage; log sage/r18_trackB/verify_p3_readonly_r18.log (15/15, negctl 5/5, 12 s) |
| 806 | 30 | [P1] reject a certificate comparing with MO2013 only (negative control) | DONE | scripts/verify_p3_readonly.sage; log sage/r18_trackB/verify_p3_readonly_r18.log (15/15, negctl 5/5, 12 s) |
| 807 | 31 | [P1] include the verifier version / hash in its summary | DONE | scripts/verify_p3_readonly.sage; log sage/r18_trackB/verify_p3_readonly_r18.log (15/15, negctl 5/5, 12 s) |
| 808 | 32 | [P2] store the full-precision outward lower endpoint | DONE | certificates/p3/D3_cert_r18.json v2 (tools/p3_interval.py); check_p3_cert.py --print identical to r17 |
| 809 | 33 | [P2] store the full-precision outward upper endpoint | DONE | certificates/p3/D3_cert_r18.json v2 (tools/p3_interval.py); check_p3_cert.py --print identical to r17 |
| 810 | 34 | [P2] store the midpoint | DONE | certificates/p3/D3_cert_r18.json v2 (tools/p3_interval.py); check_p3_cert.py --print identical to r17 |
| 811 | 35 | [P2] store the radius | DONE | certificates/p3/D3_cert_r18.json v2 (tools/p3_interval.py); check_p3_cert.py --print identical to r17 |
| 812 | 36 | [P2] store precision bits | DONE | certificates/p3/D3_cert_r18.json v2 (tools/p3_interval.py); check_p3_cert.py --print identical to r17 |
| 813 | 37 | [P2] store the rounding mode | DONE | certificates/p3/D3_cert_r18.json v2 (tools/p3_interval.py); check_p3_cert.py --print identical to r17 |
| 814 | 38 | [P2] do not use the 40-digit ball_str alone as the proved value | DONE | certificates/p3/D3_cert_r18.json v2 (tools/p3_interval.py); check_p3_cert.py --print identical to r17 |
| 815 | 39 | [P2] exact dyadic endpoints or sufficiently directed decimals | DONE | certificates/p3/D3_cert_r18.json v2 (tools/p3_interval.py); check_p3_cert.py --print identical to r17 |
| 816 | 40 | [P2] assert lower < upper | DONE | certificates/p3/D3_cert_r18.json v2 (tools/p3_interval.py); check_p3_cert.py --print identical to r17 |
| 817 | 41 | [P2] Gram route and spectral route in separate fields | DONE | certificates/p3/D3_cert_r18.json v2 (tools/p3_interval.py); check_p3_cert.py --print identical to r17 |
| 818 | 42 | [P2] intersection interval in a separate field | DONE | certificates/p3/D3_cert_r18.json v2 (tools/p3_interval.py); check_p3_cert.py --print identical to r17 |
| 819 | 43 | [P2] paper rounding values generated from the certificate automatically | DONE | certificates/p3/D3_cert_r18.json v2 (tools/p3_interval.py); check_p3_cert.py --print identical to r17 |
| 820 | 44 | [P2] separate display error from certificate radius | DONE | certificates/p3/D3_cert_r18.json v2 (tools/p3_interval.py); check_p3_cert.py --print identical to r17 |
| 821 | 45 | [P3] create a release staging directory | DONE | executed at the R18 seal (see HANDOFF SEAL R18 block); protocol in RELEASE_STATUS.md r18 revision |
| 822 | 46 | [P3] exclude .aux/.out and other by-products from the release set | DONE | executed at the R18 seal (see HANDOFF SEAL R18 block); protocol in RELEASE_STATUS.md r18 revision |
| 823 | 47 | [P3] generate the manifest on the staging tree | DONE | executed at the R18 seal (see HANDOFF SEAL R18 block); protocol in RELEASE_STATUS.md r18 revision |
| 824 | 48 | [P3] run the full verifier on the staging tree | DONE | executed at the R18 seal (see HANDOFF SEAL R18 block); protocol in RELEASE_STATUS.md r18 revision |
| 825 | 49 | [P3] do not modify the staging tree after the full verifier | DONE | executed at the R18 seal (see HANDOFF SEAL R18 block); protocol in RELEASE_STATUS.md r18 revision |
| 826 | 50 | [P3] zip the staging tree as is | DONE | executed at the R18 seal (see HANDOFF SEAL R18 block); protocol in RELEASE_STATUS.md r18 revision |
| 827 | 51 | [P3] re-extract the zip into a separate directory | DONE | executed at the R18 seal (see HANDOFF SEAL R18 block); protocol in RELEASE_STATUS.md r18 revision |
| 828 | 52 | [P3] check the manifest on the re-extracted tree | DONE | executed at the R18 seal (see HANDOFF SEAL R18 block); protocol in RELEASE_STATUS.md r18 revision |
| 829 | 53 | [P3] run the portable verifier on the re-extracted tree at least for manifest / paper / Blueprint | DONE | executed at the R18 seal (see HANDOFF SEAL R18 block); protocol in RELEASE_STATUS.md r18 revision |
| 830 | 54 | [P3] record the zip SHA-256 | DONE | executed at the R18 seal (see HANDOFF SEAL R18 block); protocol in RELEASE_STATUS.md r18 revision |
| 831 | 55 | [P3] missing 0 / unlisted 0 as a hard gate | DONE | executed at the R18 seal (see HANDOFF SEAL R18 block); protocol in RELEASE_STATUS.md r18 revision |
| 832 | 56 | [P3] old .out files not in the manifest | DONE | executed at the R18 seal (see HANDOFF SEAL R18 block); protocol in RELEASE_STATUS.md r18 revision — the 12 missing files of the r17 zip are exactly these (.out nohup logs + r12 aux/out/toc) |
| 833 | 57 | [P3] unneeded auxiliary files inside archive/ excluded from the release | DONE | executed at the R18 seal (see HANDOFF SEAL R18 block); protocol in RELEASE_STATUS.md r18 revision |
| 834 | 58 | [P4] fix the PDF Subject r16 | DONE | 2026-08-26 22:14-22:15 (CITATION/.zenodo/print.tex/README/TRUST/main_R18.tex; tools/check_release_metadata.py extended) |
| 835 | 59 | [P4] fix the Blueprint title r15 | DONE | 2026-08-26 22:14-22:15 (CITATION/.zenodo/print.tex/README/TRUST/main_R18.tex; tools/check_release_metadata.py extended) |
| 836 | 60 | [P4] fix the Blueprint package r16 | DONE | 2026-08-26 22:14-22:15 (CITATION/.zenodo/print.tex/README/TRUST/main_R18.tex; tools/check_release_metadata.py extended) |
| 837 | 61 | [P4] fix .zenodo.json main_R16 | DONE | 2026-08-26 22:14-22:15 (CITATION/.zenodo/print.tex/README/TRUST/main_R18.tex; tools/check_release_metadata.py extended) — check_release_metadata.py must also cover the notes/identifier fields |
| 838 | 62 | [P4] fix CITATION.cff main_R16 | DONE | 2026-08-26 22:14-22:15 (CITATION/.zenodo/print.tex/README/TRUST/main_R18.tex; tools/check_release_metadata.py extended) — check_release_metadata.py must also cover the notes/identifier fields |
| 839 | 63 | [P4] remove the old P3 constants from the README current summary | DONE | 2026-08-26 22:14-22:15 (CITATION/.zenodo/print.tex/README/TRUST/main_R18.tex; tools/check_release_metadata.py extended) |
| 840 | 64 | [P4] fix the TeX header main_R16 | DONE | 2026-08-26 22:14-22:15 (CITATION/.zenodo/print.tex/README/TRUST/main_R18.tex; tools/check_release_metadata.py extended) — main_R17.tex line 1 comment header; also lines 381/506/514 (BLUEPRINT_MAP_R16, CLAIMS_R16, blueprint_r16.pdf, STATEMENT_FREEZE_R15, ERRATA_R15) |
| 841 | 65 | [P4] BLUEPRINT_MAP_R16 references -> current map | DONE | 2026-08-26 22:14-22:15 (CITATION/.zenodo/print.tex/README/TRUST/main_R18.tex; tools/check_release_metadata.py extended) |
| 842 | 66 | [P4] generate version information from a single source | DONE | 2026-08-26 22:14-22:15 (CITATION/.zenodo/print.tex/README/TRUST/main_R18.tex; tools/check_release_metadata.py extended) |
| 843 | 67 | [P4] remove the round number from the submission-facing title | DONE | 2026-08-26 22:14-22:15 (CITATION/.zenodo/print.tex/README/TRUST/main_R18.tex; tools/check_release_metadata.py extended) |
| 844 | 68 | [P4] metadata sync test for the current PDF and Blueprint | DONE | 2026-08-26 22:14-22:15 (CITATION/.zenodo/print.tex/README/TRUST/main_R18.tex; tools/check_release_metadata.py extended) |
| 845 | 69 | [P5] shorten the abstract | DONE | abstract rewritten |
| 846 | 70 | [P5] move the fine improvement factors to the Introduction or a table | DONE | factors only in tab:p3 / cor:P3n4 |
| 847 | 71 | [P5] remove the R16 / R17 round history from the body | DONE | body: r11/r14 mentions removed (sect 5, App E) |
| 848 | 72 | [P5] remove ERRATA references from the body | DONE | "Errata E15-1" removed from App E intro; ERRATA_R17 ref removed from tab:p3 caption |
| 849 | 73 | [P5] move internal file paths to the Verification Appendix | DONE | body file paths -> Appendix F references (Lean declaration names kept as identifiers) |
| 850 | 74 | [P5] remove trust labels from theorem titles | DONE | 23 theorem titles stripped |
| 851 | 75 | [P5] collect trust labels in one table | DONE | tab:legend + CORRESPONDENCE.csv + Blueprint |
| 852 | 76 | [P5] separate development history from mathematical claims | DONE | history only in ERRATA_R18 / RELEASE_STATUS |
| 853 | 77 | [P5] do not force the 36 pages shorter; remove duplication only | DONE | no forced cuts |
| 854 | 78 | [P5] strengthen the Introduction linking Z_2 and Z_3 through the one SH framework | DONE | Introduction paragraph "one theorem, two towers" |
| 855 | 79 | [P5] state precisely that the MO2016 improvement is layer-fixed vs a uniform bound | DONE | abstract, intro, caption, cor:P3n4 |
| 856 | 80 | [P6] Lean: norm-one telescope | DONE | confirmed in <LOCAL_LEAN_WORKSPACE>/weber_r17/WeberP3Rel.lean: telescope_three, sin_telescope_step (since r17) — already in Lean since r17 (WeberP3Rel: telescope_three/sin_telescope_step; a_cube_modEq_one; dft_vanish_of_relnorm; eq_zero_of_vanish_on_primitiveRoots) — to be confirmed against the file, not closed from memory |
| 857 | 81 | [P6] Lean: order-3 congruence | DONE | confirmed: a_cube_modEq_one (since r17) — already in Lean since r17 (WeberP3Rel: telescope_three/sin_telescope_step; a_cube_modEq_one; dft_vanish_of_relnorm; eq_zero_of_vanish_on_primitiveRoots) — to be confirmed against the file, not closed from memory |
| 858 | 82 | [P6] Lean: polynomial rank argument | PARTIAL | polynomial step in Lean (eq_zero_of_vanish_on_primitiveRoots, totient_three_pow); Parseval/Vandermonde M (= hw 733) — partly in Lean (eq_zero_of_vanish_on_primitiveRoots, totient_three_pow); Parseval/Vandermonde step remains M (= hw 733 residue) |
| 859 | 83 | [P6] Lean: DFT vanishing for 3 | k | DONE — confirmed: dft_vanish_of_relnorm (since r17) — already in Lean since r17 (WeberP3Rel: telescope_three/sin_telescope_step; a_cube_modEq_one; dft_vanish_of_relnorm; eq_zero_of_vanish_on_primitiveRoots) — to be confirmed against the file, not closed from memory |
| 860 | 84 | [P6] Lean: primitive-root polynomial divisibility | DONE | confirmed: eq_zero_of_vanish_on_primitiveRoots (since r17) — already in Lean since r17 (WeberP3Rel: telescope_three/sin_telescope_step; a_cube_modEq_one; dft_vanish_of_relnorm; eq_zero_of_vanish_on_primitiveRoots) — to be confirmed against the file, not closed from memory |
| 861 | 85 | [P6] Lean: finite linear-algebra part of the exact determinant | OPEN | not started (no new Lean in r18 by ruling) |
| 862 | 86 | [P6] isolate Washington / Dirichlet nonvanishing as L | DONE | lem:D3, lem:dirichlet, lem:disc [L]; THM_RANK3 inputs list the four L inputs separately |
| 863 | 87 | [P6] isolate Horie lemma / MO floor as L | DONE | lem:horie13, lem:mo25 [L] |
| 864 | 88 | [P6] P3 theorem: paper / Blueprint / Lean statements literally synchronized | PARTIAL | paper/Blueprint statements identical; Lean theoremP3_core = discrete core (as in r16) |
| 865 | 89 | [P6] update the #print axioms listing | DONE | boot census 63 decl std-3; no new Lean |
| 866 | 90 | [P6] C label only after the read-only verifier exists | DONE | C of CERT_D3 rests on step 04f |
| 867 | 91 | [P6] until then mark the P3 table "C-pending replay" | DONE | moot: replay exists (superseded by 90) |
| 868 | 92 | [P7] fix MO2016 as the primary comparator | DONE | tab:p3 / cor:P3n4 / CLAIMS |
| 869 | 93 | [P7] demote MO2013 to historical comparison | DONE | tab:p3 caption "for the historical record" |
| 870 | 94 | [P7] confirm the exact result of Morisawa 2012 | OPEN |  |
| 871 | 95 | [P7] search for explicit odd-p upper bounds after MO2016 | OPEN |  |
| 872 | 96 | [P7] search for prior instances of an exact Horie log-covolume formula | OPEN |  |
| 873 | 97 | [P7] check later literature citing KY / MO | OPEN |  |
| 874 | 98 | [P7] no "new" / "first" until the final audit | DONE | grep: no "is new"/"first" claims in the body (only "the first 1000 primes") |
| 875 | 99 | [P7] split the novelty matrix into Z_2 and Z_3 | OPEN |  |
| 876 | 100 | [P7] split Z_3 novelty into spectral rank / exact covolume / explicit improvement | OPEN |  |

## R19 — GPT r18 review (Weberレビュー.txt md5 52efdb3d4e6048aa9d565b942b660c17, 20916 B, mtime 2026-08-27 11:48 JST, read 2026-08-27, node <LOCAL_HOST>). GPT numbering 1-101 -> tracker 877-977; Claude-found items 978-984. All OPEN at entry except 881 (= GPT 5, reproduced at the boot) and 971-976 (STOP rules, DEFERRED policy). Nothing closed from memory. Overall: mathematics GO on every theorem (SH, Z_2 Thm A, criterion, Prop D, n=7, KY1000, Z_3 norm-one, spectral rank, exact covolume, P3, (4,4) corollary: 95-99%); NO-GO for sealing r18 AS IS on four artifact grounds, none mathematical: (1) the read-only verifier checks only that the shipped interval MEETS the recomputed one (overlap), not that it CONTAINS it — 65/120 load-bearing intervals fail containment (n=4,r=4 C3rel shipped upper endpoint 3.4e-1167 below the recomputed one); (2) current proof source proofs/cor_P3n4.tex still cites D3_cert_r17.json / r17 producer; STATEMENT_FREEZE_R18 (R17 block), blueprint/README (blueprint_r17.pdf), proofs/README (main_R17.tex), CLAIMS_R18.yaml header (CLAIMS_R17) stale; check_release_metadata.py does not audit them; (3) Blueprint \label{lem:mo25} defined twice (Z_2 height floor l.60, Z_3 relative-norm-one floor l.340; LaTeX 'multiply defined'); (4) submission body still carries 'statement numbers are to be confirmed against a physical copy' (main l.334, l.480) and 'The r16 version ... see ERRATA_R17' (proofs/thm_P3.tex l.9, shared into paper and Blueprint); overfull boxes main 4 (max 17.7pt), Blueprint 9 (max 13.5pt). Re-derived on <LOCAL_HOST> 2026-08-27 BEFORE entry, all [MC]: manifest on the re-extracted zip 4579/0/0 md5 d4b2f374; KY1000 = the first 1000 primes > 1e9 with l == 65 (mod 128), distinct, all prime, 1000000321..1001287361; check_graph 64/88/39 proofs; containment 65/120 with exactly GPT's example gap (-3.347e-1167), plus ship subset rec 110/120 and identical 45/120 (the shipped balls are NARROWER than the independent ones); n=4,r=4 recomputed D 3.2566331593197598214e54, Lrel 7.0107178918636975872, C 1.0727497797681583582e33, sqrt C 3.2752859108300123456e16, G(3,4,1) 3.7111406e37, G(3,4,2) 6.0919132e18 — GPT's six numbers to the printed digit; verify_p3_readonly.sage l.147 = overlap() only [MC]; the four stale references and the two label lines at the stated line numbers [MC]; print.aux carries two \newlabel{lem:mo25}, the second (7.2, Z_3) wins, so the Z_2 Lemma A+ (content.tex l.104 \uses{lem:mo25}) resolves to the Z_3 floor in the shipped Blueprint PDF; check_graph has no duplicate-label test and counts 64 nodes for 65 unique labels of 66 definitions (the two lem:mo25 nodes merged) — Claude-found; overfull 4/17.73pt and 9/13.47pt from verify_out logs in the zip; Washington GTM 83 is NOT in paper/ (GPT item 52 'from the included source' has a false premise). LETTER_R18: the scoreboard (777-876) is not itemized by GPT; the R18 repairs are accepted in substance (manifest 4579/0/0 confirmed; read-only verifier 'a real advance', 98%; metadata sync judged incomplete = the r17 references above). Question (9) (remaining artifact conditions before the final release): ANSWERED by the 15 hard gates of the review (containment 120/120, shifted-overlap negctl, D3_cert_r19.json, r17 current refs 0, duplicate labels 0, Washington wording 0, ERRATA refs 0, paper values generated, full verifier 0/0, fresh-extraction manifest 0/0 + P3 replay PASS, LaTeX label warnings 0, metadata sync, zip SHA-256, no edit after verification). Question (10) (novelty matrix: paper table or repository document): NOT ANSWERED (first silence) — restate once in LETTER_R19 with a default (repository document + one-line pointer in the paper). Decisions: (a) explicitly acknowledged in sect 5 ('no external endorsement needed', distinguished from citation confirmation) — recorded, no argument; (b) consistent with P6 (local seal only, zip SHA-256 recorded, no push) — recorded. GPT's P7 = our hw 696/772 policy, unchanged.

| hw | GPT | item | status | note |
|---|---|---|---|---|
| 877 | 1 | [P0] abolish PASS by overlap only in the read-only verifier | DONE | scripts/verify_p3_readonly.sage r19: contains() gate on 8 fields x 15 rows = 120; overlap never accepted; p3_containment_detail.json written |
| 878 | 2 | [P0] require shipped interval to CONTAIN the recomputed interval | DONE | scripts/verify_p3_readonly.sage r19: contains() gate on 8 fields x 15 rows = 120; overlap never accepted; p3_containment_detail.json written |
| 879 | 3 | [P0] assert I_rec subset I_ship on every load-bearing field | DONE | scripts/verify_p3_readonly.sage r19: contains() gate on 8 fields x 15 rows = 120; overlap never accepted; p3_containment_detail.json written |
| 880 | 4 | [P0] containment report over 15 rows x 8 intervals = 120 | DONE | scripts/verify_p3_readonly.sage r19: contains() gate on 8 fields x 15 rows = 120; overlap never accepted; p3_containment_detail.json written |
| 881 | 5 | [P0] reproduce the r18 65/120 containment failure | DONE | re-derived at the R19 boot: 65/120 (D_dft 15, D_intersection 15, C3rel 15, C3rel_sqrt 15, D_gram 5; Lrel/G 0); n=4,r=4 C3rel ship.hi - rec.hi = -3.347e-1167 [MC] |
| 882 | 6 | [P0] build the outward hull of producer and read-only intervals | DONE | tools/gen_p3_cert_r19.py -> certificates/p3/D3_cert_r19.json v3 (widen_x2(hull(producer, readonly)), exact dyadics, provenance per field, radius/prec/rounding, routes in own fields, intersection != hull); check_p3_cert.py --print strings from the v3 cert (unchanged digits); verifier PASS containment 120/120 |
| 883 | 7 | [P0] generate certificates/p3/D3_cert_r19.json | DONE | tools/gen_p3_cert_r19.py -> certificates/p3/D3_cert_r19.json v3 (widen_x2(hull(producer, readonly)), exact dyadics, provenance per field, radius/prec/rounding, routes in own fields, intersection != hull); check_p3_cert.py --print strings from the v3 cert (unchanged digits); verifier PASS containment 120/120 |
| 884 | 8 | [P0] store hull lo/hi as exact dyadics | DONE | tools/gen_p3_cert_r19.py -> certificates/p3/D3_cert_r19.json v3 (widen_x2(hull(producer, readonly)), exact dyadics, provenance per field, radius/prec/rounding, routes in own fields, intersection != hull); check_p3_cert.py --print strings from the v3 cert (unchanged digits); verifier PASS containment 120/120 |
| 885 | 9 | [P0] store midpoint, radius, precision bits, rounding mode | DONE | tools/gen_p3_cert_r19.py -> certificates/p3/D3_cert_r19.json v3 (widen_x2(hull(producer, readonly)), exact dyadics, provenance per field, radius/prec/rounding, routes in own fields, intersection != hull); check_p3_cert.py --print strings from the v3 cert (unchanged digits); verifier PASS containment 120/120 |
| 886 | 10 | [P0] Gram-route interval in its own field | DONE | tools/gen_p3_cert_r19.py -> certificates/p3/D3_cert_r19.json v3 (widen_x2(hull(producer, readonly)), exact dyadics, provenance per field, radius/prec/rounding, routes in own fields, intersection != hull); check_p3_cert.py --print strings from the v3 cert (unchanged digits); verifier PASS containment 120/120 |
| 887 | 11 | [P0] spectral-route interval in its own field | DONE | tools/gen_p3_cert_r19.py -> certificates/p3/D3_cert_r19.json v3 (widen_x2(hull(producer, readonly)), exact dyadics, provenance per field, radius/prec/rounding, routes in own fields, intersection != hull); check_p3_cert.py --print strings from the v3 cert (unchanged digits); verifier PASS containment 120/120 |
| 888 | 12 | [P0] never confuse intersection with hull | DONE | tools/gen_p3_cert_r19.py -> certificates/p3/D3_cert_r19.json v3 (widen_x2(hull(producer, readonly)), exact dyadics, provenance per field, radius/prec/rounding, routes in own fields, intersection != hull); check_p3_cert.py --print strings from the v3 cert (unchanged digits); verifier PASS containment 120/120 |
| 889 | 13 | [P0] paper display values generated from the R19 certificate | DONE | tools/gen_p3_cert_r19.py -> certificates/p3/D3_cert_r19.json v3 (widen_x2(hull(producer, readonly)), exact dyadics, provenance per field, radius/prec/rounding, routes in own fields, intersection != hull); check_p3_cert.py --print strings from the v3 cert (unchanged digits); verifier PASS containment 120/120 |
| 890 | 14 | [P0] safe upper bound from the hull upper endpoint | DONE | tools/gen_p3_cert_r19.py -> certificates/p3/D3_cert_r19.json v3 (widen_x2(hull(producer, readonly)), exact dyadics, provenance per field, radius/prec/rounding, routes in own fields, intersection != hull); check_p3_cert.py --print strings from the v3 cert (unchanged digits); verifier PASS containment 120/120 |
| 891 | 15 | [P0] comparator lower bound from the rigorous lower endpoint | DONE | tools/gen_p3_cert_r19.py -> certificates/p3/D3_cert_r19.json v3 (widen_x2(hull(producer, readonly)), exact dyadics, provenance per field, radius/prec/rounding, routes in own fields, intersection != hull); check_p3_cert.py --print strings from the v3 cert (unchanged digits); verifier PASS containment 120/120 |
| 892 | 16 | [P0] R19 containment 120/120 PASS as a hard gate | DONE | tools/gen_p3_cert_r19.py -> certificates/p3/D3_cert_r19.json v3 (widen_x2(hull(producer, readonly)), exact dyadics, provenance per field, radius/prec/rounding, routes in own fields, intersection != hull); check_p3_cert.py --print strings from the v3 cert (unchanged digits); verifier PASS containment 120/120 |
| 893 | 17 | [P1] negctl: certificate that meets but does not contain the recomputed interval | DONE | negctl 6-12 in the replay: all REJECTED (sage/r19_trackB/verify_p3_readonly_r19.log); the r18 gate accepts plant 6 (r18gate_accepts_plant6_r19.log) |
| 894 | 18 | [P1] negctl: shipped lower endpoint moved inward only | DONE | negctl 6-12 in the replay: all REJECTED (sage/r19_trackB/verify_p3_readonly_r19.log); the r18 gate accepts plant 6 (r18gate_accepts_plant6_r19.log) |
| 895 | 19 | [P1] negctl: shipped upper endpoint moved inward only | DONE | negctl 6-12 in the replay: all REJECTED (sage/r19_trackB/verify_p3_readonly_r19.log); the r18 gate accepts plant 6 (r18gate_accepts_plant6_r19.log) |
| 896 | 20 | [P1] negctl: Gram route alone under-covers | DONE | negctl 6-12 in the replay: all REJECTED (sage/r19_trackB/verify_p3_readonly_r19.log); the r18 gate accepts plant 6 (r18gate_accepts_plant6_r19.log) |
| 897 | 21 | [P1] negctl: spectral route alone under-covers | DONE | negctl 6-12 in the replay: all REJECTED (sage/r19_trackB/verify_p3_readonly_r19.log); the r18 gate accepts plant 6 (r18gate_accepts_plant6_r19.log) |
| 898 | 22 | [P1] negctl: C alone under-covers | DONE | negctl 6-12 in the replay: all REJECTED (sage/r19_trackB/verify_p3_readonly_r19.log); the r18 gate accepts plant 6 (r18gate_accepts_plant6_r19.log) |
| 899 | 23 | [P1] negctl: sqrt C alone under-covers | DONE | negctl 6-12 in the replay: all REJECTED (sage/r19_trackB/verify_p3_readonly_r19.log); the r18 gate accepts plant 6 (r18gate_accepts_plant6_r19.log) |
| 900 | 24 | [P1] all negative controls rejected by the read-only verifier | DONE | 12/12 rejected |
| 901 | 25 | [P1] negative-control ledger generated from a single JSON | DONE | sage/r19_trackB/p3_negctl_ledger_r19.json -> docs/P3_NEGCTL_LEDGER_R19.md (tools/gen_p3_negctl_ledger.py --check; step 04h + 04h_fresh) |
| 902 | 26 | [P1] no hand-typed counts in paper / Blueprint / README | DONE | check_constant_sync reads NEG_P3 from the structured JSON; media forms twelve/12-12 gated |
| 903 | 27 | [P2] proofs/cor_P3n4.tex: r17 certificate reference -> r19 | DONE | proofs/cor_P3n4.tex: \artPcert / \artPgen / \artPreplay / \artPcover (paper: IDs + Appendix F; Blueprint: paths) |
| 904 | 28 | [P2] producer reference -> the R19 source | DONE | proofs/cor_P3n4.tex: \artPcert / \artPgen / \artPreplay / \artPcover (paper: IDs + Appendix F; Blueprint: paths) |
| 905 | 29 | [P2] name the read-only verifier there too | DONE | proofs/cor_P3n4.tex: \artPcert / \artPgen / \artPreplay / \artPcover (paper: IDs + Appendix F; Blueprint: paths) |
| 906 | 30 | [P2] theory/STATEMENT_FREEZE_R18.md made current | DONE | theory/STATEMENT_FREEZE_R19.md (N10 on top; R18 verbatim below) |
| 907 | 31 | [P2] blueprint/README.md made current | DONE | blueprint/README.md r19 |
| 908 | 32 | [P2] proofs/README.md made current | DONE | proofs/README.md main_R19 |
| 909 | 33 | [P2] docs/CLAIMS_R18.yaml header comment fixed | DONE | docs/CLAIMS_R19.yaml header + CERT_D3 restated |
| 910 | 34 | [P2] grep the active tree: zero r17 references used as current evidence | DONE | check_release_metadata.py PASS; grep clean (history-marked lines only) |
| 911 | 35 | [P2] r17 references inside archive/ are allowed | DONE | archive/rounds/ untouched |
| 912 | 36 | [P2] check_release_metadata.py audits proofs/ | DONE | tools/check_release_metadata.py r19: proofs/*.tex, content.tex, current FREEZE block, both READMEs, CLAIMS header, README, TRUST audited |
| 913 | 37 | [P2] ... audits STATEMENT_FREEZE | DONE | tools/check_release_metadata.py r19: proofs/*.tex, content.tex, current FREEZE block, both READMEs, CLAIMS header, README, TRUST audited |
| 914 | 38 | [P2] ... audits blueprint/README.md | DONE | tools/check_release_metadata.py r19: proofs/*.tex, content.tex, current FREEZE block, both READMEs, CLAIMS header, README, TRUST audited |
| 915 | 39 | [P2] ... audits the claims header | DONE | tools/check_release_metadata.py r19: proofs/*.tex, content.tex, current FREEZE block, both READMEs, CLAIMS header, README, TRUST audited |
| 916 | 40 | [P2] stale current certificate path fails CI | DONE | stale current path -> RELEASE METADATA SYNC: FAIL (verifier hard gate) |
| 917 | 41 | [P3] fix the duplicated \label{lem:mo25} | DONE | lem:mo25-z2 (Z_2, Lemma A+) / lem:mo25-z3 (Z_3, Thm P3; paper + proofs/thm_P3.tex); all \ref / \uses updated; gen_blueprint_map THM_P3 -> lem:mo25-z3 |
| 918 | 42 | [P3] Z_2 side -> lem:mo25-z2 (or similar) | DONE | lem:mo25-z2 (Z_2, Lemma A+) / lem:mo25-z3 (Z_3, Thm P3; paper + proofs/thm_P3.tex); all \ref / \uses updated; gen_blueprint_map THM_P3 -> lem:mo25-z3 |
| 919 | 43 | [P3] Z_3 side -> lem:mo25-z3 (or similar) | DONE | lem:mo25-z2 (Z_2, Lemma A+) / lem:mo25-z3 (Z_3, Thm P3; paper + proofs/thm_P3.tex); all \ref / \uses updated; gen_blueprint_map THM_P3 -> lem:mo25-z3 |
| 920 | 44 | [P3] update every \ref | DONE | lem:mo25-z2 (Z_2, Lemma A+) / lem:mo25-z3 (Z_3, Thm P3; paper + proofs/thm_P3.tex); all \ref / \uses updated; gen_blueprint_map THM_P3 -> lem:mo25-z3 |
| 921 | 45 | [P3] LaTeX multiply-defined labels = 0 | DONE | multiply 0 (print.log) |
| 922 | 46 | [P3] undefined references = 0 | DONE | undefined 0 |
| 923 | 47 | [P3] build LaTeX twice or more so references settle | DONE | two passes in /tmp/r19_pdf_ship.sh and in verifier steps 10b/11 |
| 924 | 48 | [P3] PDF visual check: Theorem P3 cites the Z_3 relative floor | DONE | pdftotext: Theorem 7.7 (P3) cites Lemma 7.2 (Z_3 relative floor) |
| 925 | 49 | [P3] PDF visual check: Z_2 Theorem A cites the Z_2 floor | DONE | pdftotext: Lemma 3.2 (A+) cites Lemma 2.5 (Z_2 floor) |
| 926 | 50 | [P3] Blueprint overfull boxes below 10pt | DONE | Blueprint overfull 2 / max 9.04pt (tolerance 2000; \allowbreak in path macros; lem_normone (v) displayed) |
| 927 | 51 | [P4] delete "statement numbers are to be confirmed" | DONE | main l.334/480 wording withdrawn |
| 928 | 52 | [P4] fix Washington theorem numbers from the source | PARTIAL | RULING hw 984: Washington GTM 83 is not on disk; cited at CHAPTER level (Ch.2 discriminant/integral basis; Ch.4 L(1,chi) formula, Gauss-sum modulus), no theorem/page number asserted from memory; numbers remain OPEN hw 29 |
| 929 | 53 | [P4] fix page numbers | PARTIAL | RULING hw 984: Washington GTM 83 is not on disk; cited at CHAPTER level (Ch.2 discriminant/integral basis; Ch.4 L(1,chi) formula, Gauss-sum modulus), no theorem/page number asserted from memory; numbers remain OPEN hw 29 |
| 930 | 54 | [P4] fix the chi / bar chi convention | PARTIAL | RULING hw 984: Washington GTM 83 is not on disk; cited at CHAPTER level (Ch.2 discriminant/integral basis; Ch.4 L(1,chi) formula, Gauss-sum modulus), no theorem/page number asserted from memory; numbers remain OPEN hw 29 |
| 931 | 55 | [P4] fix the Gauss-sum convention | PARTIAL | RULING hw 984: Washington GTM 83 is not on disk; cited at CHAPTER level (Ch.2 discriminant/integral basis; Ch.4 L(1,chi) formula, Gauss-sum modulus), no theorem/page number asserted from memory; numbers remain OPEN hw 29 |
| 932 | 56 | [P4] delete every "physical copy pending" wording | DONE | no 'physical copy' wording in paper/, proofs/, blueprint/ |
| 933 | 57 | [P4] delete "The r16 version ..." from the body | DONE | proofs/thm_P3.tex sentence removed |
| 934 | 58 | [P4] delete "see ERRATA_R17" from the body | DONE | idem |
| 935 | 59 | [P4] delete development history from the submission body | DONE | also thm_S0 (r14/E15-1 remark), prop_F (R15), lem_Sineq (r10), lem_depthfloor (r14/r15), thm_family (r11), Artifact index; grep of the body for r1N / ERRATA / round = 0 |
| 936 | 60 | [P4] development history only in archive / supplement | DONE | ERRATA_R*.md, archive/rounds/, RELEASE_STATUS, tracker |
| 937 | 61 | [P4] only the current proof in the body | DONE | body = current proof only |
| 938 | 62 | [P4] no round numbers in submission-facing theorems or captions | DONE | trust-table caption path-free; Documents paragraph path-free (ruling hw 979); Cor 1.9 constant displayed |
| 939 | 63 | [P4] main overfull boxes below 10pt | DONE | main overfull 3 / max 7.27pt (\emergencystretch 3em; C_7 displayed) |
| 940 | 64 | [P4] long paths -> artifact IDs | DONE | [P3-CERT] [P3-GEN] [P3-REPLAY] [P3-COVER] [P3-CHECK] |
| 941 | 65 | [P4] full paths in the correspondence table | DONE | Appendix F (Artifact index) carries the paths |
| 942 | 66 | [P5] read-only verifier keeps trusting nothing shipped | DONE | replay trusts nothing shipped (unchanged) |
| 943 | 67 | [P5] document the roles of producer checker and read-only verifier | DONE | TRUST.md C paragraph: three roles, never one checker; headers of the three tools |
| 944 | 68 | [P5] producer checker = internal consistency | DONE | TRUST.md C paragraph: three roles, never one checker; headers of the three tools |
| 945 | 69 | [P5] read-only verifier = semantic recomputation | DONE | TRUST.md C paragraph: three roles, never one checker; headers of the three tools |
| 946 | 70 | [P5] containment checker = certificate coverage | DONE | TRUST.md C paragraph: three roles, never one checker; headers of the three tools |
| 947 | 71 | [P5] never call the three roles one checker | DONE | TRUST.md C paragraph: three roles, never one checker; headers of the three tools |
| 948 | 72 | [P5] structured semantic summary | DONE | p3_readonly_summary.json (format p3_readonly_summary_r19) |
| 949 | 73 | [P5] raw log hash is not a mathematical hard gate | DONE | no gate parses a raw log (check_constant_sync reads the JSON ledger) |
| 950 | 74 | [P5] threshold comparisons on structured values | DONE | containment / improvement decided on Decimal endpoints and Arb balls |
| 951 | 75 | [P5] verifier version / source SHA-256 in the summary | DONE | summary carries verifier_version r19 + verifier_sha256 + cert_sha256 |
| 952 | 76 | [P5] certificate schema version bumped | DONE | p3_covol_cert_r19_v3 |
| 953 | 77 | [P5] R18 schema accepted or explicitly deprecated | DONE | v2 REJECTED as deprecated (sage/r19_trackB/verify_r18cert_deprecated_r19.log) |
| 954 | 78 | [P5] unknown schema rejected | DONE | unknown format_version rejected |
| 955 | 79 | [P6] make the R19 staging tree | DONE | executed at the R19 seal attempt 2 (HANDOFF SEAL R19 block, full verifier 2026-08-27T04:10:16Z; bumped DONE at the R20 boot) |
| 956 | 80 | [P6] manifest on the staging tree | DONE | executed at the R19 seal attempt 2 (HANDOFF SEAL R19 block, full verifier 2026-08-27T04:10:16Z; bumped DONE at the R20 boot) |
| 957 | 81 | [P6] full Sage verification on the staging tree | DONE | executed at the R19 seal attempt 2 (HANDOFF SEAL R19 block, full verifier 2026-08-27T04:10:16Z; bumped DONE at the R20 boot) |
| 958 | 82 | [P6] Lean on the staging tree | DONE | executed at the R19 seal attempt 2 (HANDOFF SEAL R19 block, full verifier 2026-08-27T04:10:16Z; bumped DONE at the R20 boot) |
| 959 | 83 | [P6] rebuild the paper | DONE | executed at the R19 seal attempt 2 (HANDOFF SEAL R19 block, full verifier 2026-08-27T04:10:16Z; bumped DONE at the R20 boot) |
| 960 | 84 | [P6] rebuild the Blueprint | DONE | executed at the R19 seal attempt 2 (HANDOFF SEAL R19 block, full verifier 2026-08-27T04:10:16Z; bumped DONE at the R20 boot) |
| 961 | 85 | [P6] label warnings = 0 | DONE | executed at the R19 seal attempt 2 (HANDOFF SEAL R19 block, full verifier 2026-08-27T04:10:16Z; bumped DONE at the R20 boot) |
| 962 | 86 | [P6] P3 containment 120/120 PASS | DONE | executed at the R19 seal attempt 2 (HANDOFF SEAL R19 block, full verifier 2026-08-27T04:10:16Z; bumped DONE at the R20 boot) |
| 963 | 87 | [P6] all negative controls rejected | DONE | executed at the R19 seal attempt 2 (HANDOFF SEAL R19 block, full verifier 2026-08-27T04:10:16Z; bumped DONE at the R20 boot) |
| 964 | 88 | [P6] no change of the staging tree after full verification | DONE | executed at the R19 seal attempt 2 (HANDOFF SEAL R19 block, full verifier 2026-08-27T04:10:16Z; bumped DONE at the R20 boot) |
| 965 | 89 | [P6] zip that tree as is | DONE | executed at the R19 seal attempt 2 (HANDOFF SEAL R19 block, full verifier 2026-08-27T04:10:16Z; bumped DONE at the R20 boot) |
| 966 | 90 | [P6] re-extract into a separate directory | DONE | executed at the R19 seal attempt 2 (HANDOFF SEAL R19 block, full verifier 2026-08-27T04:10:16Z; bumped DONE at the R20 boot) |
| 967 | 91 | [P6] manifest re-check on the re-extracted tree | DONE | executed at the R19 seal attempt 2 (HANDOFF SEAL R19 block, full verifier 2026-08-27T04:10:16Z; bumped DONE at the R20 boot) |
| 968 | 92 | [P6] P3 read-only verifier re-run on the re-extracted tree | DONE | executed at the R19 seal attempt 2 (HANDOFF SEAL R19 block, full verifier 2026-08-27T04:10:16Z; bumped DONE at the R20 boot) |
| 969 | 93 | [P6] record the zip SHA-256 | DONE | executed at the R19 seal attempt 2 (HANDOFF SEAL R19 block, full verifier 2026-08-27T04:10:16Z; bumped DONE at the R20 boot) |
| 970 | 94 | [P6] 0 missing / 0 unlisted as a hard gate | DONE | executed at the R19 seal attempt 2 (HANDOFF SEAL R19 block, full verifier 2026-08-27T04:10:16Z; bumped DONE at the R20 boot) |
| 971 | 95 | [P7] STOP: no general odd p | DEFERRED | policy (unchanged from hw 696/772 etc.); nothing to execute |
| 972 | 96 | [P7] STOP: no additional layer | DEFERRED | policy (unchanged from hw 696/772 etc.); nothing to execute |
| 973 | 97 | [P7] STOP: no KY1000 growth | DEFERRED | policy (unchanged from hw 696/772 etc.); nothing to execute |
| 974 | 98 | [P7] STOP: no class-1 search | DEFERRED | policy (unchanged from hw 696/772 etc.); nothing to execute |
| 975 | 99 | [P7] STOP: no n=7 complete proof | DEFERRED | policy (unchanged from hw 696/772 etc.); nothing to execute |
| 976 | 100 | [P7] STOP: no Luo companion note yet | DEFERRED | policy (unchanged from hw 696/772 etc.); nothing to execute |
| 977 | 101 | [P7] close only certificate / sync / body in R19 | DONE | closed at the R19 seal (no mathematics, no Lean, no statement change; bumped DONE at the R20 boot) |
| 978 | - | [C-R19] check_graph.py: duplicate labels must FAIL (content.tex has 66 \label, 65 unique, graph reports 64 nodes: the two lem:mo25 lemmas are MERGED into one node; the Z_2 lem:Aplus \uses{lem:mo25} and the shipped print.aux resolve to the Z_3 lemma 7.2) | DONE | Claude-found at the R19 boot [MC]; not in the GPT list — check_graph.py: DUPLICATE LABEL -> FAIL (negative control caught); 65 nodes |
| 979 | - | [C-R19] main_R18.tex l.519 "Documents" paragraph names docs/ERRATA_R18.md, RELEASE_STATUS.md, TRUST.md paths in the submission body — hard gate 7 (ERRATA references 0) needs a ruling: move the paragraph to README / a repository-facing note, or keep a path-free pointer | DONE | ruling point — ruling: Documents paragraph path-free |
| 980 | - | [C-R19] root cause of ship-narrower-than-recomputed (ship subset rec in 110/120, identical 45/120): locate the operation-order difference between the producer p3_covol_cert_r18.sage and the read-only verifier (D_dft 15/15 differ); record in ERRATA_R19 | DONE | [MC] numbers at the R19 boot — root cause: producer uses matrix determinant() + per-term exp(-2 pi i jk/N); replay uses Gram-Schmidt + omega-power table; both rigorous, different rounding histories; recorded ERRATA_R19 E19-1 |
| 981 | - | [C-R19] hull policy: hull(producer, read-only) computed on <LOCAL_HOST> equals the verifier's own balls, so containment on the same machine is tautological; decide whether the R19 certificate adds a DOCUMENTED outward margin (e.g. radius x2, still rel width < 1e-700) so that a foreign Arb build with a different rounding history still satisfies I_rec subset I_ship | DONE | ruling point (GPT item 6 alone does not settle it) — ruling: widen x2 about the hull centre, documented in the certificate header (margin_policy) and TRUST.md |
| 982 | - | [C-R19] vault verify_out/ still holds R15-R17 paper by-products (main_R15/16/17.*); not shipped (verify_out is regenerated on the staging tree) — joins the standing vault by-product OPEN | OPEN | vault only; no package effect |
| 983 | - | [C-R19] docs/ERRATA_R19.md: E19-1 interval semantics (overlap vs containment, 65/120), E19-2 stale r17 evidence references in current proof source, E19-3 duplicate label merged by check_graph | DONE | write before the seal — docs/ERRATA_R19.md E19-1/2/3 + wording item |
| 984 | - | [C-R19] GPT item 52-55 premise: Washington GTM 83 is NOT in paper/ (no PDF; the book is not open access) — the theorem/page/convention fix depends on Dr. Fukui's copy (NEXT ACTION 2, hw 29/70/497/585-590); Claude does not fix citation numbers from memory | OPEN | blocker for hard gate 6 unless the copy arrives — BLOCKER for the theorem numbers only; the wording is gone (chapter-level citation, ruling) |

## R20 — GPT r19 review (Weberレビュー.txt md5 76c5b4964e0fc6b4a6b0af2860d01d67, 19588 B, mtime 2026-08-27 13:59 JST, read 2026-08-27, node <LOCAL_HOST>). GPT numbering 1-65 -> tracker 985-1049; Claude-found items 1050-1059 (1059 added during the round). All OPEN at entry except the policy items (1005, 1026, 1027, 1029, 1043-1049: DEFERRED, nothing to execute). Nothing closed from memory. Overall: the R18 artifact repair ACCEPTED (all 15 hard gates of r18 = PASS in GPT's table; P3 certificate GO 99% "no further certificate architecture needed"; KY1000 GO 99%; general-n paper GO); the r19 zip itself NO-GO "until small fixes", on TWO NEW MATHEMATICAL-TEXT grounds, both mine: (1) SCOPE: Theorem P3 (paper main_R19.tex l.351, Blueprint content.tex l.366) says "l != 3 a prime", hence includes l = 2, while the proof needs l ODD (lem_normone (iv): Nr(eps)^l = 1, Nr(eps) real, l odd => Nr(eps) = 1, Lean WeberP3Rel.eq_one_of_odd_pow_eq_one with `Odd l`; and the conclusion step applies Theorem SH, whose statement l.54 already assumes "l an odd prime"); (2) FALSE EQUALITY: proofs/thm_rank3.tex l.5 writes "a = 1+N = 4^{N/3}" and "Since a = 4^{N/3}" as integer equalities; only the congruence 4^{N/3} == 1+N (mod q), q = 3N, is true (and is what Lemma normone (ii) / Lean four_pow_modEq prove). Re-derived on <LOCAL_HOST> 2026-08-27 BEFORE entry, all [MC]: the two statement lines carry "\ell\ne3$ a prime" and no oddness; lem_normone.tex l.11 "$\ell$ an odd prime", l.15 "with the odd exponent 3"; WeberP3Rel.eq_one_of_odd_pow_eq_one : Odd l -> x^l = 1 -> x = 1 (x real); WeberP3.theoremP3_core takes only 0 < l (generic carrier, no oddness — oddness enters at the M-step lem_normone (iv), exactly as GPT says); four_pow_modEq : 4^(3^(n-1)) == 1 + 3^n [ZMOD 3^(n+1)]; python: 4^{N/3} == 1+N (mod 3N) for n = 1..12 TRUE, equality 4^{N/3} = 1+N FALSE for every n >= 2 (n = 2: 64 vs 10, GPT's example reproduced; n = 1 is the only case where it happens to be an equality, 4 = 4); thm_rank3.tex contains exactly the two false equalities GPT lists (grep of the active tree: proofs/thm_rank3.tex only; archive untouched); the same paragraph also writes "-2 = 4^{j_0}" (an identity in (Z/q)^x, i.e. a congruence — same notation class, not flagged by GPT, Claude-found 1050); Cor P3n4 requires l == +-1 (mod 81), which forces l odd (2 !== +-1 mod 81; 81k +- 1 is even for odd k), so the n = 4 numbers 1.0728e33 / 3.2753e16 and the factors 3.4594e4 / 1.8599e2 are untouched — GPT's claim confirmed; GPT's alternative sign-correction for l = 2 (N(eps) = -1 => N(-eps) = (-1)^3 N(eps) = 1, relative degree 3, |H| unchanged) is correct as far as it goes but is NOT adopted (GPT recommends the odd-prime restriction; so do I); the abstract's Z_3 sentence (l.31) and the introduction state no prime condition for the Z_3 bound and mention only the classes l == +-1 (mod 81) — no contradiction, audit items 987/988 are a one-line confirmation; docs/CLAIMS_R19.yaml THM_P3.statement carries NO prime condition at all (not even l != 3) — Claude-found 1051; "to be confirmed against a physical copy" survives in the CURRENT ledgers (CORRESPONDENCE.csv PROP_D_ii / THM_RANK3, TRUST.md l.42, CLAIMS_R19.yaml l.84/247, STATEMENT_FREEZE_R19 l.27/328) as GPT item 33/35 says — the book is still not on disk (hw 984), so the ledger can only be made chapter-level (like the body), the numbers stay OPEN (1052); KY1000 summary numbers (primes 1000 / T 32000 / RHO 31987 / T-only 13 / max T 4164.489721582 / margin 59.510278418) match sage/family_ky1000_r11_clean/VERIFY_LEDGER.txt; check_graph 65/88/39 proofs; paper 38 pp / Blueprint 32 pp / overfull 7.27 / 9.04 pt match the R19 seal record. LETTER_R19: the scoreboard (877-984) is not itemized by GPT — its 15-gate table = PASS on every line, which is the acceptance of 877-970 in substance (955-970 + 977 bumped DONE at this boot, executed at the seal); question (10) (novelty matrix placement) NOT ANSWERED a second time -> per the standing rule the DEFAULT is adopted (docs/NOVELTY_MATRIX.md generated from the claims + one-sentence pointer in the introduction) and the question is not restated (1053); question (11) (widen_x2 of the hull vs bare hull) NOT ANSWERED explicitly — GPT rates the v3 certificate GO 99% and says the certificate architecture needs nothing further, which is acceptance of the shipped policy by silence: recorded, no argument, not restated (1054). Decisions: (a) not mentioned — recorded, no argument; (b) restated by GPT as its item 65 ("GitHub cleanup in one batch after this synchronisation") and in its final paragraph — recorded, no argument. GPT's P6 (59-64) = our hw 696/772/971-976 policy, unchanged. GPT's item 11 asks for NEW LEAN (a paper-facing wrapper with `Odd l`); r18/r19 were "no new Lean by ruling" — ruling point (1055). GPT's item 23 names a `check_math_notation.py` that does not exist (tools/ has no notation checker) — the forbidden-string gate goes into an existing gate or a new small tool (ruling; 1056). This is the FIRST statement change since STATEMENT_FREEZE_R19 N10 ("no statement changes"): R20 needs FREEZE N11 (Theorem P3 scope narrowed to odd primes; every other statement unchanged) and ERRATA_R20 E20-1 (scope) + E20-2 (false equality) (1057). Each row is closed only when the artifact is on disk and re-verified.

| hw | GPT | item | status | note |
|---|---|---|---|---|
| 985 | 1 | [P0] paper Theorem P3: "l != 3 a prime" -> "l != 3 an odd prime" (main tex l.351) | DONE | statement change -> FREEZE N11 + ERRATA_R20 E20-1; the Blueprint line (content.tex l.366) is the twin of 986 -- main_R20.tex l.351 "an odd prime" |
| 986 | 2 | [P0] Blueprint Theorem P3: same wording | DONE | content.tex l.366; byte-identical statement text in both media (1058 checker) -- content.tex l.366, byte-identical (13c) |
| 987 | 3 | [P0] audit the introduction's P3 summary | DONE | [MC] at boot: no prime condition stated in sect 1 for the Z_3 bound; confirm after the edit and record the line numbers -- [MC] sect 1 states no prime condition for the Z_3 bound; no edit |
| 988 | 4 | [P0] audit the abstract's P3 summary | DONE | [MC] at boot: abstract l.31 names only the classes l == +-1 (mod 81) (odd); confirm, no edit expected -- [MC] abstract names only l == +-1 (mod 81); no edit |
| 989 | 5 | [P0] docs/CLAIMS_R20.yaml THM_P3: odd-prime condition in the statement string | DONE | current string has NO prime condition at all (1051); add "l != 3 an odd prime" + machine-readable conditions (1013) -- CLAIMS_R20 THM_P3 statement + conditions {n_ge_1, ell_prime, ell_ne_3, ell_odd} |
| 990 | 6 | [P0] regenerate CORRESPONDENCE.csv | DONE | tools/gen_correspondence.py r20 after 989; header status_..._r20 -- gen_correspondence r20, header status_2026-08-27_r20 |
| 991 | 7 | [P0] theory/STATEMENT_FREEZE: current N block records the P3 scope | DONE | N11 (R20): Theorem P3 scope narrowed to odd primes l != 3; all other statements unchanged; N10 kept as history -- STATEMENT_FREEZE_R20 N11 |
| 992 | 8 | [P0] TRUST.md: P3 scope | DONE | P3 row / paragraph: l odd prime, oddness consumed at LEM_NORMONE (iv) (M) via eq_one_of_odd_pow_eq_one (F) -- TRUST.md M paragraph (r20 sentence) + L block |
| 993 | 9 | [P0] proofs/thm_P3.tex: "Since l is odd ..." at the start of the proof | DONE | shared proof (paper + Blueprint); one sentence naming where oddness is used (transfer (iv) and Theorem SH's hypothesis) -- thm_P3.tex "The prime." paragraph |
| 994 | 10 | [P0] Horie input and the norm-one bridge: same symbol for the prime | DONE | lem_normone (iv) uses \ell; thm_P3 uses \ell; check the MO13 Lemma 1.3 sentence and Theorem SH's l — unify and record -- \ell in lem_normone (iv), thm_P3, Theorem SH; MO13 sentence unchanged (uses \ell) |
| 995 | 11 | [P0] Lean paper-facing wrapper with `Odd l` as a hypothesis | DEFERRED | NEW LEAN — ruling point 1055; if ruled yes: new file weber_r20/..., 13th load-bearing file, verifier step 09 + md5 list + declaration count change -- RULED 2026-08-27: no new Lean in R20; R21+ with hw 858/861 |
| 996 | 12 | [P0] theoremP3_core stays generic; the correspondence states that oddness is needed at the M/F bridge | DONE | CORRESPONDENCE / BLUEPRINT_MAP / TRUST: one sentence; this is what hard gate 3 requires (Lean MAP, not new Lean) -- CLAIMS conditions_note; TRUST.md; BLUEPRINT_MAP_R20 (four_pow_modEq row) |
| 997 | 13 | [P0] regenerate #print axioms record and the correspondence | DONE | if 995 ruled no: the 12-file axiom record is unchanged (re-run at the seal, step 09); correspondence regenerated by 990 -- no new Lean: axiom record unchanged (63 decl std-3, boot + step 09); CORRESPONDENCE regenerated |
| 998 | 14 | [P0] unit test: l = 2 is outside Theorem P3 | DONE | where: statement-sync checker (1058) asserts the phrase "odd prime" in both statement texts and the claims conditions ell_odd = true; a planted "a prime" variant must FAIL -- check_statement_sync --negctl: paper wording / Blueprint wording / claims phrase planted -> 3/3 REJECTED (step 13c) |
| 999 | 15 | [P0] assert Cor P3n4 unchanged | DONE | [MC] at boot: l == +-1 (mod 81) forces l odd; certificate D3_cert_r19.json untouched (gen --check byte-identical); record in ERRATA_R20 E20-1 -- recorded in ERRATA_R20 E20-1 + FREEZE N11; cert gen --check byte-identical |
| 1000 | 16 | [P1] delete "a = 1+N = 4^{N/3}" | DONE | proofs/thm_rank3.tex l.5 (first occurrence) -- thm_rank3.tex l.5 |
| 1001 | 17 | [P1] write "a = 1+N == 4^{N/3} (mod q)" | DONE | same line; Lemma normone (ii) is the reference -- a=1+N, a \equiv 4^{N/3} \pmod q + four_pow_modEq |
| 1002 | 18 | [P1] "Since a = 4^{N/3}" -> congruence | DONE | proofs/thm_rank3.tex l.5 (second occurrence); chi_k(a) is evaluated on the class of a mod q -- "Since a \equiv 4^{N/3} \pmod q ... chi_k is a function of the class modulo q" |
| 1003 | 19 | [P1] one sentence: character arguments are classes mod q | DONE | thm_rank3.tex Step 2, next to the definition of chi_k -- in the same parenthesis of Step 2 |
| 1004 | 20 | [P1] paper and Blueprint updated together from the shared proof source | DONE | proofs/thm_rank3.tex is \input by both (check_graph single-source 39/39); confirm after rebuild -- shared proof; both PDFs rebuilt and read (pdftotext: a \equiv 4^{N/3} (mod q) in both) |
| 1005 | 21 | [P1] archive copies may keep the old wording as history | DEFERRED | policy; archive/ and docs/archive/ untouched |
| 1006 | 22 | [P1] grep the active tree: no false integer equality left | DONE | [MC] at boot: only proofs/thm_rank3.tex l.5 (two hits) outside archive; re-grep after the edit, include \_-escaped and spaced forms -- [MC] grep of proofs/ + main_R20.tex + content.tex: 0 hits; gate 00e |
| 1007 | 23 | [P1] CI forbidden string for the stale equality | DONE | no check_math_notation.py exists (1056): add the pattern to tools/check_release_metadata.py or a new tools/check_notation.py; must catch `= *4\^{N/3}` and `=4^{N/3}` in proofs/, paper/draft/main_R20.tex, blueprint/src/ -- tools/check_release_metadata.py FORBID (3 patterns; self-detected the three r19 hits before the edit); verifier step 00e |
| 1008 | 24 | [P1] Blueprint: name the Lean lemma four_pow_modEq at the congruence | DONE | content.tex / thm_rank3.tex: \path{WeberP3Rel.four_pow_modEq} at the congruence (the paper already cites Lemma normone (ii)) -- thm_rank3.tex names \path{WeberP3Rel.four_pow_modEq} twice (shared into the Blueprint) |
| 1009 | 25 | [P2] cross-check the odd condition: paper / Blueprint / claims / Lean map | DONE | 1058 checker + manual read -- check_statement_sync + manual read |
| 1010 | 26 | [P2] cross-check the rank-proof congruence: paper / Blueprint / Lean map | DONE | shared source -> one edit; BLUEPRINT_MAP row THM_RANK3 names four_pow_modEq -- shared source; BLUEPRINT_MAP_R20 THM_RANK3 row lists four_pow_modEq |
| 1011 | 27 | [P2] single source for the theorem statement (hash or normalized text) | DONE | scope ruling: minimal = 1058 (byte-compare the \begin{theorem}...\label{thm:P3} bodies of main tex and content.tex after whitespace normalisation) — full statement-hash system is out of R20 scope -- MINIMAL form by ruling (byte identity for 6 identical shared labels incl. thm:P3; phrase check for conditions); full single-source = hw 1059 / LETTER_R20 (12) |
| 1012 | 28 | [P2] machine-readable list of the P3 conditions | DONE | CLAIMS_R20.yaml THM_P3: conditions: {ell_prime: true, ell_ne_3: true, ell_odd: true, n_ge_1: true} -- CLAIMS_R20 THM_P3 conditions + conditions_phrases + conditions_tex (COR_P3N4) |
| 1013 | 29 | [P2] ell_prime / ell_ne_3 / ell_odd as separate fields | DONE | = 1012 -- = 1012 |
| 1014 | 30 | [P2] CI diff of the paper statement against the claims statement | DONE | 1058: the checker asserts that every condition field marked true has its phrase in the statement text ("odd prime", "\ne3") -- check_statement_sync (ii): claims statement vs paper vs Blueprint |
| 1015 | 31 | [P2] the same diff against the Blueprint statement | DONE | = 1058 -- = 1014 |
| 1016 | 32 | [P2] docs/ERRATA_R20.md records the scope error | DONE | E20-1 (scope) + E20-2 (false equality) + the notation item 1050 -- docs/ERRATA_R20.md E20-1/E20-2/E20-3 + ledger note |
| 1017 | 33 | [P3] THM_RANK3 input "theorem number to be confirmed": confirm against the source | PARTIAL | BLOCKED for the numbers: Washington GTM 83 is not on disk (hw 984); what CAN be done is 1052 (ledger at chapter level, numbers not asserted) -- ledger chapter-level (1052); the NUMBERS cannot be confirmed: Washington not on disk (hw 29/984, Dr. Fukui) |
| 1018 | 34 | [P3] if chapter-level citation suffices, write the reason in the trust ledger | DONE | reason: the L(1,chi) formula is used in absolute-value form and restated as Lemma D3, whose normalisation was independently checked (hw 30/32); the discriminant exponent is Lemma disc [L]; no theorem number is load-bearing -- TRUST.md L block: reason written |
| 1019 | 35 | [P3] remove "waiting for a physical copy" wording from the CURRENT trust ledger | DONE | ruling (1052): replace by chapter-level wording in CORRESPONDENCE / TRUST / CLAIMS / FREEZE current block; the OPEN item lives in this tracker only (hw 29/984) -- CORRESPONDENCE (via claims), TRUST.md, FREEZE current block, HUMAN_REVIEW history clause, REVIEWER_GUIDE "not claimed" line: chapter-level; numbers OPEN here only (hw 29/984) |
| 1020 | 36 | [P3] if Horie 2002 is unread and Ho05a Prop. 1 is the actual L input, say so consistently | DONE | body: MO13 Lemma 1.3 (attributed to Ho05b <- Ho02; general form with proof Ho05a Prop. 1); claims input string says "original not compared verbatim" — unify wording in body / TRUST / CLAIMS / FREEZE -- claims THM_P3 inputs + TRUST.md L: MO13 L1.3 [used] / Ho05a P1 [used] / Ho05b [relay] / Ho02 [unread] |
| 1021 | 37 | [P3] do not conflate "MO13 attributed to Ho05b" with the theorem actually used | DONE | = 1020; the L input actually used = MO13 Lemma 1.3 as stated there (read verbatim), with Ho05a Prop. 1 as the proved general form (read r17) -- = 1020 |
| 1022 | 38 | [P3] split the L inputs: actually used / historical source / unverified | DONE | TRUST.md L table: three columns or three tags per input (Ho02 = historical, unread; Ho05b = relay; MO13 L1.3 / Ho05a P1 = used, read) -- TRUST.md L: three tags defined and applied |
| 1023 | 39 | [P4] abstract 10-15% shorter | DEFERRED | ruling: polish in R20 or defer (GPT: R20 = scope-sync round) -- RULED 2026-08-27: P4 polish deferred |
| 1024 | 40 | [P4] artifact-verifier detail out of the abstract into the Verification section | DEFERRED | ruling as 1023 -- RULED 2026-08-27: P4 polish deferred |
| 1025 | 41 | [P4] consider moving one P3 improvement factor from the abstract to the introduction | DEFERRED | ruling as 1023 -- RULED 2026-08-27: P4 polish deferred |
| 1026 | 42 | [P4] title stays (Z_2 / Z_3 towers) | DEFERRED | policy; nothing to execute |
| 1027 | 43 | [P4] do not shorten the 38 pages by force | DEFERRED | policy; nothing to execute |
| 1028 | 44 | [P4] underfull warnings only where meaning is preserved | DEFERRED | ruling as 1023; count at the R20 build -- RULED 2026-08-27: P4 polish deferred |
| 1029 | 45 | [P4] overfull < 10 pt is not mandatory | DEFERRED | policy; keep the R19 settings (\emergencystretch 3em / \tolerance 2000) |
| 1030 | 46 | [P4] Table 3 caption: consider moving part into the body | DEFERRED | ruling as 1023 -- RULED 2026-08-27: P4 polish deferred |
| 1031 | 47 | [P5] rebuild LaTeX after the P3 scope edit | DONE | main_R20.pdf via the /tmp/r19_pdf_final.sh pattern -- main_R20.pdf 38 pp, errors 0, undefined 0, multiply 0, overfull 3 (max 7.27 pt) |
| 1032 | 48 | [P5] rebuild the Blueprint | DONE | blueprint_r20.pdf -- blueprint_r20.pdf 32 pp, overfull 2 (max 9.04 pt) |
| 1033 | 49 | [P5] duplicate / undefined labels 0 | DONE | check_graph duplicate gate + LaTeX log grep at the build -- check_graph duplicate gate 65 nodes; LaTeX multiply 0 / undefined 0 in both logs |
| 1034 | 50 | [P5] regenerate the manifest | DONE | on the STAGING tree only (r18 protocol; the vault manifest stays stale by design) -- executed at the R20 seal (recorded in the HANDOFF SEAL R20 block; bumped at the next boot) -- bumped DONE at the R21 boot 2026-08-27 (SEAL R20: full verifier 52 steps 0 FAIL 0 SKIP 05:49:30Z, containment 120/120, negctl 12/12, zip 2c43cae7...6c04, re-extract 4616/0/0) |
| 1035 | 51 | [P5] run the full local verifier | DONE | on the staging tree, ~13 min, 48 steps (+1 if 995 adds a Lean file, +1 for the notation gate 1007) -- executed at the R20 seal (recorded in the HANDOFF SEAL R20 block; bumped at the next boot) -- bumped DONE at the R21 boot 2026-08-27 (SEAL R20: full verifier 52 steps 0 FAIL 0 SKIP 05:49:30Z, containment 120/120, negctl 12/12, zip 2c43cae7...6c04, re-extract 4616/0/0) |
| 1036 | 52 | [P5] 0 FAIL / 0 SKIP | DONE | SUMMARY.json -- executed at the R20 seal (recorded in the HANDOFF SEAL R20 block; bumped at the next boot) -- bumped DONE at the R21 boot 2026-08-27 (SEAL R20: full verifier 52 steps 0 FAIL 0 SKIP 05:49:30Z, containment 120/120, negctl 12/12, zip 2c43cae7...6c04, re-extract 4616/0/0) |
| 1037 | 53 | [P5] P3 containment 120/120 again | DONE | step 04f/04g (+_fresh) -- executed at the R20 seal (recorded in the HANDOFF SEAL R20 block; bumped at the next boot) -- bumped DONE at the R21 boot 2026-08-27 (SEAL R20: full verifier 52 steps 0 FAIL 0 SKIP 05:49:30Z, containment 120/120, negctl 12/12, zip 2c43cae7...6c04, re-extract 4616/0/0) |
| 1038 | 54 | [P5] negative controls 12/12 again | DONE | step 04f --negctl / 04h -- executed at the R20 seal (recorded in the HANDOFF SEAL R20 block; bumped at the next boot) -- bumped DONE at the R21 boot 2026-08-27 (SEAL R20: full verifier 52 steps 0 FAIL 0 SKIP 05:49:30Z, containment 120/120, negctl 12/12, zip 2c43cae7...6c04, re-extract 4616/0/0) |
| 1039 | 55 | [P5] zip the fresh staging tree | DONE | as is, after removing run by-products -- executed at the R20 seal (recorded in the HANDOFF SEAL R20 block; bumped at the next boot) -- bumped DONE at the R21 boot 2026-08-27 (SEAL R20: full verifier 52 steps 0 FAIL 0 SKIP 05:49:30Z, containment 120/120, negctl 12/12, zip 2c43cae7...6c04, re-extract 4616/0/0) |
| 1040 | 56 | [P5] fresh-extraction manifest check | DONE | re-extract to /tmp, gen_manifest --check 0/0, lean+paper profile + P3 replay + containment there -- executed at the R20 seal (recorded in the HANDOFF SEAL R20 block; bumped at the next boot) -- bumped DONE at the R21 boot 2026-08-27 (SEAL R20: full verifier 52 steps 0 FAIL 0 SKIP 05:49:30Z, containment 120/120, negctl 12/12, zip 2c43cae7...6c04, re-extract 4616/0/0) |
| 1041 | 57 | [P5] record the zip SHA-256 | DONE | HANDOFF SEAL R20 block only (never inside the tree) -- executed at the R20 seal (recorded in the HANDOFF SEAL R20 block; bumped at the next boot) -- bumped DONE at the R21 boot 2026-08-27 (SEAL R20: full verifier 52 steps 0 FAIL 0 SKIP 05:49:30Z, containment 120/120, negctl 12/12, zip 2c43cae7...6c04, re-extract 4616/0/0) |
| 1042 | 58 | [P5] no mathematical statement change after that | DONE | = FREEZE N11 sealed; any later change = N12 + new round -- executed at the R20 seal (recorded in the HANDOFF SEAL R20 block; bumped at the next boot) -- bumped DONE at the R21 boot 2026-08-27 (SEAL R20: full verifier 52 steps 0 FAIL 0 SKIP 05:49:30Z, containment 120/120, negctl 12/12, zip 2c43cae7...6c04, re-extract 4616/0/0) |
| 1043 | 59 | [P6] STOP: no general odd p | DEFERRED | policy (hw 696/772/971) |
| 1044 | 60 | [P6] STOP: no extra P3 rows | DEFERRED | policy |
| 1045 | 61 | [P6] STOP: no KY1000 growth | DEFERRED | policy |
| 1046 | 62 | [P6] STOP: no class-1 search | DEFERRED | policy |
| 1047 | 63 | [P6] STOP: no n=7 complete proof | DEFERRED | policy |
| 1048 | 64 | [P6] STOP: no Luo companion note yet | DEFERRED | policy |
| 1049 | 65 | [P6] GitHub cleanup in one batch after this synchronisation | DEFERRED | = decision (b), recorded, no argument |
| 1050 | - | [C-R20] thm_rank3.tex l.5 also writes "-2 = 4^{j_0}" (an identity in (Z/q)^x): write it as a congruence mod q for consistency with 1001/1002 | DONE | same notation class as GPT's two hits; found at the boot grep -- thm_rank3.tex: -2 \equiv 4^{j_0} \pmod q (E20-3); forbidden by gate 00e |
| 1051 | - | [C-R20] CLAIMS_R19.yaml THM_P3.statement has NO prime condition on l (not even l != 3); Cor P3n4 string is fine | DONE | fix in CLAIMS_R20 (989); add a claims-vs-statement phrase check (1058) so a missing condition fails -- CLAIMS_R20 THM_P3 statement carries "every ODD prime l != 3"; conditions gate fails on omission |
| 1052 | - | [C-R20] "to be confirmed against a physical copy" survives in the CURRENT ledgers: CORRESPONDENCE.csv (PROP_D_ii, THM_RANK3), TRUST.md l.42, CLAIMS_R19.yaml l.84/247, STATEMENT_FREEZE_R19 l.27/328 — the body was made chapter-level in r19, the ledgers were not | DONE | ruling point: make the ledgers chapter-level too (hard gate 12), keep hw 29/984 OPEN here only; Claude does not write theorem numbers from memory -- all current ledgers chapter-level; "physical copy" only in verbatim history blocks |
| 1053 | - | [C-R20] LETTER_R19 (10) unanswered twice -> adopt the default: docs/NOVELTY_MATRIX.md (generated from the claims) + one-sentence pointer in the introduction; stop restating | DONE | execute in R20 (hw 868-876 novelty content still OPEN for Dr. Fukui — the document is the container, the reading is not) -- docs/NOVELTY_MATRIX.md by tools/gen_novelty_matrix.py (11 rows; step 13d); pointer in sect 2 via [NOVELTY], path in Appendix F |
| 1054 | - | [C-R20] LETTER_R19 (11) margin policy: no explicit answer; the v3 certificate rated GO 99% and "no further architecture needed" -> widen_x2 stands; recorded, not restated | DONE | recorded at the boot; nothing to execute |
| 1055 | - | [C-R20] ruling: new Lean in R20 (GPT item 11 wrapper with Odd l) vs the r18/r19 "no new Lean" invariant; hard gate 3 asks for the MAP only | DONE | proposal: NO new Lean in R20 (map + TRUST sentence satisfy gate 3; 12-file axiom record unchanged); wrapper joins hw 858/861 as R21+ Lean work -- RULED: no new Lean in R20; hw 995 -> R21+ |
| 1056 | - | [C-R20] GPT item 23 names check_math_notation.py which does not exist | DONE | implement the forbidden-string gate in check_release_metadata.py (extend) or tools/check_notation.py (new) — ruling on placement -- RULED: extension of check_release_metadata.py (step 00e) |
| 1057 | - | [C-R20] first statement change since N10: STATEMENT_FREEZE_R20 N11 + ERRATA_R20 E20-1/E20-2; RELEASE_STATUS r20 candidate must say "one statement narrowed (Theorem P3), no other change" | DONE | 1057 is the frame for 985-999 -- FREEZE N11 + ERRATA_R20 + RELEASE_STATUS r20 candidate written |
| 1058 | - | [C-R20] tools/check_statement_sync.py: (i) the theorem-environment text of thm:P3 (and every \label{thm:...}/lem:.../cor:... present in both) byte-equal between main_R20.tex and content.tex after whitespace normalisation; (ii) for each claim with a conditions block, every true condition has its phrase in the statement text; (iii) planted negative controls ("a prime" without odd; ell_odd true but phrase absent) FAIL; wired as a verifier step | DONE | minimal implementation of GPT 14/27/30/31; unit test 998 lives here -- tools/check_statement_sync.py (6 synced labels; conditions (ii); --negctl 3/3); verifier steps 13c + 13c negctl |
| 1059 | - | [C-R20] check_statement_sync reports 32 of the 38 shared theorem-like labels with DIFFERENT statement text between paper and Blueprint (the Blueprint rephrases / expands; reviewed as such since r16); six identical (thm:SH, thm:P3, cor:Ahat, cor:order, cor:SHmod, lem:prod13) locked by the checker; statement single-source (\input like the proofs) is the structural fix | OPEN | LETTER_R20 question (12) -> GPT ranks vs hw 858/861/995; R21+ candidate, mechanical, no mathematics |

## R21 — GPT r20 review (Weberレビュー.txt md5 6bdedd792079f7b8e5b5604e3ca9895f, 19653 B, mtime 2026-08-27 15:30 JST, read 2026-08-27, node <LOCAL_HOST>). GPT numbering 1-63 -> tracker 1060-1122; Claude-found items 1123-1126. Nothing closed from memory: the P0 rows are DONE only because the artifacts were written and gate-verified in this session before the entry. Overall: the two R19 mathematical points (E20-1 odd-prime scope, E20-2/E20-3 congruences) "both correctly closed"; no new mathematical gap; mathematics / text / internal artifacts "very close to submission GO" (internal 97%: mathematics 99, text 97, Blueprint 96, certificates 99); every theorem GO 98-99% (Blueprint GO pending the author's self sign-off, 96%); the R20 zip NO-GO as the FINAL GitHub-Actions / Zenodo version on ONE new ground, release engineering not mathematics: .github/workflows/verify.yml's `full` aggregator requires S["round"] == "r15" and L["round"] == "r15" and writes round='r15' into ci_attestation.json while scripts/verify_all_portable.sh writes "round": "r20" -- the clean run would FAIL at the aggregator after both profile jobs pass. GPT's instruction for R21: add NO mathematics; (1) fix the CI round sync (design: package round in one source, sage round == lean round == package round, attestation round from the summaries, a static checker with a planted stale round), (2) single-source ALL 38 shared theorem statements (answer to LETTER_R20 question (12): option (a), full single-source in proofs/statements/, not the conditions-only option (b); at least the 11 load-bearing ones, but all 38 at once is cheaper to maintain). Re-derived on <LOCAL_HOST> 2026-08-27 BEFORE entry, all [MC]: verify.yml l.126-127 `S.get('round') == 'r15'` / `L.get('round') == 'r15'`, l.131 `round='r15'`, file mtime 2026-08-26 11:55 (r15, never touched since); verify_all_portable.sh l.107 `round='r20'`; tools/check_release_metadata.py contains no 'github'/'workflow' token (GPT's root cause confirmed); manifest 4616/0/0; 32 of 38 shared labels differ (check_statement_sync INFO list counted); check_graph 65/88/39 proofs; KY1000 = 1000 distinct ascending primes > 1e9, all == 65 (mod 128), == the first 1000 such primes (sympy, independent of GPT's tool), witness files == ledger; P3 static / containment 120/120 / negctl 12/12 / profile tests 10/10; paper 38 pp Letter (612x792 pt) vs Blueprint 32 pp A4 (595x842 pt) = GPT's "page size differs"; /tmp/r20_pdf_final.log undefined 0 / multiply 0, overfull 3 (max 7.27 pt) / 2 (max 9.04 pt); P2 item 25: neither def:p3 nor thm:P3 says what "l | h_{3,n}/h_{3,n-1}" means (integer quotient or valuation) -- the Z_2 side has lem:ky17 (integrality) + lem:oldnew (v_l reading), the Z_3 side has no such sentence; lem:oldnew is stated for L/K cyclic of degree p^k, l != p, so it applies with p = 3 and gives v_l(h_{3,n}) >= v_l(h_{3,n-1}) -- GPT's remark correct; .zenodo.json related_identifier is the relative path paper/draft/main_R20.pdf, keywords carry no Z_3 term, CITATION.cff date-released 2026-08-26 (P5 items 57-60 correct, final-release round by decision (b)); the "Lean 78%" and the other percentages are GPT's ratings, recorded only. Claude-found: (i) docs/BLUEPRINT_HUMAN_REVIEW_R20.md's TABLE is the r15 snapshot (13 rows, generated 2026-08-26) -- thm:P3, thm:rank3, lem:normone, thm:SH, cor:P3n4, cor:SHmod, prop:D, thm:cert, thm:A have NO row although the header prose calls several of them KEY / UNSIGNED; of GPT's six sign-off targets only thm:Acore and thm:family have a row (1123); (ii) the review file's mtime (15:30 JST) precedes the HANDOFF's estimated posting time (~16:0x JST) -- the estimate was coarse; the content is unambiguously the r20 review (1125); (iii) verify_all_portable.sh step 12 (placeholders) listed docs/ERRATA_R16.md TWICE and never the current errata since r17 (1126). LETTER_R20 scoreboard (985-1059): not itemized by GPT; the R20 repairs are accepted in substance ("P3 odd-prime condition fully synchronized", "spectral rank congruence corrected", "machine-readable theorem conditions", statement sync PASS, manifest, negative controls); 1034-1042 bumped DONE at this boot (executed at the R20 seal); 1059 ANSWERED = option (a) (single-source all 38) -> executed as 1070-1083. Question (12): ANSWERED (a), recorded, no argument, not restated. Decisions: (a) explicitly acknowledged ("no external endorsement as a gate; the author's own final adversarial sign-off suffices", item 38) -- recorded, no argument; (b) acknowledged ("GitHub Actions execution may wait until the end; only the workflow's static correctness is closed now", item 10; P5 = the final release batch) -- recorded, no argument. The 12 hard gates GPT sets for the next version, status at this boot: 1 CI hard-code 0 -- NOT MET (three r15 literals); 2 CI round-sync checker -- NOT MET (absent); 3 shared statements 38/38 single-source -- NOT MET (6/38); 4 P3 odd condition inside the single-source statement -- follows 3; 5 false integer equality 0 -- met (00e); 6 author sign-off of the main F/M nodes -- NOT MET (and the ledger table lacks their rows, 1123); 7 statement sync PASS -- met; 8 full verifier 0/0 -- met (R20); 9 containment 120/120 -- met; 10 manifest 0/0 -- met; 11 fresh extraction -- met; 12 no new mathematics -- met. Ruling 2026-08-27 (GO on the R21 plan): A package round single source = CITATION.cff `version:` (the source check_statement_sync / check_release_metadata already read; no new JSON); B the paper wording is canonical for the 38 statements, the Blueprint rephrasings are dropped, any CONTENT difference found while moving a statement stops the work and is reported (it would be a statement change = FREEZE N12); C page sizes (Letter vs A4) are left to the journal-style stage, recorded; D the def:p3 sentence defining "l | h_{3,n}/h_{3,n-1}" as a valuation inequality is a definition, not a theorem-statement change: no FREEZE bump, ERRATA_R21 clarification entry; E the sign-off ledger is regenerated in R21, the signing itself is Dr. Fukui's separate session, the R21 seal does not wait for it. Each row is closed only when the artifact is on disk and re-verified.

| hw | GPT | item | status | note |
|---|---|---|---|---|
| 1060 | 1 | [P0] remove the hard-coded `r15` from the workflow aggregator | DONE | .github/workflows/verify.yml `full` job: no round literal (comment lines only cite the defect); backup .bak_r21_*; yaml loads |
| 1061 | 2 | [P0] aggregator checks sage summary round == lean summary round | DONE | verify.yml: `S.get('round') == L.get('round')` |
| 1062 | 3 | [P0] aggregator checks the summary round == package current round | DONE | verify.yml: the `full` job now checks out the same commit (pinned actions/checkout) and reads PACKAGE_ROUND from CITATION.cff `version:` (ruling A); `S.get('round') == PACKAGE_ROUND`; the aggregator prints the three rounds |
| 1063 | 4 | [P0] attestation round taken from the summaries | DONE | verify.yml: `att = dict(round=S.get('round'), package_round=PACKAGE_ROUND, ...)` |
| 1064 | 5 | [P0] no hard-coded round in ci_attestation.json | DONE | = 1063; the verifier's own round is no longer a literal either: scripts/verify_all_portable.sh derives ROUND from CITATION.cff (SUMMARY.json round, the FULL line, the started line, the claims step assertion) |
| 1065 | 6 | [P0] create tools/check_ci_round_sync.py | DONE | new; four checks (workflow / verifier / claims / release metadata) + --negctl; verifier step 00f (+ negctl) added; the pre-fix workflow FAILS the gate (8 findings recorded at its first run) -- true negative control |
| 1066 | 7 | [P0] audit the workflow, the verifier, the claims and the release metadata for round drift | DONE | check_ci_round_sync.py covers the four; tools/check_release_metadata.py additionally audits the workflow and the verifier (code lines) for stale package / certificate file tokens (1124) |
| 1067 | 8 | [P0] negative control with a planted stale round | DONE | check_ci_round_sync.py --negctl: (a) workflow r15 literals re-inserted, (b) verifier round hard-coded, (c) claims round: r15, (d) .zenodo.json version stale -- in memory only |
| 1068 | 9 | [P0] the static checker FAILS on the stale round | DONE | NEGCTL 4/4 REJECTED [MC] 2026-08-27 |
| 1069 | 10 | [P0] the real GitHub Actions run may wait until the final release round | DEFERRED | decision (b); nothing to execute; the workflow is still NEVER EXECUTED (header STATUS line) |
| 1070 | 11 | [P1] create proofs/statements/ | DONE | ruling B: paper wording canonical -- proofs/statements/ (38 files) (2026-08-27) |
| 1071 | 12 | [P1] move all 38 shared theorem statements there | DONE | one file per label, statement body only; any content difference paper vs Blueprint stops the work (ruling B) -- 38/38; content differences reported and ruled (E21-1..3) (2026-08-27) |
| 1072 | 13 | [P1] the paper \input{}s them | DONE | wrapper keeps \begin{theorem}[name]\label{...} -- main_R21.tex: 38 wrappers \input the statement (2026-08-27) |
| 1073 | 14 | [P1] the Blueprint \input{}s the same files | DONE | wrapper keeps \label / \lean / \leanok / \uses / trust tag -- content.tex: 38 wrappers (2026-08-27) |
| 1074 | 15 | [P1] theorem number / label only in the wrappers | DONE |  -- labels / Lean tags / \uses / trust tag in the wrappers only (2026-08-27) |
| 1075 | 16 | [P1] no trust label inside a statement file | DONE | trust tags stay in the environment name of the wrapper -- trust labels and Lean pointers moved to a Note paragraph after the environment (cor:S1, lem:C7int, lem:oddtransfer; 15 Blueprint notes) (2026-08-27) |
| 1076 | 17 | [P1] claims normalized statement generated from the same source | DONE | design: statements/INDEX.yaml (label -> file -> conditions) as the machine-readable index; claims `statement` checked against it -- conditions single-sourced in the statement file header; claims conditions must EQUAL it (check_statement_sync iii) (2026-08-27) |
| 1077 | 18 | [P1] machine-readable conditions generated from the same definition | DONE | conditions declared in the statement file header comment / INDEX.yaml; check_statement_sync (ii) reads them from there -- = 1076 (2026-08-27) |
| 1078 | 19 | [P1] update the paper / Blueprint byte-difference checker | DONE | check_statement_sync: both wrappers \input the same statements/ file; no inline theorem text left in either medium -- check_statement_sync r21 (structural: both wrappers \input the same file; inline text FAILS) (2026-08-27) |
| 1079 | 20 | [P1] 38/38 byte-identical as a hard gate | DONE | SYNC_LABELS = all 38; INFO list must be empty -- 38/38 hard gate; orphan statement files FAIL (2026-08-27) |
| 1080 | 21 | [P1] negative control: P3 ell_odd | DONE | already planted in 13c (a); keep, re-point at the statements/ file -- negctl (a) thm_P3 "a prime" + (e) header without ell_odd (2026-08-27) |
| 1081 | 22 | [P1] negative control: S0 depth range | DONE | plant a wrong depth range in thm:S0 -- negctl (d) thm_S0 t >= 1 (THM_S0 conditions t_ge_2) (2026-08-27) |
| 1082 | 23 | [P1] negative control: certificate floor piecewise condition | DONE | plant a wrong case split (17*2^n at n=2 / 33*2^n for n>=3) in lem:depthfloor / thm:cert -- covered by tools/check_floor_sync.py (00c, five media) -- the piecewise floor is not a shared theorem statement (paper prose l.113, lem:ky23, def:verifier); no planted variant added (would duplicate 00c) (2026-08-27) |
| 1083 | 24 | [P1] false congruence / equality as a stale-string gate | DONE | already the FORBID list of tools/check_release_metadata.py (r20, step 00e); nothing to add |
| 1084 | 25 | [P2] define l | h_{3,n}/h_{3,n-1} near Theorem P3 as v_l(h_{3,n}) > v_l(h_{3,n-1}) | OPEN | ruling D: a sentence in def:p3 (definition, not the theorem statement) + the same sentence in the paper; ERRATA_R21 clarification; no FREEZE bump |
| 1085 | 26 | [P2] cite the old/new lemma there | DONE | lem:oldnew with p = 3, l != 3: ker(N)_l != 0 iff v_l jumps; difference >= 0 -- = 1084 (Lemma oldnew with p = 3) (2026-08-27) |
| 1086 | 27 | [P2] shorten the abstract by ~10% if needed | DEFERRED | GPT: "acceptable as is"; merged with the P4 polish items 1023-1030 (ruling of R20: when a polish round is opened) |
| 1087 | 28 | [P2] verifier implementation details to the Verification section | DEFERRED | = 1024/1028 (P4 polish) |
| 1088 | 29 | [P2] part of the improvement factors to the table | DEFERRED | = 1025 (P4 polish) |
| 1089 | 30 | [P2] add no new theorem | DEFERRED | policy; honoured in R21 (no new mathematics, hard gate 12) |
| 1090 | 31 | [P3] re-read the Theorem A node without code | OPEN | Dr. Fukui's hand (NEXT ACTION 2); after 1123 regenerates the ledger rows |
| 1091 | 32 | [P3] re-read the Proposition D node | OPEN | Dr. Fukui's hand |
| 1092 | 33 | [P3] re-read the Certificate Soundness node | OPEN | Dr. Fukui's hand |
| 1093 | 34 | [P3] re-read the spectral rank node | OPEN | Dr. Fukui's hand (thm:rank3 changed in r20) |
| 1094 | 35 | [P3] re-read the exact covolume node | OPEN | Dr. Fukui's hand (= thm:rank3 second half) |
| 1095 | 36 | [P3] re-read the Theorem P3 node | OPEN | Dr. Fukui's hand (thm:P3 statement narrowed in r20) |
| 1096 | 37 | [P3] author initials / date on each node | OPEN | Dr. Fukui's hand; recorded in the ledger only |
| 1097 | 38 | [P3] no external endorsement required | DEFERRED | = decision (a); recorded |
| 1098 | 39 | [P3] a statement change after sign-off invalidates the signature | DONE | ledger row carries the statement file sha256 at signing; the gate compares -- docs/human_review_r21.json: statement sha256 per row; INVALIDATED when it changes (gen_human_review.py) (2026-08-27) |
| 1099 | 40 | [P3] sign-off status machine-readable | DONE | docs/human_review_r21.json generated with the table (tools/gen_human_review.py, 1123) -- tools/gen_human_review.py + step 13e --check (2026-08-27) |
| 1100 | 41 | [P4] rebuild the paper after single-sourcing | DONE | executed at the R21 seal -- executed at the R21 seal 2026-08-27 (55 steps 0/0, containment 120/120, negctl 12/12, zip 5501edec...13ac, re-extract 4670/0/0); bumped DONE at the R22 boot |
| 1101 | 42 | [P4] rebuild the Blueprint | DONE | executed at the R21 seal -- executed at the R21 seal 2026-08-27 (55 steps 0/0, containment 120/120, negctl 12/12, zip 5501edec...13ac, re-extract 4670/0/0); bumped DONE at the R22 boot |
| 1102 | 43 | [P4] undefined / duplicate labels 0 | DONE | executed at the R21 seal (steps 10b / 11 + check_graph DUPLICATE LABEL gate) -- executed at the R21 seal 2026-08-27 (55 steps 0/0, containment 120/120, negctl 12/12, zip 5501edec...13ac, re-extract 4670/0/0); bumped DONE at the R22 boot |
| 1103 | 44 | [P4] statement sync 38/38 | DONE | executed at the R21 seal (13c) -- executed at the R21 seal 2026-08-27 (55 steps 0/0, containment 120/120, negctl 12/12, zip 5501edec...13ac, re-extract 4670/0/0); bumped DONE at the R22 boot |
| 1104 | 45 | [P4] regenerate the manifest | DONE | on the staging tree only (r18 protocol) -- executed at the R21 seal 2026-08-27 (55 steps 0/0, containment 120/120, negctl 12/12, zip 5501edec...13ac, re-extract 4670/0/0); bumped DONE at the R22 boot |
| 1105 | 46 | [P4] run the full local verifier | DONE | on the staging tree; 54 steps (52 + 00f, 00f negctl) -- executed at the R21 seal 2026-08-27 (55 steps 0/0, containment 120/120, negctl 12/12, zip 5501edec...13ac, re-extract 4670/0/0); bumped DONE at the R22 boot |
| 1106 | 47 | [P4] 0 FAIL / 0 SKIP | DONE | executed at the R21 seal -- executed at the R21 seal 2026-08-27 (55 steps 0/0, containment 120/120, negctl 12/12, zip 5501edec...13ac, re-extract 4670/0/0); bumped DONE at the R22 boot |
| 1107 | 48 | [P4] P3 containment 120/120 | DONE | executed at the R21 seal -- executed at the R21 seal 2026-08-27 (55 steps 0/0, containment 120/120, negctl 12/12, zip 5501edec...13ac, re-extract 4670/0/0); bumped DONE at the R22 boot |
| 1108 | 49 | [P4] negative controls all rejected | DONE | executed at the R21 seal -- executed at the R21 seal 2026-08-27 (55 steps 0/0, containment 120/120, negctl 12/12, zip 5501edec...13ac, re-extract 4670/0/0); bumped DONE at the R22 boot |
| 1109 | 50 | [P4] fresh-extraction manifest check | DONE | executed at the R21 seal -- executed at the R21 seal 2026-08-27 (55 steps 0/0, containment 120/120, negctl 12/12, zip 5501edec...13ac, re-extract 4670/0/0); bumped DONE at the R22 boot |
| 1110 | 51 | [P4] record the zip SHA-256 | DONE | HANDOFF SEAL R21 block only -- executed at the R21 seal 2026-08-27 (55 steps 0/0, containment 120/120, negctl 12/12, zip 5501edec...13ac, re-extract 4670/0/0); bumped DONE at the R22 boot |
| 1111 | 52 | [P4] mathematical statement freeze here | DONE | = FREEZE R21 block N12 (three statement texts corrected while single-sourcing; written after the ruling "すべてGPTに合わせて") -- executed at the R21 seal 2026-08-27 (55 steps 0/0, containment 120/120, negctl 12/12, zip 5501edec...13ac, re-extract 4670/0/0); bumped DONE at the R22 boot |
| 1112 | 53 | [P5] real GitHub Actions green run | DEFERRED | decision (b), final release batch |
| 1113 | 54 | [P5] CI aggregator attestation | DEFERRED | decision (b) |
| 1114 | 55 | [P5] GitHub directory cleanup | DEFERRED | decision (b); vault by-products ruling hw 982 |
| 1115 | 56 | [P5] separate the stale round archive | DEFERRED | decision (b) |
| 1116 | 57 | [P5] CITATION.cff release date | DEFERRED | decision (b); currently 2026-08-26 |
| 1117 | 58 | [P5] .zenodo.json publication date | DEFERRED | decision (b) |
| 1118 | 59 | [P5] .zenodo.json relative related identifier -> remove or persistent URL | DEFERRED | decision (b); [MC] the identifier is the relative path paper/draft/main_R20.pdf |
| 1119 | 60 | [P5] Z_3 keyword in the metadata | DEFERRED | decision (b); [MC] keywords name Z2 only while the title names both towers |
| 1120 | 61 | [P5] immutable release | DEFERRED | decision (b) |
| 1121 | 62 | [P5] Zenodo DOI | DEFERRED | decision (b) |
| 1122 | 63 | [P5] asset hash comparison | DEFERRED | decision (b); hw 622-630 |
| 1123 | - | [C-R21] docs/BLUEPRINT_HUMAN_REVIEW_R20.md: the table is the r15 snapshot (13 rows); thm:P3 / thm:rank3 / lem:normone / thm:SH / cor:P3n4 / cor:SHmod / prop:D / thm:cert / thm:A have no row although the prose calls them KEY / UNSIGNED; of GPT's six sign-off targets only thm:Acore and thm:family have a row | DONE | regenerate the table from the current F/M node list with tools/gen_human_review.py (keep the 13 old rows' fields), + machine-readable JSON (1099), + statement sha256 per row (1098) -- regenerated: 30 rows, KEY 11; the six GPT targets have rows (2026-08-27) |
| 1124 | - | [C-R21] tools/check_release_metadata.py did not audit .github/workflows/ or the verifier (GPT's root cause) | DONE | both audited now (code lines; comment lines are the per-round changelog); the round-literal check is 1065 |
| 1125 | - | [C-R21] the review file mtime (15:30 JST) precedes the HANDOFF's estimated posting time (~16:0x JST) | DONE | the estimate was coarse; content unambiguously r20; no action |
| 1126 | - | [C-R21] verify_all_portable.sh step 12 (placeholders) scanned docs/ERRATA_R16.md twice and never the current errata (r17-r20) | DONE | now docs/ERRATA_R*.md (all); ERRATA_R17-R20 re-scanned at the R21 seal |

## R22 — GPT r21 review (Weberレビュー.txt md5 a0d2e24546cd313c9cfd4f65a6515cf0, 13824 B, mtime 2026-08-27 18:25 JST, read 2026-08-27, node <LOCAL_HOST>). GPT numbering 1-50 -> tracker 1127-1176; Claude-found 1177-1178. Ruling (Dr. Fukui, 2026-08-27): "P1 (author sign-off) and P3 (release stage) are done separately; do all the other repairs properly" -> P0 and P2 executed here (R22 seal), P1 11-26 and P3 43-50 OPEN for the author / the final release. Verdict: no new mathematical gap; single-source 38/38 and CI round sync "properly implemented"; mathematics GO, general-theorem paper GO; the final fix of R21 NO-GO until two literal errors in ordinary mathematical prose are corrected and the author sign-off is done. Re-derived on <LOCAL_HOST> BEFORE entry, all [MC]: (1) proofs/prop_D.tex carried "Lemma~1", "Lemma~2", "Lemma~3" (the r16 appendix numbering; the labels are lem:D1 / lem:D2 / lem:D3 and the three uses match them semantically: insert the eta_n expression, drop the c = 2,6 terms, evaluate the Gauss sum); (2) proofs/cor_T.tex line 9 wrote log C_7 / log B = 30.2374.../15.1187... -- python: log10 C_7 = 30.2374, log10 B = 15.1187, ln C_7 = 69.6241, ln B = 34.8121, ratio 2.0 -- GPT's numbers correct, the displayed equality was literally false (base-10 values under a base-e symbol); the paper's table row "7 & 64 & 30.2374 & ..." is a log10 column and stays; (3) proofs/thm_family.tex enumerated the five target-list corruptions as "a composite, a wrong class, a duplicate, an omission, an element beyond 1001287361" while scripts/verify_ky1000_target.py --negctl plants corrupted (one entry altered: composite AND wrong class), missing (one omitted, padded with the 1001st), duplicate, unsorted (two neighbours swapped), replaced (one prime replaced by the next qualifying one beyond the maximum) -- "wrong class" double-counted the first plant and "unsorted" was absent: GPT correct; (4) lem:mo22 was a normal [L] lemma node titled "superseded in r17" and used by nothing (orphan): GPT correct. GPT's other numbers: 4670/0/0, 38/38, CI negctl 4/4, floor sync, C_7 sync, containment 120/120, negctl 12/12, KY1000 eight properties, Blueprint 65 nodes / 39 proofs / dangling 0, both PDFs build -- all equal to the R21 seal record; "88 or so edges" = 89. GPT counts KEY 10 where the ledger has KEY 11 (the r15 KEY set + the six review targets; lem:oldnew is the eleventh) -- recorded, both readings listed in LETTER_R22. Decisions (a)(b): reaffirmed by the review ("no external number theorist; GitHub / CI / Zenodo at the end"). Each row is closed only when the artifact is on disk and re-verified.

| hw | GPT | item | status | note |
|---|---|---|---|---|
| 1127 | 1 | [P0] prop_D.tex "Lemma 1" -> label reference | DONE | Lemma~\ref{lem:D1} |
| 1128 | 2 | [P0] "Lemma 2" -> label reference | DONE | Lemma~\ref{lem:D2} |
| 1129 | 3 | [P0] "Lemma 3" -> label reference | DONE | Lemma~\ref{lem:D3} |
| 1130 | 4 | [P0] correct references in both media | DONE | proofs/prop_D.tex is \input by both; both PDFs rebuilt at the seal, undefined 0 |
| 1131 | 5 | [P0] cor_T.tex numbers -> log_10 | DONE | "= \log_{10}C_7/\log_{10}B = 30.2374.../15.1187..." + the base-e values 69.6241.../34.8121... in a parenthesis (ERRATA_R22 E22-2) |
| 1132 | 6 | [P0] or natural-log numbers | DONE | both shown (1131) |
| 1133 | 7 | [P0] target-list negative-control description == implementation | DONE | thm_family.tex: the five plants named as scripts/verify_ky1000_target.py plants them (ERRATA_R22 E22-3) |
| 1134 | 8 | [P0] lem:mo22 removed from the current Blueprint or marked historical | DONE | no longer a node: a "Historical / superseded input" paragraph in the literature chapter; graph 64 nodes / 89 edges / orphans 2 (exp:class1, exp:svp, intentional) |
| 1135 | 9 | [P0] build LaTeX twice, references stable | DONE | at the seal (steps 10b / 11: two runs each; errors 0 / undefined 0 / multiply 0) |
| 1136 | 10 | [P0] grep the active tree for hard-coded "Lemma 1/2/3" | DONE | proofs/*.tex, proofs/statements/*.tex, main tex, content.tex: none [MC] |
| 1137 | 11 | [P1] re-read the KEY nodes first | OPEN | the author's sign-off session (ruling: separate) |
| 1138 | 12 | [P1] Theorem A without code | OPEN | the author's sign-off session (ruling: separate) |
| 1139 | 13 | [P1] Proposition D without code | OPEN | the author's sign-off session (ruling: separate) |
| 1140 | 14 | [P1] Certificate Soundness without the checker source | OPEN | the author's sign-off session (ruling: separate) |
| 1141 | 15 | [P1] KY1000 Family Theorem without the generator | OPEN | the author's sign-off session (ruling: separate) |
| 1142 | 16 | [P1] S0 / S1 without code | OPEN | the author's sign-off session (ruling: separate) |
| 1143 | 17 | [P1] spectral rank theorem without code | OPEN | the author's sign-off session (ruling: separate) |
| 1144 | 18 | [P1] exact covolume theorem without code | OPEN | the author's sign-off session (ruling: separate) |
| 1145 | 19 | [P1] Theorem P3 without code | OPEN | the author's sign-off session (ruling: separate) |
| 1146 | 20 | [P1] check hypotheses / conclusion / inputs of each node | OPEN | the author's sign-off session (ruling: separate) |
| 1147 | 21 | [P1] check the F / C / L / M boundaries | OPEN | the author's sign-off session (ruling: separate) |
| 1148 | 22 | [P1] initials and date when clean | OPEN | the author's sign-off session (ruling: separate) |
| 1149 | 23 | [P1] update the statement hash after a fix | OPEN | the author's sign-off session (ruling: separate) |
| 1150 | 24 | [P1] invalidate and re-read after a fix | OPEN | the author's sign-off session (ruling: separate) |
| 1151 | 25 | [P1] then the remaining 20 F/M nodes | OPEN | the author's sign-off session (ruling: separate) |
| 1152 | 26 | [P1] 30/30 SIGNED as a hard gate | OPEN | the author's sign-off session (ruling: separate) |
| 1152 | 27 | [P2] statement sync 38/38 | DONE | at the R22 seal (HANDOFF SEAL R22 block) |
| 1153 | 28 | [P2] dangling 0 | DONE | at the R22 seal (HANDOFF SEAL R22 block) |
| 1154 | 29 | [P2] orphans not needed by a current theorem cleaned (lem:mo22) | DONE | at the R22 seal (HANDOFF SEAL R22 block) |
| 1155 | 30 | [P2] manifest regenerated (staging) | DONE | at the R22 seal (HANDOFF SEAL R22 block) |
| 1156 | 31 | [P2] full local verifier | DONE | at the R22 seal (HANDOFF SEAL R22 block) |
| 1157 | 32 | [P2] 0 FAIL / 0 SKIP | DONE | at the R22 seal (HANDOFF SEAL R22 block) |
| 1158 | 33 | [P2] P3 containment 120/120 | DONE | at the R22 seal (HANDOFF SEAL R22 block) |
| 1159 | 34 | [P2] P3 negative controls 12/12 | DONE | at the R22 seal (HANDOFF SEAL R22 block) |
| 1160 | 35 | [P2] KY1000 target verifier re-run | DONE | at the R22 seal (HANDOFF SEAL R22 block) |
| 1161 | 36 | [P2] certificate negative controls re-run | DONE | at the R22 seal (HANDOFF SEAL R22 block) |
| 1162 | 37 | [P2] paper and Blueprint rebuilt | DONE | at the R22 seal (HANDOFF SEAL R22 block) |
| 1163 | 38 | [P2] undefined / duplicate references 0 | DONE | at the R22 seal (HANDOFF SEAL R22 block) |
| 1164 | 39 | [P2] fresh staging tree zipped | DONE | at the R22 seal (HANDOFF SEAL R22 block) |
| 1165 | 40 | [P2] manifest after fresh extraction | DONE | at the R22 seal (HANDOFF SEAL R22 block) |
| 1166 | 41 | [P2] zip SHA-256 recorded | DONE | at the R22 seal (HANDOFF SEAL R22 block) |
| 1167 | 42 | [P2] mathematical statement freeze | DONE | at the R22 seal (HANDOFF SEAL R22 block) |
| 1168 | 43 | [P3] actual GitHub Actions run | DEFERRED | decision (b): the final release stage (ruling: separate) |
| 1169 | 44 | [P3] GitHub directory cleanup | DEFERRED | decision (b): the final release stage (ruling: separate) |
| 1170 | 45 | [P3] stale archive separation | DEFERRED | decision (b): the final release stage (ruling: separate) |
| 1171 | 46 | [P3] release date | DEFERRED | decision (b): the final release stage (ruling: separate) |
| 1172 | 47 | [P3] CITATION.cff / .zenodo.json final sync | DEFERRED | decision (b): the final release stage (ruling: separate) |
| 1173 | 48 | [P3] immutable release | DEFERRED | decision (b): the final release stage (ruling: separate) |
| 1174 | 49 | [P3] Zenodo DOI | DEFERRED | decision (b): the final release stage (ruling: separate) |
| 1175 | 50 | [P3] release asset hash comparison | DEFERRED | decision (b): the final release stage (ruling: separate) |
| 1177 | - | [C-R22] KEY count: GPT reads 10, the ledger has 11 (r15 KEY set + the six review targets; lem:oldnew is the eleventh) | DONE | recorded in LETTER_R22; the ledger keeps 11 |
| 1178 | - | [C-R22] the paper's constants table prints log10 C_n (30.2374 at n = 7) in a column headed as such -- checked against cor_T.tex so that no second base-e/base-10 mismatch remains | DONE | [MC] table column is log10; unchanged |
