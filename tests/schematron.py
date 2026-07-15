#!/usr/bin/env python

import argparse
import sys
from lxml import etree
from lxml.isoschematron import Schematron

# Don't print stack trace with exception.
sys.tracebacklimit = 0

def main():
  parser = argparse.ArgumentParser()
  parser.add_argument('schema')
  parser.add_argument('target')
  parser.add_argument('--noout', action='store_true', help='Suppress report display')
  args = parser.parse_args()

  with open(args.schema, 'r') as schema_file:
    schema_doc = etree.parse(schema_file)
  schematron = Schematron(schema_doc, store_report=True)

  with open(args.target, 'r') as target_file:
    target_doc = etree.parse(target_file)
  valid = schematron.validate(target_doc)

  if not valid or not args.noout:
    sys.stdout.write(str(schematron.validation_report))

  if valid:
    sys.stderr.write(f'{args.target} validates with {args.schema}\n')

  sys.exit(None if valid else f'{args.target} fails to validate with {args.schema}')

if __name__ == '__main__':
  main()
