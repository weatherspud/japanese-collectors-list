#!/usr/bin/env python3
import csv
import os
import sys

PRODUCT_TYPES = ['box set', 'rulebook', 'supplement', 'scenario', 'replay', 'periodical', 'gamebook', 'slipcase set', 'novel', 'manga']
HEADER = ['product_type', 'japanese', 'english', 'publisher', 'year', 'product_code']


def checklist(paths, fout):
    writer = csv.writer(fout)
    writer.writerow(['category'] + HEADER)
    for path in sorted(paths):
        category = os.path.basename(os.path.dirname(path))
        try:
            with open(path) as f:
                header = None
                for row in csv.reader(f):
                    if header:
                        if 'product_type' in header and row[header.index('product_type')]:
                            product_type = row[header.index('product_type')]
                            if product_type not in PRODUCT_TYPES:
                                raise Exception('{}: not a product type {}'.format(path, product_type))
                        outrow = [row[header.index(h)] if h in header else ''
                                  for h
                                  in HEADER]
                        outrow.insert(0, category)
                        writer.writerow(outrow)
                    else:
                        header = [o.lstrip('\ufeff') for o in row]
                        assert('japanese' in header)
        except FileNotFoundError:
            sys.stderr.write(f'WARNING not found: {path}\n')


if __name__ == '__main__':
    if len(sys.argv) < 2:
        raise Exception('USAGE: checklist.py PATHS')
    checklist(sys.argv[1:], sys.stdout)
