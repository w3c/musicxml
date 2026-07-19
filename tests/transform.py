#!/usr/bin/env python3
"""
Run an XSLT transformation SaxonC HE and outputs to stdout.
"""

import sys
import argparse
from saxonche import PySaxonProcessor

# Don't print stack trace with exception.
sys.tracebacklimit = 0

def transform(xml_file: str, xsl_file: str) -> str:
    with PySaxonProcessor(license=False) as proc:
        xslt_executable = proc.new_xslt30_processor()
        executable = xslt_executable.compile_stylesheet(stylesheet_file=xsl_file)
        source = proc.parse_xml(xml_file_name=xml_file)
        return executable.transform_to_string(xdm_node=source)

def main():
    parser = argparse.ArgumentParser(
        description='Transform XML using XSLT.'
    )
    parser.add_argument(
        'xsl_file',
        help='Path to the XSL transformation'
    )
    parser.add_argument(
        'xml_file',
        help='Path to the XML file to transform'
    )
    args = parser.parse_args()
    result = transform(args.xml_file, args.xsl_file)
    print(result)

if __name__ == '__main__':
    main()