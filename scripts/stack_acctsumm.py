import sys
import pandas as pd


HEADER_MAP = {
    '': '', 
}

def clean(row):
    ret = []
    for c in row:
        c = c.replace('\n', ' ')
        c = c.replace('-', ' ')
        c = c.replace('%', ' percent ')
        c = c.replace('#', ' number ')
        c = c.replace('/', ' or ')
        c = '_'.join(c.split())
        c = c.lower()
        c = HEADER_MAP.get(c, c)
        ret.append(c)
    return ret

if __name__ == '__main__':
    d16 = pd.read_csv('cleaned/2015-16/acctsumm.csv')
    d15 = pd.read_csv('cleaned/2014-15/acctsumm.csv')
    d14 = pd.read_csv('cleaned/2013-14/acctsumm.csv')

    d16['school_year'] = '2015-16'
    d15['school_year'] = '2014-15'
    d14['school_year'] = '2013-14'

    d16.columns = clean(d16.columns)
    d15.columns = clean(d15.columns)
    d14.columns = clean(d14.columns)

    d = pd.concat([d16, d15, d14], ignore_index=True)

    col = list(d16.columns)
    for c in sorted(set(d.columns) - set(d16.columns)):
        col.append(c)
        
    d = d[col]
    d.to_csv(sys.stdout, index=False)
