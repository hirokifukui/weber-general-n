#!/usr/bin/env python3
"""gen_correspondence.py - regenerate CORRESPONDENCE.csv from docs/CLAIMS_<round>.yaml (hw 15, 50). Round from argv[1] (r12 default)."""
import yaml,csv,sys,os
root=os.path.join(os.path.dirname(__file__),'..')
rnd=(sys.argv[1] if len(sys.argv)>1 else 'r12').upper()
d=yaml.safe_load(open(os.path.join(root,'docs/CLAIMS_%s.yaml'%rnd)))
with open(os.path.join(root,'CORRESPONDENCE.csv'),'w',newline='') as f:
    w=csv.writer(f)
    w.writerow(['claim_id','paper_location','statement_short','trust_label','lean_declaration','lean_file','certificate_or_log','literature_inputs','status_'+str(d['date']).split(' ')[0]+'_'+d['round']])
    for c in d['claims']:
        w.writerow([c['id'],c.get('paper',''),c['statement'],c['label'],'; '.join(c.get('lean',[])) or '-',c.get('lean_file','-'),'; '.join(c.get('evidence',[])) or '-','; '.join(c.get('inputs',[])) or '-',c.get('status','')])
print("CORRESPONDENCE.csv regenerated from CLAIMS_%s.yaml: %d claims"%(rnd,len(d['claims'])))
