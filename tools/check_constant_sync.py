#!/usr/bin/env python3
"""check_constant_sync.py - r14 hard gate (step 00c; GPT r13 sect 2/4, hw 403-405, 417-433).
Every shared number that appears in more than one medium is read from ONE machine-readable source and the media are
checked against it; stale forms are forbidden. Sources:
  C_n            certificates/constants/Cn_interval_r14.json  (display string, certified-prefix count, width bound, thresholds)
  negctl counts  certificates/negctl/negctl_ledger_r14.json     (negative_controls / rejected / positive_controls)
  KY1000 counts  sage/family_ky1000_r11_clean/VERIFY_LEDGER.txt (# SUMMARY line: primes, T certs, RHO certs, T-only, max T, margin, median)
Media checked (active tree only; archive/, *.bak, HANDOFF.md, superseded round files and the ERRATA/LETTER/TRACKER history
are NOT checked - they legitimately quote the old forms):
  paper/draft/main_1.0.2.tex, blueprint/src/content.tex, proofs/*.tex, README.md, TRUST.md, blueprint/README.md, lean/README_lean.md,
  proofs/README.md, theory/STATEMENT_FREEZE_1.0.2.md, docs/CLAIMS_1.0.2.yaml, CORRESPONDENCE.csv, RELEASE_STATUS.md (text from the
  "## 1.0.2" block on only; earlier Sealed blocks are history), docs/BLUEPRINT_MAP_1.0.2.md if present.
Prints one line per check and "CONSTANT SYNC: PASS" / "CONSTANT SYNC: FAIL (k)"; exit 1 on FAIL.
Lean declaration names (e.g. WeberCert.barT_seven) are exempt from the word checks."""
import re, sys, json, os, glob
bad = []; notes = []
cn = json.load(open(os.environ.get('CN_CERT', 'certificates/constants/Cn_interval_r14.json')))   # env override ONLY for tools/negctl_tools_r14.py
r7 = [r for r in cn['rows'] if r['n'] == 7][0]
ng = json.load(open(os.environ.get('NEGCTL_LEDGER', 'certificates/negctl/negctl_ledger_r14.json')))
led = open('sage/family_ky1000_r11_clean/VERIFY_LEDGER.txt', encoding='utf-8', errors='replace').read()
ms = re.search(r'^# SUMMARY primes (\d+) ; T certificates (\d+) ; RHO certificates (\d+) ; T-only components (\d+) ; max T ([0-9.]+) ; min margin 4224-maxT ([0-9.]+) ; median T ([0-9.]+)', led, re.M)
if not ms: bad.append('KY1000 ledger SUMMARY line not found'); primes = tcert = rcert = tonly = maxT = margin = median = None
else: primes, tcert, rcert, tonly = (int(ms.group(i)) for i in (1, 2, 3, 4)); maxT, margin, median = (float(ms.group(i)) for i in (5, 6, 7))
mex = re.search(r'EXCLUDED (\d+) / (\d+)', led); excl = (int(mex.group(1)), int(mex.group(2))) if mex else None
disp_plain = r7['display']                                   # 1.7273421630363529579743237623519834054e30
mant, ex = disp_plain.split('e'); disp_tex = mant + r'\ldots\times10^{' + ex + '}'
disp_md = mant + '... x 10^' + ex
prefix_digits = r7['certified_prefix_digits']; disp_digits = r7['display_digits']
NEG, POS = ng['negative_controls'], ng['positive_controls']
P3_LEDGER = json.load(open(os.environ.get('P3_NEGCTL_JSON', 'sage/r19_trackB/p3_negctl_ledger_r19.json')))   # r19: STRUCTURED single source (GPT r18 items 25-26, 73-74); the raw log is never parsed
NEG_P3 = int(P3_LEDGER['rejected'])
if P3_LEDGER['planted'] != P3_LEDGER['rejected'] or P3_LEDGER.get('format_version') != 'p3_negctl_ledger_r19': bad.append('p3 negctl ledger: planted %s != rejected %s or wrong format' % (P3_LEDGER['planted'], P3_LEDGER['rejected']))
if ng['rejected'] != NEG or ng['excluded'] != POS: bad.append('negctl ledger: not all controls behaved (%d/%d, %d/%d)' % (ng['rejected'], NEG, ng['excluded'], POS))
words = {1: 'one', 2: 'two', 3: 'three', 4: 'four', 5: 'five', 6: 'six', 7: 'seven', 8: 'eight', 9: 'nine', 10: 'ten', 11: 'eleven', 12: 'twelve'}
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from texsrc import expand_statements   # r21: single-sourced statements inlined (proofs/statements/)
def rd(p):
    return expand_statements(open(p, encoding='utf-8', errors='replace').read()) if os.path.exists(p) else None
