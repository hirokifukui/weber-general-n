# RELEASE_STATUS — weber_general_n (package-level sealed status; in the manifest; replaces the operational HANDOFF.md in shipped packages)

This file states the sealed status of the package. The operational session file HANDOFF.md is
NOT shipped from r12 on (it records the zip hash after sealing and cannot be inside the package;
the pre-seal r11 copy that was shipped is archived at docs/archive/HANDOFF_R11_preseal_as_shipped.md).

## Sealed: r11 (weber_general_n_r11_20260825.zip)
- SHA256 9de2831288281fdc2822a32ff1cbc16074457cdf40d9118cc3d5fb8cc974af68 ; 23,098,732 bytes ; 5,505 entries.
- Local verifier run (scripts/verify_all_portable.sh r11, Apple M4, Sage 10.8): 13 steps, PASS 2026-08-25T10:52:48Z
  (verify_out/ shipped inside the zip). KY1000 EXCLUDED 1000/1000; negative controls 7/7 REJECTED;
  4 load-bearing Lean files std-3; manifest 4437 files, 0 failed, 0 unlisted.
- NOT done at r11: clean-checkout replay (no CI run; Dockerfile never executed on an author machine),
  Blueprint full proofs, Blueprint PDF, Washington citation numbers (hw 29), novelty reading (hw 122).

## Sealed: r12 (weber_general_n_r12_20260825.zip; zip SHA256 recorded in the vault HANDOFF only)
- Local verifier run (scripts/verify_all_portable.sh r12, node <LOCAL_HOST>, Apple M4, Sage 10.8, Lean workspace
  <LOCAL_LEAN_WORKSPACE> pinned to mathlib d568c8c0): every executed step OK, 0 FAIL, 0 SKIP,
  final line `VERIFY_ALL_PORTABLE r12: PASS (2026-08-25T12:40:06Z)`; verify_out/ shipped inside the zip.
  Steps: manifest, environment asserts (Sage 10.8 / PARI 2.17.1 / FLINT 3.3.1 / toolchain + mathlib pin),
  twoadic rank, blueprint map, C_n JSON certificate, KY1000 target list + 5 negative controls, Prop D audit,
  C_7 dual route + flagship, KY1000 EXCLUDED 1000/1000 (per-prime compare with the shipped ledger: verdict,
  components, witness sha256 and verifier-log sha256 all 1000/1000 equal), 7 negative controls, Lean axiom gate
  (18 declarations, 3/5/4/6 per file, all std-3), Blueprint proof-completeness gate, Blueprint PDF (17 pages),
  paper PDF (19 pages), placeholders, claims (27) == CORRESPONDENCE.csv.
- Manifest: MANIFEST_SHA256.txt regenerated after this file was written (the only edit after the verifier run;
  verify_out/01_manifest.log shows the check of the manifest as it stood at 12:28Z, 4486 files, 0/0).
- NOT done at r12 (see docs/LETTER_R12.md gates 7, 8, 12, 13): clean-checkout CI replay (never executed; docker
  absent on every author machine; first run = GitHub Actions after push), Washington citation numbers (hw 29),
  novelty reading (hw 122), external read of Theorem A (hw 191). No "green" and no "clean replay" is claimed.

## Release protocol (r15, GPT r14 sect 7 / question (1); replaces the r13-r14 "Sealed block appended after CI" protocol, E15-3)
1. All edits finished; generated files re-run (gen_cn_certs, gen_negctl_ledger, gen_correspondence r15, gen_blueprint_map,
   check_graph --report); MANIFEST_SHA256.txt regenerated; the candidate block below written; manifest regenerated once more.
2. scripts/verify_all_portable.sh VERIFY_PROFILE=full on the tree as it stands (verify_out/ shipped). NO edit of any tracked file after
   this run — not this file, not the PDFs, nothing. If anything must change, the change is made, and steps 1-2 are repeated in full.
3. At the END of the project (decision (b) below: one release, after every round is closed) Dr. Fukui freezes the final source
   commit, pushes, and lets .github/workflows/verify.yml run the three jobs (sage / lean / full) on that commit. The `full` job's artifact ci_attestation.json (run id, run URL, commit SHA, Docker image id, runner image, both
   profile summaries) is downloaded and attached to the GitHub Release as an ASSET, together with the CI logs. It is NEVER committed.
4. An immutable tag is set on the verified commit. The source tree is not touched afterwards; any later change is a new version
   (new candidate block, steps 1-3 again), never a re-tag.
5. The GitHub Release and the Zenodo record carry: source commit SHA, tag, source archive SHA-256, the release-asset SHA-256 list,
   ci_attestation.json, the CI logs, paper PDF, Blueprint PDF, certificates and checker. Zenodo and GitHub asset hashes are compared
   (hw 622-630). A third-party clean-clone replay is compared with the CI summaries (normalized) before the DOI is cited (hw 562-564).
6. Consequently this file never contains a run id or a commit SHA: a document cannot certify the tree it is part of. The "Sealed: r11"
   and "Sealed: r12" blocks below are history (they were written before this protocol and were never pushed).

## Release protocol, r18 revision (GPT r17 sect 6 / items 45-57; supersedes steps 1-2 of the r15 protocol above for the packaging)
1a. All edits finished; generated files re-run (check_graph --report, gen_cn_certs, gen_negctl_ledger, gen_correspondence r18, gen_blueprint_map);
    PDFs built into paper/draft/ and blueprint/.
1b. A RELEASE STAGING TREE is made: a fresh copy of the package from which every build by-product (.aux/.out/.toc/.log of LaTeX, .sage.py,
    __pycache__, .DS_Store, *.bak*, HANDOFF.md, external_review/, and *.sage.py — Sage preparse output whose header embeds the absolute
    source path, hence unreproducible across checkouts; tools/gen_manifest.py skips it) and every nohup .out log is removed BEFORE the manifest is generated
    (r17 defect: the manifest listed twelve files that the zip filter then dropped -- ERRATA_R18 E18-1). The manifest is generated ON the
    staging tree; `gen_manifest.py --check` there must report missing 0 / unlisted 0 (hard gate).
2.  scripts/verify_all_portable.sh VERIFY_PROFILE=full runs ON THE STAGING TREE as it stands (verify_out/ shipped). NO edit of any tracked
    file after this run. Untracked by-products CREATED BY THE RUN (Sage preparse *.sage.py, python __pycache__/) are removed — these are
    outside the manifest's coverage by construction, so `gen_manifest.py --check` is unaffected — and the staging tree is then zipped AS IS; the zip is re-extracted into a separate directory; `gen_manifest.py --check`
    on the re-extracted tree must again report missing 0 / unlisted 0, and the lean/paper/blueprint portable steps are re-run there;
    the zip SHA-256 is recorded in the vault HANDOFF (never inside the tree). Any change afterwards = a new staging tree, steps 1a-2 again.
3-6. Unchanged (one push / CI / tag / release / Zenodo at the end, decision (b)).

