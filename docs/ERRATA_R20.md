# ERRATA_R20 — corrections made in r20 against the sealed r19 (2026-08-27)

Two MATHEMATICAL-TEXT errata, both mine, both found by the GPT r19 review (items 1-2), both repaired here without new mathematics,
without new Lean and without touching the p = 3 certificate; a third item (notation, same class as E20-2, found by my own grep) is
recorded as E20-3. No printed digit is affected. The r19 artifact repair (E19-1/2/3) was accepted by the review in full.

- E20-1 (scope of Theorem P3: the wording admitted l = 2, which the proof never covered). The sealed r19 Theorem P3 (paper
  main_R19.tex l.351, Blueprint content.tex l.366, identical in r17 and r18) read "Let n >= 1, l != 3 a prime, ...". The proof uses
  the oddness of l twice: (a) in Lemma normone (iv), the transfer of relative norm 1 to the l-th root -- Nr(eps)^l = Nr(eta_n)^{alpha}
  = 1 with Nr(eps) a real number gives Nr(eps) = 1 only for l ODD (the Lean lemma WeberP3Rel.eq_one_of_odd_pow_eq_one carries the
  hypothesis `Odd l`; the shared proof proofs/lem_normone.tex already said "l an odd prime"); (b) in the conclusion, which applies
  Theorem SH, whose statement (sect 1.2, N1) is for an odd prime. So the r19 statement asserted a case (l = 2) that was not proved:
  a scope error of the same kind as the earlier n = 2 trace floor / all-n rank certificate items, and the FIRST statement change
  since STATEMENT_FREEZE_R19 N10. Repair (STATEMENT_FREEZE_R20 N11): Theorem P3 now reads "l != 3 an odd prime" in both media
  (byte-identical statement text, tools/check_statement_sync.py, verifier step 13c); the shared proof proofs/thm_P3.tex opens with
  "Since l is odd and l != 3 ..." naming (a) and (b) and stating that nothing is claimed for l = 2; docs/CLAIMS_R20.yaml THM_P3
  carries machine-readable conditions {n_ge_1, ell_prime, ell_ne_3, ell_odd} with their phrases, each checked in the claims
  statement and in both statement texts, and a note that the Lean core WeberP3.theoremP3_core is the generic carrier (0 < l) --
  the odd-prime condition enters at the M/F bridge and is NOT a hypothesis of the Lean core (TRUST.md; no new Lean in r20 by
  ruling, tracker hw 995 -> R21+). Cor P3n4 is unchanged: its hypothesis l == +-1 (mod 81) already forces l odd (2 !== +-1 mod 81;
  81k +- 1 is even for odd k), so the printed thresholds 1.0728e33 / 3.2753e16 and the factors 3.4594e4 / 1.8599e2, the certificate
  certificates/p3/D3_cert_r19.json (unchanged, ships under its r19 name) and every other statement of N1-N10 are untouched. The
  alternative of keeping l = 2 by a sign correction (Nr(eps) = -1 => Nr(-eps) = (-1)^3 Nr(eps) = 1, relative degree 3, log
  absolute vector unchanged) is correct but not adopted: it would add a branch to the proof, the Blueprint and the Lean bridge for a
  case that no corollary uses. (GPT r19 items 1-15 = tracker hw 985-999.)

- E20-2 (false integer equalities in the shared proof of Theorem rank3). proofs/thm_rank3.tex Step 2 (sealed r17-r19) wrote
  "q = 3N, a = 1+N = 4^{N/3} by Lemma normone (ii)" and, in the conductor argument, "Since a = 4^{N/3} (Lemma normone (ii))".
  As integer equalities these are FALSE for every n >= 2 (n = 2: a = 10, 4^{N/3} = 4^3 = 64; checked for n = 1..12); only the
  congruence 4^{N/3} == 1+N (mod q), q = 3N, holds, and that is exactly what Lemma normone (ii) states and the Lean lemma
  WeberP3Rel.four_pow_modEq proves (4^(3^(n-1)) == 1 + 3^n [ZMOD 3^(n+1)]). The argument needs only the congruence, because the
  function g and the characters chi_k are functions on (Z/q)^x. Repair: both places now read a == 4^{N/3} (mod q), with
  \path{WeberP3Rel.four_pow_modEq} named, and one sentence states that the arguments of g and of chi_k are residue classes modulo q;
  the Blueprint is updated through the single-source proof; the false forms are FORBIDDEN in the active proof source, the paper body
  and the Blueprint by tools/check_release_metadata.py (verifier step 00e; the archive keeps the old wording as history). Lean, the
  statement of Theorem rank3, the certificate and every number are unchanged. (GPT r19 items 16-24 = tracker hw 1000-1008.)

- E20-3 (same notation class, found by the boot grep, tracker hw 1050). The same Step 2 wrote "write -2 = 4^{j_0}": an identity in
  (Z/q)^x, i.e. a congruence mod q, written as an equality. Now "-2 == 4^{j_0} (mod q)"; forbidden by the same gate.

Wording / ledger items recorded without a number (GPT r19 items 33-38 = hw 1017-1022): the CURRENT trust ledgers (CORRESPONDENCE.csv
via docs/CLAIMS_R20.yaml, TRUST.md, STATEMENT_FREEZE_R20 current block) still carried "theorem numbers to be confirmed against a
physical copy" for Washington GTM 83 after the submission body had been made chapter-level in r19. They now cite Washington at
chapter level too, with the reason (the two formulas are restated as Lemma D3 / App D and Lemma disc and their normalisations were
checked independently, hw 30/32 -- no theorem NUMBER is load-bearing); the numbers stay an OPEN tracker item (hw 29/984) and are
asserted nowhere. The L inputs are tagged [used] / [historical] / [unread] (TRUST.md; Ho02 unread, Ho05b a relay, MO13 Lemma 1.3 and
Ho05a Prop. 1 used). Design note, not an erratum: the p = 3 certificate family is unchanged in r20 and keeps its r19 file names;
tools/check_release_metadata.py now distinguishes the PACKAGE round (main_R20, CLAIMS_R20, ...) from the CERTIFICATE round (single
source: the certificate path in tools/check_p3_cert.py), so an unchanged certificate is not renamed and a stale one still fails.
