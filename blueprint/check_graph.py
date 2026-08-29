#!/usr/bin/env python3
r"""check_graph.py - dependency graph + EVIDENCE-PRESENCE gate + HUMAN-PROOF gate for blueprint/src/content.tex
(r14: --report lists every F/M node with its proof length; r13; GPT r10 hw 97-98, r11 hw 182-184, r12 hw 47-49: the r12 name "proof-completeness gate" over-described a check that only
asserted the PRESENCE of evidence; renamed. The human-proof gate added in r13 fails any F/M node whose proof body is not a real
proof: a body without \input{\proofsdir/...} that is shorter than 200 characters or contains only a kernel note).
Parses \begin{env}[title]\label{L} ... \uses{a,b} ... \end{env} for env in theorem/lemma/proposition/corollary/definition,
and the \begin{proof} ... \end{proof} that follows a statement. Emits DOT (blueprint/dep_graph.dot).
FAILS (exit 1) on: dangling \uses targets; \leanok without \lean; and any non-definition node that carries NONE of
  (a) a non-empty proof environment (from r13: a full proof; a bare kernel note fails the human-proof gate),
  (b) [L] in its title together with a named source (KY / MO16 / MO3 / Wash / Bl14 / Dirichlet),
  (c) [C] in its title together with a certificate/checker path,
  (d) [E] in its title together with a log path.
Definitions are exempt (they define; def:verifier is a [C] specification and is checked under (c)).
Full leanblueprint (plasTeX) rendering is a separate step (print.tex / web.tex)."""
import re,sys,os
_root=os.path.join(os.path.dirname(os.path.abspath(__file__)),'..'); sys.path.insert(0,os.path.join(_root,'tools'))
from texsrc import read_expanded   # r21: the statements are single-sourced in proofs/statements/, inlined here as LaTeX does
src=read_expanded(os.path.join(os.path.dirname(__file__),'src','content.tex'),_root)
env_re=re.compile(r'\\begin\{(theorem|lemma|proposition|corollary|definition)\}(\[[^\]]*(?:\{[^}]*\}[^\]]*)*\])?\\label\{([^}]+)\}(.*?)\\end\{\1\}',re.S)
proof_re=re.compile(r'\\begin\{proof\}(.*?)\\end\{proof\}',re.S)
nodes={}; order=[]; dup=[]
# r19 (hw 917-921, 978): a label defined twice silently MERGES two nodes (r18: the two lem:mo25 lemmas became one node, and LaTeX
# resolved every \ref to the last definition, so the Z_2 Lemma A+ pointed at the Z_3 floor in the PDF). Duplicate labels FAIL.
all_labels=re.findall(r'\\label\{([^}]+)\}',src)
for l in sorted(set(all_labels)):
    if all_labels.count(l)>1: print("DUPLICATE LABEL (%d definitions): %s"%(all_labels.count(l),l)); dup.append(l)
for m in env_re.finditer(src):
    env,title,lab,body=m.group(1),m.group(2) or '',m.group(3),m.group(4)
    uses=[u.strip() for mm in re.finditer(r'\\uses\{([^}]*)\}',body) for u in mm.group(1).split(',') if u.strip()]
    # the proof that follows this statement (before the next statement env)
    nxt=env_re.search(src,m.end()); tail=src[m.end():nxt.start() if nxt else len(src)]
    pm=proof_re.search(tail); proof=(pm.group(1).strip() if pm else '')
    if lab in nodes: print("DUPLICATE NODE LABEL (would merge): %s"%lab); dup.append(lab)
    nodes[lab]=dict(env=env,title=title,uses=uses,leanok='\\leanok' in body or '\\leanok' in proof,lean=bool(re.search(r'\\lean\{',body)),proof=proof,body=body)
    order.append(lab)
bad=1 if dup else 0
for lab,n in nodes.items():
    for u in n['uses']:
        if u not in nodes: print("DANGLING: %s uses %s"%(lab,u)); bad=1
    if n['leanok'] and not n['lean']: print("LEANOK WITHOUT LEAN: %s"%lab); bad=1
    if n['env']=='definition' and '[C]' not in n['title']: continue
    t=n['title']; b=n['body']; ok=None
    if len(n['proof'])>0: ok='proof'
    # r13 human-proof gate: every F / M node must carry a real proof body, not a kernel-checked note
    if re.search(r'\[(F|M)',t) and n['env']!='definition':
        pr=n['proof']
        if ('\\input{' not in pr) and (len(pr)<200 or re.search(r'[Kk]ernel-checked as stated',pr)):
            print("HUMAN-PROOF MISSING (kernel note only): %s (%s)"%(lab,t[:60])); bad=1
    elif '[L]' in t and re.search(r'\b(KY|MO16|MO3|Wash|Bl14|Dirichlet|Ram04|Rob55|MO13|Ho02|Ho05a|Ho05b|Mo12|Sch73)\b',b): ok='citation'
    elif '[C]' in t and re.search(r'[A-Za-z0-9_\\]+(/|\\_)[A-Za-z0-9_\\/.]+\.(txt|log|sage|py|yaml)|certificates/|scripts/|sage/',b): ok='certificate'
    elif '[E]' in t and re.search(r'\.log',b): ok='experiment-log'
    if ok is None: print("NO PROOF / CITATION / CERTIFICATE / LOG: %s (%s)"%(lab,t[:60])); bad=1
