# Componentwise saturation-height bounds for relative class-number growth in the cyclotomic Z2- and Z3-towers

Weber's class number problem asks whether every layer of the cyclotomic Z2-extension of Q has class number one. This package proves componentwise saturation-height bounds for the relative class-number growth h_n/h_{n-1} in the cyclotomic Z2- and Z3-towers (all layers n >= 2 at p = 2; every layer n >= 1 at p = 3, constants certified for n <= 5 and replayed read-only from the definitions), with an unconditional certified family of 1000 primes at layer 7 and a computation-free criterion at every layer. Version v1.0.0 (paper, Blueprint, Lean, certificates, read-only verifiers).

## Main results

- **Theorem A (Z2-tower).** For every layer n >= 2 and every odd prime l: if l^{ord_{2^n}(l)} > C_n then l does not divide h_n/h_{n-1}, with C_n an explicit product of L-values. The displayed C_7 = 1.7273421630363529579743237623519834054... x 10^30 is a 38-digit truncation of the certified 145-digit prefix and carries no ball radius.
- **All-layer criterion.** A computation-free criterion at every layer n >= 2 of the Z2-tower.
- **KY1000.** An unconditional certified family of 1000 primes l = 65 (mod 128) at n = 7 (per-prime witness certificates; ledger EXCLUDED 1000/1000).
- **Z3-tower.** Norm-one Horie units, a spectral rank theorem, and exact characterwise covolumes; Theorem P3 for odd primes l != 3, with all 15 certified rows at n <= 5 below the uniform-in-n bound of Morisawa-Okazaki (MO2016 Thm A) in both classes.

## Artifact

- Paper: `paper/draft/main_1.0.1.pdf` (39 pages) — source `main_1.0.1.tex`
- Blueprint: `blueprint/blueprint_1.0.1.pdf` (34 pages) — every F/M node with a complete human-readable proof; source `blueprint/src/`
- Lean 4: `lean/` — 12 load-bearing files, 63 declarations, axiom footprint within `[propext, Classical.choice, Quot.sound]` (toolchain v4.31.0-rc1, mathlib pin d568c8c0)
- Certificates: `certificates/` — C_n interval enclosures, the p = 3 covolume certificate (exact dyadic endpoints), KY1000 witnesses, two-adic rank certificates
- Read-only verifiers: `scripts/` — recompute the designated certificate claims from first principles, using exact arithmetic and Arb/ball arithmetic as appropriate; 9 negative controls REJECTED plus the n = 2 positive control; the p = 3 replay rejects its twelve planted certificates
- Statements are single-sourced: the 38 shared theorem statements live only in `proofs/statements/` and are `\input` by both the paper and the Blueprint (`tools/check_statement_sync.py`)

## Quick verification

Integrity (seconds):

    python3 tools/gen_manifest.py --check

Full replay (SageMath 10.x, a Lean workspace with the pinned mathlib, pdflatex):

    VERIFY_PROFILE=full SAGE_BIN=<sage> LEAN_WORKSPACE=<workspace> bash scripts/verify_all_portable.sh

Partial profiles `VERIFY_PROFILE=sage` / `VERIFY_PROFILE=lean` need only their own prerequisite. CI (`.github/workflows/verify.yml`) runs all three on every push.

## Trust model

Every claim carries a label (definitions and per-claim checking instructions: `TRUST.md`; claim map: `CORRESPONDENCE.csv`, generated from `docs/CLAIMS_1.0.1.yaml`):

- **F (Formal)** — proven in Lean 4, standard axioms only; covers the discrete reasoning
- **C (Certificate)** — finite certificate + read-only checker recomputing from first principles
- **L (Literature)** — a published, proven theorem used as an explicit hypothesis (tagged used / historical / unread)
- **M (Manuscript)** — proved in the paper and, verbatim, in the Blueprint; not machine-checked; all 31 F/M nodes carry the author's signed review (`docs/BLUEPRINT_HUMAN_REVIEW_1.0.1.md`)
- **E (Experiment)** — reported output on which no theorem depends

## Repository map

`paper/draft/` `proofs/` `blueprint/` `lean/` `certificates/` `sage/` `scripts/` `tools/` `docs/` `theory/` `literature/`

Third-party papers are recorded, not redistributed: `literature/SOURCES.yaml`. Development history (sealed review rounds, errata chain, sign-off): `docs/PROJECT_HISTORY.md`.

## Citation

See `CITATION.cff`. The version DOI is assigned by the archived record at release and is not written into the source tree.

## Licenses

- Code and machine-readable artifacts (`lean/`, `scripts/`, `tools/`, `sage/`, `certificates/`): MIT (`LICENSE`)
- Prose authored by the author (`paper/draft/`, `proofs/`, `blueprint/src/*.tex`, `docs/`, `theory/`, this README): CC BY 4.0 (`LICENSE-CC-BY-4.0.txt`)
- Third-party literature is not redistributed and is not covered by either license (`literature/`)
