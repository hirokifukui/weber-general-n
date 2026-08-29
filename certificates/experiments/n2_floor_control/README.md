# n2_floor_control — substrate for the n = 2 threshold controls (E13-1; GPT r12 hw 11-13 / tracker 267-269)

Not a theorem, not a claim (k_2 = h_2 = 1 is classical; nothing is excluded that was open). The file
witness_n2_l17.txt is a generator output at (n, l) = (2, 17) whose header carries bar_T = 68 = 17 * 2^2
(MO3 Prop 6.6), produced by scripts/family_gen.sage (r10 generator, unchanged) on <LOCAL_HOST> 2026-08-25 in
under one second (log n2_pilot_gen_verify.log, together with l = 41 and l = 97). It exists so that the
read-only verifier can be shown, on a real n = 2 file, to
  (a) accept bar_T = 68 (positive control: scripts/family_verify.sage returns EXCLUDED, 2/2 components), and
  (b) reject a header claiming the uniform 33 * 2^2 = 132 (negative control nc9 in scripts/family_negctl.sh).
The companion control nc8 mutates an n = 7 KY1000 witness header to the 17-floor (2176) and must be rejected.
Verifier sha256 0f38bb0d (r11) unchanged.
