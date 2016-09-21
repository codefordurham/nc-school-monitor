'''Filter to clean and normalize csv headers.'''
import csv
import sys

def clean(row):
    ret = []
    for c in row:
        c = c.replace('\n', '_')
        c = c.replace(' ', '_')
        c = c.lower()
        ret.append(c)
    return ret

if __name__ == '__main__':
    reader = csv.reader(sys.stdin)
    writer = csv.writer(sys.stdout)

    header = next(reader)
    writer.writerow(clean(header))
    for row in reader:
        writer.writerow(row)
