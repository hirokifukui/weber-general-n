# r7_smallring_cls65.sage — cls65 32-dim small-ring certification (homework 44-46)
# Lattice: Lambda' = (1/l) H_7 iota(L^even), iota: Z[y]/(y^32+1) -> Z[x]/(x^64+1),
# g(y) |-> g(x^2). For l = 65 mod 128 every irreducible factor is f = x^2 + a and
# w = (x^64+1)/f is an EVEN polynomial, so M_f cap (even) = span{w}: the even
# preimage L^even has index l^31 in Z^32 and covol(Lambda') = D65 / l with
# D65 = sqrt(det G'), G'_{ik} = r_{2(i-k)} (32x32 negacyclic, even-lag autocorr).
# Blichfeldt in dim 32 then excludes l | k_7 for l > C65 :=
#   (2/pi)^16 * Gamma(18) * D65 / L_7^32          [LINEAR in l - the whole point]
# Dual route: negacyclic symbol at odd 64th roots. Three precisions + nesting.
# Also: homework 79 ladder (class-1 thresholds at height floors h).

m2 = 32
results = {}
for PREC in (256, 512, 1024):
    R = RealBallField(PREC)
    C = ComplexBallField(PREC)
    lam = []
    for j in range(128):
        k = power_mod(3, j, 512)
        ang = R(2)*R(pi)*R(k)/R(512)
        Xj = 2*ang.cos()
        lam.append(((Xj+1)/(Xj-1)).abs().log())
    # even-lag autocorrelation r_{2d}
    r2 = [sum(lam[j]*lam[(j+2*d) % 128] for j in range(128)) for d in range(m2)]
    # negacyclic sanity: r_{2(d+32)} = -r_{2d}
    neg_ok = True
    for d in range(m2):
        lhs = sum(lam[j]*lam[(j+2*d+64) % 128] for j in range(128))
        neg_ok = neg_ok and float((lhs + r2[d]).abs().upper()) < 2.0**(-(PREC//2))
    # route DET: Gram G'_{ik} = r_{2(i-k)} with negacyclic sign
    def gram(i, k):
        d = (i - k) % 64
        if d < 32: return r2[d]
        return -r2[d-32]
    G = matrix(R, m2, m2, lambda i, k: gram(i, k))
    detG = G.det()
    lnD2_det = detG.abs().log()          # ln(D65^2) = ln det G'
    # route SPEC: mu_t = sum_d r_{2d} omega^d at omega = e^{i pi (2t+1)/32}
    lnD2_spec = R(0); posall = True
    for t in range(m2):
        w = C(0, R(pi)*(2*t+1)/R(m2)).exp()
        mu = sum(C(r2[d])*w**d for d in range(m2)).real()
        posall = posall and (mu.lower() > 0)
        lnD2_spec += mu.log()
    ov = lnD2_det.overlaps(lnD2_spec)
    results[PREC] = (lnD2_det, lnD2_spec)
    print("PREC %4d  negacyclic r2 check = %s" % (PREC, neg_ok))
    print("PREC %4d  lnD65^2 det  = [%s, %s]" % (PREC, lnD2_det.lower(), lnD2_det.upper()))
    print("PREC %4d  lnD65^2 spec = [%s, %s]" % (PREC, lnD2_spec.lower(), lnD2_spec.upper()))
    print("PREC %4d  all mu positive = %s ; overlap = %s" % (PREC, posall, ov))
    assert neg_ok and posall and ov

for route, idx in (("DET", 0), ("SPEC", 1)):
    a256, a512, a1024 = results[256][idx], results[512][idx], results[1024][idx]
    n1 = (a512.lower() >= a256.lower()) and (a512.upper() <= a256.upper())
    n2 = (a1024.lower() >= a512.lower()) and (a1024.upper() <= a512.upper())
    print("NESTING %s: 512 in 256 = %s ; 1024 in 512 = %s" % (route, n1, n2))
    assert n1 and n2

# C65 from the sharpest enclosure
R = RealBallField(1024)
lnD = results[1024][0]/2
L7 = R(128).sqrt()*(2+R(5).sqrt()).log()
lnC65 = (R(2)/R(pi)).log()*16 + R(ZZ(17).factorial()).log() + lnD - 32*L7.log()
C65 = lnC65.exp()
print("C65 enclosure = [%s, %s]" % (C65.lower(), C65.upper()))
print("C65 upper ~ %.6e" % float(C65.upper()))
print("provisional r6 value 2.65e12: %s" % (
  "VERIFIED (same order, exact value above supersedes)" if 1.0e12 < float(C65.upper()) < 8.0e12
  else "RETRACT provisional; certified value differs materially"))
print("MO fixed-layer cls65 (d=32): 7.71569554400e12 ; ours-linear C65 vs MO: factor %.4f" %
      (7.71569554400e12/float(C65.upper())))
print("big-ring deg-2 threshold (l^2 > C_7): l > 1.315e15 ; small-ring linear beats it for cls65: %s" %
      (float(C65.upper()) < 1.315e15))

# homework 79 ladder: class-1 thresholds under height floor h
C7 = R('1.7273421630363531e30')
base = R('16.332871')
print("LADDER (79): class-1 threshold C_7 * (16.3329/h)^64")
for h in ('20', '25', '25.367', '30', '32', '35.067'):
    th = C7 * (base/R(h))**64
    print("  h >= %-7s -> threshold %.4e" % (h, float(th.upper())))
print("R7 SMALLRING CLS65 CERT DONE")
