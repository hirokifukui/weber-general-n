# r14_cross_cas_audit.sage - R14 P1 (GPT r13 sect 3, hw 407-416). Replaces the r11 "inside ball" line of
# sage/r11_propD_audit.sage (which accepted |Magma - upper| < 1e10 as "inside" a 1e-115 ball; that test is withdrawn, E14-3).
# Every cross-CAS route is turned into an INTERVAL with an explicit, per-route trust level, and compared with the certified
# digamma enclosure [C7_lo, C7_hi] of certificates/constants/Cn_interval_r14.json by literal interval inclusion / intersection.
# Routes:
#   r6   interval determinant (certificates/blichfeldt/r6_blichfeldt_cert.log): RIGOROUS ln C7 intervals at PREC 256/512/1024
#        -> exp taken in ball arithmetic at 1200 bits, endpoints rounded outward; gate = the digamma enclosure lies INSIDE the
#        PREC-256 interval and INTERSECTS the PREC-512 and PREC-1024 intervals; the r6 integer threshold T1 exceeds every upper end.
#   magma  sage/r10_bin4_xcas.log (Magma V2.29-7, RealField(60), LSeries Precision 40): HEURISTIC. The vendor precision claim is
#        40 digits per L-value; the product of 64 L-values is given a relative uncertainty 64*10^-40 < 10^-37 (a heuristic bound,
#        not a proof) -> interval v*(1 -+ 10^-37); gate = intersects the digamma enclosure; the number of leading digits of the
#        printed value that coincide with the certified prefix is REPORTED (agreement), not used as inclusion.
#   pari   sage/r10_bin4_lvalue_route.log (PARI, 60 digits and a 200-bit rerun): HEURISTIC. Only ln D_7 is printed at 200 bits;
#        gate = the 200-bit ln D_7 lies inside the r6 PREC-256 rigorous ln D7 interval; the 60-digit lnC_7 value is recorded with
#        its OBSERVED discrepancy (~4.6e-17, i.e. effective precision far below the nominal 60 digits) and trust level LOW.
# Cross-CAS routes are numerical audits of the C-labelled certificate; they are not part of it (trust label E-numerical).
# Output: certificates/constants/C7_cross_cas_r14.json and this log. ASCII only.
import re, json, hashlib, os, sys
from decimal import Decimal, getcontext, ROUND_FLOOR, ROUND_CEILING
PREC = 1200; RBF = RealBallField(PREC)
def sha(p): return hashlib.sha256(open(p,'rb').read()).hexdigest()
def dec(x, digits, rounding):
    getcontext().prec = int(digits); getcontext().rounding = rounding
    q = x.exact_rational(); return Decimal(int(q.numerator())) / Decimal(int(q.denominator()))
def sci(d, digits): return ('{:.%dE}' % (int(digits)-1)).format(d)
def ball_to_dec(b, digits=int(170)):
    return sci(dec(b.lower(), digits, ROUND_FLOOR), digits), sci(dec(b.upper(), digits, ROUND_CEILING), digits)
def common_digits(a, b):
    a = a.split('E')[0].replace('.', '').replace('e','').lstrip('0'); b = b.split('E')[0].replace('.', '').replace('e','').lstrip('0')
    k = int(0)
    while k < min(len(a), len(b)) and a[k] == b[k]: k += 1
    return k
cert = json.load(open('certificates/constants/Cn_interval_r14.json')); r7 = [r for r in cert['rows'] if r['n'] == 7][0]
D_lo, D_hi = Decimal(r7['C_lo']), Decimal(r7['C_hi']); getcontext().prec = int(400)
T1 = Integer(1727342163036353095979941756929)
routes = []; fails = []
# ---- r6 interval determinant ----
R6 = 'certificates/blichfeldt/r6_blichfeldt_cert.log'; txt6 = open(R6).read()
for m in re.finditer(r'^PREC (\d+) : ln C7\s+in \[([0-9.]+), ([0-9.]+)\]', txt6, re.M):
    p = int(m.group(1)); a = RBF(m.group(2)); b = RBF(m.group(3))
    I = RBF(a.lower().union(b.upper())) if False else RBF(a.lower(), 0).union(RBF(b.upper(), 0))  # hull of the two rigorous endpoints
    E = I.exp(); lo_s, hi_s = ball_to_dec(E); Elo, Ehi = Decimal(lo_s), Decimal(hi_s)
    inter = bool(max(Elo, D_lo) <= min(Ehi, D_hi))
    w6 = Ehi - Elo; wD = D_hi - D_lo
    # two RIGOROUS enclosures of the same number must intersect, and the narrower one must lie inside the wider one
    narrower_inside_wider = bool((Elo <= D_lo and D_hi <= Ehi) if w6 >= wD else (D_lo <= Elo and Ehi <= D_hi))
    mu = re.search(r'^PREC %d : C7 upper\s+= ([0-9.e+]+)' % p, txt6, re.M); up = Decimal(mu.group(1)) if mu else None
    t1_ok = bool(up is None or Decimal(int(T1)) > up)
    gate = inter and narrower_inside_wider and t1_ok and (p != 256 or (up is not None and D_hi <= up))
    if not gate: fails.append('r6 PREC %d' % p)
    routes.append(dict(route='r6_interval_determinant', precision_bits=p, trust='rigorous (interval arithmetic, three precisions; C)', source_log=R6, source_sha256=sha(R6),
                       lnC7_interval=[m.group(2), m.group(3)], C7_interval_from_exp=[lo_s, hi_s], width_r6='%.3E' % w6, width_digamma='%.3E' % wD,
                       wider='r6' if w6 >= wD else 'digamma', C7_upper_as_printed=str(up) if up is not None else None,
                       intersects=inter, narrower_inside_wider=narrower_inside_wider, T1_gt_printed_upper=t1_ok,
                       digamma_hi_le_printed_upper_256=(bool(D_hi <= up) if (p == 256 and up is not None) else None), gate='PASS' if gate else 'FAIL'))
    print('r6 PREC %4d: C7 in [%s, %s] ; widths r6 %.2E / digamma %.2E (wider: %s) ; intersects: %s ; narrower inside wider: %s ; printed upper %s ; T1 > upper: %s ; %s' % (p, lo_s[:45], hi_s[:45], w6, wD, routes[-1]['wider'], inter, narrower_inside_wider, (str(up)[:40] if up is not None else 'n/a'), t1_ok, routes[-1]['gate']))
