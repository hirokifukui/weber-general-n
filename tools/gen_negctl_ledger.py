#!/usr/bin/env python3
"""gen_negctl_ledger.py - r14 (GPT r13 sect 4 / hw 417-419). Single machine-readable source for the negative-control counts.
Parses the shipped negative-control log (LOG) and writes certificates/negctl/negctl_ledger_r14.json:
  negative_controls (files planted), rejected (verifier FAIL on each), positive_controls, excluded (positive accepted),
  the file list with the verifier's verdict line, and the sha256 of the log. Every prose count ("9/9", "nine") is
  checked against THIS file by tools/check_constant_sync.py; nothing is typed by hand.
--check: re-parse the log and compare with the JSON (counts, file list, log sha256) -> "NEGCTL LEDGER: PASS/FAIL"."""
import re, sys, json, hashlib, os
LOG = os.environ.get('NEGCTL_LOG', 'sage/negctl_r13/negctl_r13.log'); OUT = os.environ.get('NEGCTL_LEDGER', 'certificates/negctl/negctl_ledger_r14.json')   # env overrides ONLY for tools/negctl_tools_r14.py
def build():
    txt = open(LOG, encoding='utf-8', errors='replace').read()
    neg = [(m.group(1), m.group(2).strip()) for m in re.finditer(r'^(nc\d+_[^:]+\.txt): REJECTED \(correct\) :: (.*)$', txt, re.M)]
    pos = [(m.group(1), m.group(2).strip()) for m in re.finditer(r'^(n2 positive control[^:]*): EXCLUDED \(correct\) :: (.*)$', txt, re.M)]
    all_rejected = bool(re.search(r'^NEGATIVE CONTROLS ALL_REJECTED$', txt, re.M))
    return dict(format_version=1, source_log=LOG, source_sha256=hashlib.sha256(open(LOG, 'rb').read()).hexdigest(),
                negative_controls=len(neg), rejected=len(neg), positive_controls=len(pos), excluded=len(pos),
                all_rejected_line=all_rejected, negative_files=[dict(file=f, verdict=v) for f, v in neg],
                positive_files=[dict(name=f, verdict=v) for f, v in pos],
                generator='scripts/family_negctl.sh (nc1..nc9 + n2 positive)', verifier='scripts/family_verify.sage (r11, sha256 0f38bb0d...)')
L = build()
if '--check' in sys.argv:
    bad = []
    if not os.path.exists(OUT): bad.append('ledger missing')
    else:
        J = json.load(open(OUT))
        keys = ('negative_controls', 'rejected', 'positive_controls', 'excluded', 'all_rejected_line') if '--counts-only' in sys.argv else ('source_sha256', 'negative_controls', 'rejected', 'positive_controls', 'excluded', 'all_rejected_line')
        for k in keys:   # --counts-only: a FRESH negctl log (verifier step 08) is compared with the shipped ledger on counts, not on the log sha
            if J.get(k) != L[k]: bad.append('%s: ledger %r != log %r' % (k, J.get(k), L[k]))
        if [x['file'] for x in J.get('negative_files', [])] != [x['file'] for x in L['negative_files']]: bad.append('negative file list differs')
    if L['negative_controls'] != L['rejected'] or not L['all_rejected_line']: bad.append('log itself: not all negative controls rejected')
    if L['positive_controls'] < 1 or L['positive_controls'] != L['excluded']: bad.append('log itself: positive control missing or not accepted')
    print('negctl log %s: negative %d rejected %d ; positive %d excluded %d ; ALL_REJECTED line %s' % (LOG, L['negative_controls'], L['rejected'], L['positive_controls'], L['excluded'], L['all_rejected_line']))
    for b in bad: print('NEGCTL FAIL:', b)
    print('NEGCTL LEDGER: %s' % ('PASS' if not bad else 'FAIL')); sys.exit(1 if bad else 0)
os.makedirs(os.path.dirname(OUT), exist_ok=True); json.dump(L, open(OUT, 'w'), indent=1)
print('wrote', OUT, ': negative', L['negative_controls'], 'rejected', L['rejected'], '; positive', L['positive_controls'], 'excluded', L['excluded'])
