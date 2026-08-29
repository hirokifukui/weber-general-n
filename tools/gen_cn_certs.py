#!/usr/bin/env python3
"""gen_cn_certs.py - r14 (GPT r13 sect 2 / hw 387-406; supersedes the r12 version that scraped sage/r11_propD_audit.log).
Source of truth for every printed C_n number: certificates/constants/Cn_interval_r14.json (format_version 2, produced by
sage/r14_cn_interval.sage from the 500-bit balls; both endpoints to 160 significant digits, rounded OUTWARD; midpoint,
radius upper bound, precision bits and rounding convention as separate fields; certified common-prefix digits; and the
paper DISPLAY value = truncated prefix, carrying only its truncation bound).  This tool
  (default)  prints the generated Table tab:Cn rows and the canonical display strings (LaTeX and plain) for C_7;
  --check    re-validates the certificate (script sha256 unchanged; endpoint strings differ; lo < hi as decimals;
             certified prefix is a common prefix of both endpoints; display == truncation of the prefix; n = 7
             frozen integer thresholds exceed the upper endpoint; recorded width bound) and asserts that the Table rows
             in TEX are exactly the generated ones -> "CN CERT CHECK: PASS" / "FAIL".
The old certificates/constants/Cn_digamma_r12.json is SUPERSEDED (its 25-38-digit strings were RealField(80/120) roundings
of the endpoints, both ends printed equal; ERRATA_R14 E14-1) and is not read here."""
import re, sys, json, hashlib, os
from decimal import Decimal, getcontext
CERT = os.environ.get('CN_CERT', 'certificates/constants/Cn_interval_r14.json'); TEX = os.environ.get('CN_TEX', 'paper/draft/main_1.0.2.tex')   # env overrides exist ONLY for the negative-control harness (tools/negctl_tools_r14.py)
WIDTH_BOUND_N7 = Decimal('5e-115')
getcontext().prec = 400
cert = json.load(open(CERT)); rows = {r['n']: r for r in cert['rows']}
bad = []
def rad_up_2sig(s):
    # upper bound of the radius, rounded UP to 2 significant digits, as (mantissa, exponent) for LaTeX
    d = Decimal(s); t = d.as_tuple(); digs = t.digits; e = len(digs) + t.exponent - 1
    m2 = Decimal('%d.%d' % (digs[0], digs[1] if len(digs) > 1 else 0))
    if len(digs) > 2 and any(x != 0 for x in digs[2:]): m2 += Decimal('0.1')
    if m2 >= 10: m2 = Decimal('1.0'); e += 1
    return '%s\\times10^{%d}' % (m2, e)
def texrow(r):
    s = r['sum_logL_mid']; sign = '+' if s >= 0 else '-'
    extra = '; three further routes agree' if r['n'] == 7 else ''
    return '%d & %d & %.4f & $%s%.4f$ & ball, radius $\\le%s$%s\\\\' % (r['n'], r['m'], r['log10_mid'], sign, abs(s), rad_up_2sig(r['radius_upper']), extra)
def display_tex(r):
    mant, ex = r['display'].split('e'); return '%s\\ldots\\times10^{%s}' % (mant, ex)
