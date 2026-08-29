# literature/ — third-party sources: recorded, not redistributed

This repository does NOT redistribute third-party papers. Every third-party
work used as an input is recorded in `SOURCES.yaml` with its bibliographic
data, the exact local file the author read (name + SHA-256 prefix), and the
places in this package where it is used. The files themselves live only in
the author's local literature cache and are excluded from the public tree.

Throughout the historical documents of this package (theory/, docs/,
RELEASE_STATUS.md, LaTeX comments), paths of the form `paper/<Name>.pdf` or
`paper/sources/<Name>` refer to that LOCAL cache. They are kept verbatim as
honest provenance records of what was read; the files are intentionally not
present here.

Nothing in the verification chain reads these files: the Lean kernel checks,
the certificate verifiers, the manifest, and the paper/Blueprint builds are
all reproducible from this tree alone.
