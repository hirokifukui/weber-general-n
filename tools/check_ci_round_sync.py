#!/usr/bin/env python3
"""check_ci_round_sync.py (r21; GPT r20 review P0 items 1-9 = hw 1060-1068, 1124) -- CI ROUND SYNC gate.
The r20 defect (GPT r20 sect 4): scripts/verify_all_portable.sh wrote "round": "r20" into SUMMARY.json while the aggregator of
.github/workflows/verify.yml required S["round"] == "r15" and wrote round='r15' into ci_attestation.json (a hard-code left from r15),
so the clean-CI `full` job would have FAILED after both profile jobs passed. Neither the round bump nor check_release_metadata.py
audited the workflow. Single source of the PACKAGE round = the `version:` line of CITATION.cff (already the source read by
tools/check_statement_sync.py and tools/check_release_metadata.py). Static checks, exit 1 on any failure:
 (1) WORKFLOW: the aggregator carries NO literal round (no `== 'rNN'`, no `round='rNN'`, no `round="rNN"`); it reads the package
     round from CITATION.cff of the checked-out commit (marker PACKAGE_ROUND), asserts the sage and lean summaries carry the SAME
     round and that it equals the package round, and takes the attestation round from the summaries; no header line claims a
     current "ROUND NN" other than the package round;
 (2) VERIFIER: scripts/verify_all_portable.sh derives its round from CITATION.cff (marker `ROUND=$(...CITATION.cff...)`), writes
     round=ROUND into SUMMARY.json and prints "VERIFY_ALL_PORTABLE $ROUND FULL" -- no literal `round='rNN'` / `VERIFY_ALL_PORTABLE rNN`;
     every package-round file token in a non-comment line (main_RNN, CLAIMS_RNN, STATEMENT_FREEZE_RNN, BLUEPRINT_MAP_RNN, blueprint_rNN.pdf,
     ERRATA_RNN, BLUEPRINT_PROOF_REPORT_RNN) names the package round;
 (3) CLAIMS: docs/CLAIMS_R<NN>.yaml exists for the package round and its `round:` field equals it;
 (4) RELEASE METADATA: .zenodo.json version == CITATION.cff version; RELEASE_STATUS.md's first candidate block names the package round.
 --negctl: four planted variants must FAIL, in memory only, nothing written into the package: (a) the workflow with the r15 literals
     re-inserted (the r20 defect verbatim), (b) the verifier with round='r15' hard-coded, (c) the claims with round: r15, (d) .zenodo.json
     with a stale version.
Usage: python3 tools/check_ci_round_sync.py [--negctl]      (run from the package root)"""
import re,sys,os,json
WF='.github/workflows/verify.yml'; VA='scripts/verify_all_portable.sh'; RS='RELEASE_STATUS.md'
def rd(p): return open(p,encoding='utf-8').read() if os.path.exists(p) else ''
def cffver(cff):
    m=re.search(r'^version: "?([A-Za-z0-9.]+)"?$',cff,re.M); return m.group(1) if m else None
