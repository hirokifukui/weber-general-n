#!/usr/bin/env python3
"""check_statement_sync.py (r21; GPT r20 review P1 items 11-24 = hw 1070-1083; r20 origin: GPT r19 items 14, 25-31 = hw 998, 1009-1015, 1058)
-- STATEMENT SYNC gate. Since r21 every theorem-like statement shared by the paper and the Blueprint is SINGLE-SOURCED: the statement
text lives in proofs/statements/<label>.tex (label ':' -> '_') and both media \\input it inside their own theorem environment, which
carries only \\label, the Lean tags (\\lean / \\leanok), \\uses and the trust tag in the environment title. (r20 defect ERRATA_R20 E20-1:
the statement of Theorem P3 was written twice and one copy lost the oddness condition; r20 locked six labels by byte identity, r21
locks all 38 structurally.) Checks, exit 1 on any failure:
 (i)  SINGLE SOURCE: for every label present in BOTH media, both environment bodies (after removing \\label / \\lean / \\leanok / \\uses /
      \\discussion and whitespace) are exactly `\\input{\\proofsdir/statements/<label_file>}` with the SAME file, and the file exists.
      A shared label with inline statement text in either medium FAILS. The count printed is single-sourced / shared (must be equal);
 (ii) STATEMENT FILES: no \\label / \\lean / \\leanok / \\uses / \\lbl / \\input inside; every \\ref{L} in a statement file targets a label
      defined in BOTH media (medium-specific pointers go through the four macros \\refConst \\refCert \\refAppF \\refDefH defined per medium);
      no statement file is orphaned (every proofs/statements/*.tex is \\input by both media);
 (iii) CONDITIONS: for every claim of docs/CLAIMS_R<ver>.yaml with a `conditions` block, the set of true conditions EQUALS the
      `% conditions:` header of the claim's statement file (single source of the machine-readable conditions), and each condition's
      phrase (`conditions_phrases`) is in the claims statement string and its LaTeX form (`conditions_tex`, else the built-in forms) is
      in the statement file text;
 (iv) --negctl: five planted variants must FAIL, in memory only (nothing written): (a) statement file thm_P3 with "an odd prime" -> "a prime"
      (the r19 wording), (b) claims THM_P3 with the oddness phrase removed, (c) the Blueprint wrapper of thm:P3 carrying inline text
      instead of the \\input (statement drift surface), (d) statement file thm_S0 with the depth range t >= 2 -> t >= 1 (GPT r20 item 22),
      (e) the statement file header of thm_P3 without ell_odd (conditions single source broken).
Usage: python3 tools/check_statement_sync.py [--negctl]      (run from the package root; the round is read from CITATION.cff)"""
import re,sys,os,glob,copy,yaml
def cffver():
    m=re.search(r'^version: "?([A-Za-z0-9.]+)"?$',open('CITATION.cff',encoding='utf-8').read(),re.M); return m.group(1)
VER=cffver(); R=VER.upper()
PAPER='paper/draft/main_%s.tex'%R; BP='blueprint/src/content.tex'; CLAIMS='docs/CLAIMS_%s.yaml'%R; SDIR='proofs/statements'
CLAIM_LABEL={'THM_P3':'thm:P3','COR_P3N4':'cor:P3n4','THM_RANK3':'thm:rank3','LEM_NORMONE':'lem:normone','THM_SH':'thm:SH','THM_S0':'thm:S0','THM_A':'thm:A','THM_CERT':'thm:cert','FAMILY_KY1000':'thm:family'}
BUILTIN_TEX={'ell_ne_3':[r'\ell\ne3',r'\ell\neq3',r'\ell \ne 3'],'n_ge_1':[r'n\ge1',r'n \ge 1'],'ell_odd':['odd'],'ell_prime':['prime'],'t_ge_2':[r't\ge2',r't \ge 2'],'ell_pm1_mod_81':[r'\pmod{81}']}
ENVS=('theorem','lemma','corollary','proposition')
TOK=re.compile(r'\\(label|lean|uses|discussion)\{[^}]*\}|\\leanok|\\mathlibok|\\notready')
def strip_comments(s): return re.sub(r'(?m)(?<!\\)%.*$','',s)
def skip_balanced(s,i):
    depth=0; j=i
    while j<len(s):
        c=s[j]
        if c in '[{': depth+=1
        elif c in ']}': depth-=1
        if depth==0: return j+1
        j+=1
    raise ValueError('unbalanced optional argument at %d'%i)
def statements(src):
    """label -> (env, normalised body without the wrapper tokens). src = file TEXT."""
    s=strip_comments(src); out={}
    for m in re.finditer(r'\\begin\{(%s)\}'%'|'.join(ENVS),s):
        env=m.group(1); i=m.end()
        while i<len(s) and s[i] in ' \t\n': i+=1
        if i<len(s) and s[i]=='[': i=skip_balanced(s,i)
        end=s.find('\\end{%s}'%env,i); body=s[i:end]
        lm=re.search(r'\\label\{([^}]+)\}',body)
        if not lm: continue
        norm=re.sub(r'\s+',' ',TOK.sub('',body)).strip()
        out[lm.group(1)]=(env,norm)
    return out
def all_labels(src): return set(re.findall(r'\\label\{([^}]+)\}',strip_comments(src)))
def read_statement_files(sdir=SDIR):
    files={}
    for f in sorted(glob.glob(os.path.join(sdir,'*.tex'))):
        raw=open(f,encoding='utf-8').read()
        m=re.search(r'^% conditions:\s*(.*)$',raw,re.M)
        cond=set(m.group(1).split()) if m else set()
        files[os.path.basename(f)[:-4]]=dict(raw=raw,text=strip_comments(raw),cond=cond)
    return files
