# PROJECT_HISTORY — how this package was built

The package was developed in sealed internal rounds (r1-r23, 2026). Each round ended with a
full portable verification on a staged tree, a zip whose SHA-256 is recorded outside the tree,
and an adversarial external review of the sealed zip; the next round repaired what the review
found. Nothing in this history is a correctness premise: formal claims are checked by the Lean
kernel, finite computations by frozen read-only verifiers, published inputs are isolated
explicitly (TRUST.md), and the remaining manuscript arguments are marked as non-kernel trust
boundaries and carry the author's signed review.

Honest wreckage is kept, not hidden:

- Errata chain: docs/ERRATA_R11.md ... docs/ERRATA_R22.md — every defect found by a review,
  with what was wrong and how it was repaired (artifact defects, scope errata, prose errata).
- Review homework ledger: docs/GPT_HOMEWORK_R11_TRACKER.md — every review item, numbered,
  with its disposition (DONE / OPEN / DEFERRED); nothing closed from memory.
- Statement freezes: theory/STATEMENT_FREEZE_1.0.0.md — the frozen wording of every shared
  statement, with the numbered changes (N-blocks) and their reasons, all rounds appended.
- Author sign-off: docs/BLUEPRINT_HUMAN_REVIEW_1.0.0.md — all 31 F/M Blueprint nodes read by
  the author against the single-source statements and proofs, signed row by row; a signature
  is invalidated automatically when the statement file changes.
- Round-by-round candidate records: RELEASE_STATUS.md.

The public tree v1.0.0 equals the final sealed round plus release engineering only (license,
repository metadata, this history file, the literature index, and a uniform host/path sanitization applied by tools/make_public_tree.py);
no statement, no proof, no Lean file and no certificate differs from the sealed round.
