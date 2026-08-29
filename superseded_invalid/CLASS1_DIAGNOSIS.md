> MOVED TO superseded_invalid 2026-08-24 (r7, per GPT r6 review items 17-18):
> contains retracted claims (class-1 wall / null directions, refuted by
> NEGACYCLIC_SPECTRUM_CORRECTION.md and the Blichfeldt-saturation theorem).
> Any still-valid groundwork must be re-extracted into a fresh document.

# CLASS1_DIAGNOSIS — Phase E homework (GPT-r1 sec. 13, items 1-8 + stopping rule)  (2026-08-23)

Setting: l = 1 (mod 128), deg f = 1, 64 components M_f = F_l * w_f; lattice l*R + Z*w_f,
index l^63 (one power HIGHER than deg-2: intrinsic l^(1/64) = 1.38x length penalty at 1e9).

Item status:
1. best-Q bug: FIXED (r5 engine tracks best-Q and best-T separately). r3 retired.
2. All 64 factors scanned per prime — 8 primes, scales 1e9..1e33 (r5_stress_allclasses.log).
3. Inverse-pair symmetry preserves Q: [P] + Lean (autocorr_reversal, std-3). Not T: [MC].
4. Non-centered lifts: [OPEN next round].
5. Construction-A / CVP formulation: [OPEN next round].
6. Envelope measured (BKZ-24 + two-scale probe): OPEN 64/64 at ALL eight scales.
   worst_rho 1.76 (1e9) ... 1.87 (1e33), non-monotone spikes (3.2 at 1e16, 6.3 at 1e28
   = search variance); T_min 40704 (1e9) -> 24685 (1e33), improving but 6-10x above 4224.
7. Monotonicity NOT assumed — correctly so: the naive covolume heuristic predicted a
   rho < 1 crossing near l ~ 1e18; the data refutes it (still 64/64 OPEN at 1e33).
   The anisotropy of G (DEG2_UNIFORM_GROUNDWORK item 1) is the suspected reason the
   scalar-family minima do not follow the isotropic GH scaling. Diagnosis value: the
   1-parameter family b*w_f is too rigid; its Q-values are governed by the few large
   spectral directions of G, not by covolume.
8. Bottom edge l ~ 1e9 scrutinised: worst class-wide, as predicted.

Stopping rule (GPT-r1 sec. 13: rho_max > 1.25 and T_min > 15000 persisting over multiple
primes after reliable full search): thresholds exceeded at every tested prime at BKZ-24;
cls-1 escalation (BKZ-40/50 + combos, r5_escalate_cls1.log) running to meet the
"reliable search" requirement; items 4-5 remain before the rule is formally invoked.
PROVISIONAL verdict: pure-lift per-prime exclusion for class 1 is blocked at all
accessible scales; the exit routes (filtration / saturation-conditioned trace bound /
independent re-proof of pre-Luo congruence results) should be planned for the next round.
