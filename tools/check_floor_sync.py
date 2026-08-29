#!/usr/bin/env python3
"""check_floor_sync.py - E13-1 constant-synchronisation gate (GPT r12 hw 271 / tracker 271).
Asserts that the T-route threshold is the SAME piecewise function of n in every medium:
  verifier  scripts/family_verify.sage   `BAR = 33*2**n if n >= 3 else 17*2**n`
  Lean      lean/WeberCertFloor.lean     `def barT (n : N) : N := if n = 2 then 17 * 2 ^ n else 33 * 2 ^ n`
  Blueprint blueprint/src/content.tex    lem:ky23 (n>=3: 33·2^n ; n=2: 17·2^n) and def:verifier (\\bar T_n piecewise)
  paper     paper/draft/main_1.0.1.tex     definition of \\barT (17·2^n for n=2, 33·2^n for n>=3)
  proof     proofs/thm_cert.tex          the same two constants
and that no remaining prose site states the uniform 33·2^n as the certificate threshold without an n >= 3 qualifier.
Exit 0 iff all pass. Pure python, no Sage.
"""
import re, sys, os
root = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'); os.chdir(root)
bad = []
def need(path, pattern, what):
    s = open(path, encoding='utf-8').read()
    if not re.search(pattern, s, re.S): bad.append('%s: %s not found' % (path, what))
def forbid(path, pattern, what, allow=()):
    for i, line in enumerate(open(path, encoding='utf-8'), 1):
        if re.search(pattern, line) and not any(a in line for a in allow): bad.append('%s:%d: %s' % (path, i, what))
# 1 verifier: exact piecewise line
need('scripts/family_verify.sage', r'^BAR = 33\*2\*\*n if n >= 3 else 17\*2\*\*n\s*$'.replace('^', r'(?m)^'), 'piecewise BAR line')
need('scripts/family_verify.sage', r'bar_claim != BAR', 'header bar_T rejection')
# 2 Lean
need('lean/WeberCertFloor.lean', r'def barT \(n : ℕ\) : ℕ := if n = 2 then 17 \* 2 \^ n else 33 \* 2 \^ n', 'Lean barT definition')
need('lean/WeberCertFloor.lean', r'theorem barT_two : barT 2 = 68', 'barT 2 = 68')
need('lean/WeberCertFloor.lean', r'theorem barT_seven : barT 7 = 4224', 'barT 7 = 4224')
# 3 Blueprint
need('blueprint/src/content.tex', r'label\{lem:ky23\}.*?n\\ge3.*?33\\cdot2\^n.*?n=2.*?17\\cdot2\^n', 'lem:ky23 piecewise')
need('blueprint/src/content.tex', r'label\{def:verifier\}.*?\\bar T_n=17\\cdot2\^n\$ for \$n=2\$ and \$33\\cdot2\^n\$ for \$n\\ge3\$', 'def:verifier piecewise')
# 4 paper
need('paper/draft/main_1.0.1.tex', r'\\barT:=17\\cdot2\^n\$ for \$n=2\$ and \$\\barT:=33\\cdot2\^n\$ for \$n\\ge3\$', 'paper \\barT definition')
# 5 proof text
need('proofs/thm_cert.tex', r'\\bar T_n=33\\cdot2\^n\$ for \$n\\ge3\$ and \$\\bar T_n=17\\cdot2\^n\$ for \$n=2\$', 'thm_cert piecewise')
# 6 no uniform threshold left in the current prose: every "33\cdot2^n" must sit on a line that also says n\ge3 or 17\cdot2^n
for p in ('paper/draft/main_1.0.1.tex', 'proofs/thm_cert.tex', 'blueprint/src/content.tex', 'theory/STATEMENT_FREEZE_1.0.1.md', 'README.md', 'TRUST.md', 'lean/README_lean.md'):
    if not os.path.exists(p): continue
    for i, line in enumerate(open(p, encoding='utf-8'), 1):
        if re.search(r'33\s*(\\cdot|\*|·)\s*2\^n', line) and not re.search(r'n\s*(\\ge|>=|≥)\s*3|17\s*(\\cdot|\*|·)\s*2\^n', line):
            bad.append('%s:%d: uniform 33*2^n without n>=3 qualifier' % (p, i))
print('FLOOR SYNC: %s' % ('PASS (verifier / Lean / Blueprint / paper / proof agree: 17*2^n at n=2, 33*2^n for n>=3)' if not bad else 'FAIL'))
for b in bad: print('  ' + b)
sys.exit(0 if not bad else 1)
