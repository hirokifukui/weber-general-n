"""p3_interval.py (r19) -- exact dyadic interval helpers shared by the p = 3 certificate producer
(sage/r19_trackB/p3_covol_balls_r19.sage), the certificate generator (tools/gen_p3_cert_r19.py), the read-only verifier
(scripts/verify_p3_readonly.sage), the containment checker (tools/check_p3_containment.py) and the consistency gate
(tools/check_p3_cert.py). Pure python; no Sage preparsing. A stored interval is
  {"lo": {"sign": s, "mantissa": "m", "exp2": e}, "hi": {...}, "rad_upper": str, "mid": str, "lo_dec": str, "hi_dec": str}
with value = s * m * 2^e. The dyadics are the proved values; lo_dec/hi_dec are DIRECTED decimals (down/up); mid is display only.
r19 additions: contains() (the certificate-coverage relation I_rec subset I_ship; overlap() is NOT a coverage test),
hull() and widen() in EXACT dyadic arithmetic (no rounding), interval_from_dyadics() to rebuild a stored interval."""
from decimal import Decimal, getcontext, ROUND_FLOOR, ROUND_CEILING, ROUND_HALF_EVEN
getcontext().prec = 1400
def dyadic_of_sme(s, m, e):
    return {"sign": int(s), "mantissa": str(int(m)), "exp2": int(e)}
def dyadic_to_decimal(d):
    sgn, m, e = int(d["sign"]), int(d["mantissa"]), int(d["exp2"])
    if e >= 0: return Decimal(sgn * m * (2 ** e))
    return Decimal(sgn * m) / Decimal(2 ** (-e))
def directed(dec, mode, digits=40):
    digits = int(digits); dec = Decimal(dec)
    if dec == 0: return "0E+0"
    e = int(dec.adjusted()); q = Decimal(1).scaleb(int(e - digits + 1))
    return format((dec / q).to_integral_value(rounding=mode) * q, 'E')
def interval_dict(lo_sme, hi_sme, rad_upper_str, mid_str, digits=40):
    dl, dh = dyadic_of_sme(*lo_sme), dyadic_of_sme(*hi_sme)
    dec_lo, dec_hi = dyadic_to_decimal(dl), dyadic_to_decimal(dh)
    assert dec_lo <= dec_hi, ("interval endpoints reversed", dl, dh)
    return {"lo": dl, "hi": dh, "rad_upper": str(rad_upper_str), "mid": str(mid_str),
            "lo_dec": directed(dec_lo, ROUND_FLOOR, digits), "hi_dec": directed(dec_hi, ROUND_CEILING, digits)}
def endpoints(iv):
    """(lo, hi) as Decimals from the exact dyadics; asserts lo <= hi and that the directed decimals bracket them."""
    lo, hi = dyadic_to_decimal(iv["lo"]), dyadic_to_decimal(iv["hi"])
    assert lo <= hi, "lo > hi"
    assert Decimal(iv["lo_dec"]) <= lo and hi <= Decimal(iv["hi_dec"]), "directed decimals do not bracket the dyadics"
    return lo, hi
def overlap(a, b):
    """True if the intervals (lo,hi) pairs a and b intersect. NOT a coverage test (r18 defect, ERRATA_R19 E19-1)."""
    return max(a[0], b[0]) <= min(a[1], b[1])
def contains(outer, inner):
    """True if the (lo,hi) pair `inner` lies inside `outer`: outer.lo <= inner.lo and inner.hi <= outer.hi.
    This is the certificate-coverage relation: a shipped interval certifies a value only if it CONTAINS an independent
    rigorous recomputation of that value."""
    return outer[0] <= inner[0] and inner[1] <= outer[1]
# ---- exact dyadic arithmetic (python integers; never rounds) ----
def _dy_to_int_pair(d):
    """dyadic -> (integer numerator, exp2) with value = numerator * 2^exp2."""
    return int(d["sign"]) * int(d["mantissa"]), int(d["exp2"])
def _int_pair_to_dy(num, e):
    s = 1 if num >= 0 else -1
    m = abs(num)
    while m and m % 2 == 0: m //= 2; e += 1     # normalise (odd mantissa) so equal values have one representation
    return {"sign": int(s if m else 1), "mantissa": str(m), "exp2": int(e if m else 0)}
