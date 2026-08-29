# FAMILY_CERTIFICATE_SPEC_R10 - certificate family: generator, verifier, soundness, failure classes (bin 5, 2026-08-25)

## 1. Artefacts (all under this repository)

- scripts/family_gen.sage   GENERATOR. Input (n, l, bkz_max). Output one witness file
  certificates/family/witness_n<n>_l<l>.txt. Certifies nothing.
- scripts/family_verify.sage  READ-ONLY VERIFIER (separate program; opens the witness file
  read-only; recomputes factorisation, lambda profile and all bounds in RealBallField(256)).
- scripts/family_negctl.sh   five planted negative controls (must all be REJECTED; CI gate).
- scripts/family_escalate.sage  escalation for OPEN components (BKZ-60, wider combinations,
  fpylll exact SVP time-capped); writes a separate _esc.txt file in the same line format.
- scripts/family_lane.sh, family_survey.sh, family_verify_all.sh  detached drivers (KILL file).

## 2. Witness-file format (one file per (n, l))

Header: "n = <n> ; l = <l> ; m = <m> ; deg = <d> ; ncomp = <K> ; bar_T = <B> ; L_n = <L>".
Lines:  "f = c0,...,c_d | route RHO|T | claimed <v> | coeffs a_0,...,a_{m-1}"
where f is the monic irreducible factor of x^m + 1 over F_l given by its FULL coefficient
sequence (identifier), a in Z^m, and the claimed value is rho = ht((1/l)H_n a)/L_n (RHO) or
T = sum_j exp(2 y_j) (T). Status/summary lines start with '#' and are ignored by the verifier.

## 3. Verifier acceptance (exactly what is checked)

(V0) n >= 2; l an odd prime; m = 2^{n-1} matches; x^m+1 squarefree over F_l; every
     irreducible factor has degree ord_{2^n}(l).
(V1) every line names a recomputed factor by its full coefficient sequence; no (f, route)
     pair twice; witness length m.
(V2) exact membership  f * a = 0 in F_l[x]/(x^m+1)   (a in L_f = pi^{-1}(M_f)).
(V3) a not in l R_n (some coefficient nonzero mod l).
(V4) some coordinate of y = (1/l) H_n a is certified nonzero (ball strictly away from 0).
(V5) route condition in ball arithmetic: RHO: upper(ht/L_n) < 1 ; T: upper(T) < bar_T, with
     bar_T = 33 * 2^n for n >= 3 (KY Thm 2.3) and 17 * 2^n for n = 2 (MO3 Prop 6.6).
(V6) claimed value agrees with the recomputed midpoint to relative 1e-6.
VERDICT EXCLUDED  iff  every recomputed factor has at least one line passing V1-V6 AND no
line fails (a single failing line rejects the whole file - strict by design).

## 4. Soundness theorem (statement)

THEOREM (certificate soundness). Let n >= 2, l an odd prime, and suppose family_verify.sage
returns EXCLUDED on a witness file for (n, l). Then l does not divide k_n = h_n/h_{n-1}.
Proof. By (V0)-(V6), for EVERY irreducible f | x^m+1 over F_l there is a in L_f \ l R_n with a
certified nonzero log coordinate and either ht(r_a) < L_n or T(r_a) < bar_T, where r_a is the
real formal root of KY sect 4. If l | k_n, KY Prop 4.1 supplies a saturated component f_0
with r_a in RE+_n for all a in L_{f_0} (Lemma E of BLICHFELDT_SATURATION_THEOREM_R7); its
certified a gives an element of RE+_n \ {+-1} (nonzero log vector) violating either MO 2016
Lemma 2.5(1) (via Lemma A, RHO route) or KY Thm 2.3 / MO3 Prop 6.6 (T route). Contradiction.
This is FLAGSHIP_T_ONLY / FLAGSHIP_Q_ONLY verbatim, with the certificate supplying the
component data.  Inputs (L): KY Eq.(17), KY Prop 4.1 + (23), KY Thm 2.3, MO3 Prop 6.6,
MO 2016 Lemma 2.5(1). [P relative to these]
What the verifier does NOT prove: correctness of the generator (irrelevant to soundness),
optimality of witnesses, or anything about primes/components without a CERT line.

## 5. Negative controls (sage/r10_family_negctl.log, 2026-08-25)

(1) one witness coefficient +1 -> REJECTED (V2 fails; whole file NOT_EXCLUDED)
(2) factor identifier swapped   -> REJECTED (V2 fails on the swapped line; duplicate pair also caught)
(3) claimed value halved        -> REJECTED (V6)
(4) one bit of l flipped        -> REJECTED (V0: l not prime / factor degrees)
(5) duplicated component line   -> REJECTED (V1)
All five REJECTED: NEGATIVE CONTROLS ALL_REJECTED.

