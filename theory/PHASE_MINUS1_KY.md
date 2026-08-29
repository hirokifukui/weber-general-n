# PHASE −1 — Kashio–Yoshizaki (arXiv:2107.08587v3) verbatim findings

Date 2026-08-23. Source: full text fetched from arXiv (PDF saved as
`paper/KY2022_minimal_relative_units.pdf`, md5 `0f3a82af27a28bebbf74c5d880bb5447`, 19 pp.).
Everything below is read from the paper body, not from summaries. Layer dictionary: KY's
`B_n = Q(cos(π/2^{n+1})) = Q(X_n)`, `X_n = 2cos(2π/2^{n+2})`; Luo's `k = n+2`.

## 1. Confirmed verbatim (the reviewer's claims that check out)

- **Proven, class-number-free lower bound (their Thm "Y"):** for `n ≥ 3`,
  `min{Tr ε² | ±1 ≠ ε ∈ RE_n^+} ≥ 2^n·33`. Proof is combinatorial (parity of coefficients on the
  orthogonal basis `b_i`, MO Lemma 6.2: `a_0` odd, all other `a_i` even; then counting nonzero
  coefficients). **L_7 = 33·2^7 = 4224 is available unconditionally.** The reviewer's design —
  swap KY's conjectural threshold for this proven bound in their component criterion — is sound.
- **The conjectured minimum (their Conj):** `min = 2^n(1+8c_n)` with `c_1 = 2`,
  `c_n = 2·round(2^n/5)`. Table printed in the paper: c_1..c_10 = 2, 2, 4, 6, 12, 26, **52**, 102,
  204, 410. **So 53376 = 2^7(1+8·52) is KY's own value; the r2 dispute is resolved in the
  review's favour on attribution** (see §3 below for what remains genuinely open).
- **Component criterion (their Thm `k=1`):** identifications
  `F_ℓ[x]/(x^{2^{n-1}}+1) ≅ A_n^{1/ℓ}/A_n`, decomposition `⊕ M_f` with
  **`M_f = (x^{2^{n-1}}+1)/f · F_ℓ[x]/(x^{2^{n-1}}+1)`** — the COFACTOR form, confirming that our
  r2 `kt2b` lattice `(ℓ, f)` was the wrong object. If `ℓ | k_n` then some whole `M_f` lands in
  `RE_n^+/A_n` (their Prop in §4); if for EVERY irreducible `f` some `0 ≠ g mod (ℓ,F_n) ∈ M_f` has
  extended trace `T̃r((g·ε_n)²) < threshold`, then `ℓ ∤ k_n`. Their threshold is the conjectured
  minimum; with the proven `33·2^n` instead, the criterion is **unconditional**.
- **Extended trace:** `T̃r(ε^{2/ℓ}) = Σ_i (σ^i(ε)²)^{1/ℓ}`, i.e. the reviewer's
  `T = 2Σ_j cosh(2y_j)` with `y_j = (1/ℓ)Σ_i a_i λ_{i+j}`.
