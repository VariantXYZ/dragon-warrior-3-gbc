## Converts XLSX file to CSV file for bin conversion
## Usage: python3 scripts/xlsx2csv.py ../sheet.xlsx ./text/dialog SHEET1 SHEET2 SHEET3
import sys
import re
import openpyxl as xl
import csv
from os import path

sys.path.append(path.join(path.dirname(__file__), 'common'))
from common import utils

xlsx = sys.argv[1]
csvdir = sys.argv[2]
SHEETS = list(sys.argv[3:])

wb = xl.load_workbook(filename = xlsx)

for sheet in wb.worksheets:
    if not sheet.title in SHEETS:
        continue
    values = sheet.values
    data = sheet.rows
    header = next(values)

    index_idx = header.index('Index') # Index must precede all useful data (data before the pointer index is ignored)
    text_idx = header.index('Text') 
    fieldnames = header
    file_path = path.join(csvdir, "{0}.csv".format(sheet.title))
    text = []
    for line in data:
        if data is None:
            continue
        idx = line[index_idx].value
        txt = line[text_idx].value.replace('\n', '<F1>') if line[text_idx].value else ""
        text.append([idx, txt])
    
    with open(file_path, "w", encoding='utf-8', newline='\n') as csvfile:
        print("Writing {0}".format(file_path))
        writer = csv.writer(csvfile, lineterminator='\n', delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
        for row in text:
            writer.writerow(row)