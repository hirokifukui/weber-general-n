#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""lint_ams_macros.py - freeze hard gate (GPT R2 finding 2).
Checks the MoC build for author-defined macros where the AMS Author Handbook forbids them:
title, abstract, section/subsection/subsubsection headings, theorem-environment optional
heads, keywords, and the bibliography actually input by the build. Also checks \\cite/\\ref
in the abstract. Run from papers/moc/. Exit 0 = clean.
  --gen-bib : regenerate bibliography_moc.tex from ../../proofs/bibliography.tex
"""
import re, sys, os

MAIN = "main_1.1.0.tex"
BIB_SRC = "../../proofs/bibliography.tex"
BIB_OUT = "bibliography_moc.tex"
MACROS = r"\\(?:Q|Z|R|F|RE|ord|hgt|Nr|covol|barT|refConst|refCert|refAppF|refDefH|artP[a-zA-Z]*|artNovelty|lbl)\b"
PAT = re.compile(MACROS)

def gen_bib():
    b = open(BIB_SRC, encoding="utf-8").read()
    for m, r in [(r"\\Q\b", r"\\mathbb{Q}"), (r"\\Z\b", r"\\mathbb{Z}"),
                 (r"\\R\b", r"\\mathbb{R}"), (r"\\F\b", r"\\mathbb{F}")]:
        b = re.sub(m, r, b)
    hdr = ("% bibliography_moc.tex - generated from proofs/bibliography.tex with author macros expanded\n"
           "% (AMS Handbook: no author-defined macros in references). Do not edit by hand; regenerate with lint_ams_macros.py --gen-bib.\n")
    open(BIB_OUT, "w", encoding="utf-8").write(hdr + b)
    print("regenerated", BIB_OUT)

def main():
    s = open(MAIN, encoding="utf-8").read()
    bad = []
    # title
    for m in re.finditer(r"\\title\[[^\]]*\]\{[^\n]*", s):
        if PAT.search(m.group(0)): bad.append(("title", m.group(0)[:100]))
    # abstract: macros, \cite, \ref
    a = s.split(r"\begin{abstract}")[1].split(r"\end{abstract}")[0]
    if PAT.search(a): bad.append(("abstract macro", PAT.search(a).group(0)))
    for t in (r"\cite", r"\ref"):
        if t in a: bad.append(("abstract " + t, t))
    # headings (heading text only, up to closing brace at depth 0)
    for m in re.finditer(r"\\(?:sub){0,2}section\*?\{", s):
        i, d = m.end(), 1
        while d and i < len(s):
            if s[i] == "{": d += 1
            elif s[i] == "}": d -= 1
            i += 1
        head = s[m.start():i]
        if PAT.search(head): bad.append(("heading", head[:100]))
    # theorem-env optional heads
    for m in re.finditer(r"\\begin\{(?:theorem|lemma|corollary|proposition|definition|remark|algorithm)\}\[[^\]]*\]", s):
        if PAT.search(m.group(0)): bad.append(("theorem head", m.group(0)[:120]))
    # keywords
    for m in re.finditer(r"\\keywords\{[^\n]*", s):
        if PAT.search(m.group(0)): bad.append(("keywords", m.group(0)[:120]))
    # bibliography actually input
    if r"\input{bibliography_moc}" in s and os.path.exists(BIB_OUT):
        b = open(BIB_OUT, encoding="utf-8").read()
        mm = PAT.search(b)
        if mm: bad.append(("bibliography", mm.group(0)))
    elif r"\input{\proofsdir/bibliography}" in s:
        bad.append(("bibliography", "build still inputs proofs/bibliography (unexpanded)"))
    for where, what in bad:
        print("FAIL [%s] %s" % (where, what))
    print("LINT", "FAIL (%d)" % len(bad) if bad else "PASS")
    sys.exit(1 if bad else 0)

if __name__ == "__main__":
    if "--gen-bib" in sys.argv:
        gen_bib()
    main()