- **The n = 7 published data (§5.2):** for `ℓ ≡ 65 (mod 128)`, `x^{64}+1 ≡ ∏_{i=1}^{32}(x²+a_i)`
  (32 quadratic components; the congruence class is chosen exactly so that `y^{32}+1` splits and
  `x^{64}+1` doesn't). For `ℓ = 1000000321`: all 32 `a_i` and multipliers `b_i` are printed;
  center lifts of `b_i·(x^{64}+1)/(x²+a_i)` give `t_i` from **15616.7 to 52445.8**, all `< 53376`.
  Conclusion (conditional on their Conj at n=7): `ℓ ∤ k_7` for the first 1000 primes
  `ℓ > 10^9, ℓ ≡ 65 (mod 128)` (1000000321 … 1001287361). Matches the reviewer's quoted range.
- **Safe exclusions, verbatim (their (previous)):** a prime `ℓ` does not divide `h_n` if
  `n < 7` or `ℓ ≤ 10^9` or `ℓ ≢ ±1 (mod 64)`. Exactly the quarantine set the reviewer prescribed;
  the `ℓ ≡ 65 (mod 128)` class is outside it, which is why KY chose it.
- **`k_n = h_n/h_{n-1} = [RE_n^+ : A_n]`** with references (Washington Thm 8.2/Prop 8.11, Horie,
  Yoshizaki §4.1). The saturation framing is exactly as the reviewer stated.
- **Their own n ≤ 6 verification method** is our KT-2 method: log-embedding, the constraint-region
  radius (their `L_n`-max computation via Lagrange; `L_6 = 291.4`, `L_7 = 723.8` — note this is a
  DIFFERENT `L_n` than the trace bound: it is the log-radius), Fincke–Pohst (`qfminim`), then exact
  trace of every candidate. At n = 6: 290 624 candidate vectors, min = 13376, and **all minimisers
  are conjugates of `u_6`**.

## 2. Facts the review did NOT surface (materially important)

- **The witness gap at n = 7.** Their Thm "lb" produces explicit minimal-trace witnesses `u_n` ONLY
  for `n = 1, 3, 5` and for EVEN `n` (formula `u_n = b_0 + (−1)^{n/2}·2·Σ_{⌈2^{n+1}/5⌉}^{⌊2^{n+2}/5⌋} b_i`).
  **For odd `n ≥ 7` there is no witness**, so at n = 7 even the direction
  `min ≤ 53376` is conjectural. The conjectured 53376 has no known realiser.
- **Their n = 6 remark:** for many `ℓ` (31, 97, 127, 193, 223, 257, 449, …) the CENTER lift fails
  the threshold at n = 6, and searching non-center lifts was "difficult due to the high dimension";
  they completed only `ℓ = 31`. So the center/non-center lift optimisation is the known hard point
  even at n = 6 — the reviewer's Theorem C (uniform lift bound) is precisely what is missing.
- **KY's generator vs the Horie unit.** KY generate `A_n` by `ε_n = (X_n+1)/(X_n−1)` with Galois
  generator `σ: X_n ↦ 2cos(3·2π/2^{n+2})` (**the 3-multiplication generator**, not MO's 5). The
  bridge `ε_n = η_n^{τ−1}` (reviewer's Round-0 deliverable) is consistent with this but is not in
  either paper; it must be proven, including the exact relation between the ⟨3⟩- and
  ⟨5⟩-parametrisations of the conjugates.

## 3. Status of the c_7 question after Phase −1 (correction of our r2 stance)

- Our r2 accusation ("the review's 53376 does not reproduce") was **misdirected**: 53376 is KY's
  published conjectured value, correctly quoted.
- Our r2 recursion `c_{n+1} = c_n + 2^{n-1} − 2`, fitted to n ≤ 6, **coincides with KY's
  `2·round(2^n/5)` for every step up to n = 6 and diverges exactly at n = 7** (56 vs 52). A
  four-point fit that happened to match the round-function increments — an A-29-class extrapolation
  error on our side. Recorded.
- What remains genuinely open: the true minimum at n = 7. KY have no witness (see §2); our 57472 is
  a box-limited upper bound computed on the lattice `⟨η^{(1−σ_5)}⟩_{Z[G]}` — whose identity with
  KY's `A_7 = ⟨ε_7⟩_{Z[G]}` is exactly the unproven bridge. **Until the bridge is proven, our
  57472 and KY's 53376 are not even about provably the same lattice.** First computation for the
  new track: rebuild the log-lattice directly from KY's `ε_n` and `σ_3` (no bridge needed), re-run
  the calibrated box search, and test the natural odd-n witness candidates `ε_7·σ^j(ε_7)`.

## 4. What this changes in the r3 plan (none of it adverse)

The plan's load-bearing citations all held under verbatim reading: the proven `33·2^n`, the
component machinery, the cofactor form of `M_f`, the extended trace, the published n = 7 data, the
safe exclusion set. The two additions from §2 sharpen Rounds 2–5: Round 2's reproduction targets
are exactly KY's printed tables (n=4 ℓ=3: 95.6/100.1; n=4 ℓ=7: 106.5/546.9/840.6→200.7/160.2;
n=5 ℓ=97: the 16 listed lifts; n=7 ℓ=1000000321: the 32 t_i); Round 4/5 should treat the
center-lift failure at n = 6 (their remark) as the canonical hard instance; and the witness gap at
odd n ≥ 7 means Theorem D's `L_sat` target is not competing against a known 53376 realiser.
