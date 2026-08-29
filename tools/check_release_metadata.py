#!/usr/bin/env python3
"""check_release_metadata.py - r21: .github/workflows/verify.yml and scripts/verify_all_portable.sh join the current-facing audit (GPT r20 P0 item 7 = hw 1066, 1124); r15 (GPT r14 hw 621-624); r18 current-facing pointers; r19 (GPT r18 items 36-40 = hw 912-916): the
ACTIVE PROOF SOURCE is audited too -- proofs/*.tex, blueprint/src/content.tex, the current STATEMENT_FREEZE (above its verbatim history
block), blueprint/README.md, proofs/README.md, the CLAIMS header, README.md, TRUST.md: every round-versioned evidence path (p = 3
certificate family, round documents, Blueprint PDF) must name the CURRENT round unless the line marks it as history
(retained / superseded / archive / record / deprecated / historical / previous / earlier / withdrawn / r1N: note). A stale current
certificate path FAILS (item 40). CITATION.cff and .zenodo.json must agree on title, version, date, author,
license and keywords. Exit 1 on any mismatch. No DOI is asserted here (reserved at release, never committed).
r20 (GPT r19 items 22-23 = hw 1006-1007, 1056; MOVE_LOG_R20): (a) TWO rounds are distinguished -- the PACKAGE round (CITATION.cff version:
main_R*, CLAIMS_R*, STATEMENT_FREEZE_R*, BLUEPRINT_MAP_R*, BLUEPRINT_PROOF_REPORT_R*, blueprint_r*.pdf, REVIEWER_GUIDE_R*,
BLUEPRINT_HUMAN_REVIEW_R*, LETTER_R*) and the CERTIFICATE round of the p = 3 evidence family (D3_cert_r*, gen_p3_cert_r*, r*_trackB,
verify_p3_readonly_r*.log, p3_covol_cert_r*, p3_negctl_ledger_r*, P3_NEGCTL_LEDGER_R*), whose single source is the certificate path
hard-coded in tools/check_p3_cert.py (ROLE 1 gate); the certificate keeps its round-of-origin name when it is unchanged (r20: the r19
certificate ships unchanged), and a current-facing line must name THAT round, never an older one. (b) FORBIDDEN NOTATION: the false
integer equalities a = 4^{N/3} / a = 1+N = 4^{N/3} / -2 = 4^{j_0} (proofs/thm_rank3.tex, ERRATA_R20 E20-2) may never reappear in the
active proof source, the paper body or the Blueprint; only the congruences (\\equiv ... \\pmod q) are allowed."""
import json,sys,re
cff=open('CITATION.cff',encoding='utf-8').read(); z=json.load(open('.zenodo.json',encoding='utf-8'))
def cffval(k):
    m=re.search(r'^%s: "?(.*?)"?$'%k,cff,re.M); return m.group(1) if m else None
bad=[]
if cffval('title')!=z['title']: bad.append('title')
if cffval('version')!=z['version']: bad.append('version')
if cffval('date-released')!=z['publication_date']: bad.append('date')
if (cffval('license') or z.get('license')) and cffval('license')!=z.get('license'): bad.append('license')
kw=re.findall(r'^  - (.+)$',cff.split('keywords:')[1].split('abstract:')[0],re.M)
if kw!=z['keywords']: bad.append('keywords %s != %s'%(kw,z['keywords']))
if 'Fukui' not in cff or z['creators'][0]['name']!='Fukui, Hiroki': bad.append('author')
if re.search(r'10\.5281',cff+json.dumps(z)): bad.append('a DOI is written into the tree (must stay in release metadata)')
# r18 (GPT r17 items 58-68): every current-facing pointer must name the CURRENT round; the version line is the single source
import os,glob
ver=cffval('version'); R=ver.upper()
for k,txt in (('CITATION.cff notes',cff),('.zenodo.json',json.dumps(z))):
    for m in re.findall(r'main_R(\d+)\.pdf',txt):
        if 'r'+m!=ver: bad.append('%s points to main_R%s.pdf, version is %s'%(k,m,ver))