## 1.0.0 candidate (the PUBLIC release; written BEFORE the final verifier run; not edited after it)
- Opened 2026-08-28 after the GPT audit of the sealed r23 zip. That audit: mathematics / paper / Blueprint / Lean / certificates /
  manifest all GO; the r23 zip as a PUBLIC tree NO-GO on four release blockers -- (1) third-party paper PDFs and full-text extractions
  included, (2) the sign-off ledger generator dropped prop:F (KEY filter used GPT_KEY only; 30 rows / KEY 10 instead of 31 / 11),
  (3) private host, IP and absolute-path strings in archive/, verify_out/ and two sage logs, (4) the CC-BY notice covered paper/
  wholesale, i.e. relicensed third-party PDFs, and the Zenodo metadata declared a single license for a mixed package.
- Repairs in this round: gen_human_review.py KEY = GPT_KEY | R15_KEY; prop:F read and SIGNED by the author (31/31, KEY 11/11);
  literature/README.md + literature/SOURCES.yaml (third-party works recorded with local SHA-256, not redistributed); .gitignore;
  tools/make_public_tree.py (public-tree filter: excludes archive/, docs/archive/, verify_out/, paper third-party PDFs,
  paper/sources/, session files; sanitizes two sage/r16_trackB logs; generic-regex forbidden-pattern scan, zero hits required);
  LICENSE (MIT) + LICENSE-CC-BY-4.0.txt with the covered directories enumerated; public README (mathematics first) +
  docs/PROJECT_HISTORY.md; package round renamed r23 -> 1.0.0 (CITATION.cff single source; every version-token parser generalized
  from r\d+ to a general token). Zenodo: TWO records by ruling -- software (GitHub webhook, MIT) and paper/Blueprint
  (manual upload, CC BY 4.0), cross-linked; no arXiv deposit (no endorsement, standing).
- No statement change (no N-block), no new mathematics, no new Lean theorem, no certificate touched; the p = 3 certificate family
  keeps its r19 names. The twelve load-bearing Lean files are byte-identical to the r22/r23 seals.
- Release execution (decision (b), this round): make_public_tree -> manifest ON the public tree -> full verifier ON the public tree ->
  zip -> re-extract checks -> GPT short confirmation -> push to the (private) repository -> CI green -> tag v1.0.0 -> repository
  public -> GitHub Release with assets -> Zenodo records. Decision (a) binds unchanged.

## r23 candidate (written BEFORE the final verifier run; not edited after it)
- Opened 2026-08-28 after the author's sign-off session (GPT r21 hard gate 6, the last unmet completion gate). The GPT r22 review was
  journal-venue advice (JTNB first choice; JNT / Acta as alternatives), no homework and no new gap.
- Done in this round: (1) the author read all 30 F/M Blueprint nodes (KEY 11 first) against proofs/statements/<label>.tex and
  proofs/<label>.tex and signed; the transcription is docs/human_review_r23.json (30/30 SIGNED, reviewer H. Fukui, date 2026-08-28,
  signed_sha = statement_sha256_16 per row; the sealed r22 ledger, all UNSIGNED, is archived in archive/rounds/r22/). (2) Release
  metadata (P5): release date 2026-08-28 in CITATION.cff / .zenodo.json; license and repository-code set by the author's ruling;
  cyclotomic Z3-extension keyword; the relative related identifier replaced by the repository URL. (3) LICENSE file(s) added at the
  package root. No statement change (FREEZE R23: no N13), no new mathematics, no new Lean, no certificate touched; the p = 3
  certificate family keeps its r19 names.
- This round EXECUTES standing decision (b): one push / CI (GitHub Actions verify.yml: sage / lean / full) / immutable tag / GitHub
  Release / Zenodo webhook DOI, at the end — after this candidate is sealed (staging tree, full verifier, zip) and the zip is
  audited by GPT for release-engineering mistakes. Decision (a) binds unchanged: no external reviewer as a correctness premise.
- Claims: docs/CLAIMS_R23.yaml -> CORRESPONDENCE.csv (37 claims). Single sources of shared numbers unchanged (r22 list). Verifier:
  scripts/verify_all_portable.sh (55 steps as r21/r22); step 09 unchanged: TWELVE Lean files, 63 declarations, std-3.
- Paper: paper/draft/main_R23.tex; Blueprint blueprint/blueprint_r23.pdf. Round files of r22 moved to archive/rounds/r22/ (MOVE_LOG_R23).

## r22 candidate (written BEFORE the final verifier run; not edited after it)
- Opened 2026-08-27 after the GPT r21 review (tracker rows 1127-1178; docs/ERRATA_R22.md). Verdict of that review: no new mathematical gap;
  38/38 single-source and CI round sync "properly implemented"; mathematics GO, general-theorem paper GO; the final fix NO-GO until (1) two
  literal errors in proof prose are repaired and (2) the author signs off the F/M nodes. Ruling (Dr. Fukui): P1 sign-off and P3 release
  separately; everything else here.
