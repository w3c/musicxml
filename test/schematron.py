#!/usr/bin/env python

import argparse
import sys
from lxml import etree
from lxml.isoschematron import Schematron

sys.tracebacklimit = 0

def main():
  parser = argparse.ArgumentParser()
  parser.add_argument('schema')
  parser.add_argument('target')
  args = parser.parse_args()

  with open(args.schema, 'r') as schema_file:
    schema_doc = etree.parse(schema_file)
  schematron = Schematron(schema_doc, store_report=True, error_finder=Schematron.ASSERTS_AND_REPORTS)

  with open(args.target, 'r') as target_file:
    target_doc = etree.parse(target_file)
  valid = schematron.validate(target_doc)

  if valid:
    sys.stdout.write(str(schematron.validation_report))
  else:
    sys.stderr.write(str(schematron.validation_report))

  sys.exit(None if valid else 1)

if __name__ == '__main__':
  main()
