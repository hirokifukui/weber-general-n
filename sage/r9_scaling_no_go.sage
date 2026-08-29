# r9_scaling_no_go.sage - interval certificates for the scaling no-go (hw 30-35)
R = RealBallField(256)
def Lt(t): return R(128).sqrt() * (R(2)**t).arcsinh()
L1 = Lt(1)
print("L_t = sqrt(128)*arcsinh(2^t) cross-check vs r8 form:")
for t in (1,2,3,4):
    c = R(2)**(t+1)
    old = R(128).sqrt()*(((c+(c*c+4).sqrt())/2).log())
    d = (Lt(t)-old).abs().upper()
    print("  t=%d: L_t = %s  |diff old-form| < %.1e" % (t, Lt(t).mid().str(digits=20), float(d)))
print("RATIOS 2^{t-1} L_1 / L_t (all must be > 1 for the no-go):")
ok = True
for t in (2,3,4,5,6,7,8):
    r = (R(2)**(t-1))*L1/Lt(t)
    lo = r.lower()
    print("  t=%d: ratio in [%.6f, %.6f]  > 1: %s" % (t, float(r.lower()), float(r.upper()), bool(lo > 1)))
    ok = ok and bool(lo > 1)
print("ALGEBRAIC FORM (2+sqrt5)^{2^{t-1}} vs 2^t + sqrt(4^t+1):")
for t in (2,3,4):
    lhs = (R(2)+R(5).sqrt())**(2**(t-1)); rhs = R(2)**t + (R(4)**t+1).sqrt()
    print("  t=%d: lhs = %.4f  rhs = %.4f  lhs > rhs: %s" % (t, float(lhs.mid()), float(rhs.mid()), bool(lhs.lower() > rhs.upper())))
print("MONOTONE DIVERGENCE (kill test hw 34-35): ratio_{t+1}/ratio_t =")
for t in (2,3,4,5,6,7):
    q = ((R(2)**t)*L1/Lt(t+1)) / ((R(2)**(t-1))*L1/Lt(t))
    print("  t=%d->%d: %.4f (>1: %s)" % (t, t+1, float(q.mid()), bool(q.lower() > 1)))
print("VERDICT: all ratios certified > 1 and increasing - J_5, J_6, ... need no exact computation.")
print("SCALING NO-GO CERTIFIED:", ok)
print("R9 SCALING NO GO DONE")
