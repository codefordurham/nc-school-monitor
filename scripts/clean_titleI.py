import pandas as pd
import numpy as np


def fix_school_year(x):
    if x is np.nan:
        return x
    x = str(x)
    return ''.join((x[:5], x[-2:]))

def fix_code(x):
    'fix the lea_code and school_code in the case where excel made float vs str'
    x = x[:-2] if x.endswith('.0') else x
    if len(x) in (2, 5):
        x = '0' + x
    return x

def fix_code_charter(x):
    'fix school_code when school is a charter based on lea code and the school_code is not padded with zeros.'
    if x.lea_code[-1] in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' and len(x.school_code) != 6:
        return x.lea_code + '000'
    return x.lea_code    

if __name__ == '__main__':
    import sys
    d = pd.read_csv(sys.stdin)
    d.school_year = d.school_year.map(fix_school_year)
    d.served_1st_year = d.served_1st_year.map(fix_school_year)
    d['lea_code'] = d.lea_code.map(fix_code)
    d['school_code'] = d.school_code.map(fix_code)
    d['school_code'] = d.apply(fix_code_charter, axis=1)
    del d['lea_code']
    d['is_title_I'] = True
    d.to_csv(sys.stdout, index=False)