gen = [texrow(rows[n]) for n in sorted(rows)]
r7 = rows[7]
def validate():
    ssha = hashlib.sha256(open(cert['produced_by'], 'rb').read()).hexdigest()
    if ssha != cert['script_sha256']: bad.append('script sha256 changed since the certificate was produced')
    if not cert.get('assertions', '').startswith('ALL PASS'): bad.append('certificate assertions field is not ALL PASS')
    if cert.get('format_version') != 2: bad.append('format_version != 2')
    for n, r in sorted(rows.items()):
        lo, hi = r['C_lo'], r['C_hi']
        if lo == hi: bad.append('n=%d endpoint strings identical' % n)
        if not (Decimal(lo) < Decimal(hi)): bad.append('n=%d lo >= hi' % n)
        ml, el = lo.split('E'); mh, eh = hi.split('E'); dl = ml.replace('.', ''); dh = mh.replace('.', '')
        pm, pe = r['certified_prefix'].split('e'); pd = pm.replace('.', '')
        if not (el == eh == '+' + pe if int(pe) >= 0 else el == eh == pe): bad.append('n=%d prefix exponent mismatch' % n)
        if not (dl.startswith(pd) and dh.startswith(pd)): bad.append('n=%d certified_prefix is not a common prefix of the endpoints' % n)
        if len(pd) != r['certified_prefix_digits']: bad.append('n=%d prefix digit count mismatch' % n)
        dm, de = r['display'].split('e'); dd = dm.replace('.', '')
        if not (pd.startswith(dd) and de == pe and len(dd) == r['display_digits']): bad.append('n=%d display is not the truncated prefix' % n)
        m = re.match(r'less than 1e(-?\d+)$', r['display_truncation_error_bound'])
        if not m or int(m.group(1)) != int(pe) - (r['display_digits'] - 1): bad.append('n=%d truncation bound inconsistent' % n)
        rad = Decimal(r['radius_upper'])
        # width <= 2*radius + binary outward rounding of the two 500-bit endpoints (2 * 2^-500 * |x| each side) + decimal outward rounding
        slack = abs(Decimal(hi)) * Decimal(2) ** (-(cert['prec_bits'] - 2)) + 2 * Decimal(10) ** (int(pe) - cert['endpoint_digits'] + 1)
        if not (Decimal(hi) - Decimal(lo) <= 2 * rad + slack): bad.append('n=%d endpoint width exceeds 2*radius + rounding slack' % n)
    t = cert['thresholds_n7']; hi7 = Decimal(r7['C_hi'])
    if not (hi7 < Decimal(t['deg1_int']) and hi7 < Decimal(t['deg2_sq'])): bad.append('n=7 threshold assertion fails on the recorded endpoint')
    if Decimal(t['deg2_sq']) != (Decimal(t['deg2_int']) + 1) ** 2: bad.append('deg2_sq != (deg2_int+1)^2')
    if t['deg1_int'] != '1727342163036353095979941756929' or t['deg2_int'] != '1314283897427172': bad.append('frozen r6 thresholds changed')
    if not (Decimal(r7['C_hi']) - Decimal(r7['C_lo']) < WIDTH_BOUND_N7): bad.append('n=7 width not < %s' % WIDTH_BOUND_N7)
    if r7['certified_prefix_digits'] < 145: bad.append('n=7 certified prefix < 145 digits')
if '--check' in sys.argv:
    validate()
    tex = open(TEX).read(); miss = [g for g in gen if g not in tex]
    print('certificate %s: rows %d ; script sha256 %s' % (CERT, len(rows), cert['script_sha256'][:12]))
    print('Cn rows generated from the certificate: %d ; found verbatim in %s: %d' % (len(gen), TEX, len(gen) - len(miss)))
    for b in miss: print('MISSING ROW:', b)
    for b in bad: print('CERT FAIL:', b)
    print('CN CERT CHECK: %s' % ('PASS' if not (bad or miss) else 'FAIL'))
    sys.exit(1 if (bad or miss) else 0)
validate()
print('rows for Table tab:Cn:'); print('\n'.join(gen))
print('C_7 display (LaTeX):', display_tex(r7)); print('C_7 display (plain):', r7['display'])
print('C_7 certified prefix digits:', r7['certified_prefix_digits'], '; width <', WIDTH_BOUND_N7, '; truncation error', r7['display_truncation_error_bound'])
print('n=7 thresholds:', cert['thresholds_n7']['deg1_int'], cert['thresholds_n7']['deg2_int'], 'C7_hi < both:', cert['thresholds_n7']['C7_hi_lt_deg1'] and cert['thresholds_n7']['C7_hi_lt_deg2_sq'])
print('validation:', 'OK' if not bad else bad)
