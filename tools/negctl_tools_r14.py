#!/usr/bin/env python3
"""negctl_tools_r14.py - negative controls for the r14 gates themselves (step 00d). Never touches the tree: tampered copies of
the certificate / ledger are written to a temp dir and the gates are pointed at them through CN_CERT / NEGCTL_LEDGER.
Each planted defect MUST be caught (gate prints FAIL or exits non-zero); the constant-sync gate also runs --selftest
(planted stale prose forms). Prints one line per control and "TOOLS NEGCTL: PASS" iff every control is caught."""
import json, subprocess, os, sys, tempfile, shutil
J = 'certificates/constants/Cn_interval_r14.json'; N = 'certificates/negctl/negctl_ledger_r14.json'
tmp = tempfile.mkdtemp(prefix='negctl_tools_r14_')
def run(cmd, env=None):
    e = dict(os.environ); e.update(env or {}); r = subprocess.run(cmd, shell=True, capture_output=True, text=True, env=e); return r
def tampered_cert(f):
    d = json.load(open(J)); f(d); p = os.path.join(tmp, 'cn_%d.json' % len(os.listdir(tmp))); json.dump(d, open(p, 'w'), indent=1); return p
def tampered_ledger(f):
    d = json.load(open(N)); f(d); p = os.path.join(tmp, 'ng_%d.json' % len(os.listdir(tmp))); json.dump(d, open(p, 'w'), indent=1); return p
def r7(d): return [r for r in d['rows'] if r['n'] == 7][0]
controls = []
def cn_case(name, mutate, expect):
    p = tampered_cert(mutate); r = run('python3 tools/gen_cn_certs.py --check', {'CN_CERT': p})
    ok = ('CN CERT CHECK: FAIL' in r.stdout or r.returncode != 0) and (expect in r.stdout); controls.append((name, ok, expect))
cn_case('NC1 display digit altered (…834054 -> …834061)', lambda d: r7(d).update(display=r7(d)['display'].replace('834054e30', '834061e30')), 'display is not the truncated prefix')
cn_case('NC2 upper endpoint set equal to lower', lambda d: r7(d).update(C_hi=r7(d)['C_lo']), 'identical')
cn_case('NC3 lower endpoint raised above upper', lambda d: r7(d).update(C_lo=r7(d)['C_hi'].replace('E+30', '1E+30')), 'lo >= hi')
cn_case('NC4 frozen deg-1 threshold integer changed', lambda d: d['thresholds_n7'].update(deg1_int='1727342163036353095979941756930'), 'frozen r6 thresholds changed')
cn_case('NC5 upper endpoint above the deg-1 threshold', lambda d: r7(d).update(C_hi='1.8' + r7(d)['C_hi'][3:]), 'threshold assertion fails')
cn_case('NC6 producing script sha256 mismatch', lambda d: d.update(script_sha256='0' * 64), 'sha256 changed')
cn_case('NC7 certified prefix count inflated', lambda d: r7(d).update(certified_prefix_digits=160), 'prefix digit count mismatch')
cn_case('NC8 assertions field not ALL PASS', lambda d: d.update(assertions='FAIL: planted'), 'not ALL PASS')
# negctl ledger
p = tampered_ledger(lambda d: d.update(negative_controls=7, rejected=7)); r = run('python3 tools/gen_negctl_ledger.py --check', {'NEGCTL_LEDGER': p})
controls.append(('NC9 negctl ledger count 7 vs log 9', 'NEGCTL LEDGER: FAIL' in r.stdout and 'ledger 7 != log 9' in r.stdout, 'ledger 7 != log 9'))
p = tampered_ledger(lambda d: d.update(source_sha256='0' * 64)); r = run('python3 tools/gen_negctl_ledger.py --check', {'NEGCTL_LEDGER': p})
controls.append(('NC10 negctl ledger source sha mismatch', 'NEGCTL LEDGER: FAIL' in r.stdout, 'source_sha256'))
# constant-sync gate: ledger says 7 -> media (which say 9) must fail; certificate display altered -> media must fail; planted prose (--selftest)
p = tampered_ledger(lambda d: d.update(negative_controls=7, rejected=7)); r = run('python3 tools/check_constant_sync.py', {'NEGCTL_LEDGER': p})
controls.append(('NC11 sync gate vs ledger 7', 'CONSTANT SYNC: FAIL' in r.stdout and ('nine' in r.stdout or '9/9' in r.stdout), 'media say 9, ledger 7'))
p = tampered_cert(lambda d: r7(d).update(display=r7(d)['display'].replace('834054e30', '834061e30'))); r = run('python3 tools/check_constant_sync.py', {'CN_CERT': p})
controls.append(('NC12 sync gate vs altered certificate display', 'CONSTANT SYNC: FAIL' in r.stdout and 'C_7 display' in r.stdout, 'display mismatch'))
r = run('python3 tools/check_constant_sync.py --selftest'); import re
m = re.search(r'SELFTEST: (\d+)/(\d+)', r.stdout); controls.append(('NC13-20 sync gate --selftest planted prose forms', bool(m) and m.group(1) == m.group(2) and int(m.group(1)) >= 8, m.group(0) if m else 'no selftest line'))
shutil.rmtree(tmp, ignore_errors=True)
allok = all(c[1] for c in controls)
for name, ok, ev in controls: print('%s :: %s :: %s' % (name, 'CAUGHT (correct)' if ok else 'MISSED', ev))
print('TOOLS NEGCTL: %s (%d/%d caught)' % ('PASS' if allok else 'FAIL', sum(c[1] for c in controls), len(controls)))
sys.exit(0 if allok else 1)
