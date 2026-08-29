# r8_twoadic_depth_exact.sage — homework 19-26, 28(numeric side), 30-35 (r8)
# EXACT arithmetic in Z[z]/(z^256+1, 2^t), t <= 4. No floats anywhere (hw 32).
# eps_7 = (z^2+z+1)/(z^2-z+1); denominator unit certified via F_2 xgcd + Newton lift
# (hw 21). Conjugates sigma^i: z -> z^{3^i mod 512} with z^256 = -1 sign rule.
# Three F_2 families and their ranks (hw 23-26); pivot certificates (hw 30-31);
# closed-form crosscheck (eps-1)/2 = z * inv(z^2-z+1) as an internal assert.
# L_t exact recomputation to 40 digits (hw 34-35).

import time
t0 = time.time()
N = 256

def red(p):
    # reduce list of coeffs mod z^256 = -1 into length-N list (over given ring)
    out = [p.parent().base_ring()(0)]*N if hasattr(p, 'parent') else None
    raise RuntimeError

def poly_red(coeffs, ring):
    out = [ring(0)]*N
    for k, c in enumerate(coeffs):
        q, r = divmod(k, N)
        out[r] += ring(c) * ring(-1)**q
    return out

def pmul(a, b, ring):
    # negacyclic convolution length 256 over ring (schoolbook; 256^2 = 65k ops)
    out = [ring(0)]*(2*N)
    for i, ai in enumerate(a):
        if ai == 0: continue
        for j, bj in enumerate(b):
            out[i+j] += ai*bj
    return poly_red(out, ring)

def sigma_pow(a, i, ring):
    # z -> z^{e}, e = 3^i mod 512, with z^256 = -1
    e = power_mod(3, i, 512)
    out = [ring(0)]*N
    for k, c in enumerate(a):
        if c == 0: continue
        ke = (k*e) % 512
        if ke < N: out[ke] += c
        elif ke < 2*N: out[ke-N] -= c
        else: raise RuntimeError
    return out

R16 = Integers(16)
one = [R16(0)]*N; one[0] = R16(1)
znum = [R16(0)]*N; znum[2] = R16(1); znum[1] = R16(1); znum[0] = R16(1)   # z^2+z+1
zden = [R16(0)]*N; zden[2] = R16(1); zden[1] = R16(-1); zden[0] = R16(1)  # z^2-z+1
zpoly = [R16(0)]*N; zpoly[1] = R16(1)

# ---- hw 21: denominator is a unit. Step 1: xgcd in F_2[z] against z^256+1 ----
F2p.<y> = PolynomialRing(GF(2))
d2 = y^2 + y + 1              # z^2 - z + 1 mod 2
mod2 = y^256 + 1
g, s, tco = xgcd(d2, mod2)
print("HW21 step1: gcd(z^2+z+1, z^256+1) over F_2 =", g, " (unit iff 1)")
assert g == 1
# Step 2: Newton lift of the inverse from mod 2 to mod 16 (3 steps):
inv2 = [R16(ZZ(c)) for c in s.list()] + [R16(0)]*(N - len(s.list()))
v = inv2
for step in range(3):
    dv = pmul(zden, v, R16)
    two_minus = [ -c for c in dv ]; two_minus[0] += R16(2)
    v = pmul(v, two_minus, R16)
chk = pmul(zden, v, R16)
assert chk == one, "denominator inverse failed"
print("HW21 step2: Newton-lifted inverse verified: (z^2-z+1)*inv = 1 in Z[z]/(z^256+1,16)")

# ---- hw 20, 22: eps mod 16 and its 64 conjugates ----
eps = pmul(znum, v, R16)
# closed-form crosscheck: (eps - 1) = 2 z inv  (i.e. (eps-1)/2 = z*inv)
em1 = list(eps); em1[0] -= R16(1)
zinv2 = pmul(zpoly, v, R16); zinv2 = [R16(2)*c for c in zinv2]
assert em1 == zinv2, "closed form (eps-1) = 2 z/(z^2-z+1) FAILED"
print("CROSSCHECK: (eps-1) = 2*z*inv(z^2-z+1) exactly in Z/16 ring: PASS")