- Done in this round (P0 + P2 of the review): proofs/prop_D.tex Lemma~\ref{lem:D1}/\ref{lem:D2}/\ref{lem:D3} instead of the hard-coded
  r16 numbers; proofs/cor_T.tex logarithm base made explicit (log10 numbers under a log10 symbol, base-e values alongside);
  proofs/thm_family.tex names the five target-list plants exactly as scripts/verify_ky1000_target.py plants them; lem:mo22 demoted to a
  historical paragraph (graph 64 nodes / 89 edges / orphans 2, both intentional experiment nodes). No statement change (FREEZE R22: no N13;
  proofs/statements/*.tex byte-identical to r21), no new mathematics, no new Lean, no certificate touched.
- Not done by ruling: the author sign-off (P1 items 11-26; docs/human_review_r22.json stays all UNSIGNED, KEY 11) and every release-stage
  item (P3 43-50, decision (b)); the standing deferrals of r21 (polish, Lean hw 858/861/995, Washington, novelty, page sizes).
- Claims: docs/CLAIMS_R22.yaml -> CORRESPONDENCE.csv (tools/gen_correspondence.py r22; 37 claims). Single sources of shared numbers (hard
  gate 00c): unchanged -- certificates/p3/D3_cert_r19.json (15 rows; containment 120/120; sage/r19_trackB/p3_negctl_ledger_r19.json: 12
  planted certificates, 12 rejected), certificates/negctl/negctl_ledger_r14.json (9/9 negative controls REJECTED + the n = 2 positive
  control EXCLUDED), certificates/constants/Cn_interval_r14.json, sage/family_ky1000_r11_clean/VERIFY_LEDGER.txt (EXCLUDED 1000/1000).
- Verifier: scripts/verify_all_portable.sh (55 steps as r21); step 09 unchanged: TWELVE Lean files, 63 declarations, std-3.
- Paper: paper/draft/main_R22.tex; Blueprint blueprint/blueprint_r22.pdf. Round files of r21 moved to archive/rounds/r21/ (MOVE_LOG_R22).
- The two standing decisions bind unchanged: (a) no external reviewer; (b) push / CI / tag / release / Zenodo once, at the end.

## Previous: r21 candidate (superseded by the r22 candidate before any push; never released)
- Opened 2026-08-27 after the GPT r20 review (docs/GPT_HOMEWORK_R11_TRACKER.md rows 1060-1126; docs/ERRATA_R21.md). Verdict of that review:
  the two R19 mathematical points closed, no new mathematical gap, every theorem GO 98-99%, mathematics / text / internal artifacts "very
  close to submission GO"; the r20 zip NO-GO as the FINAL CI / Zenodo version on ONE ground, release engineering: the `full` aggregator of
  .github/workflows/verify.yml required round r15 while the verifier wrote r20. Instruction: no new mathematics; (1) CI round sync,
  (2) single-source all 38 shared statements (answer to LETTER_R20 question (12): option (a)).
- Done in this round: (1) the workflow aggregator carries no round literal, checks out the same commit and reads PACKAGE_ROUND from
  CITATION.cff (single source of the package round), asserts sage round == lean round == PACKAGE_ROUND and takes the attestation round from
  the summaries; scripts/verify_all_portable.sh derives its ROUND from CITATION.cff (no literal); new tools/check_ci_round_sync.py (step 00f,
  + --negctl rejecting four in-memory stale-round variants); check_release_metadata audits the workflow and the verifier. (2) proofs/statements/<label>.tex (38 files,
  paper wording canonical) are \input by both media; tools/check_statement_sync.py r21 = 38/38 single-sourced hard gate + conditions
  single-sourced in the statement file headers (+ --negctl rejecting five in-memory variants); trust labels / Lean pointers moved out of the theorem environments; the
  medium-specific pointers go through \refConst / \refCert / \refAppF / \refDefH; tools/texsrc.py inlines the statements for every text
  gate. Three statement texts corrected while single-sourcing (FREEZE N12; ERRATA_R21 E21-1..3: Lemma A narrowed to its proof, Theorem A
  with explicit n >= 2, Lemma D3's hypotheses restored in the Blueprint) and the Z_3 divisibility defined as a valuation inequality
  (E21-4, GPT items 25-26). (3) the author's sign-off ledger regenerated from the current node list (30 rows, KEY 11, GPT's six targets
  included; docs/human_review_r21.json machine-readable, statement sha256 per row, INVALIDATED on change) — NOTHING SIGNED (the signing is
  the author's separate session). Verifier step 12 now scans every ERRATA_R*.md (r17-r20 scanned ERRATA_R16 twice, hw 1126).
- Not done / deferred by ruling: abstract polish (P2 27-29 = P4 polish), the actual GitHub Actions run and every P5 item (decision (b)),
  the sign-off itself (P3 31-37), no new Lean (hw 995 stays deferred: the review asked for none), general odd p / class 1 / n = 7 / Luo note
  (GPT's standing "do not proceed"), Washington statement numbers (hw 29/984), novelty reading (hw 868-876), page-size alignment of paper
  (Letter) and Blueprint (A4) left to the journal-style stage (ruling C).
- Claims: docs/CLAIMS_R21.yaml -> CORRESPONDENCE.csv (tools/gen_correspondence.py r21; 37 claims; THM_S0 gains a conditions block t_ge_2).
  Blueprint: 65 nodes; thm:P3 now \uses lem:oldnew (89 edges).
- Single sources of shared numbers (hard gate 00c): unchanged from r20 -- certificates/p3/D3_cert_r19.json (15 rows; containment 120/120; the
  p = 3 replay's structured ledger sage/r19_trackB/p3_negctl_ledger_r19.json: 12 planted certificates, 12 rejected), the family ledger
  certificates/negctl/negctl_ledger_r14.json (9/9 negative controls REJECTED + the n = 2 positive control EXCLUDED), certificates/constants/
  Cn_interval_r14.json, sage/family_ky1000_r11_clean/VERIFY_LEDGER.txt (EXCLUDED 1000/1000).
- Verifier: scripts/verify_all_portable.sh (54 steps: r20's 52 + 00f ci_round_sync, 00f negctl; step 13e human_review --check added);
  step 09 unchanged: TWELVE Lean files, 63 declarations, std-3; no new Lean.
- Paper: paper/draft/main_R21.tex; Blueprint blueprint/blueprint_r21.pdf. Round files of r20 moved to archive/rounds/r20/
  (archive/rounds/MOVE_LOG_R21.txt).
- The two standing decisions of the author bind this round unchanged: (a) no external reviewer (the GPT r20 review explicitly agrees:
  "no external endorsement as a gate"); (b) push / CI / tag / release / Zenodo once, at the end (the review: "the real run may wait").

## Previous: r20 candidate (superseded by the r21 candidate before any push; never released)
- Opened 2026-08-27 after the GPT r19 review (docs/GPT_HOMEWORK_R11_TRACKER.md rows 985-1058; docs/ERRATA_R20.md). Verdict of that review:
  the r18 artifact repair of r19 ACCEPTED in full (all 15 hard gates PASS; P3 certificate GO 99%, "no further certificate architecture
  needed"; KY1000 GO 99%; every theorem GO 96-99%); the r19 zip NO-GO "until small fixes" on two grounds in the MATHEMATICAL TEXT, none
  in the mathematics: (A) Theorem P3 read "l != 3 a prime" and so included l = 2, which the proof never covered (Lemma normone (iv) and
  Theorem SH assume l odd) -- a scope error; (B) the shared proof of Theorem rank3 wrote a = 1+N = 4^{N/3} and "Since a = 4^{N/3}" as
  integer equalities, false for n >= 2 (only the congruence mod q = 3N holds). Both are recorded as errata (E20-1, E20-2; E20-3 = the
  same notation class for -2 = 4^{j_0}, found by my grep) and repaired in this round. ONE statement change (theory/STATEMENT_FREEZE_R20.md
  N11: Theorem P3 for odd primes l != 3); no other statement changed; no new mathematics; no new Lean (ruling); the p = 3 certificate
  family ships UNCHANGED under its r19 file names.
- Repaired in this round: Theorem P3 "l != 3 an odd prime" in paper and Blueprint (byte-identical statement text, tools/check_statement_sync.py,
  step 13c, with its own --negctl self-test of planted wordings); proofs/thm_P3.tex opens by naming the two places where oddness is used and states that
  nothing is claimed for l = 2; docs/CLAIMS_R20.yaml THM_P3 / LEM_NORMONE / COR_P3N4 carry machine-readable `conditions` blocks checked
  against the claims statement and both statement texts; proofs/thm_rank3.tex Step 2 writes a == 4^{N/3} (mod q) and -2 == 4^{j_0} (mod q)
  as congruences, names WeberP3Rel.four_pow_modEq, and states that the arguments of g and chi_k are classes mod q; the false forms are
  FORBIDDEN in proofs/*.tex, the paper body and the Blueprint by tools/check_release_metadata.py (step 00e), which now also distinguishes
  the PACKAGE round (main_R20, CLAIMS_R20, ...) from the CERTIFICATE round (single source: the certificate path in tools/check_p3_cert.py),
  so the unchanged r19 certificate is not renamed and a stale one still fails; the trust ledgers (TRUST.md, claims -> CORRESPONDENCE.csv,
  the current FREEZE block) cite Washington at chapter level like the body, with the reason (no theorem NUMBER is load-bearing) -- the
  numbers stay an OPEN tracker item (hw 29/984) and are asserted nowhere; every L input tagged [used] / [historical] / [unread] (Ho02
  unread, Ho05b relay, MO13 Lemma 1.3 and Ho05a Prop. 1 used); docs/NOVELTY_MATRIX.md generated by tools/gen_novelty_matrix.py (the default
  answer to LETTER_R18/R19 question (10) after two silences; the novelty reading itself is OPEN, hw 868-876) with a one-sentence pointer in
  sect 2 by artifact ID [NOVELTY] and the path in Appendix F.
- Claims: docs/CLAIMS_R20.yaml -> CORRESPONDENCE.csv (tools/gen_correspondence.py r20; 37 claims: THM_P3 restricted, THM_RANK3 status +
  four_pow_modEq, PROP_D_ii / THM_RANK3 / THM_P3 inputs retagged). Blueprint: 65 nodes (unchanged).
- Single sources of shared numbers (hard gate 00c): unchanged from r19 -- certificates/p3/D3_cert_r19.json (15 rows; containment 120/120; the
  p = 3 replay's structured ledger sage/r19_trackB/p3_negctl_ledger_r19.json: 12 planted certificates, 12 rejected), the family ledger
  certificates/negctl/negctl_ledger_r14.json (9/9 negative controls REJECTED + the n = 2 positive control EXCLUDED), certificates/constants/
  Cn_interval_r14.json, sage/family_ky1000_r11_clean/VERIFY_LEDGER.txt (EXCLUDED 1000/1000).
- Verifier: scripts/verify_all_portable.sh r20 (new steps 13c statement_sync + statement_sync_negctl and 00e release_metadata; 04e-04h
  unchanged on the r19 certificate; step 09 unchanged: TWELVE Lean files, 63 declarations, std-3; no new Lean).
- Paper: paper/draft/main_R20.tex; Blueprint blueprint/blueprint_r20.pdf. Round files of r19 moved to archive/rounds/r19/
  (archive/rounds/MOVE_LOG_R20.txt).
- The two standing decisions of the author bind this round unchanged: (a) no external reviewer is solicited (not mentioned by the GPT r19
  review); (b) push / CI / tag / release / Zenodo happen once, at the end (restated by the review as its item 65, "GitHub cleanup in one
  batch after this synchronisation").
- NOT done at r20 (not claimed): clean-checkout CI replay, third-party replay, Washington statement numbers (hw 29 / 984; the book is not
  in paper/), the novelty reading (hw 868-876; the matrix is the container only), the author's sign-off of the Blueprint nodes (thm:P3 and
  thm:rank3 changed and are to be signed), web Blueprint build (hw 54), DOI reservation, Horie 2002 verbatim, Ramare journal-version
  comparison (hw 660), general odd p (hw 696 / 772 / 971 / 1043), Lean paper-facing wrapper with `Odd l` (hw 995) and the Lean of the
  character identification / Parseval step of Theorem rank3 (hw 733, 858-861), the P4 polish items of the review (hw 1023-1030, deferred).

## Previous: r19 candidate (superseded by the r20 candidate before any push; never released)
- Opened 2026-08-27 after the GPT r18 review (docs/GPT_HOMEWORK_R11_TRACKER.md rows 877-984; docs/ERRATA_R19.md). Verdict of that review:
  every theorem GO (Saturation-Height, Z_2 Theorem A, computation-free criterion, Prop D, n = 7, KY1000, Z_3 norm-one, spectral rank,
  exact covolume, Theorem P3, (4,4) corollary: 95-99%); NO-GO for sealing r18 AS IT STOOD, on four artifact grounds, none mathematical:
  (A) the read-only p = 3 replay tested only that the shipped interval MEETS the recomputed one (overlap); under containment 65/120 of the
  load-bearing shipped intervals failed (the shipped balls were narrower than the independent recomputation; at n = 4, r = 4 the C upper
  endpoint by 3.4e-1167 -- no printed digit affected); (B) the current proof source proofs/cor_P3n4.tex still cited the r17 certificate and
  producer, with stale round references in STATEMENT_FREEZE, blueprint/README, proofs/README and the CLAIMS header, none audited by
  tools/check_release_metadata.py; (C) the Blueprint defined \label{lem:mo25} twice (Z_2 height floor and Z_3 relative-norm-one floor;
  LaTeX resolved every \ref to the Z_3 lemma, so Lemma A+ pointed at the wrong floor in the PDF; blueprint/check_graph.py had merged the
  two lemmas into one node); (D) the submission body carried "statement numbers are to be confirmed against a physical copy" and "The r16
  version ... see ERRATA_R17", plus overfull boxes (main 4 / 17.7 pt, Blueprint 9 / 13.5 pt). All four are recorded as errata (E19-1,
  E19-2, E19-3; (D) is wording) and repaired in this round. No new mathematics; no statement change (theory/STATEMENT_FREEZE_R19.md N10).
- Repaired in this round: certificates/p3/D3_cert_r19.json, format v3 (every certified quantity = the EXACT dyadic outward hull of the
  producer balls sage/r19_trackB/p3_covol_balls_r19.json and of the read-only recomputation sage/r19_trackB/p3_readonly_recomputed_r19.json,
  widened about its centre to twice its half-width; producer / readonly / hull kept per field; generated by tools/gen_p3_cert_r19.py, which
  --check regenerates byte-identically from the two shipped inputs); the read-only replay scripts/verify_p3_readonly.sage (step 04f) now
  accepts schema v3 only (v2 rejected as deprecated, unknown schemas rejected), requires CONTAINMENT of its recomputation in every
  certified interval (120/120 = 8 load-bearing intervals x 15 rows; overlap is never accepted), writes a structured summary (verifier
  version + sha256, cert sha256, containment checked/failed, negctl planted/rejected) and rejects TWELVE planted certificates (the five of
  r18 plus seven that meet but do not contain the recomputed interval; the r18 gate demonstrably accepts planted certificate 6:
  sage/r19_trackB/r18gate_accepts_plant6_r19.log); the negative-control ledger docs/P3_NEGCTL_LEDGER_R19.md is generated from that one JSON
  (tools/gen_p3_negctl_ledger.py) and tools/check_constant_sync.py reads the count from it (no raw-log parsing); three checkers with
  separate roles (TRUST.md): tools/check_p3_cert.py = producer-record consistency + print strings (04e), the replay = semantic recomputation
  (04f), tools/check_p3_containment.py = coverage (04g; on the shipped recomputation and, 04g_fresh, on the run's own). Evidence sync: the
  shared proof cor_P3n4.tex names certificate, generator, replay and coverage checker by artifact ID (\artPcert etc.; the paper prints
  [P3-CERT] / [P3-GEN] / [P3-REPLAY] / [P3-COVER] / [P3-CHECK] with the paths in Appendix F, the Blueprint prints the paths);
  tools/check_release_metadata.py audits proofs/*.tex, blueprint/src/content.tex, the current STATEMENT_FREEZE block, both READMEs, the
  CLAIMS header, README.md and TRUST.md for round-versioned evidence paths that do not name the current round (history-marked lines
  exempt). Blueprint: lem:mo25 -> lem:mo25-z2 (Z_2, used by Lemma A+) and lem:mo25-z3 (Z_3, used by Theorem P3; the paper's lemma is
  lem:mo25-z3); blueprint/check_graph.py FAILS on any duplicate \label (65 nodes). Submission body: the two "to be confirmed against a
  physical copy" sentences withdrawn (Wash cited at chapter level; the theorem numbers stay an OPEN item, hw 29 / 984, recorded in the
  freeze and the tracker, never asserted from memory); the r16 / ERRATA_R17 development sentence removed from proofs/thm_P3.tex; the
  Documents paragraph path-free; round-numbered paths out of the trust-table caption.
- Claims: docs/CLAIMS_R19.yaml -> CORRESPONDENCE.csv (tools/gen_correspondence.py r19; 37 claims: CERT_D3 restated on the v3 certificate,
  COR_P3N4 / THM_P3 / THM_RANK3 / LEM_NORMONE evidence paths moved to r19). Blueprint: 65 nodes (lem:mo25-z2, lem:mo25-z3).
- Single sources of shared numbers (hard gate 00c): as r18, with certificates/p3/D3_cert_r19.json replacing the r18 file (gate 04e reads the
  exact endpoints; the printed 5- and 10-digit values are unchanged by the widening) and the structured ledger
  sage/r19_trackB/p3_negctl_ledger_r19.json (12 planted certificates, 12 rejected) as the second negative-control ledger; the family
  ledger certificates/negctl/negctl_ledger_r14.json is unchanged (9/9 negative controls REJECTED + the n = 2 positive control EXCLUDED).
- Verifier: scripts/verify_all_portable.sh r19 (steps 04e2, 04g, 04h and their _fresh twins new; 04f gated on containment 120/120 and
  12/12; step 09 unchanged: TWELVE Lean files, 63 declarations, std-3; no new Lean).
- Paper: paper/draft/main_R19.tex; Blueprint blueprint/blueprint_r19.pdf. Current-facing metadata synchronized to r19 by
  tools/check_release_metadata.py. Round files of r18 moved to archive/rounds/r18/ (archive/rounds/MOVE_LOG_R19.txt).
- The two standing decisions of the author bind this round unchanged: (a) no external reviewer is solicited (acknowledged by the GPT r18
  review, sect 5, as distinct from confirming citations); (b) push / CI / tag / release / Zenodo happen once, at the end (consistent with
  the review's P6, a local seal only).
- NOT done at r19 (not claimed): clean-checkout CI replay, third-party replay, Washington statement numbers (hw 29 / 70 / 497 / 585-590 /
  984; the book is not in paper/), novelty reading (hw 122 / 113-115 / 499-503 / 591-597 / 868-876), the author's sign-off of the Blueprint
  nodes, web Blueprint build (hw 54), DOI reservation, Horie 2002 verbatim, Ramare journal-version comparison (hw 660), general odd p
  (hw 696 / 772 / 971), Lean of the character identification / Parseval step of Theorem rank3 (hw 733, 858-861).

## Previous: r18 candidate (superseded by the r19 candidate before any push; never released)
- Opened 2026-08-26 after the GPT r17 review (docs/GPT_HOMEWORK_R11_TRACKER.md rows 777-876; docs/ERRATA_R18.md). Verdict of that review:
  the Z_3-tower mathematics GO (norm-one lemma, spectral rank for every (n, r), exact covolume, improvement over MO2016 Thm A in both
  classes: all three R17 gates accepted; Z_3 in the title justified); NO-GO for sealing the r17 zip as it stood, on artifact grounds:
  (A) the p = 3 certificate carried the label C while tools/check_p3_cert.py only checked JSON consistency / script hash / stored
  endpoints / improvement flags and did not recompute anything from the definitions; (B) the uploaded zip lacked twelve files listed in
  MANIFEST_SHA256.txt (r12 aux/out/toc, family-driver and survey-driver nohup .out logs); (C) current-facing metadata still said
  r15/r16; (D) the submission PDF carried round history. Both artifact defects are recorded as errata (E18-1, E18-2, E18-3).
- Repaired in this round: certificates/p3/D3_cert_r18.json, format v2 (every enclosed quantity as EXACT dyadic outward endpoints with
  radius, precision 4000 bits and rounding mode; directed 40-digit decimals for display; Gram route, character-product route and their
  intersection in separate fields; producer sage/r18_trackB/p3_covol_cert_r18.sage); the READ-ONLY REPLAY scripts/verify_p3_readonly.sage
  (verifier step 04f) rebuilds eta_n, all conjugate logs (sin form, cross-checked against the cyclotomic form), the Gram route by
  Gram-Schmidt, the DFT route, the floor, C^{(3)}_{n,r} and G(3,s,f) from the definitions in Arb at 4000 bits, requires every recomputed
  enclosure to meet the shipped exact interval, re-decides the improvement from its own balls (15/15 rows), and rejects five planted certificates
  (malformed / one route missing / wrong discriminant exponent / Schinzel floor substituted / MO13 comparator substituted);
  tools/check_p3_cert.py is now the consistency + print-string half (step 04e), reading the exact endpoints through tools/p3_interval.py.
  The label C of CERT_D3 rests on step 04f. Mathematics wording (GPT items 1-11): B_{3,0} = Q, h_{3,0} = 1 stated; a = 1+3^n of exact
  order 3; Lemma normone gains clause (v) (a lower-layer unit of relative norm 1 is 1), used in the floor paragraph of Theorem P3;
  conductor of chi_k proved in full; DFT sign and absolute-value conventions fixed; the 1/N normalisation of the two covolume routes made
  explicit; Lemma disc [L] (|disc Q(zeta_{3^r})| = 3^{3^{r-1}(2r-1)}) isolated; the comparator is named (the uniform-in-n bound of
  Morisawa-Okazaki, MO16 Thm A), never "best published"; "two independent linear-algebraic routes from the same log profile".
- Claims: docs/CLAIMS_R18.yaml -> CORRESPONDENCE.csv (tools/gen_correspondence.py r18; 37 claims: LEM_NORMONE, THM_RANK3, THM_P3, COR_P3N4,
  CERT_D3 restated). Blueprint: new node lem:disc; 64 nodes.
- Single sources of shared numbers (hard gate 00c): as r17, with certificates/p3/D3_cert_r18.json replacing the r17 file (gate 04e reads the
  exact endpoints) and the p = 3 replay log sage/r18_trackB/verify_p3_readonly_r18.log as the second negative-control ledger.
- Verifier: scripts/verify_all_portable.sh r18 (step 04f new; step 09 unchanged: TWELVE Lean files, 63 declarations, std-3).
- Paper: paper/draft/main_R18.tex; Blueprint blueprint/blueprint_r18.pdf. Current-facing metadata (CITATION.cff, .zenodo.json, PDF subject,
  Blueprint title, README summary, TeX header, trust-table caption) synchronized to r18 by tools/check_release_metadata.py (extended to the
  notes / identifier fields). Round files of r17 moved to archive/rounds/r17/ (archive/rounds/MOVE_LOG_R18.txt).
- The two standing decisions of the author bind this round unchanged: (a) no external reviewer is solicited; (b) push / CI / tag /
  release / Zenodo happen once, at the end. The GPT r17 review acknowledged (b) in its sect 7 and did not mention (a).
- NOT done at r18 (not claimed): clean-checkout CI replay, third-party replay, Washington citation numbers (hw 29 / 70 / 497 / 585-590;
  now also Lemma disc), novelty reading (hw 122 / 113-115 / 499-503 / 591-597 / 868-876), the author's sign-off of the Blueprint nodes,
  web Blueprint build (hw 54), DOI reservation, Horie 2002 verbatim, Ramare journal-version comparison (hw 660), general odd p (hw 696 / 772),
  Lean of the character identification / Parseval step of Theorem rank3 (hw 733, 858-861).

## Previous: r17 candidate (superseded by the r18 candidate before any push; never released)
- Opened 2026-08-26 after the GPT r16 review (docs/GPT_HOMEWORK_R11_TRACKER.md rows 707-776; docs/ERRATA_R17.md). Verdict of that review:
  Track A GO; Track B (Theorem P3 / Cor P3n4 of r16) NO-GO as stated: (A) the statement was for every n while (Rank) was certified for
  n <= 5 only; (B) the comparison used MO2013 only, whereas MO2016 Theorem A (G(3,4,1) = 3.71e37, G(3,4,2) = 6.09e18) is below the r16
  constants 2.12e44 / 1.46e22. Both defects are recorded as errata (E17-1, E17-2) and repaired in this round (theory/STATEMENT_FREEZE_R17.md
  N8): Lemma normone (Nr_{B_{3,n}/B_{3,n-1}} eta_n = 1 by a three-term telescoping; the saturation root has relative norm 1 and degree 3^n),
  Theorem rank3 (spectral rank: the Fourier coefficients of log|sigma^j eta_n| vanish exactly at 3 | k, so (Rank) holds for every n, r, and
  (D_r^{(n)})^2 = 3^{3^{r-1}(2r-1)} prod W_{n,r}(b), an exact character product), Theorem P3 restated with the relative-norm-one floor of
  MO2016 Lemma 2.5(2) and (Rank) proved (no certificate in the theorem), Cor P3n4 at n = 4: l == 1 (mod 81), l > 1.0728e33 or l == -1
  (mod 81), l > 3.2753e16 => l does not divide h_{3,4}/h_{3,3}, below MO2016 Thm A by 3.4594e4 resp. 1.8599e2 in the classes 81 || l -+ 1;
  the certificate certificates/p3/D3_cert_r17.json (two covolume routes, radii < 1e-800, MO2016 comparators, 15 rows, improvement in both
  classes in every row). Theorem SH restated in the carrier form proved in Lean (WeberSH.theoremSH); its r16 module form is Cor SH-mod.
- Claims: docs/CLAIMS_R17.yaml -> CORRESPONDENCE.csv (tools/gen_correspondence.py r17; 37 claims: + LEM_NORMONE, THM_RANK3, COR_SHMOD;
  THM_SH, THM_P3, COR_P3N4, CERT_D3 restated).
- Single sources of shared numbers (hard gate 00c): unchanged from r16 (certificates/constants/Cn_interval_r14.json, negctl ledger, KY1000
  ledger) plus certificates/p3/D3_cert_r17.json (gate 04e tools/check_p3_cert.py: every printed p = 3 number is generated from the JSON,
  our constants rounded up, comparators and gains rounded down, and must appear verbatim in paper / proofs / Blueprint).
- Verifier: scripts/verify_all_portable.sh r17 (step 09 compiles TWELVE Lean files, 3/5/4/6/6/5/3/7/4/4/3/13 = 63 declarations, std-3;
  step 04e reads the r17 certificate). Lean new in r17: lean/WeberP3Rel.lean (13 declarations: the discrete parts of Lemma normone, the
  coset-sum vanishing, the twisted-sum shift algebra of Theorem rank3 Step 2, the primitive-root polynomial step).
- Paper: paper/draft/main_R17.tex (Theorem SH carrier form + Cor SH-mod; Section "The cyclotomic Z_3-tower" rewritten: Lemma normone,
  Theorem rank3, Lemma mo25 [L], Theorem P3, Table tab:p3 with the MO2016 comparators, Cor P3n4; title and abstract carry the Z_3-tower
  again after the three gates of the review passed). Blueprint: 63 nodes / 87 edges, docs/BLUEPRINT_PROOF_REPORT_R17.md; human sign-off
  ledger docs/BLUEPRINT_HUMAN_REVIEW_R17.md (still unsigned). Round files of r16 moved to archive/rounds/r16/ (archive/rounds/MOVE_LOG_R17.txt).
- Release metadata: CITATION.cff, .zenodo.json version r17 (synchronized; DOI / license / repository URL still the author's).
- Literature inputs new in r17 and their reading status: MO2016 Theorem A (p = 3 formula parsed from the JTNB PDF, checked against the
  paper's own Example 1.6), MO2016 Def. 2.2, Lemma 2.3, Lemma 2.4(2), Lemma 2.5(2) (read verbatim); Washington Thm 4.9 (formula as in
  Prop D; theorem number still to be confirmed against a physical copy, hw 29); Dirichlet L(1,chi) != 0 (standard). Horie 2005 JMSJ (open access, paper/Horie2005_JMSJ_triviality.pdf) Proposition 1 = the general form of Horie's saturation lemma with proof,
  read; Horie 2002 (JLMS, paywalled) still not compared verbatim (flagged in lem:horie13); Morisawa 2012 quoted through MO2013 only,
  for the record column.
- The two standing decisions of the author bind this round unchanged: (a) no external reviewer is solicited; (b) push / CI / tag /
  release / Zenodo happen once, at the end. The GPT r16 review restated (b) as its item 70 and did not mention (a).
- NOT done at r17 (not claimed): clean-checkout CI replay, third-party replay, Washington citation numbers (hw 29 / 70 / 497 / 585-590),
  novelty reading (hw 122 / 113-115 / 499-503 / 591-597), the author's sign-off of the Blueprint nodes, web Blueprint build (hw 54), DOI
  reservation, Horie 2002 verbatim, Ramare journal-version comparison (hw 660), general odd p (hw 696 / 772), Lean of the L-function
  identity behind Theorem rank3 Step 2 (the finite Fourier algebra is in Lean; the character identification, Washington's formula and
  the Parseval/Vandermonde step of Step 4 stay M with L inputs).

## Previous: r16 candidate (superseded by the r17 candidate before any push; never released)
- Opened 2026-08-26 after the GPT r15 review (docs/GPT_HOMEWORK_R11_TRACKER.md rows 635-706; docs/LETTER_R16.md). Author's ruling: all 72
  items of the review are executed in this round ("last push"). Mathematics added (theory/STATEMENT_FREEZE_R16.md): Theorem SH
  (abstract componentwise saturation-height bound, N1; Theorem A re-proved as its specialisation, Prop F), Corollary A-hat (computation-
  free criterion from Ramaré's explicit |L(1,chi)| bound, N3), Corollary order (explicit threshold T_n via Robbins, N4), Theorem P3 and
  Corollary P3n4 (the cyclotomic Z_3-tower, layer-fixed bound from Horie's saturation lemma + Schinzel floor + exact covolume, N7; at
  n = 4: l == 1 (mod 81), l > 2.1204e44 or l == -1 (mod 81), l > 1.4562e22 => l does not divide h_{3,4}/h_{3,3}). Statement change of
  a frozen item: Cor T floor max{1, .} (presentational). Sect 2 items of the review (Kronecker in Lemma D, Lemma E typing residue,
  Washington wording, Prop D role, Magma digits wording, S0 "weaker" scope, trust-boundary wording, title "relative") done.
- Claims: docs/CLAIMS_R16.yaml -> CORRESPONDENCE.csv (tools/gen_correspondence.py r16; new claims THM_SH, COR_AHAT, COR_ORDER, THM_P3,
  COR_P3N4, CERT_D3; LEM_B upgraded to F; LEM_E / PROP_F gain Lean declarations).
- Single sources of shared numbers (hard gate 00c): unchanged from r15 (certificates/constants/Cn_interval_r14.json, negctl ledger,
  KY1000 ledger) plus certificates/p3/D3_cert_r16.json (p = 3 covolumes and constants, 15 rows, 4000-bit balls, radii < 1e-800; gate
  04e tools/check_p3_cert.py checks the printed p = 3 numbers against it; script sage/r16_trackB/p3_covol_cert.sage).
- Verifier: scripts/verify_all_portable.sh r16 (step 09 compiles ELEVEN Lean files, 3/5/4/6/6/5/3/7/4/4/3 = 50 declarations, std-3;
  new step 04e p3_cert). Lean new in r16: lean/WeberHatC.lean, WeberSH.lean, WeberLemmaB.lean, WeberRoots.lean, WeberP3.lean.
- Paper: paper/draft/main_R16.tex (Theorem SH in the results section; Cor A-hat, Cor order; new Section "The cyclotomic Z_3-tower";
  trust table + 4 rows). Blueprint: 60 nodes / 80 edges, docs/BLUEPRINT_PROOF_REPORT_R16.md; human sign-off ledger
  docs/BLUEPRINT_HUMAN_REVIEW_R16.md (still unsigned). Round files of r15 moved to archive/rounds/r15/ (archive/rounds/MOVE_LOG_R16.txt).
- Release metadata: CITATION.cff, .zenodo.json version r16 (synchronized; DOI / license / repository URL still the author's).
- Literature inputs new in r16 and their reading status (theory/PHASE_MINUS1_R16_LITERATURE.md): Ramaré 2004 Cor. 1 (read from the
  author's accepted manuscript; journal typesetting not compared), Robbins 1955 (read), MO2013 (read in full), Horie 2005 PJA (read;
  relays Horie 2002, which has NOT been read — flagged in the Blueprint node lem:horie13), Morisawa 2012 (not read; its p = 3 theorem
  is used only as quoted in MO2013 Thm 0.3, for the comparison table).
- The two standing decisions of the author (r15) bind this round unchanged: (a) no external reviewer is solicited; (b) push / CI / tag /
  release / Zenodo happen once, at the end. The GPT r15 review adopted both.
- NOT done at r16 (not claimed): clean-checkout CI replay, third-party replay, Washington citation numbers (hw 29 / 70 / 497 / 585-590),
  novelty reading (hw 122 / 113-115 / 499-503 / 591-597), the author's sign-off of the Blueprint nodes, web Blueprint build (hw 54), DOI
  reservation, Horie 2002 verbatim, Ramaré journal-version comparison (hw 660), the character-product formula for D_r^{(n)} (hw 689),
  general odd p (hw 696).

## Previous: r15 candidate (superseded by the r16 candidate before any push; never released)
- Opened 2026-08-26 after the GPT r14 review (docs/GPT_HOMEWORK_R11_TRACKER.md rows 525-634; docs/LETTER_R15.md). One theorem statement
  change (theory/STATEMENT_FREEZE_R15.md item 6): Theorem S0 keeps hypothesis (i) only; the former hypothesis (ii) is Lemma depthfloor;
  NEW Lemma oddtransfer (odd-power depth transfer; lean/WeberOddTransfer.lean, 5 declarations, std-3). Errata against r14:
  docs/ERRATA_R15.md (E15-1 the S0 proof gap u_a = r_a^l == 1 -> r_a == 1 (mod 2^t); E15-2 Cor S1 "three independent systems";
  E15-3 the self-referential release protocol; E15-4 record-only). No new primes, no new experiments, no other statement change.
- Claims: docs/CLAIMS_R15.yaml -> CORRESPONDENCE.csv (tools/gen_correspondence.py r15; 28 claims; new claim LEM_ODDTRANSFER).
- Single sources of shared numbers (hard gate 00c): certificates/constants/Cn_interval_r14.json (C_n enclosures, both endpoints to 160
  digits; C_7 display = 38-digit truncation of the certified 145-digit prefix), certificates/negctl/negctl_ledger_r14.json (nine negative
  controls REJECTED + the n = 2 positive control EXCLUDED), sage/family_ky1000_r11_clean/VERIFY_LEDGER.txt (KY1000: 1000/1000, 32000 T,
  31987 RHO, 13 T-only, max T 4164.4897, margin 59.5103). Cross-CAS: certificates/constants/C7_cross_cas_r14.json (intervals per route;
  no tolerance). Gates on the gates: tools/negctl_tools_r14.py (13 planted defects), tools/verifier_profile_tests.sh (10 profile cases).
- Verifier: scripts/verify_all_portable.sh r15 with VERIFY_PROFILE=full|sage|lean (step 09 now compiles six Lean files, 3/5/4/6/6/5 =
  29 declarations); a skipped mandatory step is a FAIL; partial profiles never print the FULL line; verify_out/SUMMARY.json.
  CI (.github/workflows/verify.yml): sage job (profile sage, Docker) + lean job (profile lean) + full job (aggregator; ci_attestation.json
  as a release asset, with the Docker image id and the runner image recorded by the sage job).
- Paper: paper/draft/main_R15.tex (Table 1 split into 1a/1b, Table 2 long column moved to prose, artifact paths moved to the
  Verification appendix; overfull boxes reduced). Blueprint: 49 nodes / 63 edges, docs/BLUEPRINT_PROOF_REPORT_R15.md, human sign-off
  ledger docs/BLUEPRINT_HUMAN_REVIEW_R15.md (empty until a human signs). Active root: theory/ reduced to the frozen statements and the
  documents a current theorem cites; research documents moved to archive/proof_search/ (archive/README.md, MOVE_LOG_R15).
- Release metadata prepared: CITATION.cff, .zenodo.json (synchronized; version r15; DOI fields left for the reservation step).
- Two standing decisions of the author (2026-08-26, ruling of R15; they bind every later round):
  (a) NO EXTERNAL REVIEWER IS SOLICITED. The author trusts the kernel: correctness rests on F (Lean, std-3) and C (certificate + read-only
      checker); M nodes are read by the author (adversarial re-reading) and by the LLM reviewer (GPT rounds). The Theorem A translation
      note docs/audit_notes/THM_A_KY_TRANSLATION_NOTE_R15.tex is an INTERNAL audit document; it is not sent to anyone. Gate "external
      number-theorist review" is DECLINED, not pending.
  (b) GITHUB PUSH / CI / TAG / RELEASE / ZENODO HAPPEN ONCE, AT THE END, after every other item is closed. CI green is therefore not a
      per-round gate: the three jobs, the attestation asset, the tag and the DOI are one final step, executed together by the author.
- NOT done at r15 (not claimed): clean-checkout CI replay (never executed; docker absent on every author machine; the workflow was
  written blind; by decision (b) it runs once, at the end), third-party replay, Washington citation numbers (hw 29 / 70 / 497 / 585-590),
  novelty reading (hw 122 / 113-115 / 499-503 / 591-597), the author's sign-off of the Blueprint nodes (ledger empty), web Blueprint
  build (hw 54), DOI reservation (at the final release).

## Previous: r14 candidate (superseded by the r15 candidate before any push; never released)
- Opened 2026-08-26 after the GPT r13 review (docs/GPT_HOMEWORK_R11_TRACKER.md rows 387-524; docs/LETTER_R14.md). Seal round: no new
  mathematics, no theorem statement change (theory/STATEMENT_FREEZE_R14.md). Errata against r13: docs/ERRATA_R14.md (E14-1 C_7 display
  and certificate; E14-2 negative-control count desync; E14-3 Magma tolerance test withdrawn; E14-4 verifier PASS on skipped steps).
- Claims: docs/CLAIMS_R14.yaml -> CORRESPONDENCE.csv (tools/gen_correspondence.py r14; 27 claims).
- Single sources of shared numbers (hard gate 00c): certificates/constants/Cn_interval_r14.json (C_n enclosures, both endpoints to 160
  digits; C_7 display = 38-digit truncation of the certified 145-digit prefix), certificates/negctl/negctl_ledger_r14.json (nine negative
  controls REJECTED + the n = 2 positive control EXCLUDED), sage/family_ky1000_r11_clean/VERIFY_LEDGER.txt (KY1000: 1000/1000, 32000 T,
  31987 RHO, 13 T-only, max T 4164.4897, margin 59.5103). Cross-CAS: certificates/constants/C7_cross_cas_r14.json (intervals per route;
  no tolerance). Gates on the gates: tools/negctl_tools_r14.py (13 planted defects), tools/verifier_profile_tests.sh (10 profile cases).
- Verifier: scripts/verify_all_portable.sh r14 with VERIFY_PROFILE=full|sage|lean; a skipped mandatory step is a FAIL; partial profiles
  end with SAGE_PROFILE / LEAN_PROFILE lines and never with the FULL line; verify_out/SUMMARY.json is the structured result.
  CI (.github/workflows/verify.yml): sage job (profile sage, Docker) + lean job (profile lean) + full job (aggregator: FULL VERIFICATION
  only from both profile PASSes on the same commit; ci_attestation.json).
- Sealing order for r14: all edits finished -> tools re-run (gen_cn_certs, gen_negctl_ledger, gen_correspondence r14, gen_blueprint_map)
  -> MANIFEST_SHA256.txt regenerated -> this block written -> manifest regenerated once more -> scripts/verify_all_portable.sh
  (VERIFY_PROFILE=full, local Sage + Lean + pdflatex) on the tree as it stands (verify_out/ shipped) -> NO edit of any listed file
  afterwards -> zip. The zip's own SHA256 is recorded in the vault HANDOFF.md (not shipped). The git commit SHA, the immutable tag and
  the CI run (run id / URL / ci_attestation.json) are Dr. Fukui's and are appended ONLY as a new "Sealed: r14" block; if anything
  else changes, the full verifier is re-run and a new candidate block replaces this one.
- NOT done at r14 (not claimed): clean-checkout CI replay (never executed; docker absent on every author machine; the r14 workflow,
  profiles and aggregator were written blind), Washington citation numbers (hw 29 / 70 / 497), novelty reading (hw 122 / 113-115 /
  499-503), external read of Theorem A (hw 191 / 56 / 491), web Blueprint build (hw 54), CITATION.cff / .zenodo.json (hw 118-119 / 511-512).

## Previous: r13 candidate (superseded by the r14 candidate before any push; never released)
- Opened 2026-08-25 after the GPT r12 review (docs/GPT_HOMEWORK_R11_TRACKER.md rows 257-386; docs/LETTER_R13.md).
- Errata against r12: docs/ERRATA_R13.md (E13-1, the n = 2 certificate threshold). Statements: theory/STATEMENT_FREEZE_R13.md
  (no theorem statement changed). Claims: docs/CLAIMS_R13.yaml -> CORRESPONDENCE.csv (tools/gen_correspondence.py r13).
- Sealing order for r13: all edits finished -> MANIFEST_SHA256.txt regenerated -> this block written -> manifest regenerated once
  more (so that this file is listed) -> scripts/verify_all_portable.sh r13 run on the tree as it stands (verify_out/ shipped) ->
  NO edit of any listed file afterwards -> zip. The zip's own SHA256 cannot be inside the zip; it is recorded in the vault
  HANDOFF.md (not shipped). The git commit SHA and the immutable tag of this tree are Dr. Fukui's and are appended to this file
  ONLY as a new "Sealed: r13" block at release time, after the GitHub Actions run (URL / run id) exists; if anything else changes,
  the full verifier is re-run and a new candidate block replaces this one.
- What the r13 run checks that r12 did not: step 00b threshold synchronisation; step 07b normalized per-prime comparison (raw
  verifier-log sha256 demoted to forensic); nine negative controls + the n = 2 positive control; five Lean files (24 declarations,
  3/5/4/6/6); Blueprint evidence-presence + human-proof gate on 48 nodes.
- NOT done at r13 (not claimed): clean-checkout CI replay (never executed; docker absent on every author machine; elan/porcelain
  fixes written blind), Washington citation numbers (hw 29 / 70), novelty reading (hw 122 / 113-115), external read of Theorem A
  (hw 191 / 56), certificate format version and second verifier (R14), web Blueprint build (R14).

## Previous: r12 opening record
- Opened 2026-08-25 after the GPT r11 review (docs/GPT_HOMEWORK_R11_TRACKER.md rows 127-256).
- Errata against r11: docs/ERRATA_R12.md (E12-1..E12-7). Statements: theory/STATEMENT_FREEZE_R12.md.
- Claims: docs/CLAIMS_R12.yaml -> CORRESPONDENCE.csv (tools/gen_correspondence.py r12).
- This section is replaced by a "Sealed: r12" block at the r12 seal (verifier PASS timestamp, manifest md5,
  counts); the zip hash itself is recorded only in the vault HANDOFF.md.