def release_status_active():
    s = rd('RELEASE_STATUS.md') or ''
    i = s.find('## 1.0.2')
    if i < 0: return ''
    j = s.find('\n## Previous', i)      # r19: the CURRENT candidate block only; superseded candidates are history (they quote their own, older counts)
    return s[i:] if j < 0 else s[i:j]
media = {p: rd(p) for p in ['paper/draft/main_1.0.2.tex', 'blueprint/src/content.tex', 'README.md', 'TRUST.md', 'blueprint/README.md', 'lean/README_lean.md', 'proofs/README.md', 'theory/STATEMENT_FREEZE_1.0.2.md', 'docs/CLAIMS_1.0.2.yaml', 'CORRESPONDENCE.csv', 'docs/BLUEPRINT_MAP_1.0.2.md'] + sorted(glob.glob('proofs/*.tex'))}
media['RELEASE_STATUS.md (r20 block on)'] = release_status_active()
media = {k: v for k, v in media.items() if v is not None}
def forbid(pattern, why, flags=0, exempt=None, media=None, bad=None):
    for k, v in media.items():
        for m in re.finditer(pattern, v, flags):
            ctx = v[max(0, m.start() - 40):m.end() + 40].replace('\n', ' ')
            if exempt and re.search(exempt, ctx): continue
            bad.append('%s: stale form (%s): ...%s...' % (k, why, ctx))
def require(pattern, files, why, flags=0, media=None, bad=None):
    for k in files:
        v = media.get(k)
        if v is None: bad.append('%s missing' % k); continue
        if not re.search(pattern, v, flags): bad.append('%s: required form absent (%s): %s' % (k, why, pattern))
def run(media):
    bad = []
    F = lambda *a, **k: forbid(*a, media=media, bad=bad, **k)
    R = lambda *a, **k: require(*a, media=media, bad=bad, **k)
    # ---- C_7 ----
    R(re.escape(disp_tex), ['paper/draft/main_1.0.2.tex', 'blueprint/src/content.tex'], 'C_7 display (LaTeX) from the certificate')
    R(re.escape(disp_plain), ['docs/CLAIMS_1.0.2.yaml', 'CORRESPONDENCE.csv'], 'C_7 display (plain) from the certificate')
    R(re.escape(disp_md), ['theory/STATEMENT_FREEZE_1.0.2.md'], 'C_7 display (markdown) from the certificate')
    R(r'first \$?%d\$? digits' % prefix_digits, ['paper/draft/main_1.0.2.tex', 'blueprint/src/content.tex', 'theory/STATEMENT_FREEZE_1.0.2.md'], 'certified prefix count %d' % prefix_digits)
    R(r'\$?%d\$? digits' % disp_digits, ['paper/draft/main_1.0.2.tex', 'blueprint/src/content.tex', 'theory/STATEMENT_FREEZE_1.0.2.md'], 'display digit count %d' % disp_digits)
    F(r'1\.7273421630363529579743237623519834(?!054)', 'truncated 35-digit C_7 without the certified continuation')
    F(r'\\pm\s*2\.2\\times10\^\{-115\}', 'ball radius attached to a display value (E14-1)')
    F(r'up to an error of at most \$2\.2', 'ball radius attached to a display value (E14-1)')
    F(r'\+-\s*2\.2e-115', 'ball radius attached to a display value (E14-1)')
    F(r'error at most 2\.2 x 10\^\{-115\}', 'ball radius attached to a display value (E14-1)')
    F(r'inside ball', 'r11 "inside ball" wording withdrawn (E14-3)', re.I)
    # ---- negative controls ----
    R(r'\b%d/%d\b|\b%s\b|\b%d (negative|planted)' % (NEG, NEG, words[NEG], NEG), ['paper/draft/main_1.0.2.tex', 'blueprint/src/content.tex', 'README.md', 'TRUST.md', 'theory/STATEMENT_FREEZE_1.0.2.md', 'RELEASE_STATUS.md (r20 block on)'], 'negative-control count %d from the ledger' % NEG, re.I)
    # r18: the p = 3 read-only replay's planted-certificate count is a second ledger (single source: its log); the media must quote it as k/k
    R(r'\b%d/%d\b(?=[^\n]{0,80}(planted|reject))|\b%s planted certificates' % (NEG_P3, NEG_P3, words[NEG_P3]), ['blueprint/src/content.tex', 'docs/CLAIMS_1.0.2.yaml', 'TRUST.md', 'README.md'], 'p3 read-only negative-control count %d from sage/r19_trackB/p3_negctl_ledger_r19.json' % NEG_P3, re.I)
    for k in range(1, 13):
        if k == NEG: continue
        # the KY1000 TARGET-LIST verifier (step 03b/03c) has its own 5 planted corruptions - a different control set, exempt by context;
        # r18/r19: the p = 3 read-only replay (step 04f) has its own planted set, count read from the structured ledger sage/r19_trackB/p3_negctl_ledger_r19.json
        tl = r'target|03[bc]'
        if k == NEG_P3: tl = tl + r'|planted certificates|p3|P3 READONLY|04f'
        F(r'\b%d/%d\b(?=[^\n]{0,60}(negative|reject|control|corrupt))' % (k, k), 'negative-control count %d != ledger %d' % (k, NEG), re.I, exempt=tl)
        F(r'\b%s (planted|negative)' % words[k], 'negative-control count %s != ledger %d' % (words[k], NEG), re.I, exempt=r'barT_%s|%s' % (words[k], tl))
        F(r'\b%d (planted |negative )' % k, 'negative-control count %d != ledger %d' % (k, NEG), re.I, exempt=tl)
    # ---- KY1000 ----
    if primes is not None:
        R(r'\b%d/%d\b' % (excl[0], excl[1]) if excl else r'1000/1000', ['paper/draft/main_1.0.2.tex', 'blueprint/src/content.tex', 'README.md', 'theory/STATEMENT_FREEZE_1.0.2.md'], 'EXCLUDED %s' % (excl,))
        R(r'\b%d\b' % tcert, ['paper/draft/main_1.0.2.tex', 'theory/STATEMENT_FREEZE_1.0.2.md'], 'T certificate count %d' % tcert)
        R(r'\b%d\b' % rcert, ['paper/draft/main_1.0.2.tex', 'theory/STATEMENT_FREEZE_1.0.2.md'], 'RHO certificate count %d' % rcert)
        R(r'%.4f' % maxT, ['paper/draft/main_1.0.2.tex', 'theory/STATEMENT_FREEZE_1.0.2.md'], 'max T %.4f' % maxT)
        R(r'%.4f' % margin, ['paper/draft/main_1.0.2.tex', 'theory/STATEMENT_FREEZE_1.0.2.md'], 'margin %.4f' % margin)
        R(r'%.4f' % median, ['paper/draft/main_1.0.2.tex', 'theory/STATEMENT_FREEZE_1.0.2.md'], 'median T %.4f' % median)
        def four_dec_variants(x):   # any 4-decimal rendering of int(x).xxxx other than the ledger's own rounding
            ip, fp = ('%.4f' % x).split('.'); return r'\b%s\.(?!%s\b)\d{4}\b' % (ip, fp)
        for wrong in (r'\b3200[1-9]\b', r'\b3198[0-6]\b', r'\b3198[89]\b', four_dec_variants(maxT), four_dec_variants(margin), four_dec_variants(median)):
            F(wrong, 'KY1000 number not matching the ledger')

    return bad
