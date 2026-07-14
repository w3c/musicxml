#!/usr/bin/env python

import argparse
import sys
from lxml import etree

# Don't print stack trace with exception.
sys.tracebacklimit = 0

def main():
  parser = argparse.ArgumentParser()
  parser.add_argument('xslt')
  parser.add_argument('target')
  args = parser.parse_args()

  with open(args.xslt, 'r') as xslt_file:
    xslt = etree.XSLT(etree.parse(xslt_file))

  with open(args.target, 'r') as target_file:
    target_doc = etree.parse(target_file)

  result = xslt(target_doc)
  print(etree.tostring(result, pretty_print=True).decode())

if __name__ == '__main__':
  main()
