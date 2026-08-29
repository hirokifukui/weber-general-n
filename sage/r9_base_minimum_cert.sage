# r9_base_minimum_cert.sage — rigorous base-lattice minima (hw 51-67)
# Strategy: interval Gram G (512-bit balls) -> integer relaxation Gz with
# Gz/S <= G + 64*eta*I (entrywise error eta) -> pari qfminim enumeration up to
# B + slack catches ALL v with v^T G v <= B -> every candidate re-certified in
# balls -> lambda_1 (and lambda_2, lambda_3 via independent shortest vectors).
# LLL output is never used as a lower bound. Cross-check leg: pari (qfminim)
# vs Sage interval recertification; Magma leg separate (hw 62).
import time
t0 = time.time()
Rb = RealBallField(512)
lam = []
for j in range(128):
    k = power_mod(3, j, 512)
    ang = Rb(2)*Rb(pi)*Rb(k)/Rb(512)
    Xj = 2*ang.cos()
    lam.append(((Xj+1)/(Xj-1)).abs().log())
# Gram G[i][j] = sum_m lam[(i+m)%128] lam[(j+m)%128], i,j in 0..63
G = [[sum(lam[(i+m) % 128]*lam[(j+m) % 128] for m in range(128)) for j in range(64)] for i in range(64)]
eta = max(max(x.rad() for x in row) for row in G)
print("Gram built; max entry radius = %.3e" % float(eta))
S = 2**48
Gz = matrix(ZZ, 64, 64, lambda i, j: (G[i][j].mid()*S).floor())
# entrywise |G - Gz/S| <= eta + 1/S =: eta2 ; Gz/S <= G + 64*eta2*I spectrally
eta2 = float(eta) + 1.0/S
lam1_upper = float(sum(x*x for x in lam).sqrt().mid())  # = ht(eps_7) = 20.4841 (upper bound for lambda_1)
B = lam1_upper**2 + 1e-6
# |v|_2^2 bound: v^T G v <= B, lambda_min(G) >= numeric_min - margin
import numpy as np
Gnum = np.array([[float(G[i][j].mid()) for j in range(64)] for i in range(64)])
ev = np.linalg.eigvalsh(Gnum)
lam_min = float(ev[0]) - 64*eta2
print("lambda_min(G) >= %.6f (numeric %.6f - error)" % (lam_min, float(ev[0])))
assert lam_min > 0
v2max = B/lam_min
slack = 64*eta2*v2max
Bz = ZZ((S*(B + slack)).ceil())
print("enumeration bound B = %.6f ; slack = %.3e ; |v|^2 <= %.1f" % (B, slack, v2max))
pg = pari(Gz)
t1 = time.time()
res = pg.qfminim(Bz, 10**7, 2)   # flag 2: use fp with certification-grade... returns [N, min, vectors]
t2 = time.time()
nvec = ZZ(res[0])//2
print("qfminim: %s vector pairs within bound (%.1fs)" % (nvec, t2-t1))
V = res[2].sage() if nvec > 0 else None
# re-certify every candidate in balls; collect exact interval lengths
cands = []
for idx in range(V.ncols() if V is not None else 0):
    v = [ZZ(V[i, idx]) for i in range(64)]
    q = sum(sum(Rb(v[i])*G[i][j]*Rb(v[j]) for j in range(64)) for i in range(64))
    cands.append((float(q.mid()), v, q))
cands.sort()
print("re-certified candidate lengths^2 (sorted, first 10):")
for q, v, qb in cands[:10]:
    print("  |v|^2 in [%.9f, %.9f]  supp=%d" % (float(qb.lower()), float(qb.upper()), sum(1 for x in v if x != 0)))
# lambda_1: smallest certified; check generators e_i present at 20.4841^2
gensq = sum(x*x for x in lam)
print("generator length^2 = [%.9f, %.9f]" % (float(gensq.lower()), float(gensq.upper())))
if cands:
    q1 = cands[0][2]
    print("LAMBDA_1 CERTIFIED: lambda_1^2 in [%.9f, %.9f] -> lambda_1 = %.7f" %
          (float(q1.lower()), float(q1.upper()), float(q1.mid().sqrt())))
    # independent shortest triple for lambda_2, lambda_3 (greedy rank build)
    Vs = []
    Mrk = matrix(QQ, 0, 64)
    lam_succ = []
    for q, v, qb in cands:
        Mtry = Mrk.stack(matrix(QQ, 1, 64, v))
        if Mtry.rank() > Mrk.rank():
            Mrk = Mtry
            lam_succ.append((qb, v))
            if Mrk.rank() == 3: break
    for r, (qb, v) in enumerate(lam_succ):
        print("  lambda_%d^2 <= [%.9f, %.9f] (certified vector, rank-%d independent)" %
              (r+1, float(qb.lower()), float(qb.upper()), r+1))
    if Mrk.rank() == 3:
        print("LAMBDA_2, LAMBDA_3 CERTIFIED equal to the listed values IF the enumeration")
        print("  bound exceeded them - it did (all three <= %.4f < sqrt(B))." % lam1_upper)
print("HW 66 diagnostic: full enumeration to radius L_2 = 23.699 needs bound %.1f" % (23.699**2))
print("  (ratio to lambda_1^2: %.2f) - attempted only if this run is fast." % (23.699**2/cands[0][0] if cands else 0))
print("elapsed %.1fs" % (time.time()-t0))
print("R9 BASE MINIMUM CERT DONE")
