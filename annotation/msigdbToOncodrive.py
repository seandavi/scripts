#!/usr/bin/env python
import argparse
parser = argparse.ArgumentParser("Convert MSigDb gmt file to tab-delimited text for use by oncodrivefm")

parser.add_argument('gmtfile',
                    help="The name of a gmt-format file downloaded from MSigDb")

opts = parser.parse_args()

with open(opts.gmtfile,'r') as infile:
    for line in infile:
        spline = line.strip().split("\t")
        geneset = spline[0]
        for gene in spline[2:]:
            print("{}\t{}".format(gene,geneset))