def check(P,B,files,d):
    bad=[]; A=statements(P); Bs=statements(B); LP=all_labels(P); LB=all_labels(B)
    shared=sorted(set(A)&set(Bs)); synced=0; used=set()
    for l in shared:
        fn=l.replace(':','_'); want='\\input{\\proofsdir/statements/%s}'%fn
        okp=A[l][1]==want; okb=Bs[l][1]==want
        if not okp: bad.append('paper %s is not single-sourced (body: %s)'%(l,A[l][1][:60]))
        if not okb: bad.append('Blueprint %s is not single-sourced (body: %s)'%(l,Bs[l][1][:60]))
        if fn not in files: bad.append('%s/%s.tex missing'%(SDIR,fn))
        if okp and okb and fn in files: synced+=1
        used.add(fn)
    for fn,f in files.items():
        if fn not in used: bad.append('%s/%s.tex is not \\input by both media (orphan)'%(SDIR,fn))
        t=f['text']
        for tok in ('\\label{','\\lean{','\\leanok','\\uses{','\\lbl{','\\input{'):
            if tok in t: bad.append('%s/%s.tex contains %s (wrapper / trust token inside a statement)'%(SDIR,fn,tok))
        for ref in re.findall(r'\\(?:ref|eqref|Cref)\{([^}]+)\}',t):
            if ref not in LP: bad.append('%s/%s.tex refers to %s, not a label of the paper'%(SDIR,fn,ref))
            if ref not in LB: bad.append('%s/%s.tex refers to %s, not a label of the Blueprint'%(SDIR,fn,ref))
    ncond=0
    for c in d['claims']:
        if 'conditions' not in c: continue
        ncond+=1; lab=CLAIM_LABEL.get(c['id'])
        if not lab: bad.append('claim %s has conditions but no label map (CLAIM_LABEL)'%c['id']); continue
        fn=lab.replace(':','_'); f=files.get(fn)
        if not f: bad.append('claim %s: statement file %s missing'%(c['id'],fn)); continue
        true_set={k for k,v in c['conditions'].items() if v is True}
        if true_set!=f['cond']: bad.append('claim %s: conditions %s != statement file header %s'%(c['id'],sorted(true_set),sorted(f['cond'])))
        ph=c.get('conditions_phrases',{})
        for k in sorted(true_set):
            p=ph.get(k)
            if not p: bad.append('claim %s: condition %s has no phrase'%(c['id'],k)); continue
            if p.lower() not in c['statement'].lower(): bad.append('claim %s: condition %s (%s) not in the claims statement'%(c['id'],k,p))
            tex=c.get('conditions_tex',{}).get(k)
            if tex is None: tex=BUILTIN_TEX.get(k,[p])
            if isinstance(tex,str): tex=[tex]
            if not any(x in f['text'] for x in tex): bad.append('claim %s: condition %s (%s) not in %s/%s.tex'%(c['id'],k,p,SDIR,fn))
    if ncond==0: bad.append('no claim carries a conditions block (THM_P3 must)')
    return bad,synced,len(shared),ncond
def main():
    P=open(PAPER,encoding='utf-8').read(); B=open(BP,encoding='utf-8').read(); files=read_statement_files(); d=yaml.safe_load(open(CLAIMS,encoding='utf-8'))
    if '--negctl' in sys.argv:
        res=[]
        fa=copy.deepcopy(files); assert 'an odd prime' in fa['thm_P3']['text']; fa['thm_P3']['text']=fa['thm_P3']['text'].replace('an odd prime','a prime')
        res.append(('a statement file thm_P3 "a prime"',check(P,B,fa,d)[0]))
        db=copy.deepcopy(d)
        for c in db['claims']:
            if c['id']=='THM_P3': c['statement']=c['statement'].replace('ODD prime','prime')
        res.append(('b claims THM_P3 phrase absent',check(P,B,files,db)[0]))
        Bc=B.replace('\\input{\\proofsdir/statements/thm_P3}','Let $n\\ge1$, $\\ell\\ne3$ a prime. (inline copy)',1); assert Bc!=B
        res.append(('c Blueprint thm:P3 inline text',check(P,Bc,files,d)[0]))
        fd=copy.deepcopy(files); assert 't\\ge2' in fd['thm_S0']['text']; fd['thm_S0']['text']=fd['thm_S0']['text'].replace('t\\ge2','t\\ge1')
        res.append(('d statement file thm_S0 depth range t >= 1',check(P,B,fd,d)[0]))
        fe=copy.deepcopy(files); fe['thm_P3']['cond']=fe['thm_P3']['cond']-{'ell_odd'}
        res.append(('e thm_P3 header without ell_odd',check(P,B,fe,d)[0]))
        for n,bad in res: print('NEGCTL %s :: %s'%(n,'REJECTED (correct)' if bad else 'ACCEPTED (WRONG)'))
        ok=all(b for _,b in res)
        print('STATEMENT SYNC NEGCTL: %s (%d/5 rejected)'%('PASS' if ok else 'FAIL',sum(1 for _,b in res if b)))
        if not ok: sys.exit(1)
    bad,synced,nshared,ncond=check(P,B,files,d)
    print('STATEMENT SYNC: %s (round %s; single-sourced statements %d/%d shared; statement files %d; claims with conditions %d)'%(
        'PASS' if not bad else 'FAIL '+'; '.join(bad),VER,synced,nshared,len(files),ncond))
    sys.exit(1 if bad else 0)
if __name__=='__main__': main()
