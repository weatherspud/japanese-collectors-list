#!/usr/bin/env python
import csv
import os
import sys

PRODUCT_TYPES = ['box set', 'rulebook', 'supplement', 'scenario', 'replay', 'periodical', 'gamebook']
HEADER = ['product_type', 'japanese', 'english', 'publisher', 'year']

def checklist(paths, fout):
    writer = csv.writer(fout)
    writer.writerow(['category'] + HEADER)
    for path in paths:
        category = os.path.basename(os.path.dirname(path))
        with open(path) as f:
            header = None
            for row in csv.reader(f):
                if header:
                    outrow = [row[header.index(h)] if h in header else ''
                              for h
                              in HEADER]
                    outrow.insert(0, category)
                    writer.writerow(outrow)
                else:
                    header = row
                    assert('japanese' in header)


if __name__ == '__main__':
    if len(sys.argv) < 2:
        raise Exception('USAGE: checklist.py PATHS')
    checklist(sys.argv[1:], sys.stdout)
