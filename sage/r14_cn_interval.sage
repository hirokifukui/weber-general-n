# r14_cn_interval.sage - R14 P0 (GPT r13 sect 2, hw 387-402). FULL-PRECISION interval certificate for the
# constants C_n, n = 2..9, of Corollary A' (digamma route, IDENTICAL arithmetic to sage/r11_propD_audit.sage (e);
# no new mathematics). Differences from the r11/r12 record are in the OUTPUT only:
#   * both endpoints are printed from the EXACT binary endpoints of the 500-bit ball, rounded OUTWARD
#     (lower: ROUND_FLOOR, upper: ROUND_CEILING) to ENDPOINT_DIGITS significant decimal digits, so that
#     C_lo_str <= C_lo <= C_n <= C_hi <= C_hi_str and the two strings DIFFER (asserted);
#   * midpoint, an UPPER bound on the radius, precision bits and the rounding convention are separate fields;
#   * certified_prefix = the longest common leading-digit string of the two endpoints; every real number in the
#     enclosure starts with exactly these digits, so a TRUNCATED display taken from this prefix is provably a
#     prefix of the decimal expansion of C_n (truncation error < one unit in the last displayed place);
#   * the paper display (DISPLAY_DIGITS significant digits, truncated, never rounded) is generated HERE and
#     carries its own truncation bound; the ball radius is NEVER attached to the display value;
#   * the n = 7 integer thresholds are the FROZEN r6 integers of lean/WeberR6.lean / lean/WeberExternalResults.lean;
#     they are NOT regenerated: the certificate asserts C_7_hi_str < 1727342163036353095979941756929 and
#     C_7_hi_str < 1314283897427173^2 (both must hold, else the run FAILS).
# Output: certificates/constants/Cn_interval_r14.json (format_version 2) and this log. ASCII only.
import sys, json, hashlib, os
from decimal import Decimal, getcontext, ROUND_FLOOR, ROUND_CEILING
PREC = 500
ENDPOINT_DIGITS = 160
DISPLAY_DIGITS = 38
DEG1_INT = Integer(1727342163036353095979941756929)
DEG2_INT = Integer(1314283897427172)
RBF = RealBallField(PREC); CBF = ComplexBallField(PREC)
def chars(n):
    q = 2^(n+2); N = 2^n
    idx = {}
    for j in range(N):
        k = power_mod(3, j, q); idx[k] = j; idx[(-k) % q] = j
    out = []
    for r in range(2^(n-1)):
        om = (CBF(2)*CBF(pi)*CBF(0,1)*CBF(2*r+1)/CBF(N)).exp()
        pw = [om^j for j in range(N)]
        out.append((om, lambda a, pw=pw, idx=idx: pw[idx[a]]))
    return out
def Cn_ball(n):
    q = 2^(n+2); m = 2^(n-1)
    chis = chars(n)
    psi = {a: RBF(a)/RBF(q) for a in range(1, q) if a % 2 == 1}
    psi = {a: psi[a].psi() for a in psi}
    Lvals = [ -(sum(chi(a) * CBF(psi[a]) for a in psi)) / q for c3, chi in chis ]
    prodL = prod(L.abs() for L in Lvals)
    minL = min(float(L.abs().lower()) for L in Lvals)
    Cn = 2 * (RBF(4)/RBF(pi))^(m/2) * RBF(2 + m/2).gamma() * prodL / ((2+RBF(5).sqrt()).log())^m
    return Cn, prodL, minL
def dec_outward(x, digits, rounding):
    # x: exact Sage Rational; correctly rounded (per `rounding`) Decimal with `digits` significant digits
    getcontext().prec = int(digits); getcontext().rounding = rounding
    return Decimal(int(x.numerator())) / Decimal(int(x.denominator()))
def sci(d, digits):
    return ('{:.%dE}' % (int(digits)-1)).format(d)   # exact re-rendering of a `digits`-digit Decimal, no rounding
def split_sci(s):
    mant, ex = s.split('E'); return mant.replace('.', ''), int(ex)
def common_prefix(a, b):
    k = 0
    while k < min(len(a), len(b)) and a[k] == b[k]: k += 1
    return a[:k]
