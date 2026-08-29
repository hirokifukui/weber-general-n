# p3_gate2_pilot.sage -- Track B kill test (hw 683-698), Gates 2-3 numerics at p = 3.
# Object: the Horie unit eta_n = delta(1) = sin(2(1+3^n)pi/3^{n+1}) / sin(2pi/3^{n+1}) in B_{3,n} (MO2013 sect 1; for p=3,
# (p-1)/2 = 1 so eta_n = delta(1) itself), its Galois conjugates eta^{(k)} (k in (Z/3^{n+1})^x / {+-1}, |.| = 3^n = N),
# the log vectors H(sigma^i eta), and the lattice Lambda_0 = Z-span{H(sigma^i eta) : 0 <= i < c}, c = 2*3^{n-1} = phi(3^n)
# (the image of Z[zeta_{3^n}] under the lift alpha -> alpha_sigma of MO2013 sect 1, exponents i < (p-1)p^{n-1}).
# D = covolume of Lambda_0 in its span = sqrt(det Gram). Floor: for a unit eps != +-1 of B_n, sum_i |log|eps_i|| >= N log phi
# (MO2013 Thm 2.2 with C >= 1, multiplicities N/deg), so ht(eps) >= sqrt(N) log phi =: L_{3,n}  (Cauchy-Schwarz) [hand].
# Candidate constant (Theorem SH shape, r = n regime):  C3exact_n = (2/pi)^{c/2} Gamma(2+c/2) D / L^c,
#   claim shape: l | h_{3,n}/h_{3,n-1}, 3^n | l^{f}-1 (r = n)  =>  l^f <= C3exact_n   (f = ord of l mod 3 in {1,2}).
# Competitors (verbatim MO2013): G_1(3,r,f)^f = (sqrt6*3/2)^c c!,  G_cyclo(3,r,f)^f = sqrt6^c (3^{1}*1!^2/2!)^{c/2} c! = sqrt6^c (3/2)^{c/2} c!,
#   Morisawa Thm 0.3 (from [21]): l^f > 2^{c/2} c!  (with c = 2*3^{s-1}; here s = r = n).
# NOTE (pilot, numerical, not a certificate): 400-bit floats, no ball arithmetic; the object of Gate 1 (that Horie's saturation
# lattice lands on Lambda_0 with the height floor for the root) is NOT settled by this script.
R = RealField(2400)   # run 1 (400 bits) lost the n=5 Gram determinant; 2400 bits for n <= 5
phi = (1 + R(5).sqrt())/2
pi_ = R(pi)
print("n  r   N    c   D(covol)          L_3n      C3exact          log10C3   G1^f       Gcyclo^f   Thm0.3(s=r)  C3/Thm0.3")
for n in range(1, 6):
    N = 3^n; q = 3^(n+1)
    def eta(k):
        k = k % q
        num = (2*k*(1+N)*pi_/q).sin(); den = (2*k*pi_/q).sin()
        return num/den
    ks = []
    for j in range(N):
        k = power_mod(4, j, q); k = min(k, q-k); ks.append(k)
    assert len(set(ks)) == N
    logs = [R(abs(eta(power_mod(4, t, q)))).log() for t in range(N)]
    tot = sum(logs); assert abs(tot) < R(10)^(-100), tot
    L = R(N).sqrt() * phi.log()
    for r in range(1, n+1):
        c = 2*3^(r-1); step = 3^(n-r)     # Z[zeta_r] = Z[zeta_n^{step}]: lift exponents step*j, j < c
        rows = [[logs[(step*i+j) % N] for j in range(N)] for i in range(c)]
        M = matrix(R, rows)
        G = M * M.transpose()
        det = G.determinant()
        assert det > 0, (n, r, det)
        D = det.sqrt()
        C3 = (R(2)/pi_)^(c/2) * gamma(R(2)+R(c)/2) * D / L^c
        G1 = (R(6).sqrt()*3/2)^c * factorial(c)
        Gcy = R(6).sqrt()^c * (R(3)/2)^(c/2) * factorial(c)
        T03 = R(2)^(c/2) * factorial(c)
        print("%d %2d %4d %4d  %.6e  %.5f  %.6e  %7.2f  %.3e  %.3e  %.3e  %.3e" % (n, r, N, c, D, L, C3, log(C3,10), G1, Gcy, T03, C3/T03), flush=True)
print("R16 P3 GATE2 PILOT DONE")
