#!/usr/bin/env python3
"""ledger_summary.py - normalized, platform-independent summary of a KY1000 verification run (r13; GPT r12 hw 27-30 / tracker 283-286).

  python3 tools/ledger_summary.py <run_dir>                  -> writes <run_dir>/SUMMARY_NORMALIZED.json and prints a digest
  python3 tools/ledger_summary.py --compare <run_dir_A> <run_dir_B>   -> exit 0 iff the NORMALIZED summaries agree prime by prime

<run_dir> holds VERIFY_LEDGER.txt and verify_logs/verify_n7_l<prime>.log as written by scripts/family_verify_clean.sh.
Per prime the summary records: verdict, components certified / total, lines, failed lines, number of RHO and of T lines
accepted (CERT), the largest accepted T upper endpoint and the smallest accepted RHO upper endpoint (each rounded to 1e-6),
and the sha256 of the witness file. The sha256 of the raw verifier log is carried as a FORENSIC field only and is NOT compared:
raw logs may differ byte-wise across OS / architecture / Arb printing while the mathematical verdict is identical.
The comparison is the hard gate; the raw-log hash is informational.
"""
import sys, os, re, json, hashlib
def sha(p):
    h=hashlib.sha256(); h.update(open(p,'rb').read()); return h.hexdigest()
def summarize(run):
    led=os.path.join(run,'VERIFY_LEDGER.txt'); logs=os.path.join(run,'verify_logs')
    out={}
    for l in open(led):
        if ' | ' not in l or l.startswith('#'): continue
        f=[x.strip() for x in l.split(' | ')]
        prime=f[0]; rec={'verdict':f[1],'components':f[2],'witness_sha256':f[3],'raw_log_sha256_forensic':f[4]}
        lp=os.path.join(logs,'verify_n7_l%s.log'%prime)
        rho=[];T=[];lines=failed=None
        if os.path.exists(lp):
            for s in open(lp):
                m=re.match(r'\S+ (RHO|T)\s+.*upper=([0-9.eE+-]+)\s+CERT\s*$',s)
                if m: (rho if m.group(1)=='RHO' else T).append(float(m.group(2)))
                m=re.search(r'lines (\d+) ; failed lines (\d+)',s)
                if m: lines,failed=int(m.group(1)),int(m.group(2))
        rec.update({'lines':lines,'failed_lines':failed,'n_rho_cert':len(rho),'n_t_cert':len(T),
                    'max_T_upper':round(max(T),6) if T else None,'min_rho_upper':round(min(rho),6) if rho else None})
        out[prime]=rec
    return out
def compare(A,B):
    keys=['verdict','components','witness_sha256','lines','failed_lines','n_rho_cert','n_t_cert','max_T_upper','min_rho_upper']
    bad=[]
    if set(A)!=set(B): bad.append('prime sets differ (%d vs %d)'%(len(A),len(B)))
    for p in sorted(set(A)&set(B)):
        for k in keys:
            if A[p].get(k)!=B[p].get(k): bad.append('%s: %s %r != %r'%(p,k,A[p].get(k),B[p].get(k)))
    raw_eq=sum(1 for p in set(A)&set(B) if A[p]['raw_log_sha256_forensic']==B[p]['raw_log_sha256_forensic'])
    return bad, raw_eq
if __name__=='__main__':
    if sys.argv[1]=='--compare':
        A,B=summarize(sys.argv[2]),summarize(sys.argv[3]); bad,raw_eq=compare(A,B)
        print('normalized compare: %d primes ; fields verdict/components/witness sha/lines/failed/rho count/T count/max T upper/min rho upper'%len(A))
        print('raw verifier-log sha256 equal (forensic, not a gate): %d/%d'%(raw_eq,len(A)))
        for b in bad[:20]: print('  DIFF',b)
        print('LEDGER NORMALIZED COMPARE: %s'%('PASS' if not bad and len(A)==1000 else 'FAIL (%d differences, %d primes)'%(len(bad),len(A))))
        sys.exit(0 if not bad and len(A)==1000 else 1)
    run=sys.argv[1]; S=summarize(run)
    json.dump(S,open(os.path.join(run,'SUMMARY_NORMALIZED.json'),'w'),indent=0,sort_keys=True)
    mx=max(v['max_T_upper'] for v in S.values() if v['max_T_upper'] is not None)
    print('primes %d ; EXCLUDED %d ; T certs %d ; RHO certs %d ; max T upper %.6f'%(len(S),sum(v['verdict']=='EXCLUDED' for v in S.values()),sum(v['n_t_cert'] for v in S.values()),sum(v['n_rho_cert'] for v in S.values()),mx))
