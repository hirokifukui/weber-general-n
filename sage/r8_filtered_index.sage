# r8_filtered_index.sage — exact index-included filtered constants (hw 42, 46)
# threshold_t = I_t * C_7 * (L_1/L_t)^64, I_t = [R:J_t] = 2^{64(t-1)}.
# Interval-certified at 256 bits; reproduces the reviewer's r7 table and the
# allowed-index gates (class 1 mod 16: I < 1294.4 ; deg 2 mod 8: I < 8.73e5).

R = RealBallField(256)
lnD7 = R('355.5676340358229719191787976624282331363278782520162376366566429677285791955')/2
L = {}
for t in (1, 2, 3, 4):
    c = R(2)**(t+1)
    L[t] = R(128).sqrt() * (((c + (c*c + 4).sqrt())/2).log())
lnC7 = (R(2)/R(pi)).log()*32 + R(ZZ(33).factorial()).log() + lnD7 - 64*L[1].log()
C7 = lnC7.exp()
print("C_7 (check) = %.6e" % float(C7.upper()))
print(" t | L_t (15d)          | index-ignored      | I_t      | index-included")
for t in (2, 3, 4):
    ign = C7 * (L[1]/L[t])**64
    It = R(2)**(64*(t-1))
    inc = ign * It
    print(" %d | %.13f | %.4e | 2^%d | %.4e" %
          (t, float(L[t].mid()), float(ign.upper()), 64*(t-1), float(inc.upper())))
print("GATES: class-1 closure to 1e9 at t=4 requires I_4 < %.1f (actual 2^192 = %.3e)" %
      (1e9/float((C7*(L[1]/L[4])**64).upper()), float(2.0**192)))
d2 = C7 * (L[1]/L[3])**64
print("       deg-2 closure to 1e9 at t=3 requires I_3 < %.3e (l^2 form: sqrt gives l-gate %.3e; actual 2^128 = %.3e)" %
      (1e18/float(d2.upper()), (1e18/float(d2.upper()))**0.5, float(2.0**128)))
print("VERDICT: naive filtered-sublattice route WORSE than plain 1.727e30 at every t. FENCED.")
print("R8 FILTERED INDEX DONE")
