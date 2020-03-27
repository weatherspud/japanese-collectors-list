#!/usr/bin/env python3
import argparse
import csv
import os

IMAGE_PREFIX_FMT = 'https://raw.githubusercontent.com/weatherspud/japanese-collectors-list/master/{subdir}'
DEFAULT_ITEMS_PER_ROW = 4
HEADER_YEAR = 'year'
HEADER_JAPANESE = 'japanese'
HEADER_ENGLISH = 'english'
HEADER_PUBLISHER = 'publisher'
HEADER_IMAGE = 'image'

def gallery(args):
    checklist_path = os.path.join(args.subdir, 'checklist.csv')
    image_prefix = IMAGE_PREFIX_FMT.format(subdir=args.subdir)
    with open(checklist_path, encoding='utf-8') as f:
        reader = csv.reader(f)
        rows = list(reader)
        header = rows[0]
        print('<table><tr>')
        for i, row in enumerate(rows[1:]):
            image = row[header.index(HEADER_IMAGE)]
            japanese = row[header.index(HEADER_JAPANESE)]
            english = row[header.index(HEADER_ENGLISH)]
            year = ''
            try:
                year = row[header.index(HEADER_YEAR)]
            except ValueError:
                pass
            print(f'<td valign="top"><img src="{image_prefix}/{image}" height="240"><br/><b>{japanese}</b><br/>{english}<br/>{year}</td>')
            if i % args.items_per_row == 3:
                print('</tr><tr>')
        print('</tr></table>')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--subdir', '-d',
                        dest='subdir',
                        required=True)
    parser.add_argument('--items-per-row',
                        dest='items_per_row',
                        type=int,
                        default=DEFAULT_ITEMS_PER_ROW)
    args = parser.parse_args()
    gallery(args)
