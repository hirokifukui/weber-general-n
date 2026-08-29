# Dockerfile — clean-environment verification of the weber_general_n package, ROUND 15 (unchanged from r12 except this header and the r14 ENV line).
# Sage job only (Lean runs in the separate `lean` job of .github/workflows/verify.yml, because
# the sagemath image has no elan/lake and a mathlib cache is fetched with `lake exe cache get`).
#
# Image: sagemath/sagemath:10.8 (linux/amd64) = the recorded author environment
# (environment/sage_version.txt: SageMath version 10.8, Release Date 2025-12-18).
# Digest pin (GPT r10 hw 82 / r11 hw 151): the tag 10.8 resolved on 2026-08-25 through the Docker
# registry API (manifest index, application/vnd.oci.image.index.v1+json; no docker needed) to
#   sha256:e2e4747b0e1ea8753a9cb5a399314a8b2c25fcefaf69ba85b22ee075829d09ea
# The build asserts that the image really is Sage 10.8 (r11 hw 155).
# STATUS (2026-08-25, r13): this Dockerfile has NOT been executed on any author machine; the first
# execution is the GitHub Actions run after push. See TRUST.md "Replay".
FROM sagemath/sagemath@sha256:e2e4747b0e1ea8753a9cb5a399314a8b2c25fcefaf69ba85b22ee075829d09ea
# assert Sage 10.8 before anything else (fails the build on a wrong image)
RUN sage -c "import sage.version; assert sage.version.version == '10.8', sage.version.version; print('sage', sage.version.version, 'pari', pari.version())"
USER root
# LaTeX for the paper-build step (11) of the portable verifier; texlive is ~1 GB, remove the
# apt line and set SKIP_PAPER=1 to run the verifier without it.
RUN apt-get update && apt-get install -y --no-install-recommends \
      texlive-latex-base texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended \
      python3-yaml \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /pkg
COPY . /pkg
RUN chmod +x scripts/*.sh
# r14: the container runs the SAGE PROFILE only (Lean is the second CI job); it can never print the FULL line (E14-4)
ENV SAGE_BIN=sage OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 LANES=2 VERIFY_PROFILE=sage
# LEAN_WORKSPACE is deliberately unset here: the Lean step reports SKIP in this container.
CMD ["bash", "scripts/verify_all_portable.sh"]
