#!/usr/bin/env python3
"""make_public_tree.py <dst> -- build the PUBLIC tree from this package (v1.0.0 policy, v2).

Copies the package to <dst>, EXCLUDING: internal session files, runtime verification
output, the round archive, the third-party literature cache, machine-specific logs,
non-portable legacy scripts, LaTeX by-products and .git. Then applies a UNIFORM
sanitization to every text file (local absolute paths, tilde paths, local host names
and sync-folder fragments become placeholders), scans every text file with generic
forbidden patterns (any hit is a hard FAIL), and finally REGENERATES the manifest on
<dst> and checks it. Failures are loud; silence plus MANIFEST CHECK PASS means done.

The forbidden patterns and sanitization literals are assembled from string pieces so
that this shipped file never contains the sensitive tokens it hunts.

One evidence log is EXEMPT from the host-name rules only (never from the path / IP /
ssh / sync rules): its byte-exact sha256 is recorded inside a shipped certificate
(cross-CAS routes) and inside the claims ledger, so altering a single byte would break
the certified chain that the verifier re-checks. The one string it carries is a bare
machine name in a CAS banner line; byte integrity of signed evidence outranks it."""
import os, sys, re, shutil, subprocess

# ---- assembled tokens (never contiguous in this source) ----
_APPS = "~/App" + "lications"
_LEAN = "~/le" + "an"
_HOSTA = "Nat" + "ure"
_HOSTB = "lo" + "gos"
_HOSTC = "ag" + "ora"
_HOSTD = "Human" + "ities"
_HOSTE = "a9" + "mega"
_NATL = "nat" + "ure"
_SYNC = "Cloud" + "Storage"
_SYNC2 = "Drop" + "box"

# (pattern, replacement, is_host_rule)
SANITIZE = [
    (re.compile(r"(/Users/[A-Za-z0-9_]+)?/Library/" + _SYNC + "/" + _SYNC2 + r"[A-Za-z0-9_/.-]*"), "<LOCAL_PATH>", False),
    (re.compile(r"/Users/[A-Za-z0-9_]+"), "<LOCAL_PATH>", False),
    (re.compile(re.escape(_APPS)), "<LOCAL_APPS>", False),
    (re.compile(re.escape(_LEAN + "/" + _NATL + "-le" + "an")), "<LOCAL_LEAN_WORKSPACE>", False),
    (re.compile(re.escape(_LEAN)), "<LOCAL_LEAN_WORKSPACE>", False),
    (re.compile(r"\b" + _HOSTA + r"\b", re.I), "<LOCAL_HOST>", True),
    (re.compile(r"\b" + _HOSTB + r"\b", re.I), "<LOCAL_HOST>", True),
    (re.compile(r"\b" + _HOSTC + r"\b", re.I), "<LOCAL_HOST>", True),
    (re.compile(r"\b" + _HOSTD + r"\b", re.I), "<LOCAL_HOST>", True),
    (re.compile(r"\b" + _HOSTE + r"\b", re.I), "<LOCAL_HOST>", True),
    (re.compile(re.escape(_NATL + "-le" + "an")), "<LOCAL_HOST>-lean", True),
    (re.compile(r"\bnode " + _NATL + r"\b"), "node <LOCAL_HOST>", True),
    (re.compile(r"\bon " + _NATL + r"\b"), "on <LOCAL_HOST>", True),
    (re.compile(r"\b" + _NATL + r" <LOCAL_LEAN_WORKSPACE>"), "<LOCAL_HOST> <LOCAL_LEAN_WORKSPACE>", True),
    (re.compile(r"\b" + _NATL + r" local\b"), "<LOCAL_HOST> local", True),
    (re.compile(r"\(" + _NATL + r"\b"), "(<LOCAL_HOST>", True),
    (re.compile(r", " + _NATL + r"\)"), ", <LOCAL_HOST>)", True),
    (re.compile(r", " + _NATL + r"\b"), ", <LOCAL_HOST>", True),
]
HOST_EXEMPT = {"sage/r10_bin4_xcas.log"}
# (pattern, is_host_rule)
FORBIDDEN = [(re.compile(p), h) for p, h in (
    (r"/Users/[A-Za-z0-9_]+", False),
    (r"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b", False),
    (r"[Tt]ail" + "scale", False),
    (r"\bssh\s+[A-Za-z0-9_]+@", False),
    (re.escape(_APPS), False),
    (re.escape(_LEAN), False),
    (r"(?i)\b" + _HOSTA + r"\b", True),
    (r"(?i)\b" + _HOSTB + r"\b", True),
    (r"(?i)\b" + _HOSTC + r"\b", True),
    (r"(?i)\b" + _HOSTD + r"\b", True),
    (r"(?i)\b" + _HOSTE + r"\b", True),
    (_SYNC, False),
    (r"\b" + _SYNC2 + r"\b", False),
    (re.escape(_NATL + "-le" + "an"), True),
    (r"\bnode " + _NATL + r"\b", True),
    (r"\bon " + _NATL + r"\b", True),
    (r"\b" + _NATL + r"\b", True),
)]
EXCL_DIR_PREFIX = ("archive/", "docs/archive/", "docs/audit_notes/", "external_review/",
                   "verify_out/", "paper/sources/", "papers/", ".git/")
