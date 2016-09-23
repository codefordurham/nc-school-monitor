import sys
import pandas as pd

def clean_header(row):
    return row

if __name__ == '__main__':
    filename = sys.argv[1]
    skiprows = int(sys.argv[2])

    d = pd.read_excel(filename, skiprows=skiprows)
    d.columns = clean_header(d.columns)
    d.to_csv(sys.stdout, index=False)
