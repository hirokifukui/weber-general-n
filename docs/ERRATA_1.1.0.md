# ERRATA_1.1.0 — errata opened in the 1.1.0 (MoC recast) round

## E1.1.0-1 — proofs/cor_T.tex: the Example paragraph of the proof of Cor.~T
- v1.0.2 text: the worked example at n = 7 justified f_7(B) = 2 and f_7(B_1) = 1 through decimal quotients
  (log C_7/log B = 30.2374.../15.1187... = 1.99998...; 0.99999...), display values not themselves carried by a certificate.
- 1.1.0 text: the same conclusions are drawn from the certified integer comparisons B < C_7 < B^2 (Lemma C7int)
  and 1 < C_7 < B_1, the frozen integers of Cor.~7; no decimal is load-bearing.
- The STATEMENT of Cor.~T is unchanged (STATEMENT_FREEZE_1.1.0; the 38 statement files are byte-identical).
- Effect: the proof text shared by the paper and the Blueprint; the shipped v1.0.2 PDFs retain the old paragraph (history).