bad += run(media)
if '--selftest' in sys.argv:
    # negative controls of the gate itself: each planted stale form must be caught
    plants = [('paper/draft/main_1.0.2.tex', ' seven planted corruptions '), ('blueprint/src/content.tex', ' negative controls 7/7 rejected '),
              ('TRUST.md', ' Seven planted negative controls '), ('paper/draft/main_1.0.2.tex', r' $C_7=1.7273421630363529579743237623519834\\times10^{30}$ up to an error of at most $2.2\\times10^{-115}$ '),
              ('docs/CLAIMS_1.0.2.yaml', ' C_7 = 1.7273421630363529579743237623519834e30 +- 2.2e-115 '), ('paper/draft/main_1.0.2.tex', ' $32001$ / $31987$ '),
              ('theory/STATEMENT_FREEZE_1.0.2.md', ' max T 4164.4898 '), ('paper/draft/main_1.0.2.tex', ' Magma 40-digit value inside ball ')]
    caught = 0
    for f, txt in plants:
        m2 = dict(media); m2[f] = m2[f] + '\n' + txt
        if len(run(m2)) > len(bad): caught += 1
        else: print('SELFTEST MISS: %s <- %r' % (f, txt))
    print('SELFTEST: %d/%d planted stale forms caught' % (caught, len(plants)))
    if caught != len(plants): bad.append('selftest: gate misses a planted stale form')
print('sources: C_7 display %s (prefix %d digits, display %d) ; negctl %d/%d + %d positive ; KY1000 primes %s T %s RHO %s T-only %s maxT %s margin %s' % (disp_plain, prefix_digits, disp_digits, ng['rejected'], NEG, POS, primes, tcert, rcert, tonly, maxT, margin))
print('media checked: %d' % len(media))
for b in bad: print('SYNC FAIL:', b[:300])
print('CONSTANT SYNC: %s' % ('PASS' if not bad else 'FAIL (%d)' % len(bad)))
sys.exit(1 if bad else 0)
