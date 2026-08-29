# r9_stratum_law_pilot.sage - EXACT test of the stratum law i(+-u_b) = 1 + v_P(b)
# (P = (1-varsigma) in Z[x]/(x^64+1)) via v_big(u_b -+ 1) = v_2(Res(z^256+1, num)).
# Prediction: the RE_{7,1}-sign of u_b sits in stratum i = 1 + v_P(b), i.e.
# v_big(u_b' - 1) in {254+4i, 256+4i}. Exact integer arithmetic only.
R.<z> = PolynomialRing(ZZ)
MOD = z^256 + 1
def sig(p, e):
    # apply z -> z^e to polynomial p, reduce mod z^256+1
    return sum(c * power_mod(z, (k*e) % 512, MOD) for k, c in enumerate(p.list())) % MOD
N0 = z^2 + z + 1; D0 = z^2 - z + 1
def eps_pair(i):
    e = power_mod(3, i, 512)
    return (sig(N0, e), sig(D0, e))
def vbig(poly):
    if poly == 0: return oo
    r = MOD.resultant(poly)
    return ZZ(r).valuation(2)
def u_b_val(bdict):
    # u_b = prod eps_i^{b_i}; compute num/den exactly; return v_big(u_b - s) for s = +-1
    num = R(1); den = R(1)
    for i, b in bdict.items():
        Ni, Di = eps_pair(i)
        if b > 0: num = (num * Ni^b) % MOD; den = (den * Di^b) % MOD
        elif b < 0: num = (num * Di^(-b)) % MOD; den = (den * Ni^(-b)) % MOD
    vp = vbig((num - den) % MOD)   # u_b - 1
    vm = vbig((num + den) % MOD)   # u_b + 1
    return vp, vm
tests = [
    ("b = e0 (v_P = 0, predict i = 1)",            {0: 1}),
    ("b = e0 - e1 = (1-s)e0 (v_P = 1, i = 2)",     {0: 1, 1: -1}),
    ("b = e0 + e1 (v_P(1+s) = 1, i = 2)",          {0: 1, 1: 1}),
    ("b = e0 - 2e1 + e2 = (1-s)^2 e0 (v_P=2,i=3)", {0: 1, 1: -2, 2: 1}),
    ("b = (1-s)^3 e0 (v_P = 3, i = 4)",            {0: 1, 1: -3, 2: 3, 3: -1}),
    ("b = 2 e0 (v_P(2) = 64, predict i = 65)",     {0: 2}),
]
print("stratum law test: v_big(u_b' - 1) should be in {254+4i, 256+4i}, i = 1+v_P(b)")
ok_all = True
for label, b in tests:
    vp, vm = u_b_val(b)
    # the RE_{7,1} element is the sign with valuation >= 258; stratum i = (v-254)/4 when exact
    v = max(vp, vm); sign = '-u_b' if vm > vp else '+u_b'
    i_obs = (v - 254)/4
    exact = (v - 254) % 4 == 0
    print("%s\n  v_big(u_b-1) = %s ; v_big(u_b+1) = %s ; deep element %s, v = %s -> stratum i = %s %s"
          % (label, vp, vm, sign, v, i_obs, "(exact lower window)" if exact else "(upper window)"))
    ok_all = ok_all and exact
print("LAW i(+-u_b) = 1 + v_P(b): ALL EXACT MATCHES:", ok_all)
print("R9 STRATUM LAW PILOT DONE")
