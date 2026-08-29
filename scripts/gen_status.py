#!/usr/bin/env python3
# gen_status.py — render docs/CURRENT_STATUS.md from docs/CLAIMS.yaml (r7, homework 20-21)
# No YAML dependency assumed: minimal parser for the fixed CLAIMS.yaml shape.
import os, re, sys, datetime

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.normpath(os.path.join(HERE, '..'))
SRC  = os.path.join(ROOT, 'docs', 'CLAIMS_R9.yaml')
DST  = os.path.join(ROOT, 'docs', 'CURRENT_STATUS_R9.md')

def parse(path):
    claims, cur, section = [], None, None
    meta = {}
    quarantine = []
    for raw in open(path):
        line = raw.rstrip('\n')
        if re.match(r'^claims:', line): section = 'claims'; continue
        if re.match(r'^quarantine:', line): section = 'q'; continue
        if re.match(r'^meta:', line): section = 'meta'; continue
        if section == 'meta':
            m = re.match(r'^  (\w+): (.+)$', line)
            if m and m.group(1) != 'reviewer_gate': meta[m.group(1)] = m.group(2)
        if section == 'claims':
            m = re.match(r'^  - id: (.+)$', line)
            if m:
                cur = {'id': m.group(1)}; claims.append(cur); continue
            m = re.match(r'^    (\w+): "?(.*?)"?$', line)
            if m and cur is not None: cur[m.group(1)] = m.group(2)
        if section == 'q':
            m = re.match(r'^  - "(.*)"$', line)
            if m: quarantine.append(m.group(1))
    return meta, claims, quarantine

TAG = {'P-cite-rp': '[P-cite, repair pending]', 'MC': '[MC]', 'OPEN': '[OPEN]',
       'OPEN-survey': '[OPEN: survey pending]', 'ERRATA': '[ERRATA]'}

meta, claims, quarantine = parse(SRC)
out = []
out.append('# CURRENT_STATUS_R9 — weber_general_n (GENERATED from CLAIMS_R9.yaml; do not edit)')
out.append('Generated %s by scripts/gen_status.py. Round %s, %s.' %
           (datetime.date.today().isoformat(), meta.get('round','?'), meta.get('date','?')))
out.append('')
out.append('| id | status | statement |')
out.append('|----|--------|-----------|')
for c in claims:
    out.append('| %s | %s | %s |' % (c['id'], TAG.get(c.get('status'), c.get('status')), c.get('statement','')))
out.append('')
out.append('## Evidence and documents')
for c in claims:
    out.append('- **%s**: doc %s%s' % (c['id'], c.get('doc','-'),
               ('; evidence: ' + c['evidence']) if c.get('evidence') else ''))
out.append('')
out.append('## Quarantine (unchanged)')
for q in quarantine:
    out.append('- ' + q)
out.append('')
out.append('Restoration gate: [P-cite, repair pending] -> [P-cite] only by the external r7 review.')
open(DST, 'w').write('\n'.join(out) + '\n')
print('wrote', DST, len(claims), 'claims')
