# ERRATA_R19 — corrections made in r19 against the sealed r18 (2026-08-27)

No mathematical erratum: the GPT r18 review found no new gap in any theorem (every theorem GO, 95-99%) and no printed digit is
affected. Three ARTIFACT errata, all mine; a fourth item (wording of the submission body) is recorded below without a number.

- E19-1 (certificate semantics: overlap accepted where containment was required). The r18 read-only replay
  scripts/verify_p3_readonly.sage compared each of the 8 load-bearing intervals of each of the 15 rows (120 intervals) of the shipped
  p = 3 certificate certificates/p3/D3_cert_r18.json with its own recomputation by `overlap` only: it accepted a shipped interval that
  MEETS the recomputed one. A certificate interval certifies a value only if it CONTAINS an independent rigorous recomputation of
  that value; overlap does not establish that. Under containment, 65/120 shipped intervals FAILED (D_dft 15, D_intersection 15, C 15,
  sqrt C 15, D_gram 5; Lrel and G 0): the producer's balls (determinant route, direct-exponential DFT) and the replay's balls
  (Gram-Schmidt, omega-power DFT) are both rigorous but have different rounding histories, and the producer's were the narrower
  ones (shipped inside recomputed in 110/120, identical in 45/120); at n = 4, r = 4 the shipped upper endpoint of C^{(3)}_{4,4} lay
  3.347e-1167 below the recomputed one. The printed 5- and 10-digit values, the thresholds and the improvement factors are
  unchanged. Evidence: tools/check_p3_containment.py on the r18 certificate reports 55/120; sage/r19_trackB/
  r18gate_accepts_plant6_r19.log shows the r18 verifier ACCEPTING a planted certificate whose every field meets but does not contain
  the recomputation. Repair: (i) the certificate is regenerated as format v3 (certificates/p3/D3_cert_r19.json, tools/gen_p3_cert_r19.py):
  every certified quantity is the EXACT dyadic outward hull of the producer balls (sage/r19_trackB/p3_covol_balls_r19.json) and of the
  read-only recomputation (sage/r19_trackB/p3_readonly_recomputed_r19.json), widened about its centre to twice its half-width (a
  documented margin for foreign Arb builds, hw 981), with producer / readonly / hull kept per field; (ii) the replay's gate is
  I_rec subset I_ship on all 120 intervals (tools/p3_interval.contains); overlap is never accepted; schema v2 is rejected as
  deprecated, unknown schemas are rejected; (iii) twelve planted certificates (the five of r18 plus seven that meet but do not contain:
  shifted narrow intervals, lower endpoints moved inward, upper endpoints moved inward, Gram route alone, DFT route alone, C alone,
  sqrt C alone) must all be rejected, ledger docs/P3_NEGCTL_LEDGER_R19.md generated from the replay's JSON; (iv) the coverage relation
  is re-decided independently by tools/check_p3_containment.py (verifier step 04g) on the shipped recomputation and on the run's own;
  (v) the three checkers are documented as three roles (TRUST.md): producer-record consistency (tools/check_p3_cert.py, 04e), semantic
  recomputation (the replay, 04f), coverage (04g); the replay writes a structured summary (verifier version + sha256, cert sha256,
  containment checked/failed, negctl planted/rejected) and no raw log is parsed by any gate.
- E19-2 (stale evidence references in the current proof source). The shared proof proofs/cor_P3n4.tex (\input by the paper and the
  Blueprint) still cited certificates/p3/D3_cert_r17.json and sage/r17_trackB/p3_covol_cert_r17.sage as the certificate of Cor P3n4,
  i.e. the r18 package presented r17 evidence as current; theory/STATEMENT_FREEZE_R18.md (R17 block), blueprint/README.md
  (blueprint_r17.pdf, BLUEPRINT_PROOF_REPORT_R17, BLUEPRINT_HUMAN_REVIEW_R16), proofs/README.md (main_R17.tex), the header comment of
  docs/CLAIMS_R18.yaml (CLAIMS_R17) and the header comment of blueprint/src/content.tex (STATEMENT_FREEZE_R15 / main_R16) were stale;
  tools/check_release_metadata.py audited none of them. Repair: cor_P3n4.tex names the certificate, its generator, the read-only replay
  and the coverage checker by artifact ID (\artPcert, \artPgen, \artPreplay, \artPcover: the paper prints [P3-CERT] / [P3-GEN] /
  [P3-REPLAY] / [P3-COVER] with the paths in Appendix F, the Blueprint prints the paths); every listed file is current;
  tools/check_release_metadata.py now audits proofs/*.tex, blueprint/src/content.tex, the current block of the STATEMENT_FREEZE, both
  READMEs, the CLAIMS header, README.md and TRUST.md for round-versioned evidence paths that do not name the current round
  (lines marked as history are exempt); a stale current certificate path FAILS tools/check_release_metadata.py (a hard gate of scripts/verify_all_portable.sh).
- E19-3 (duplicate Blueprint label; merged dependency node). blueprint/src/content.tex defined \label{lem:mo25} twice: the Z_2 height
  floor (Lemma 2.5, used by Lemma A+) and the Z_3 relative-norm-one floor (Lemma 7.2, used by Theorem P3). LaTeX warned "multiply
  defined" and resolved every \ref to the LAST definition, so in the shipped Blueprint PDF the Z_2 Lemma A+ cited the Z_3 floor; and
  blueprint/check_graph.py, which keys nodes by label, silently MERGED the two lemmas into one node (66 label definitions, 65 unique,
  64 nodes reported), so the dependency graph and the leanok / orphan counts were computed on a wrong graph. Repair: lem:mo25-z2 and
  lem:mo25-z3, every \ref and \uses updated (the paper's single lemma is lem:mo25-z3; proofs/thm_P3.tex updated); check_graph.py FAILS
  on any duplicate \label (65 nodes now); the shipped print.aux carries one \newlabel per label; verified in the rebuilt PDF that
  Lemma A+ cites Lemma 2.5 and Theorem P3 cites Lemma 7.2.
- Wording (no number). The submission body carried "the statement numbers are to be confirmed against a physical copy" (Lemma disc,
  and the citation-conventions paragraph on Wash Thm 4.9) and the development sentence "The r16 version of this theorem used the
  weaker floor ... see ERRATA_R17" (proofs/thm_P3.tex), plus smaller round-history remarks (thm_S0, prop_F, lem_Sineq, lem_depthfloor,
  thm_family, the Artifact index) and round-numbered paths in the trust-table caption and the Documents paragraph. All removed:
  Washington is cited at chapter level (Chapter 2 for the discriminant and integral basis; Chapter 4 for the L(1, chi) formula and the
  Gauss-sum modulus) and no theorem number is asserted from memory -- the numbers remain an OPEN item (hw 29 / 984) recorded in the
  freeze and the tracker; development history lives in the ERRATA files and archive/rounds/; the body refers to artifacts by ID.
  Overfull boxes reduced below 10 pt in both PDFs (paper 3 / max 7.3 pt; Blueprint 2 / max 9.0 pt).
