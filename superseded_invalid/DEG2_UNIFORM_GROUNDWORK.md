> MOVED TO superseded_invalid 2026-08-24 (r7, per GPT r6 review items 17-18):
> contains retracted claims (class-1 wall / null directions, refuted by
> NEGACYCLIC_SPECTRUM_CORRECTION.md and the Blichfeldt-saturation theorem).
> Any still-valid groundwork must be re-extracted into a fresh document.

# DEG2_UNIFORM_GROUNDWORK — Phase D homework (GPT-r1 sec. 12, items 1-8)  (2026-08-23)

Target theorem shape: l = 63, 65, 127 (mod 128) => l does not divide q_7. Status per item:

1. **DFT diagonalisation of G** [P identity / MC numbers]. G_{ik} = C(i-k) with
   C = autocorrelation of lambda on Z/128; eigenvalues = |DFT(lambda)|^2.
   Computed (sage/r5_moments_deg2.log): min 2.6e-77 (numerically the unit-relation null
   directions: sum of lambda over the group and over index-2 cosets vanish for a unit),
   median 2.77, max 2314.5; trace check sum(ev)/128 = S2 = 419.598 exact match.
   The spectrum is EXTREMELY anisotropic — identity-form Gaussian-heuristic intuition
   does not transfer; effective dimension is much smaller than 64.
2. **F_{l^2} coordinates for M_f** [P]: basis {w, xw} from the component lattice lemma.
3. **(b,c) lift representation** [P/engine]: a = centered(b*w + c*xw) + l*z.
4. **Centered lift vs l*R-correction separation** [engine]: implemented (HNF handles z).
5. **Moments** [P]: E[Q] over the uniform coefficient model = (64/12)*S2*(1-1/l^2)
   = 2237.86 (l -> inf). Threshold L0^2 = 266.76.
6. **Sufficient condition** [OPEN — the real research core]: mean pigeonhole fails by
   E[Q]/L0^2 = 8.39; observed minima sit at ~0.105 of the mean. A second-moment /
   Paley-Zygmund route needs anti-concentration far beyond what generic bounds give.
   The honest formulation: one needs an equidistribution/covering theorem for the
   2-parameter family (b,c) -> centered lift against the ANISOTROPIC form G (item 1),
   exploiting the near-null spectral directions. This is a genuine open problem, not a
   computation. No fence language stronger than [OPEN] is licensed.
7. **Class split 65 vs 63/127** [MC, structural candidate]: stress data shows cls 65 closes
   at BKZ-24 at every scale (worst rho 0.91-1.01) while cls 63/127 do not (worst 1.2-5.0
   pre-escalation). Structural candidate explanation: cls 65 factors are pure x^2 + a
   (Frobenius = squaring on the ord-2 subgroup; w even-supported), cls 63/127 factors
   x^2 + bx + c generic (Frobenius = inversion); the even/odd support splitting of the
   {w, xw} basis aligns with lambda's symmetry only in cls 65. [H] until proven.
8. **Margin table** [MC]: cls 65: rho_max 1.011 (1e9) -> 0.912 (1e16), monotone improving;
   cls 63/127: see escalation log (r5_escalate_6327.log) — post-escalation numbers are the
   citable ones. All margins vs proof constants tabulated in the stress/escalation logs.

Verdict: items 1-5, 7, 8 delivered ([P]/[MC]/[H] as marked); item 6 = the uniform theorem's
core remains [OPEN] with the obstruction now quantified (8.39x mean deficit, anisotropy map).
