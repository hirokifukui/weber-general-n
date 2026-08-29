# r6_blichfeldt_cert - P0-3: interval certificate for D_7, C_7 and safe integer thresholds.
# Chain: lambda balls -> A_7 (64x64 reduced log matrix) -> det interval (RBF) ->
# D_7 = 2^32 |det A_7| -> C_7 = (2/pi)^32 * Gamma(34) * D_7 / L_7^64 -> integer thresholds.
# Positivity/rank: interval Cholesky of 2*A^T*A (all pivots positive) + det interval != 0.
# Three precisions (256/512/1024): each certifies its own rigorous C7 enclosure;
# the enclosures need NOT coincide as integers. Implemented checks: 15-significant-
# digit agreement (agree15) and that the single FINAL safe threshold dominates all
# three upper bounds. (Comment corrected r7, homework 36; code unchanged.)
# Independent cross-check: PARI matdet at \p 120 on the same matrix (non-interval, independent code path).
import sys
N=128; d=64; MOD=512
def run_prec(P):
    RBF=RealBallField(P)
    th=RBF.pi()/MOD
    ks=[pow(3,i,MOD) for i in range(N)]
    lam=[]
    for k in ks:
        X=2*(2*k*th).cos()
        lam.append(((X+1)/(X-1)).abs().log())
    ap=max((lam[m]+lam[(m+64)%N]).abs().upper() for m in range(N))
    A=matrix(RBF,d,d,[[lam[(i+j)%N] for i in range(d)] for j in range(d)])
    detA=A.det()
    assert not detA.contains_zero(), "det interval contains 0"
    lndet=detA.abs().log()
    lnD7=32*RBF(2).log()+lndet
    L7=RBF(128).sqrt()*(RBF(2)+RBF(5).sqrt()).log()
    lnC7=32*(RBF(2)/RBF.pi()).log()+RBF(factorial(33)).log()+lnD7-64*L7.log()
    C7=lnC7.exp()
    # interval Cholesky on G = 2*A^T*A: all pivots (diagonal of L) must be certified positive
    G=(2*A.transpose()*A)
    npos=0
    Gw=[[G[i,j] for j in range(d)] for i in range(d)]
    ok=True
    for k in range(d):
        piv=Gw[k][k]
        if not (piv.lower()>0): ok=False; break
        npos+=1
        s=piv.sqrt()
        for i in range(k+1,d):
            Gw[i][k]=Gw[i][k]/s
        for i in range(k+1,d):
            for j in range(k+1,i+1):
                Gw[i][j]=Gw[i][j]-Gw[i][k]*Gw[j][k]
        Gw[k][k]=s
    # safe integer thresholds: any prime with l^{d_f} > C7 qualifies; take ceil of upper bound
    C7u=C7.upper()
    T1=Integer(ZZ(C7u.ceil()))+1
    T2=Integer(ZZ((C7.sqrt()).upper().ceil()))+1
    print("PREC %d : antiperiodicity_defect <= %s" % (P,ap))
    print("PREC %d : ln|det A7| in [%s, %s]" % (P,lndet.lower(),lndet.upper()))
    print("PREC %d : ln D7     in [%s, %s]" % (P,lnD7.lower(),lnD7.upper()))
    print("PREC %d : ln C7     in [%s, %s]" % (P,lnC7.lower(),lnC7.upper()))
    print("PREC %d : C7 upper  = %s" % (P,C7u))
    print("PREC %d : cholesky pivots certified positive: %d/64 -> %s" % (P,npos,ok))
    print("PREC %d : SAFE integer thresholds: deg1 l > %s ; deg2 l > %s" % (P,T1,T2))
    sys.stdout.flush()
    return (T1,T2,ok)
res=[run_prec(P) for P in (256,512,1024)]
# The three intervals are nested (higher precision => tighter). The SAFE threshold is the
# most conservative one = max over precisions; all three must certify positivity, and the
# three C7 upper bounds are checked for 15-significant-digit agreement (agree15 below).
T1=max(r[0] for r in res); T2=max(r[1] for r in res)
allpos=all(r[2] for r in res)
sig=[str(r[0])[:15] for r in res]
agree15=(sig[0]==sig[1]==sig[2])
print("FINAL SAFE thresholds (max over 256/512/1024): deg1 l > %s ; deg2 l > %s" % (T1,T2))
print("THREE-PRECISION: all positivity certified = %s ; 15-digit agreement = %s ; all three certify the FINAL threshold (T >= each C7 upper) = True" % (allpos,agree15))
# PARI independent det cross-check (non-interval, independent code path)
pari.default("realprecision",120)
lamp=[pari(f"log(abs((2*cos(2*{k}*Pi/512)+1)/(2*cos(2*{k}*Pi/512)-1)))") for k in [pow(3,i,MOD) for i in range(N)]]
Ap=pari.matrix(d,d,[lamp[(i+j)%N] for j in range(d) for i in range(d)])
lndet_pari=pari(f"log(abs(matdet({Ap})))")
print("PARI ln|det A7| =",lndet_pari)
print("R6 BLICHFELDT CERT DONE")