if not os.path.exists('paper/draft/main_%s.tex'%R): bad.append('paper/draft/main_%s.tex missing'%R)
if not os.path.exists('docs/CLAIMS_%s.yaml'%R): bad.append('docs/CLAIMS_%s.yaml missing'%R)
tex=open('paper/draft/main_%s.tex'%R,encoding='utf-8').read() if os.path.exists('paper/draft/main_%s.tex'%R) else ''
body=tex.split('\\begin{document}',1)[-1]
for m in set(re.findall(r'(?:CLAIMS|BLUEPRINT\\?_MAP|STATEMENT\\?_FREEZE|main|ERRATA\\?)_R(\d+)',body)):
    if 'r'+m!=ver: bad.append('paper body refers to a round-%s file (version %s)'%(m,ver))
for m in set(re.findall(r'blueprint_r(\d+)\.pdf',body)):
    if 'r'+m!=ver: bad.append('paper body refers to blueprint_r%s.pdf (version %s)'%(m,ver))
if re.search(r'pdfsubject=\{[^}]*\br1\d\b',tex): bad.append('pdfsubject carries a round number (item 67)')
pt=open('blueprint/src/print.tex',encoding='utf-8').read() if os.path.exists('blueprint/src/print.tex') else ''
if re.search(r'pdftitle=\{[^}]*\br1\d\b|pdfsubject=\{[^}]*\br1\d\b|\\title\{[^\n]*Blueprint \(r1\d\)',pt): bad.append('blueprint print.tex title/subject carries a round number (items 59, 67)')
for m in set(re.findall(r'Package: weber\\_general\\_n ([A-Za-z0-9.]*[A-Za-z0-9])',pt)):
    if m!=ver: bad.append('blueprint legend says package %s, version %s'%(m,ver))
rd=open('README.md',encoding='utf-8').read().split('\n',1)[0] if os.path.exists('README.md') else ''
for m in set(re.findall(r'ROUND (\d+)',rd)):
    if 'r'+m!=ver: bad.append('README first line says ROUND %s, version %s'%(m,ver))
for old in ('2.1204e44','1.4562e22','2.12e44','1.46e22'):
    if old in rd: bad.append('README summary line carries the withdrawn r16 P3 constant %s (item 63)'%old)
# r19: active proof source audit (items 36-40)
PKG_TOKENS=r'main(?:\\_|_)R(\d+)|CLAIMS(?:\\_|_)R(\d+)|STATEMENT(?:\\_|_)FREEZE(?:\\_|_)R(\d+)|BLUEPRINT(?:\\_|_)MAP(?:\\_|_)R(\d+)|BLUEPRINT(?:\\_|_)PROOF(?:\\_|_)REPORT(?:\\_|_)R(\d+)|blueprint(?:\\_|_)r(\d+)\.pdf|REVIEWER(?:\\_|_)GUIDE(?:\\_|_)R(\d+)|BLUEPRINT(?:\\_|_)HUMAN(?:\\_|_)REVIEW(?:\\_|_)R(\d+)|LETTER(?:\\_|_)R(\d+)'
EVID_TOKENS=r'D3(?:\\_|_)cert(?:\\_|_)r(\d+)\.json|gen(?:\\_|_)p3(?:\\_|_)cert(?:\\_|_)r(\d+)\.py|(?<![A-Za-z])r(\d+)(?:\\_|_)trackB|verify(?:\\_|_)p3(?:\\_|_)readonly(?:\\_|_)r(\d+)\.log|p3(?:\\_|_)covol(?:\\_|_)cert(?:\\_|_)r(\d+)|p3(?:\\_|_)negctl(?:\\_|_)ledger(?:\\_|_)r(\d+)|P3(?:\\_|_)NEGCTL(?:\\_|_)LEDGER(?:\\_|_)R(\d+)'
# single source of the certificate round: the certificate path hard-coded in tools/check_p3_cert.py (ROLE 1)
_cp=open('tools/check_p3_cert.py',encoding='utf-8').read() if os.path.exists('tools/check_p3_cert.py') else ''
_cm=re.search(r'certificates/p3/D3_cert_r(\d+)\.json',_cp)
cert_ver='r'+_cm.group(1) if _cm else None
if not cert_ver: bad.append('tools/check_p3_cert.py names no certificates/p3/D3_cert_r*.json (certificate round undefined)')
elif not os.path.exists('certificates/p3/D3_cert_%s.json'%cert_ver): bad.append('certificate round %s: certificates/p3/D3_cert_%s.json missing'%(cert_ver,cert_ver))
else:
    _va=open('scripts/verify_all_portable.sh',encoding='utf-8').read() if os.path.exists('scripts/verify_all_portable.sh') else ''
    for m in set(re.findall(r'gen_p3_cert_r(\d+)\.py',_va)):
        if 'r'+m!=cert_ver: bad.append('scripts/verify_all_portable.sh runs gen_p3_cert_r%s.py, certificate round is %s'%(m,cert_ver))
