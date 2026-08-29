# r7_rederive_review.sage — independent re-derivation of GPT r6-review numerics [H]->check
# Discipline: nothing copied as fact; each value re-derived from the stated formula.
# Log: sage/r7_rederive_review.log (tee at launch).
# Formula under test (GPT-quoted MO fixed-layer, pre d->c substitution):
#   l <= [ 2 * (sqrt(pi) / (sqrt(2)*log(2+sqrt(5))))^d * ((d+2)/2)! ]^(1/f)

R = RealField(200)
lg = log(R(2)+sqrt(R(5)))          # log(2+sqrt5)
base = sqrt(R(pi)) / (sqrt(R(2))*lg)

def mo_fixed(d,f):
    return ( R(2) * base^d * factorial((d+2)//2) )^(R(1)/f)

print("== MO fixed-layer re-derivation (formula as quoted) ==")
for (cls,d,f) in [("65",32,1),("63/127",64,2),("1",64,1)]:
    v = mo_fixed(d,f)
    print("class %-6s (d,f)=(%2d,%d): l <= %s" % (cls,d,f,v.str(digits=15)))

print()
print("== comparison ratios vs R6 Blichfeldt thresholds ==")
C7 = R(1.7273421630363531e30)      # our certified upper bound (from r6_blichfeldt_cert.log)
thr_deg2 = sqrt(C7)
print("C7^(1/2) (deg-2 threshold) = %s (log claims 1.314283897427172e15)" % thr_deg2.str(digits=16))
mo65  = mo_fixed(32,1); mo63 = mo_fixed(64,2); mo1 = mo_fixed(64,1)
print("cls65 : R6/MO = %s  (GPT: R6 ~170x WORSE)" % (thr_deg2/mo65).str(digits=6))
print("cls63 : MO/R6 = %s  (GPT: ~34.4x improvement)" % (mo63/thr_deg2).str(digits=6))
print("cls1  : MO/R6 = %s  (GPT: ~1183x improvement)" % (mo1/C7).str(digits=6))

print()
print("== improvement factors and target heights ==")
f1  = (C7/R(1e9))^(R(1)/64)
f2  = (C7/R(1e18))^(R(1)/64)
L7  = sqrt(R(128))*lg
print("(C7/1e9)^(1/64)  = %s  (GPT: 2.147)" % f1.str(digits=8))
print("(C7/1e18)^(1/64) = %s  (GPT: 1.553)" % f2.str(digits=8))
print("L7 = sqrt(128)*log(2+sqrt5) = %s  (GPT: 16.333)" % L7.str(digits=8))
print("target ht cls1  = L7*f1 = %s  (GPT: 35.1)" % (L7*f1).str(digits=6))
print("target ht deg2  = L7*f2 = %s  (GPT: 25.4)" % (L7*f2).str(digits=6))
print("Blichfeldt coeff ratio 3.0137/f1 = %s  (GPT: 1.404)" % (R(3.0137)/f1).str(digits=6))

print()
print("== crude prime counts in open windows (x/log x, per residue class /64) ==")
for (cls,hi) in [("65",R(7.8e12)),("63o127 each",R(1.315e15)),("1",C7)]:
    est = (hi/log(hi))/64
    print("class %-12s window (1e9,%s]: ~%s primes" % (cls,hi.str(digits=4),est.str(digits=4)))

print()
print("R7 REDERIVE DONE")
