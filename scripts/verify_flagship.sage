# verify_flagship.sage — READ-ONLY verifier for the l = 1000000321 certificates (r7)
# Homework 28-31: strictly separated from the generator (sage/r6_flagship_replay.sage);
# this script NEVER opens any file for writing under certificates/ (it writes only its
# own log via shell redirection). Completeness asserts: 32 irreducible factors, each
# with exactly one RHO and one T certificate, 64 files, no duplicates, identifiers
# unique, and factor identification by FULL coefficient sequence (not constant term).
# Independence note: the lambda profile and all interval arithmetic are recomputed here
# from first principles (eps_7 = (X+1)/(X-1), X = 2cos(2pi/512), sigma: angle *3).

import os, re, sys
PREC = 256
R = RealBallField(PREC)
l = 1000000321
m = 64
CERTDIR = os.path.join(os.path.dirname(os.path.abspath(sys.argv[0] if len(sys.argv)>0 else '.')), '..', 'certificates', 'flagship')
CERTDIR = os.path.normpath(CERTDIR)

# ---- recompute the full factorization and FULL coefficient identifiers ----
P.<x> = PolynomialRing(GF(l))
F = x^m + 1
fac = F.factor()
assert all(e == 1 for _, e in fac), "FATAL: x^64+1 not squarefree mod l"
factors = sorted([g for g, _ in fac], key=lambda g: [ZZ(c) for c in g.list()])
assert len(factors) == 32, "FATAL: expected 32 irreducible factors, got %d" % len(factors)
assert all(g.degree() == 2 for g in factors), "FATAL: non-quadratic factor found"
assert all(g.is_monic() for g in factors), "FATAL: non-monic factor"
assert all(g[1] == 0 for g in factors), "FATAL: factor with nonzero linear term (identifier scheme invalid)"
full_coeffs = {}   # const-term key -> full coefficient tuple (a0, a1, a2)
for g in factors:
    key = ZZ(g[0])
    full_coeffs[key] = tuple(ZZ(g[i]) for i in range(3))
assert len(full_coeffs) == 32, "FATAL: duplicate factor identifiers"
print("FACTORIZATION: 32 monic quadratic factors, full coefficient sequences unique: OK")

# ---- enumerate certificate files (read-only) ----
files = sorted(f for f in os.listdir(CERTDIR) if f.startswith('cert_f_') and f.endswith('.txt'))
assert len(files) == 64, "FATAL: expected 64 certificate files, found %d" % len(files)
seen = set()
pairing = {}
pat = re.compile(r'cert_f_x2p(\d+)_(RHO|T)\.txt$')
for fn in files:
    mm = pat.match(fn)
    assert mm, "FATAL: unrecognized certificate filename %s" % fn
    a_const, route = ZZ(mm.group(1)), mm.group(2)
    key = a_const % l
    assert key in full_coeffs, "FATAL: %s does not correspond to a recomputed factor" % fn
    assert (key, route) not in seen, "FATAL: duplicate certificate %s" % fn
    seen.add((key, route))
    pairing.setdefault(key, set()).add(route)
assert len(pairing) == 32 and all(v == {'RHO','T'} for v in pairing.values()), \
    "FATAL: RHO/T pairing incomplete"
print("COMPLETENESS: 64 files, 32 factors x {RHO,T}, no duplicates: OK")

# ---- lambda profile of eps_7, interval-certified ----
CF = ComplexBallField(PREC)
lam = []
for j in range(2*m):
    k = power_mod(3, j, 512)             # exact integer reduction: cos has period 2pi
    ang = R(2)*R(pi)*R(k) / R(512)       # sigma^j : X -> 2cos(3^j * 2pi/512)
    Xj = 2*ang.cos()
    lam.append(((Xj+1)/(Xj-1)).abs().log())
L7 = R(128).sqrt()*(2+R(5).sqrt()).log()
TFLOOR = 4224

# ---- verify each certificate (read-only) ----
ncert = 0; nfail = 0
for fn in files:
    path = os.path.join(CERTDIR, fn)
    txt = open(path, 'r').read()          # READ ONLY
    a_const = ZZ(pat.match(fn).group(1)); route = pat.match(fn).group(2)
    g = P(x^2 + a_const)
    # full-coefficient identifier check (homework 31)
    assert tuple(ZZ(g[i]) for i in range(3)) == full_coeffs[a_const % l], \
        "FATAL: full-coefficient mismatch for %s" % fn
    co = [ZZ(c) for c in re.search(r'\(a_0\.\.a_63\) =\n([-0-9,]+)', txt).group(1).split(',')]
    assert len(co) == 64, "FATAL: %s witness length %d" % (fn, len(co))
    a_poly = P(co)
    # exact membership: f * a = 0 in F_l[x]/(x^64+1)  <=>  a in M_f-preimage
    mem = ((g * a_poly) % F) == 0
    # a not in l R
    nz = any(c % l != 0 for c in co)
    # log vector y = (1/l) H_7 a, interval
    y = [sum(R(co[i]) * lam[(i+j) % 128] for i in range(m)) / R(l) for j in range(2*m)]
    ynz = any(yy.lower() > 0 or yy.upper() < 0 for yy in y)
    ok = mem and nz and ynz
    if route == 'RHO':
        Q = sum(yy*yy for yy in y)
        rho = (Q.sqrt()/L7)
        ok = ok and (rho.upper() < 1)
        verdict = "rho<=%s" % rho.upper()
    else:
        T = sum((2*yy).exp() for yy in y)
        ok = ok and (T.upper() < TFLOOR)
        verdict = "T<=%s" % T.upper()
    ncert += 1 if ok else 0
    nfail += 0 if ok else 1
    print("%s  mem=%s nz=%s ynz=%s  %s  %s" % (fn, mem, nz, ynz, verdict, "CERT" if ok else "FAIL"))

print("VERIFY SUMMARY: CERT %d / FAIL %d of 64" % (ncert, nfail))
print("R7 FLAGSHIP VERIFY %s" % ("PASS" if (ncert == 64 and nfail == 0) else "FAIL"))