rows = []; fails = []
for n in range(2, 10):
    Cn, prodL, minL = Cn_ball(n)
    lo_q = Cn.lower().exact_rational(); hi_q = Cn.upper().exact_rational(); mid_q = Cn.mid().exact_rational()
    assert lo_q <= mid_q <= hi_q
    lo_s = sci(dec_outward(lo_q, ENDPOINT_DIGITS, ROUND_FLOOR), ENDPOINT_DIGITS)
    hi_s = sci(dec_outward(hi_q, ENDPOINT_DIGITS, ROUND_CEILING), ENDPOINT_DIGITS)
    mid_s = sci(dec_outward(mid_q, ENDPOINT_DIGITS, ROUND_FLOOR), ENDPOINT_DIGITS)
    rad_up = RealField(int(30), rnd='RNDU')(Cn.rad())
    rad_s = rad_up.str()
    ld, le = split_sci(lo_s); hd, he = split_sci(hi_s)
    if le != he: fails.append('n=%d endpoint exponents differ' % n)
    pref = common_prefix(ld, hd) if le == he else ''
    if lo_s == hi_s: fails.append('n=%d endpoint strings identical' % n)
    if not (Decimal(lo_s) < Decimal(hi_s)): fails.append('n=%d lo_str not < hi_str' % n)
    if len(pref) < DISPLAY_DIGITS: fails.append('n=%d certified prefix %d < display %d' % (n, len(pref), DISPLAY_DIGITS))
    disp = pref[0] + '.' + pref[1:DISPLAY_DIGITS]
    disp_str = disp + 'e' + str(le)
    trunc_bound = 'less than 1e%d' % (le - (DISPLAY_DIGITS - 1))
    log10 = float((Cn.log()/RBF(10).log()).mid())
    rows.append(dict(n=int(n), m=int(2^(n-1)), C_lo=lo_s, C_hi=hi_s, C_mid=mid_s, radius_upper=rad_s,
                     certified_prefix_digits=len(pref), certified_prefix=pref[0]+'.'+pref[1:]+'e'+str(le),
                     display=disp_str, display_digits=int(DISPLAY_DIGITS), display_rule='truncated (not rounded) prefix of certified_prefix',
                     display_truncation_error_bound=trunc_bound,
                     minL_lower=float(minL), sum_logL_mid=float(prodL.log().mid()), log10_mid=log10))
    print('n=%d m=%3d C_n in [%s, %s] ; radius <= %s ; certified prefix digits %d ; display %s (truncation error %s) ; log10 C_n = %.15f' % (n, 2^(n-1), lo_s, hi_s, rad_s, len(pref), disp_str, trunc_bound, log10))
    if n == 7:
        hi7 = Decimal(hi_s)
        t1 = Decimal(int(DEG1_INT)); t2 = Decimal(int((DEG2_INT+1)^2))
        ok1 = hi7 < t1; ok2 = hi7 < t2
        print('n=7 THRESHOLDS (frozen r6 integers, NOT regenerated): C_7_hi_str < %d : %s ; C_7_hi_str < (%d+1)^2 = %d : %s' % (DEG1_INT, ok1, DEG2_INT, (DEG2_INT+1)^2, ok2))
        if not (ok1 and ok2): fails.append('n=7 threshold assertion failed')
        thr = dict(deg1_int=str(DEG1_INT), deg2_int=str(DEG2_INT), deg2_sq=str((DEG2_INT+1)^2), C7_hi_lt_deg1=bool(ok1), C7_hi_lt_deg2_sq=bool(ok2),
                   source='frozen r6 integers in lean/WeberR6.lean (deg1/deg2_threshold_valid) and lean/WeberExternalResults.lean (c7_deg2_instance); unchanged since r6',
                   deg1_margin_lower=str(t1 - hi7), deg2_margin_lower=str(t2 - hi7))
script = 'sage/r14_cn_interval.sage'
ssha = hashlib.sha256(open(script,'rb').read()).hexdigest() if os.path.exists(script) else 'n/a'
cert = dict(format_version=int(2), certificate='Cn_interval_r14', produced_by=script, script_sha256=ssha, log='sage/r14_cn_interval.log',
            route='digamma L(1,chi) = -(1/q) sum chi(a) psi(a/q), prod |L(1,chi)| over the 2^(n-1) even characters of conductor 2^(n+2); C_n = 2 (4/pi)^(m/2) Gamma(2+m/2) prod|L| / log(2+sqrt5)^m (Cor A\'); same arithmetic as sage/r11_propD_audit.sage (e)',
            arithmetic='Sage 10.8 RealBallField/ComplexBallField (arb via FLINT), all operations at PREC bits', prec_bits=int(PREC),
            endpoint_digits=int(ENDPOINT_DIGITS),
            endpoint_rounding='C_lo: exact lower endpoint of the ball (Sage .lower(), RNDD) rounded DOWN (ROUND_FLOOR) to endpoint_digits significant digits; C_hi: exact upper endpoint (.upper(), RNDU) rounded UP (ROUND_CEILING); hence C_lo_str <= C_n <= C_hi_str',
            radius_field='radius_upper = ball radius rounded UP to 30 bits (an upper bound); it is a property of the enclosure, NOT of the display value',
            display_field='display = truncated prefix of certified_prefix; its only error is the truncation bound stated per row',
            thresholds_n7=thr, rows=rows, assertions=('FAIL: ' + ' ; '.join(fails)) if fails else 'ALL PASS (endpoint strings differ, lo<hi, prefix>=display digits, n=7 thresholds)')
os.makedirs('certificates/constants', exist_ok=True)
OUTP = os.environ.get('CN_OUT', 'certificates/constants/Cn_interval_r14.json')   # CN_OUT: the verifier writes a FRESH copy under verify_out/ and compares
json.dump(cert, open(OUTP,'w'), indent=1)
print('wrote %s ; assertions: %s' % (OUTP, cert['assertions']))
print('R14 CN INTERVAL DONE %s' % ('PASS' if not fails else 'FAIL'))
sys.exit(int(1) if fails else int(0))
