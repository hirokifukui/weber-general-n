#!/usr/bin/env python3
"""texsrc.py (r21; GPT r20 P1 = hw 1070-1083) -- one helper for every gate that reads the paper or the Blueprint as TEXT.
Since r21 the 38 shared theorem statements are single-sourced in proofs/statements/<label>.tex and both media only carry
`\\input{\\proofsdir/statements/<label>}` inside their theorem environments. A gate that greps a printed number / citation key /
certificate path in the paper or the Blueprint must therefore read the medium WITH its statements inlined, exactly as LaTeX does.
expand_statements(text, root) replaces each such \\input by the statement file's content (header comment lines stripped); the
proof \\inputs (proofs/*.tex) are left alone, so a gate that treats proofs separately keeps its semantics. Nothing is written."""
import re,os
_PAT=re.compile(r'\\input\{\\proofsdir/statements/([^}]+)\}')
def expand_statements(text, root='.'):
    def rep(m):
        p=os.path.join(root,'proofs','statements',m.group(1)+'.tex')
        if not os.path.exists(p): return m.group(0)
        s=open(p,encoding='utf-8').read()
        s=re.sub(r'(?m)^%.*\n?','',s)
        return s.strip()
    return _PAT.sub(rep,text)
def read_expanded(path, root='.', errors='strict'):
    return expand_statements(open(path,encoding='utf-8',errors=errors).read(), root)
