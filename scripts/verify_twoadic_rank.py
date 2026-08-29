#!/usr/bin/env python3
# verify_twoadic_rank.py — INDEPENDENT verifier of the 2-adic rank certificates
# (homework 33, 146). Pure python3, no Sage, no floats: reads the saved bit
# matrices from certificates/twoadic_rank/ and recomputes rank over F_2 by
# bitmask Gaussian elimination; checks rank = 64 and pivot columns match.
# Read-only (hw 145). Repository-relative paths (hw 139). Exit 0 iff all pass.
import os, sys, re

HERE = os.path.dirname(os.path.abspath(__file__))
CD = os.path.normpath(os.path.join(HERE, '..', 'certificates', 'twoadic_rank'))

def rank_bits(rows):
    rows = list(rows); piv = []; r = 0
    for col in range(256):
        bit = 1 << (255 - col)
        pr = None
        for i in range(r, len(rows)):
            if rows[i] & bit: pr = i; break
        if pr is None: continue
        rows[r], rows[pr] = rows[pr], rows[r]
        for i in range(len(rows)):
            if i != r and (rows[i] & bit): rows[i] ^= rows[r]
        piv.append(col); r += 1
    return r, piv

fail = 0
for name in ("fam1_eps_minus1_over2", "fam2_eps2_minus1_over4", "fam3_eps4_minus1_over8"):
    path = os.path.join(CD, name + "_certificate.txt")
    txt = open(path).read()
    claimed_rank = int(re.search(r'rank = (\d+)', txt).group(1))
    claimed_piv = eval(re.search(r'pivot_columns = (\[[^\]]*\])', txt).group(1))
    bitrows = [l for l in txt.splitlines() if re.fullmatch(r'[01]{256}', l)][:64]
    assert len(bitrows) == 64, "expected 64 original rows in %s" % name
    rows = [int(b, 2) for b in bitrows]
    r, piv = rank_bits(rows)
    ok = (r == 64 == claimed_rank) and (list(piv) == list(claimed_piv))
    print("%s: recomputed rank = %d (claimed %d), pivots match = %s -> %s" %
          (name, r, claimed_rank, list(piv) == list(claimed_piv), "PASS" if ok else "FAIL"))
    if not ok: fail = 1
print("VERIFY_TWOADIC_RANK:", "PASS" if fail == 0 else "FAIL")
sys.exit(fail)
