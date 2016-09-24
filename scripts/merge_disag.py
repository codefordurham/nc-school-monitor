import pandas as pd
import sqlite3
import sys

def extract(school_year, path):
    filename = 'Disag_{}_Data.txt'.format(school_year)
    return pd.read_csv(
        path + filename,
        sep='\t',
        #na_values='-',
        dtype={'school_code':'object'},
    )

def etl_recent(school_year, con, path):
    'extract files from 2013 onward'
    df = extract(school_year, path)
    df['school_year'] = school_year
    df.to_sql('disag', con, index=False, if_exists='append')


if __name__ == '__main__':

    path = sys.argv[1]
    outfile = sys.argv[2]
    con = sqlite3.connect(outfile) 
    
    etl_recent('2015-16', con, path)
    etl_recent('2014-15', con, path)
    etl_recent('2013-14', con, path)