def _align(a, b):
    na, ea = _dy_to_int_pair(a); nb, eb = _dy_to_int_pair(b)
    e = min(ea, eb)
    return na << (ea - e), nb << (eb - e), e
def dy_min(a, b):
    na, nb, e = _align(a, b); return _int_pair_to_dy(min(na, nb), e)
def dy_max(a, b):
    na, nb, e = _align(a, b); return _int_pair_to_dy(max(na, nb), e)
def hull(iv1, iv2):
    """Exact dyadic hull of two stored intervals: [min lo, max hi] (endpoint dyadics only)."""
    return dy_min(iv1["lo"], iv2["lo"]), dy_max(iv1["hi"], iv2["hi"])
def widen(lo_d, hi_d, factor=2):
    """Exact outward widening about the centre: half-width h = (hi-lo)/2 becomes factor*h. Returns (lo, hi) dyadics.
    factor = 2 (the r19 policy, hw 981): [c-2h, c+2h] = [lo - h, hi + h]."""
    assert int(factor) == factor and factor >= 1
    nlo, nhi, e = _align(lo_d, hi_d)
    width = nhi - nlo                      # >= 0
    # h = width/2 exactly: work at exp2 e-1
    nlo2, nhi2, e2 = nlo * 2, nhi * 2, e - 1
    extra = (int(factor) - 1) * width      # (factor-1)*h in units of 2^(e-1): (factor-1)*width/2 *2 = (factor-1)*width
    return _int_pair_to_dy(nlo2 - extra, e2), _int_pair_to_dy(nhi2 + extra, e2)
def interval_from_dyadics(lo_d, hi_d, digits=40):
    """Rebuild a full stored interval from exact endpoint dyadics: rad_upper = (hi-lo)/2 rounded UP (8 digits),
    mid = (lo+hi)/2 nearest (`digits` digits, display only), lo_dec/hi_dec directed."""
    dec_lo, dec_hi = dyadic_to_decimal(lo_d), dyadic_to_decimal(hi_d)
    assert dec_lo <= dec_hi, "reversed"
    rad = (dec_hi - dec_lo) / 2; mid = (dec_lo + dec_hi) / 2
    rad_s = directed(rad, ROUND_CEILING, 8) if rad != 0 else "0E+0"
    if mid == 0: mid_s = "0E+0"
    else:
        e = int(mid.adjusted()); q = Decimal(1).scaleb(int(e - int(digits) + 1))
        mid_s = format((mid / q).to_integral_value(rounding=ROUND_HALF_EVEN) * q, 'E')
    return {"lo": dict(lo_d), "hi": dict(hi_d), "rad_upper": rad_s, "mid": mid_s,
            "lo_dec": directed(dec_lo, ROUND_FLOOR, digits), "hi_dec": directed(dec_hi, ROUND_CEILING, digits)}
def widened_hull(iv1, iv2, factor=2, digits=40):
    """The r19 certified interval: widen(hull(iv1, iv2), factor) as a stored interval."""
    lo, hi = hull(iv1, iv2)
    wlo, whi = widen(lo, hi, factor)
    return interval_from_dyadics(wlo, whi, digits)
def dec_to_dyadic(x, mode, scale_bits=4000):
    """Decimal -> exact dyadic bound at scale 2^-scale_bits: mode 'lo' rounds DOWN, 'hi' rounds UP (never inward)."""
    x = Decimal(x); s = 1 if x >= 0 else -1; ax = abs(x)
    down = (mode == "lo") == (s > 0)
    m = (ax * (Decimal(2) ** scale_bits)).to_integral_value(rounding=(ROUND_FLOOR if down else ROUND_CEILING))
    return dyadic_of_sme(s, int(m), -scale_bits)
def interval_from_decimals(lo_dec, hi_dec, digits=40):
    """Stored interval from two Decimals, endpoints converted OUTWARD to exact dyadics (pure python; used by negative-control plants)."""
    return interval_from_dyadics(dec_to_dyadic(lo_dec, "lo"), dec_to_dyadic(hi_dec, "hi"), digits)
