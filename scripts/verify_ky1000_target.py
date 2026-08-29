#!/usr/bin/env python3
"""verify_ky1000_target.py - r12 (GPT r11 hw 159-168, 216-219).
Checks the DEFINITION of the KY1000 target set P used by the Family Theorem:
  P = the first 1000 primes l > 10^9 with l = 65 (mod 128)
    = { l prime : 10^9 < l <= 1001287361, l = 65 (mod 128) }.
Independent of Sage and of the certificate verifier: pure Python, deterministic Miller-Rabin
(bases 2..37, exact for n < 3.3e24; here n < 1.1e9).
Asserts: (1) 1000 entries (2) distinct (3) ascending (4) all prime (5) all = 65 mod 128
(6) all > 10^9 (7) elementwise equal to the regenerated first 1000 qualifying primes
(8) witness file set == list (9) interval form holds (no qualifying prime <= max P is missing).
Usage: verify_ky1000_target.py [list] [witness_dir]      -> "KY1000 TARGET VERIFY: PASS"
       verify_ky1000_target.py --negctl                    -> 5 planted corruptions must be REJECTED
Exit 0 on PASS, 1 otherwise. Every failure names the violated assertion.
"""
import sys, os, tempfile

LIST = 'sage/family_ky1000/KY1000_primes.txt'
WDIR = 'certificates/family/KY1000'
N, RES, MOD, LOW = 1000, 65, 128, 10**9

def is_prime(n):
    if n < 2: return False
    small = (2,3,5,7,11,13,17,19,23,29,31,37)
    for p in small:
        if n % p == 0: return n == p
    d, s = n-1, 0
    while d % 2 == 0: d //= 2; s += 1
    for a in small:
        x = pow(a, d, n)
        if x in (1, n-1): continue
        for _ in range(s-1):
            x = x*x % n
            if x == n-1: break
        else: return False
    return True

def regenerate(count=N, low=LOW):
    l = low + 1 + ((RES - (low+1)) % MOD)
    out, scanned = [], 0
    while len(out) < count:
        scanned += 1
        if is_prime(l): out.append(l)
        l += MOD
    return out, scanned

def check(list_path, wdir):
    ship = [int(x) for x in open(list_path).read().split()]
    if len(ship) != N: return 'FAIL A1 count %d != %d' % (len(ship), N)
    if len(set(ship)) != N: return 'FAIL A2 duplicates present'
    if ship != sorted(ship): return 'FAIL A3 not ascending'
    bad = [x for x in ship if not is_prime(x)]
    if bad: return 'FAIL A4 composite entries: %s' % bad[:3]
    bad = [x for x in ship if x % MOD != RES]
    if bad: return 'FAIL A5 entries not = %d mod %d: %s' % (RES, MOD, bad[:3])
    bad = [x for x in ship if x <= LOW]
    if bad: return 'FAIL A6 entries <= 10^9: %s' % bad[:3]
    gen, scanned = regenerate()
    if gen != ship:
        i = next(k for k in range(N) if gen[k] != ship[k])
        return 'FAIL A7 regenerated list differs at index %d: regenerated %d, shipped %d' % (i, gen[i], ship[i])
    if wdir is not None:
        files = sorted(int(f.split('_l')[1].split('.')[0]) for f in os.listdir(wdir) if f.startswith('witness_n7_l') and f.endswith('.txt'))
        if files != ship: return 'FAIL A8 witness file set != list (%d files)' % len(files)
    # A9 interval form: every qualifying prime in (10^9, max P] is in the list (implied by A7; checked directly)
    interval = [l for l in range(LOW + 1 + ((RES-(LOW+1)) % MOD), ship[-1]+1, MOD) if is_prime(l)]
    if interval != ship: return 'FAIL A9 interval form {10^9 < l <= %d, l = 65 mod 128} != list' % ship[-1]
    return 'PASS scanned %d candidates ; min %d ; max %d' % (scanned, ship[0], ship[-1])

def negctl():
    ship = [int(x) for x in open(LIST).read().split()]
    extra = regenerate(N+2)[0][N:]          # the 1001st and 1002nd qualifying primes (pass A1-A6, fail A7/A9)
    cases = {
      'nc_target_corrupted': ship[:500] + [ship[500] + 2] + ship[501:],              # one entry altered (composite, wrong class) -> A4/A5
      'nc_target_missing':   ship[:300] + ship[301:] + [extra[0]],                    # drop one qualifying prime, pad with the 1001st -> A7
      'nc_target_duplicate': ship[:999] + [ship[998]],                                # last entry duplicated -> A2
      'nc_target_unsorted':  ship[:10] + [ship[11], ship[10]] + ship[12:],            # two neighbours swapped -> A3
      'nc_target_replaced':  sorted(ship[:999] + [extra[1]]),                         # sorted, distinct, all prime, all = 65: only A7/A9 catch it
    }
    ok = 0
    for name, lst in cases.items():
        with tempfile.NamedTemporaryFile('w', suffix='.txt', delete=False) as f:
            f.write('\n'.join(map(str, lst)) + '\n'); p = f.name
        r = check(p, None); os.unlink(p)
        rej = r.startswith('FAIL')
        ok += rej
        print('%s: %s :: %s' % (name, 'REJECTED (correct)' if rej else 'ACCEPTED (WRONG)', r))
    print('KY1000 TARGET NEGCTL: %s %d/5' % ('ALL_REJECTED' if ok == 5 else 'FAIL', ok))
    return 0 if ok == 5 else 1

if __name__ == '__main__':
    if len(sys.argv) > 1 and sys.argv[1] == '--negctl':
        sys.exit(negctl())
    lp = sys.argv[1] if len(sys.argv) > 1 else LIST
    wd = sys.argv[2] if len(sys.argv) > 2 else WDIR
    r = check(lp, wd)
    print('KY1000 TARGET VERIFY: ' + r)
    sys.exit(0 if r.startswith('PASS') else 1)
