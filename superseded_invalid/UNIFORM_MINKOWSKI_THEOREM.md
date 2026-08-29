# UNIFORM_MINKOWSKI_THEOREM — items 5/7: the search-free uniform exclusion (2026-08-23)

## Lemma AP (anti-periodicity) [P]
Nm_{B7/B6}(eps_7) = +-1 gives lambda_{m+64} = -lambda_m for all m (verified to 58 digits,
sage/r5_uniform_minkowski.log). Consequences: for EVERY coefficient vector a,
y_{j+64} = -y_j; hence Q(a) = 2*sum_{j<64} y_j^2, T(a) = 2*sum_{j<64} cosh(2 y_j) >= 128;
exactly 64 eigenvalues of H^T H vanish (the characters trivial on Gal(B7/B6)).
Lean: lean/WeberAntiperiodic.lean (split + cosh floor), std-3.

## Theorem U (uniform exclusion above an explicit threshold)
Let l be a prime, l = +-1 (mod 64), l > 10^9. Put c = 0.98*L0^2 = 261.427.
(i) [deg-2 classes: l mod 128 in {63, 65, 127}] If l > l*_2 := 2.08 x 10^19, then every
    component f of x^64+1 mod l admits a in pi^{-1}(M_f) \ lR with Q(a) <= c < L0^2.
(ii) [deg-1 class: l = 1 (mod 128)] Same conclusion for l > l*_1 := 4.30 x 10^38.
Combined with the r5 exclusion chain (N7_DEPENDENCY_MINIMAL): **l does not divide h_7/h_6
for every prime l > l*_2 (resp. l*_1) in the deg-2 (resp. deg-1) classes** — same [CITE]
leaves as the flagship theorem (Horie 2.1, MO 2.5(1), KY 4224), NO search involved.

*Proof.* By Lemma AP the form lives on R^64: Q = 2|y'|^2, y' = (Lambda'/l) a with
ln|det Lambda'| = 155.603. The lattice pi^{-1}(M_f) has index l^{64-d_f}, so its y'-covolume
is |det Lambda'| / l^{d_f}. Minkowski's convex body theorem applied to the ball
{2|y'|^2 <= c} (volume V_64 (c/2)^32, ln = 111.01) yields a nonzero lattice point a with
Q(a) <= c as soon as V_64 (c/2)^32 >= 2^64 |det Lambda'| / l^{d_f}, i.e. l >= l*_{d_f}
(sage/r5_uniform_minkowski.log). It remains to exclude a in lR: for a = l*b the form is
l-free, Q(l b) = 2|Lambda' b|^2, and EXACT enumeration (pari qfminim, integral Gram scaled
by 10^6) certifies count{b != 0 : Q <= 270} = 0 (sage/r5_mu0_tbody.log); since c = 261.4 < 270,
the Minkowski point is not in lR. QED

Status: [P modulo two mechanical hardenings, queued]: (h1) interval certification (RBF) of
ln|det Lambda'| and the threshold arithmetic; (h2) interval hardening of the 10^-6 rounding
in the qfminim Gram (slack 270 - 261.4 = 8.6 dwarfs the rounding, bounded by the enumeration
radius). Neither changes any constant visibly.

## What this changes (the finite-window reduction)
With FK (l < 1e9 or l != +-1 mod 32), MO Cor B (mod 64), MO Thm A printed values, and
Theorem U, the l-indivisibility of h_7/h_6 is REDUCED TO FINITELY MANY PRIMES in explicit
windows: cls 65: (1e9, 7.8e12]; cls 63/127: (1e9, 2.08e19] (or up to G(2,s,2) where smaller);
cls 1: (1e9, 4.30e38] (minus G(2,s,1) coverage). Item 5 is thereby delivered in the form
"uniform above an explicit threshold + explicit finite windows"; the windows are the
remaining [OPEN], serviced by the certified per-prime engine (flagship demonstrates) and by
the r6 filtration program (item 7 design: within a window, condition on saturation to replace
the formal lattice by the genuine unit lattice — regulator-based covolume; design note, r6).

## T-body refinement [conditional, recorded honestly]
The convex body {T <= 4224} is LARGER (ln Vol 118.57 vs 111.01), giving l*_2 = 4.7e17,
l*_1 = 2.2e35 — CONDITIONAL on the trivial-lattice T-floor exceeding 4224, which cosh
convexity does NOT give for free; search evidence: sage/r5_tfloor.log. Adopted only if the
floor is certified by enumeration-with-convexity in r6; Theorem U above does not use it.
