# proofs/ — single source of every natural-language proof (r13; GPT r11 hw 185-186, r12 hw 37-50)

Each file is ONE proof body (no \begin{proof}), \input by BOTH paper/draft/main_1.0.1.tex and
blueprint/src/content.tex via \input{\proofsdir/<name>}, where \proofsdir = ../../proofs from either
build directory. Editing a proof here edits it in the paper and in the Blueprint at once; neither
document carries its own copy. bibliography.tex is the shared \bibitem list.
Labels used inside proofs are the shared theorem labels (lem:A, lem:Aplus, lem:B, lem:C, lem:D, lem:E,
lem:Eprime, prop:F, thm:A, lem:D0..D3, prop:D, cor:Aprime, cor:T, lem:C7, lem:C7int, cor:7, lem:oddtransfer (r15), thm:S0, cor:S1,
lem:Sgroup, lem:Sineq, lem:depthfloor, thm:cert, lem:ky1000, thm:family, lem:oldnew, eq:ident); both
documents define them.
Files: cor_7, cor_Aprime, cor_S1, cor_T, lem_A, lem_Aplus, lem_B, lem_C, lem_D, lem_D0, lem_D1, lem_D2, lem_D3, lem_E, lem_Eprime, lem_Sgroup, lem_depthfloor, lem_oddtransfer, lem_oldnew, prop_D, prop_F, thm_A, thm_S0, thm_cert, thm_family, lem_prod13; r13: lem_barT, thm_Acore, lem_C7int, lem_Sineq, thm_certcore (the five F nodes that carried only a kernel note in r12 now have prose proofs mirroring the Lean proof step by step; lem_A was already prose and is now \input by the Blueprint too).

Paper capsule vs Blueprint proof (GPT r12 hw 50; Dr. Fukui ruling R7 of R13): there is NO separate "capsule". The paper \inputs the same complete proof bodies as the Blueprint, so the two documents cannot drift; the Blueprint additionally carries the F-core nodes (thm_Acore, thm_certcore, lem_barT, lem_C7int, lem_Sineq) that the paper cites by Lean name instead of \input.

r21 (GPT r20 P1): proofs/statements/<label>.tex holds the STATEMENT of each of the 38 theorem-like nodes shared by the paper and the Blueprint (label ":" -> "_"); both media \input it and carry only \label, the Lean tags, \uses and the trust tag. Statement files contain no \label / \lean / \uses / trust label and refer to medium-specific places only through \refConst / \refCert / \refAppF / \refDefH. Gate: tools/check_statement_sync.py (38/38, conditions from the file headers, five in-memory variants rejected by --negctl).
