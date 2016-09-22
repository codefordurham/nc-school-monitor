import sys
import pandas as pd

HEADER_MAP = {
    'lea': 'lea_code',
}

def clean_header(row):
    ret = []
    for c in row:
        c = c.replace('\n', ' ')
        c = c.replace('-', ' ')
        c = c.replace('%', ' percent ')
        c = c.replace('#', ' number ')
        c = c.replace('/', ' ')
        c = '_'.join(c.split())
        c = c.lower()
        c = HEADER_MAP.get(c, c)
        ret.append(c)
    return ret

def fix_lea(x):
    if isinstance(x, int):
        return '{0:03d}'.format(x)
    else:
        return x
if __name__ == '__main__':
    school_year = sys.argv[1]
    school_type = sys.argv[2]
    d = pd.read_csv(sys.stdin, na_values=['-', 'None'])
    d.columns = clean_header(d.columns)
    d['lea_code'] = d.lea_code.map(fix_lea)
    if 'school_code' in d.columns:
        d['school_code'] = d.school_code.map(lambda x: '{0:06d}'.format(x))
    else:
        d['school_code'] = d.lea_code.map(lambda x: x+'000')
    d['school_year'] = school_year
    d['school_type'] = school_type
    if 'school_type_description' not in d.columns:
        d['school_type_description'] = None
    if 'school_program_type_description' not in d.columns:
        d['school_program_type_description'] = None
    if 'school_calendar_description' not in d.columns:
        d['school_calendar_description'] = None
    d.to_csv(sys.stdout, index=False)
