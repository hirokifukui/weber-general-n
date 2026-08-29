# r5_full_component - P0 GATE (2026-08-23, post GPT r1 review)
# A0: demonstrate the r4 bug (det l^63) and the corrected lattice (det l^62).
# P0-2: reference implementation (all 64 generators x^j*w) vs optimized (w, xw): HNF equality.
# P0-3: det + rank asserts. NO BKZ runs until this gate passes.
import sys
l=1000000321
F=GF(l); Rp=PolynomialRing(F,'y'); y=Rp.gen()
fac=[g for g,e in (y**64+1).factor()]
fac.sort(key=lambda g: ZZ(g[0]))
assert len(fac)==32 and all(g.degree()==2 for g in fac)
Zx=PolynomialRing(ZZ,'x'); x=Zx.gen()
def center(c,ll):
    c%=ll
    return c-ll if c>ll//2 else c
def cvec(p,ll):
    c=[ZZ(cc) for cc in p.list()]; c=c+[0]*(64-len(c))
    return [center(ZZ(cc),ll) for cc in c]
npass=0
for ci,g in enumerate(fac):
    w=(y**64+1)//g
    wz=sum(ZZ(cc)*x**k for k,cc in enumerate(w.list()))
    # r4 bug demonstration (one generator only)
    rows_bug=[[l if i==j else 0 for j in range(64)] for i in range(64)]+[cvec(wz,l)]
    Mbug=matrix(ZZ,rows_bug).hermite_form(include_zero_rows=False)
    assert abs(Mbug.det())==l**63, "bug-demo det mismatch"
    # reference: ALL 64 generators x^j*w mod (x^64+1), centered mod l
    gens=[]
    for j in range(64):
        p=(x**j*wz) % (x**64+1)
        gens.append(cvec(p,l))
    assert matrix(GF(l),gens).rank()==g.degree(), "gen rank != deg f"
    rows=[[l if i==j else 0 for j in range(64)] for i in range(64)]+gens
    Mref=matrix(ZZ,rows).hermite_form(include_zero_rows=False)
    assert Mref.nrows()==64
    assert abs(Mref.det())==l**(64-g.degree()), "reference det != l^(64-deg f)"
    # optimized: w, xw only
    rows_opt=[[l if i==j else 0 for j in range(64)] for i in range(64)]+[cvec(wz,l),cvec((x*wz)%(x**64+1),l)]
    Mopt=matrix(ZZ,rows_opt).hermite_form(include_zero_rows=False)
    assert Mopt==Mref, "optimized != reference"
    npass+=1
print("P0 GATE: %d/32 components PASS  (bug-demo det=l^63 confirmed; reference det=l^62; rank=deg f; optimized==reference)" % npass)
print("R5 P0 GATE DONE")
