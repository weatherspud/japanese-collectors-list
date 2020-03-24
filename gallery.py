#!/usr/bin/env python3
import argparse
import csv

IMAGE_PREFIX = 'https://raw.githubusercontent.com/weatherspud/japanese-collectors-list/master/fantasy-file'
DEFAULT_ITEMS_PER_ROW = 4
HEADER_YEAR = 'year'
HEADER_JAPANESE = 'japanese'
HEADER_ENGLISH = 'english'
HEADER_PUBLISHER = 'publisher'
HEADER_IMAGE = 'image'

def gallery(args):
    with open(args.checklist_path, encoding='utf-8') as f:
        reader = csv.reader(f)
        rows = list(reader)
        header = rows[0]
        print('<table><tr>')
        for i, row in enumerate(rows[1:]):
            image = row[header.index(HEADER_IMAGE)]
            japanese = row[header.index(HEADER_JAPANESE)]
            english = row[header.index(HEADER_ENGLISH)]
            print(f'<td><img src="{IMAGE_PREFIX}/{image}" height="240"><br/>{japanese}<br/>{english}</td>')
            if i % args.items_per_row == 3:
                print('</tr><tr>')
        print('</tr></table>')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--checklist-path',
                        dest='checklist_path',
                        required=True)
    parser.add_argument('--items-per-row',
                        dest='items_per_row',
                        type=int,
                        default=DEFAULT_ITEMS_PER_ROW)
    args = parser.parse_args()
    gallery(args)