eps_i = [eps]
for i in range(1, 64):
    eps_i.append(sigma_pow(eps, i, R16))

# ---- three families (hw 23, 25, 26): divide exactly, reduce mod 2 ----
def div2_exact(a, k):
    # divide list by 2^k exactly (all coords divisible), return mod-2 vector over GF(2)
    out = []
    for c in a:
        ci = ZZ(c)
        assert ci % (2**k) == 0, "not divisible by 2^%d" % k
        out.append(GF(2)((ci >> k) & 1))
    return out

fam1, fam2, fam3 = [], [], []
for i in range(64):
    e1 = list(eps_i[i]); e1[0] -= R16(1)
    fam1.append(div2_exact(e1, 1))                       # (eps_i - 1)/2 mod 2
    e2 = pmul(eps_i[i], eps_i[i], R16); e2[0] -= R16(1)
    fam2.append(div2_exact(e2, 2))                       # (eps_i^2 - 1)/4 mod 2
    e4 = pmul(pmul(eps_i[i], eps_i[i], R16), pmul(eps_i[i], eps_i[i], R16), R16)
    e4[0] -= R16(1)
    fam3.append(div2_exact(e4, 3))                       # (eps_i^4 - 1)/8 mod 2

import os
HERE = os.path.dirname(os.path.abspath(__file__))
CD = os.path.normpath(os.path.join(HERE, '..', 'certificates', 'twoadic_rank')) + os.sep
os.makedirs(CD, exist_ok=True)

ranks = []
for name, fam in (("fam1_eps_minus1_over2", fam1),
                  ("fam2_eps2_minus1_over4", fam2),
                  ("fam3_eps4_minus1_over8", fam3)):
    M = matrix(GF(2), fam)
    r = M.rank()
    ranks.append(r)
    E = M.echelon_form()
    piv = M.pivots()
    with open(CD + name + "_certificate.txt", "w") as fh:
        fh.write("# %s : 64 x 256 matrix over F_2, EXACT (no floats)\n" % name)
        fh.write("rank = %d\npivot_columns = %s\n" % (r, list(piv)))
        fh.write("# rows = bit rows of the original matrix (row i = conjugate sigma^i)\n")
        for row in M.rows():
            fh.write("".join(str(int(c)) for c in row) + "\n")
        fh.write("# echelon form rows (first rank rows):\n")
        for row in E.rows()[:r]:
            fh.write("".join(str(int(c)) for c in row) + "\n")
    print("RANK %s = %d  (pivots saved, %d listed)" % (name, r, len(piv)))

print("HW23-26 RESULT: ranks =", ranks, " all-64:", ranks == [64, 64, 64])
print("HW28 consequence (numeric side): rank 64 at each graded level =>")
print("  u_a = 1 mod 4 iff a in 2Z^64 ; mod 8 iff 4Z^64 ; mod 16 iff 8Z^64 ;")
print("  [R:J_2] = 2^64, [R:J_3] = 2^128, [R:J_4] = 2^192  (natural-language proof:")
print("  theory/FILTERED_SATURATION_THEOREM.md sect 1-2).")
print("HW32: entire computation is exact integer/F_2 arithmetic - no floating point")
print("  of any precision is involved anywhere above.")

# ---- hw 34-35: L_t exact recomputation, 40 digits ----
Rp = RealField(200)
print("HW34-35: L_t = sqrt(128) * log((2^{t+1} + sqrt(4^{t+1}+4))/2), 40 digits:")
gpt_vals = {1: '16.3328709449664', 2: '23.6989671488779', 3: '31.4121980396195', 4: '39.2213581328407'}
for t in (1, 2, 3, 4):
    c = Rp(2)**(t+1)
    Lt = Rp(128).sqrt() * (((c + (c*c + 4).sqrt())/2).log())
    print("  L_%d = %s" % (t, Lt.str(digits=40)))
    print("       GPT: %s ; r7 old table: %s" % (gpt_vals[t],
          {1:'16.333',2:'23.695',3:'31.417',4:'39.212'}[t]))
print("elapsed %.1fs" % (time.time()-t0))
print("R8 TWOADIC DEPTH EXACT DONE")