# ---- Magma ----
MG = 'sage/r10_bin4_xcas.log'; txtm = open(MG).read()
mm = re.search(r'^C7\s*:\s*([0-9.]+)', txtm, re.M); v = Decimal(mm.group(1))
rel = Decimal('1e-37'); Mlo = v * (Decimal('1') - rel); Mhi = v * (Decimal('1') + rel)
inter = bool(max(Mlo, D_lo) <= min(Mhi, D_hi)); agree = common_digits(sci(v, int(60)), r7['certified_prefix'].replace('e','E'))
gate = inter
if not gate: fails.append('magma')
routes.append(dict(route='magma_lseries', software='Magma V2.29-7 on A9 (RealField(60); LSeries(chi : Precision := 40))', trust='heuristic (vendor working precision; NOT a rigorous bound; E-numerical)', source_log=MG, source_sha256=sha(MG),
                   printed_value=str(v), printed_digits=int(len(mm.group(1).replace('.',''))), assumed_relative_uncertainty=str(rel), rationale='64 L-values at 40 digits -> 64*10^-40 < 10^-37 relative (heuristic)',
                   heuristic_interval=[sci(Mlo, int(45)), sci(Mhi, int(45))], intersects_certified=inter, leading_digits_agreeing_with_certified_prefix=int(agree), gate='PASS' if gate else 'FAIL'))
print('magma: printed %s (%d digits) ; heuristic interval v(1-+1e-37) intersects certified enclosure: %s ; leading digits agreeing with certified prefix: %d ; %s' % (str(v)[:40], routes[-1]['printed_digits'], inter, agree, routes[-1]['gate']))
# ---- PARI ----
PA = 'sage/r10_bin4_lvalue_route.log'; txtp = open(PA).read()
mp = re.search(r'lnD_7 \(L-route, 200 bits\) = ([0-9.]+)', txtp); lnD200 = Decimal(mp.group(1))
m6 = re.search(r'^PREC 256 : ln D7\s+in \[([0-9.]+), ([0-9.]+)\]', txt6, re.M); dlo, dhi = Decimal(m6.group(1)), Decimal(m6.group(2))
inside = bool(dlo <= lnD200 <= dhi)
m60 = re.search(r'^n=7 .*lnC_n\(Cor A\'\) = ([0-9.]+)', txtp, re.M); lnC60 = Decimal(m60.group(1))
lnC_cert_lo = Decimal(re.search(r'^PREC 512 : ln C7\s+in \[([0-9.]+),', txt6, re.M).group(1))
disc = abs(lnC60 - lnC_cert_lo)
gate = inside
if not gate: fails.append('pari')
routes.append(dict(route='pari_gauss_sum', software='PARI via Sage (60-digit run; 200-bit rerun for ln D_7 only)', trust='heuristic (E-numerical); 60-digit run has effective precision ~1e-16 (observed), LOW', source_log=PA, source_sha256=sha(PA),
                   lnD7_200bit=str(lnD200), r6_lnD7_interval_256=[m6.group(1), m6.group(2)], lnD7_200bit_inside_r6_interval=inside,
                   lnC7_60digit_run=str(lnC60), observed_discrepancy_vs_r6_lnC7='%.3E' % disc, gate='PASS' if gate else 'FAIL'))
print('pari: lnD_7 (200 bits) inside r6 PREC-256 ln D7 interval: %s ; 60-digit lnC_7 discrepancy vs r6 ln C7: %.3E (effective precision far below nominal; recorded, not a gate) ; %s' % (inside, disc, routes[-1]['gate']))
out = dict(format_version=int(1), certified_enclosure='certificates/constants/Cn_interval_r14.json (digamma, 500-bit balls; the only C-labelled source)',
           C7_lo=r7['C_lo'], C7_hi=r7['C_hi'], deg1_threshold_T1=str(T1), T1_provenance='r6 interval determinant, PREC 256 printed upper endpoint + 1 (frozen in lean/WeberR6.lean)',
           withdrawn='r11 inside-ball test (|Magma - upper| < 1e10) of sage/r11_propD_audit.sage line 83 is withdrawn (E14-3); agreement of leading digits and interval inclusion are reported separately',
           routes=routes, result='PASS' if not fails else 'FAIL: ' + ', '.join(fails))
OUTP = os.environ.get('XCAS_OUT', 'certificates/constants/C7_cross_cas_r14.json')   # XCAS_OUT: the verifier writes a fresh copy under verify_out/
json.dump(out, open(OUTP, 'w'), indent=1)
print('wrote %s' % OUTP)
print('CROSS-CAS AUDIT: %s' % out['result'])
sys.exit(int(0) if not fails else int(1))