## 6. Generator findings and failure classes

- SEARCH-LOSS BUG FIXED (r10): r5_esc_fast and the first r10 draft selected witnesses by the
  norm of the ROUNDED embedding (scale 10^9); the recovered coefficient vector's true height
  differs by up to |u|/SC (observed 1.8 in y-units), so selection picked wrong vectors. Fix:
  recover exact coefficients for the whole reduced basis and evaluate Q, T from coefficients
  (float64, error 1e-15). Effect at l = 1000000321: 29-30/32 -> 32/32; at l = 10000003199
  (class 127): 7/32 -> 27/32. The r5 escalation ledger (5 primes) is therefore SUPERSEDED as
  an estimate of the family size.
- Failure classes (per component): PASS_RHO, PASS_T, OPEN_NEAR (rho < 1.1 or T < 2 bar),
  OPEN_FAR. A prime is EXCLUSION_CANDIDATE only with all components PASS.
- Exact-SVP escalation (family_escalate.sage, fpylll enumeration in dim 64, ~40 s per
  component): on l = 10000003199 the OPEN components have TRUE lattice minima rho = 1.009-1.011
  (SVP completed): the RHO route is genuinely blocked there, not under-searched; the T route
  (direction-dependent) still closes some of them (3374 < 4224). Failure class label:
  RHO_MIN_ABOVE_FLOOR (certified by exact SVP up to embedding rounding).
- Class behaviour at n = 7 (survey, 2026-08-25): class 65 (f = 1, s = 6): every prime tested
  closes with all 32 components in ~10 s; classes 63/127 (s >= 7): many components OPEN_NEAR
  (rho 1.03-1.12). Consistent with MO's fixed-layer constants (7.7e12 for class 65 vs 4.5e16
  for 63/127): class 65 is the "easy" class. Survey numbers (SURVEY_LEDGER.txt, stopped by KILL
  after class 63's first prime): class 65 24/24 primes fully closed (each 32/32, ~10 s); class 63
  first prime 1000000447: PASS 2/32, OPEN_NEAR 27, OPEN_FAR 3 (1170 s); class 127 (1000001279:
  7/32; 10000003199: 27/32 -> 30/32 after escalation, exact SVP minima rho 1.009-1.011 on the
  rest). The certified family is therefore stated for class 65; classes 63/127 are reported as
  E-material with failure classes.

## 7. The family run (KY's own list)

Target: the first 1000 primes l > 10^9 with l = 65 mod 128, i.e. 1000000321 ... 1001287361 -
EXACTLY the list KY sect 4.2 exclude conditionally on their Conjecture 2.2 (list regenerated
and endpoints matched [MC]). Run: 6 detached lanes on <LOCAL_HOST> (sage/family_ky1000/lane_*,
LEDGER_L*.txt), then family_verify_all.sh (4 lanes) -> VERIFY_LEDGER.txt with per-prime
verdict and md5 of witness + verifier log. RESULT (2026-08-25, 15:04 first pass + r10 correction):
  FINAL EXCLUDED 1000 / 1000. First pass 993/1000; the 7 non-accepted files were 6 interface
  artefacts (non-passing best witnesses written as claim lines while the component was certified by
  the other route - fixed in the generator: such witnesses are now '# info' lines; files regenerated,
  originals kept in certificates/family/superseded_r10/) and 1 genuine INCOMPLETE (1000992193,
  component 233862715,0,1, rho 1.0218 / T 4459) closed by family_escalate (BKZ-60 + exact SVP:
  rho 0.9721, T 2782) and merged. Statistics over the 32000 components (from verifier logs):
  every component carries a T certificate (max upper 4164.5 vs bar 4224, median 2352 = 44% margin);
  31987/32000 also carry a RHO certificate (max upper 0.999845, median 0.9340); 13 components are
  T-only. Generation 8-20 s per prime (median 15 s, contended run); verification ~2 s per prime.
  Ledger: sage/family_ky1000/VERIFY_LEDGER.txt (per-prime md5 of witness and log).
  Operational lesson (not a design flaw of the mathematics): lanes must cap BLAS threads
  (OPENBLAS_NUM_THREADS=1, now baked into the generator/escalator) and E-jobs must not share cores
  with a C-run - the first pass ran at load 44 on 10 cores.
Claim shape for the paper (word freeze respected): "for these 1000 primes the conditional
exclusion of [KY, sect 4.2] holds unconditionally; the certificates are checkable by the
read-only verifier". No "first".
