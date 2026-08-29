# ERRATA_R17 — corrections made in r17 against the sealed r16 (2026-08-26)

Two mathematical-scope errata (E17-1, E17-2) and one erratum of self-assessment (E17-3). All three concern the R16 Track B
(Theorem P3, Corollary P3n4, Section "The cyclotomic Z_3-tower"); Track A (Theorem A, Theorem SH, Cor A-hat, Cor order, S0/S1,
KY1000, the certificates) is untouched by them.

- E17-1 (comparison, wrong comparator). Corollary P3n4 and the r16 abstract compared the layer-fixed constants C^{(3)}_{4,4} = 2.1204e44
  (l == 1 mod 81) / sqrt = 1.4562e22 (l == -1 mod 81) with MO2013 Thm 0.3 (3.098e79) and MO2013 Thm A (7.63e101) only. The best
  published uniform bound is MO2016 Theorem A (T. Morisawa, R. Okazaki, Height and Weber's class number problem, JTNB 28 (2016),
  811-828; paper/MO2016_height_weber_jtnb965.pdf, in this repository since r7): at p = 3, G(3,s,f) = ((sqrt(2 pi) / (3^{3/4}
  log((3^{40/81} + sqrt(3^{80/81}+4))/2)))^c ((c+2)/2)!)^{1/f}, c = 2*3^{s-1}, i.e. G(3,4,1) = 3.711e37 and G(3,4,2) = 6.092e18
  (verified against the paper's own Example 1.6: G(3,3,2) = 42407.5 vs "4.3e4"). The r16 constants are LARGER than these by 5.7e6
  (f = 1) and 2.4e3 (f = 2): the sentence "against 3.1e79 for the published uniform bound" was misleading and the r16 Track B result
  was not an improvement of the state of the art. Gate 3 of R16 (ruling point (2)) was passed on an incomplete Phase -1: MO2016 had
  been read for its Theorem 2.7 (Blichfeldt) and its Lemma 9.1 relay, but its Theorem A was not put in the comparison. Withdrawn:
  the abstract sentence, the title "... Z_2- and Z_3-towers" (reverted to the Z_2-tower until the R17 gates pass), the wording
  "published uniform bound" in Cor P3n4 and in the comparison table. Tracker hw 708-710, 714.
- E17-2 (scope, all n vs n <= 5). Theorem P3 (STATEMENT_FREEZE_R16 N7) is stated for every n >= 1 with the constant built from the
  covolume D_r^{(n)} of the Horie-unit log lattice, whose positivity (the hypothesis (Rank) of Theorem SH) is not stated as a
  hypothesis of Theorem P3 and is certified (certificates/p3/D3_cert_r16.json) only for 1 <= r <= n <= 5. As written, the statement
  for n >= 6 rested on an unproved (Rank). Repair in R17: (Rank) is proved for every n, r (spectral rank theorem: the DFT of
  log|sigma^j eta_n| vanishes exactly at 3 | k and the exact covolume is |disc Q(zeta_{3^r})| times a product of positive spectral
  weights), so the repaired theorem carries no unproved hypothesis; until that proof is in the manuscript, THM_P3 / COR_P3N4 /
  CERT_D3 are "REPAIR PENDING" in docs/CLAIMS_R16.yaml. Tracker hw 707, 711, 712.
- E17-3 (self-assessment). LETTER_R16 and the r16 candidate block said that all 72 items of the r15 review were executed. Not
  executed in substance: hw 689 (the character-product formula for D_r^{(n)} was not derived; a C-label was used instead), the
  all-n (Rank) proof (E17-2), the best-published comparison (E17-1), and Morisawa 2012 (unread, quoted only through MO2013). The
  R16 tracker statuses of 689 (PARTIAL) and the "NOT done at r16" list of RELEASE_STATUS were correct; the summary sentence was not.
  Withdrawn. Tracker hw 713.

Not an erratum but recorded here for the reader of r16: the r16 floor sqrt(3^n) log((1+sqrt5)/2) (Schinzel via MO2013 Thm 2.2)
is correct as used; it is replaced in R17 by the stronger relative-norm-one floor of MO2016 Lemma 2.5(2), which applies because
the Horie unit eta_n has relative norm 1 (three-term telescoping of sin(2 a^i pi/q), a = 1 + 3^n). The R16 numerical values are
correct enclosures of the R16 (weaker) constants; they are superseded, not wrong.
