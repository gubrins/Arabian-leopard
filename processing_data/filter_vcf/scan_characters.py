#!/usr/bin/env python

import sys

chars = [c for c in sys.argv[1]]

for line in sys.stdin:
    line = line.strip()
    if line.startswith(">"):
        chrom = line.replace(">","").split()[0]
        cpos  = 0
    else:
        for i,c in enumerate(line):
            if c in chars:
                print(chrom, cpos+i, cpos+i+1, sep="\t")
        cpos += len(line)