used=set(u for n in nodes.values() for u in n['uses'])
orph=[l for l,n in nodes.items() if l not in used and not n['uses']]
for l in orph: print("ORPHAN (unused, uses nothing): %s"%l)
with open(os.path.join(os.path.dirname(__file__),'dep_graph.dot'),'w') as f:
    f.write('digraph blueprint {\nrankdir=BT;\n')
    for l,n in nodes.items():
        col='green' if n['leanok'] else ('lightblue' if n['lean'] else ('lightyellow' if n['proof'] else 'white'))
        f.write('"%s" [style=filled,fillcolor=%s];\n'%(l,col))
        for u in n['uses']: f.write('"%s" -> "%s";\n'%(u,l))
    f.write('}\n')
# r14 --report (GPT r13 hw 474-483, 96-97): every F / M node with its proof source and prose length; short proofs are WARNINGS,
# not gate failures. The report is written to docs/BLUEPRINT_PROOF_REPORT_1.0.0.md (generated; do not edit). The gates above assert
# the PRESENCE of evidence and of a real proof body; neither the completeness nor the correctness of a prose proof is checked here.
if '--report' in sys.argv:
    SHORT=800; rows=[]; nshort=0
    proofsdir=os.path.join(os.path.dirname(os.path.abspath(__file__)),'..','proofs')
    for lab in order:
        n=nodes[lab]; t=n['title']; lb=re.search(r'\[(F|C|L|M|E)[^\]]*\]',t); label=lb.group(1) if lb else '-'
        if n['env']=='definition' and label=='-': continue
        pr=n['proof']; m=re.search(r'\\input\{\\proofsdir/([^}]+)\}',pr)
        if m:
            f=os.path.join(proofsdir,m.group(1)+('.tex' if not m.group(1).endswith('.tex') else '')); src_='proofs/'+m.group(1)+'.tex'
            plen=len(open(f,encoding='utf-8').read()) if os.path.exists(f) else -1
        else: src_='inline' if pr else '-'; plen=len(pr)
        flag=''
        if label in ('F','M'):
            if plen<SHORT: flag='SHORT (<%d chars)'%SHORT; nshort+=1
        rows.append((lab,label,src_,plen,flag,t[:70].replace('|','/')))
    out=['# BLUEPRINT_PROOF_REPORT_1.0.0 — generated by blueprint/check_graph.py --report (do not edit)','',
         'Every non-definition node of blueprint/src/content.tex with its trust label, proof source and prose length (characters of the',
         'proofs/*.tex file, or of the inline proof body). F/M nodes shorter than %d characters are flagged SHORT — a WARNING for the'%SHORT,
         'human review (GPT r13 hw 89, 96-98), not a gate failure. Presence of a proof body is the gate; completeness and correctness of',
         'the prose are NOT machine-checked (the Blueprint is the human-readable proof; the kernel checks only the F declarations).','',
         '| node | label | proof source | chars | flag | title |','|---|---|---|---|---|---|']
    out+=['| %s | %s | %s | %d | %s | %s |'%r for r in rows]
    nF=sum(1 for r in rows if r[1]=='F'); nM=sum(1 for r in rows if r[1]=='M')
    out+=['','F nodes %d ; M nodes %d ; F/M nodes with SHORT prose %d (warning)'%(nF,nM,nshort)]
    rp=os.path.join(os.path.dirname(os.path.abspath(__file__)),'..','docs','BLUEPRINT_PROOF_REPORT_1.0.0.md')
    open(rp,'w',encoding='utf-8').write('\n'.join(out)+'\n')
    print('PROOF REPORT: F %d ; M %d ; SHORT %d (warning) ; written docs/BLUEPRINT_PROOF_REPORT_1.0.0.md'%(nF,nM,nshort))
    if nshort: print('WARNING: %d F/M nodes have prose proofs shorter than %d characters (see the report)'%(nshort,SHORT))
nproof=sum(1 for n in nodes.values() if n['proof']); ninput=sum(1 for n in nodes.values() if '\\input{' in n['proof'])
print("nodes %d ; leanok %d ; lean-tagged %d ; edges %d ; orphans %d ; proofs %d (single-source \\input %d) ; EVIDENCE-PRESENCE + HUMAN-PROOF %s"%(len(nodes),sum(n['leanok'] for n in nodes.values()),sum(n['lean'] for n in nodes.values()),sum(len(n['uses']) for n in nodes.values()),len(orph),nproof,ninput,'PASS' if not bad else 'FAIL'))
sys.exit(bad)