PKG_TOKENS=r'main_R(\d+)|CLAIMS_R(\d+)|STATEMENT_FREEZE_R(\d+)|BLUEPRINT_MAP_R(\d+)|BLUEPRINT_PROOF_REPORT_R(\d+)|blueprint_r(\d+)\.pdf|ERRATA_R(\d+)'
def check(cff, wf, va, claims_txt, claims_path, zen, rs):
    bad=[]; ver=cffver(cff)
    if not ver: return ['CITATION.cff has no version: rNN line (package round undefined)']
    # (1) workflow
    if not wf: bad.append(WF+' missing')
    else:
        wf_code='\n'.join(l for l in wf.split('\n') if not l.lstrip().startswith('#'))   # YAML comment lines may cite the old defect
        for m in re.finditer(r"""round'?\)?\s*==\s*['"]([A-Za-z0-9.]+)['"]|round\s*=\s*['"]([A-Za-z0-9.]+)['"]""",wf_code):
            bad.append('%s carries a literal round in the aggregator: %s'%(WF,m.group(0)))
        if 'PACKAGE_ROUND' not in wf or 'CITATION.cff' not in wf: bad.append('%s aggregator does not read the package round from CITATION.cff (marker PACKAGE_ROUND)'%WF)
        if not re.search(r"S\.get\('round'\)\s*==\s*L\.get\('round'\)|S\['round'\]\s*==\s*L\['round'\]",wf): bad.append('%s aggregator does not assert sage round == lean round'%WF)
        if not re.search(r"==\s*PACKAGE_ROUND",wf): bad.append('%s aggregator does not assert the summary round == PACKAGE_ROUND'%WF)
        if not re.search(r"round\s*=\s*S(?:\.get\('round'\)|\['round'\])",wf): bad.append('%s attestation round is not taken from the summary'%WF)
        for m in re.finditer(r'ROUND (\d+)',wf.split('\n',1)[0]):
            if 'r'+m.group(1)!=ver: bad.append('%s first line claims ROUND %s (package round %s)'%(WF,m.group(1),ver))
    # (2) verifier
    if not va: bad.append(VA+' missing')
    else:
        if not re.search(r'^ROUND=\$\(.*CITATION\.cff.*\)',va,re.M): bad.append('%s does not derive ROUND from CITATION.cff'%VA)
        for m in re.finditer(r"""round\s*=\s*['"]([A-Za-z0-9.]+)['"]|VERIFY_ALL_PORTABLE ([A-Za-z0-9.]+) FULL""",va):
            bad.append('%s carries a literal round: %s'%(VA,m.group(0)))
        if not (re.search(r'"\$SUMMARY\.json"|SUMMARY\.json" "\$PROFILE" "\$FAIL" "\$SKIPS" "\$STEPLOG" "\$ROUND"',va) and re.search(r"round=(?:rnd|sys\.argv\[\d\])",va)): bad.append('%s SUMMARY.json round is not written from ROUND (the finish() writer must receive "$ROUND" and write round=rnd)'%VA)
        for ln,line in enumerate(va.split('\n'),1):
            if line.lstrip().startswith('#'): continue
            for m in re.finditer(PKG_TOKENS,line):
                r=next(g for g in m.groups() if g)
                if 'r'+r!=ver: bad.append('%s line %d names a round-%s package file: %s (package round %s)'%(VA,ln,r,m.group(0),ver))
    # (3) claims
    if not claims_txt: bad.append('%s missing'%claims_path)
    else:
        m=re.search(r'^round:\s*"?([A-Za-z0-9.]+)"?\s*$',claims_txt,re.M)
        if not m: bad.append('%s has no round: field'%claims_path)
        elif m.group(1)!=ver: bad.append('%s round: %s (package round %s)'%(claims_path,m.group(1),ver))
    # (4) release metadata
    try: zv=json.loads(zen).get('version')
    except Exception as e: zv=None; bad.append('.zenodo.json unreadable: %s'%e)
    if zv!=ver: bad.append('.zenodo.json version %s (package round %s)'%(zv,ver))
    m=re.search(r'^## ([A-Za-z0-9.]+) candidate',rs,re.M)
    if not m: bad.append('%s has no "## rNN candidate" block'%RS)
    elif m.group(1)!=ver: bad.append('%s first candidate block is %s (package round %s)'%(RS,m.group(1),ver))
    return bad
def main():
    cff=rd('CITATION.cff'); ver=cffver(cff) or 'r??'; cp='docs/CLAIMS_%s.yaml'%ver.upper()
    args=dict(cff=cff,wf=rd(WF),va=rd(VA),claims_txt=rd(cp),claims_path=cp,zen=rd('.zenodo.json'),rs=rd(RS))
    if '--negctl' in sys.argv:
        res=[]
        a=dict(args); a['wf']=re.sub(r"S\.get\('round'\)\s*==\s*L\.get\('round'\)","S.get('round') == 'r15' and L.get('round') == 'r15'",a['wf'],count=1).replace("round=S.get('round')","round='r15'")
        res.append(('a workflow r15 literals re-inserted',check(**a)))
        b=dict(args); b['va']=re.sub(r'^ROUND=\$\(.*\)$',"ROUND=r15",b['va'],count=1,flags=re.M).replace("round=rnd,","round='r15',")
        res.append(('b verifier round hard-coded r15',check(**b)))
        c=dict(args); c['claims_txt']=re.sub(r'^round:.*$','round: r15',c['claims_txt'],count=1,flags=re.M)
        res.append(('c claims round r15',check(**c)))
        d=dict(args); d['zen']=d['zen'].replace('"version": "%s"'%ver,'"version": "r15"')
        res.append(('d .zenodo.json version stale',check(**d)))
        ok=all(bad for _,bad in res)
        for n,bad in res: print('NEGCTL %s :: %s'%(n,'REJECTED (correct)' if bad else 'ACCEPTED (WRONG)'))
        print('CI ROUND SYNC NEGCTL: %s (%d/4 rejected)'%('PASS' if ok else 'FAIL',sum(1 for _,b in res if b)))
        if not ok: sys.exit(1)
    bad=check(**args)
    print('CI ROUND SYNC: %s (package round %s; workflow / verifier / claims / release metadata%s)'%('PASS' if not bad else 'FAIL '+'; '.join(bad),ver,'' if not bad else ''))
    sys.exit(1 if bad else 0)
if __name__=='__main__': main()