EXCL_EXACT = {"scripts/verify_all.sh", "sage/pv_environment.log",
              "sage/verify_all_environment.log", "blueprint/src/print.pdf",
              "MANIFEST_SHA256.txt"}
EXCL_SUFFIX = (".DS_Store", ".sage.py", ".aux", ".toc", ".fls",
               ".fdb_latexmk", ".synctex.gz", ".pyc")
def excluded(rel):
    b = os.path.basename(rel)
    if rel.startswith(EXCL_DIR_PREFIX) or "/__pycache__/" in rel or rel.startswith("__pycache__/"): return True
    if b.startswith("HANDOFF.md"): return True
    if rel in EXCL_EXACT: return True
    if ".bak" in b: return True
    if any(rel.endswith(s) for s in EXCL_SUFFIX): return True
    if rel.endswith(".out") and ("paper/draft/" in rel or "blueprint/src/" in rel): return True
    if rel.endswith(".log") and (rel.startswith("paper/draft/") or rel.startswith("blueprint/src/")): return True
    if rel.startswith("paper/") and rel.endswith(".pdf") and not rel.startswith("paper/draft/"): return True
    return False

def main():
    src = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
    dst = os.path.abspath(sys.argv[1])
    assert dst != src and not dst.startswith(src + os.sep), dst
    if os.path.exists(dst): shutil.rmtree(dst)
    copied = skipped = 0
    for root, dirs, files in os.walk(src):
        dirs[:] = [d for d in dirs if d not in (".git", "__pycache__")]
        for fn in files:
            p = os.path.join(root, fn); rel = os.path.relpath(p, src)
            if excluded(rel): skipped += 1; continue
            q = os.path.join(dst, rel); os.makedirs(os.path.dirname(q), exist_ok=True)
            shutil.copy2(p, q); copied += 1
    print("copied %d ; excluded %d" % (copied, skipped))
    san_files = san_total = 0
    for root, dirs, files in os.walk(dst):
        for fn in files:
            q = os.path.join(root, fn); rel = os.path.relpath(q, dst)
            try: s = open(q, encoding="utf-8", errors="strict").read()
            except (UnicodeDecodeError, ValueError): continue
            n = 0
            for pat, repl, is_host in SANITIZE:
                if is_host and rel in HOST_EXEMPT: continue
                s, k = pat.subn(repl, s); n += k
            if n:
                open(q, "w", encoding="utf-8").write(s)
                san_files += 1; san_total += n
                print("sanitized %s (%d substitutions)" % (rel, n))
    print("sanitized files %d ; substitutions %d" % (san_files, san_total))
    bad = []
    for root, dirs, files in os.walk(dst):
        for fn in files:
            q = os.path.join(root, fn); rel = os.path.relpath(q, dst)
            try: s = open(q, encoding="utf-8", errors="strict").read()
            except (UnicodeDecodeError, ValueError): continue
            for pat, is_host in FORBIDDEN:
                if is_host and rel in HOST_EXEMPT: continue
                m = pat.search(s)
                if m: bad.append((rel, pat.pattern, m.group(0)[:40]))
    if bad:
        print("FORBIDDEN PATTERN HITS (%d):" % len(bad))
        for rel, pat, hit in bad[:40]: print("  ", rel, "::", pat, "::", hit)
        sys.exit(1)
    print("PUBLIC TREE CLEAN: 0 forbidden-pattern hits")
    r1 = subprocess.run([sys.executable, "tools/gen_manifest.py"], cwd=dst)
    r2 = subprocess.run([sys.executable, "tools/gen_manifest.py", "--check"], cwd=dst)
    if r1.returncode or r2.returncode:
        print("MANIFEST GENERATION/CHECK FAILED"); sys.exit(1)
    print("PUBLIC TREE MANIFEST: generated and checked")

if __name__ == "__main__": main()
