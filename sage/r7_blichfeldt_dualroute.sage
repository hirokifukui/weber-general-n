# r7_blichfeldt_dualroute.sage — two independent routes to D_7, interval-certified (r7)
# Homework 33-35, 37.
# Route DET : D_7 = 2^{32} |det W_7|            (ball determinant, as r6)
# Route SPEC: D_7^2 = det(H^T H) = prod_t mu_t  (negacyclic symbol diagonalization,
#             NEGACYCLIC_SPECTRUM_CORRECTION.md sect 3 [P]: G = H^T H is 64x64
#             negacyclic with symbol = autocorrelation r_d, r_{d+64} = -r_d;
#             eigenvalues mu_t = rhat(omega_t) at the odd 128th roots omega_t.)
# Asserts: (a) per-precision overlap of the two ln(D_7^2) enclosures;
#          (b) cross-precision nesting 1024 subset 512 subset 256 for both routes;
#          (c) three-tier threshold display: exact C_7 enclosure upper end /
#              minimal safe integer / conservative integer in use (r6 FINAL).

import sys
m = 64
CONSERVATIVE_IN_USE = 1727342163036353095979941756929  # r6 FINAL safe threshold

def lam_profile(R):
    lam = []
    for j in range(2*m):
        k = power_mod(3, j, 512)
        ang = R(2)*R(pi)*R(k)/R(512)
        Xj = 2*ang.cos()
        lam.append(((Xj+1)/(Xj-1)).abs().log())
    return lam

results = {}
for PREC in (256, 512, 1024):
    R = RealBallField(PREC)
    C = ComplexBallField(PREC)
    lam = lam_profile(R)
    # ---- route DET ----
    W = matrix(R, m, m, lambda j, i: lam[(i+j) % 128])
    detW = W.det()
    lnD2_det = 2*(R(2).log()*32 + detW.abs().log())      # ln(D_7^2) = 2 ln(2^32 |det W|)
    # ---- route SPEC ----
    r = [sum(lam[j]*lam[(j+d) % 128] for j in range(2*m)) for d in range(m)]  # autocorr
    # negacyclic check: r_{d+64} = -r_d holds by lam antiperiodicity; symbol eigenvalues
    lnD2_spec = R(0)
    posall = True
    for t in range(m):
        w = C(0, R(pi)*(2*t+1)/R(m)).exp()               # omega_t = e^{i pi (2t+1)/64}
        mu = sum(C(r[d])*w**d for d in range(m)).real()  # rhat(omega_t), real by symmetry
        posall = posall and (mu.lower() > 0)
        lnD2_spec += mu.log()
    # ---- (a) overlap ----
    ov = lnD2_det.overlaps(lnD2_spec)
    results[PREC] = (lnD2_det, lnD2_spec, ov, posall)
    print("PREC %4d  lnD2_det = [%s, %s]" % (PREC, lnD2_det.lower(), lnD2_det.upper()))
    print("PREC %4d  lnD2_spec= [%s, %s]" % (PREC, lnD2_spec.lower(), lnD2_spec.upper()))
    print("PREC %4d  eigenvalues all positive = %s ; DET/SPEC overlap = %s" % (PREC, posall, ov))
    assert posall, "FATAL: nonpositive eigenvalue interval at PREC %d" % PREC
    assert ov, "FATAL: DET and SPEC enclosures disjoint at PREC %d" % PREC

# ---- (b) nesting across precisions, both routes ----
for route, idx in (("DET", 0), ("SPEC", 1)):
    a256, a512, a1024 = results[256][idx], results[512][idx], results[1024][idx]
    n1 = (a512.lower() >= a256.lower()) and (a512.upper() <= a256.upper())
    n2 = (a1024.lower() >= a512.lower()) and (a1024.upper() <= a512.upper())
    print("NESTING %s: 512 in 256 = %s ; 1024 in 512 = %s" % (route, n1, n2))
    assert n1 and n2, "FATAL: nesting violated for route %s" % route

# ---- (c) three-tier thresholds from the sharpest (1024) DET enclosure ----
R = RealBallField(1024)
lnD2 = results[1024][0]
lnD  = lnD2/2
L7   = R(128).sqrt()*(2+R(5).sqrt()).log()
# Gamma(1 + (m+2)/2) at m = 64 is Gamma(34) = 33!  (NOT 34!: the first run's assert
# correctly caught that transcription slip; r6 values were never in doubt.)
lnC7 = (R(2)/R(pi)).log()*32 + R(ZZ(33).factorial()).log() + lnD - 64*L7.log()
C7up = lnC7.exp().upper()
C7int = ZZ(C7up.ceil())
print("C7 exact enclosure upper end  = %s" % C7up)
print("C7 minimal safe integer       = %d" % C7int)
print("C7 conservative in use (r6)   = %d" % CONSERVATIVE_IN_USE)
assert C7int <= CONSERVATIVE_IN_USE, "FATAL: in-use threshold below minimal safe integer"
print("threshold sanity: minimal <= in-use : True")
print("R7 DUALROUTE CERT DONE")