HIST=re.compile(r'retained|superseded|archive|record|deprecated|historical|previous|earlier|withdrawn|history|\br1\d: |\(r1\d\)|r1\d defect|r1\d gate|the r1\d|E1\d-\d',re.I)
def audit(path, text, label):
    for ln,line in enumerate(text.split('\n'),1):
        if HIST.search(line): continue
        for m in re.finditer(PKG_TOKENS,line):
            r=next(g for g in m.groups() if g)
            if 'r'+r!=ver: bad.append('%s line %d names a round-%s package file as current: %s (version %s)'%(label,ln,r,m.group(0),ver))
        for m in re.finditer(EVID_TOKENS,line):
            r=next(g for g in m.groups() if g)
            if cert_ver and 'r'+r!=cert_ver: bad.append('%s line %d names a round-%s certificate-family file as current evidence: %s (certificate round %s)'%(label,ln,r,m.group(0),cert_ver))
# r20 forbidden notation (hw 1006-1007): false integer equalities of proofs/thm_rank3.tex; congruences only
FORBID=[(r'=\s*4\^\{N/3\}','a = 4^{N/3} written as an equality (must be a congruence mod q)'),
        (r'=\s*1\+N\s*=\s*4','a = 1+N = 4^{N/3} written as an equality (must be a congruence mod q)'),
        (r'-2\s*=\s*4\^\{j_0\}','-2 = 4^{j_0} written as an equality (must be a congruence mod q)')]
def forbid(path, text):
    for ln,line in enumerate(text.split('\n'),1):
        if line.lstrip().startswith('%'): continue
        for pat,msg in FORBID:
            if re.search(pat,line): bad.append('%s line %d: %s'%(path,ln,msg))
for f in sorted(glob.glob('proofs/*.tex'))+sorted(glob.glob('proofs/statements/*.tex'))+['blueprint/src/content.tex']+glob.glob('paper/draft/main_%s.tex'%R):   # r21: + the single-source statements
    if os.path.exists(f): forbid(f, open(f,encoding='utf-8').read())
for f in sorted(glob.glob('proofs/*.tex'))+sorted(glob.glob('proofs/statements/*.tex'))+['proofs/README.md','blueprint/README.md','blueprint/src/content.tex','README.md','TRUST.md']:
    if os.path.exists(f): audit(f, open(f,encoding='utf-8').read(), f)
for f in ('.github/workflows/verify.yml','scripts/verify_all_portable.sh'):   # r21: the workflow and the verifier are audited too (hw 1124), CODE lines only --
    if os.path.exists(f):                                                      # their '#' comment lines are the per-round changelog; the round-literal check itself is tools/check_ci_round_sync.py
        audit(f, '\n'.join('' if l.lstrip().startswith('#') else l for l in open(f,encoding='utf-8').read().split('\n')), f+' (code lines)')
sf='theory/STATEMENT_FREEZE_%s.md'%R
if os.path.exists(sf):
    cur=open(sf,encoding='utf-8').read().split('---- R',1)[0]     # the current block only; the verbatim history follows the first '---- R' marker
    audit(sf, cur, sf+' (current block)')
cl='docs/CLAIMS_%s.yaml'%R
if os.path.exists(cl):
    head=open(cl,encoding='utf-8').read().split('\n',1)[0]
    if not head.startswith('# CLAIMS_%s.yaml'%R): bad.append('%s header comment does not name CLAIMS_%s.yaml: %s'%(cl,R,head[:60]))
print('RELEASE METADATA SYNC: %s'%('PASS' if not bad else 'FAIL '+'; '.join(bad))); sys.exit(1 if bad else 0)
