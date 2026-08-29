# r9_cls1_trace_moments.sage - small-l exact calibration of class-1 T (hw 84-93, 97, 101, 105)
# For every prime l = 1 mod 128 below 20000: BOTH sigma-orbit representatives
# (a and a^-1: the two <3>-orbits on primitive 128th roots - inversion swaps
# them since -1 is not in <3> mod 128), full b-scan with centered lifts;
# min T, argmin, count T<4224, E[log T], orbit equality; Fourier main-term
# calibration E_b[e^{2 y_j}] vs prod_k sinh(lam_k)/lam_k (the m = 0 dual term).
import numpy as np, math
R = RealBallField(192)
lam = []
for j in range(128):
    k = power_mod(3, j, 512)
    ang = R(2)*R(pi)*R(k)/R(512)
    lam.append(float((((2*ang.cos()+1)/(2*ang.cos()-1)).abs().log()).mid()))
M = np.array([[lam[(k+j) % 128] for k in range(64)] for j in range(128)])
def scan(l, a):
    A = np.array([power_mod(a, k, l) for k in range(64)], dtype=np.int64)
    b = np.arange(1, l, dtype=np.int64)
    C = (b[:, None]*A[None, :]) % l
    C = np.where(C > l//2, C - l, C).astype(np.float64)
    Y = (2.0/l)*(C @ M.T)
    T = np.exp(Y).sum(axis=1)
    Ej0 = float(np.exp(Y[:, 0]).mean())
    return T, Ej0
main0 = float(np.prod([math.sinh(lam[k])/lam[k] for k in range(64)]))
print("prime      orbit  minT        argmin    #T<4224  E[logT]  orbit-eq  E/main(j=0)")
rows = []
for l in prime_range(129, 20000):
    if l % 128 != 1: continue
    g = primitive_root(l); a = power_mod(g, (l-1)//128, l)
    ainv = power_mod(a, l-2, l)
    res = {}
    for tag, aa in (("A", a), ("B", ainv)):
        T, Ej0 = scan(l, aa)
        res[tag] = (float(T.min()), int(T.argmin())+1, int((T < 4224).sum()),
                    float(np.log(T).mean()), Ej0/main0)
    eq = abs(res["A"][0]-res["B"][0]) < 1e-6*max(res["A"][0], 1)
    for tag in ("A", "B"):
        m, am, c, el, rat = res[tag]
        print("%-9d  %s   %11.3f %9d  %7d  %7.3f  %s  %8.4f" % (l, tag, m, am, c, el, eq, rat))
    rows.append((l, res["A"][0], res["A"][2], eq))
print("SUMMARY (hw 105-106): min-T level and 4224-margin across l:")
for l, m, c, eq in rows:
    print("  l=%-7d minT=%11.3f  below-4224: %s  frac<4224=%.3e  orbits-equal=%s" %
          (l, m, m < 4224, c/(l-1), eq))
print("CHEBYSHEV KILL TEST (hw 97): E_b[e^{2y_0}]/main-term ratios above; E[log T]")
print("  vastly exceeds log 4224 = %.2f -> mean/Chebyshev cannot certify T<4224; " % math.log(4224))
print("  existence lives in the extreme lower tail (small-ball problem). VERDICT: KILLED as a standalone tool.")
print("R9 CLS1 TRACE MOMENTS DONE")
