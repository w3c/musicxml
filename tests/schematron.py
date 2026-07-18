#!/usr/bin/env python3
"""
Run a transpiled Schematron XSLT against an XML document and report validation results.
Exit code 0 if no failed assertions, exit code 1 if there are failed assertions.
"""

import sys
import argparse
from saxonche import PySaxonProcessor

# Don't print stack trace with exception.
sys.tracebacklimit = 0

def validate_xml(xml_file: str, xsl_file: str) -> dict:
    """
    Validate an XML document against a transpiled Schematron XSLT.

    Args:
        xml_file: Path to the XML document to validate
        xsl_file: Path to the transpiled Schematron XSLT

    Returns:
        Dictionary containing validation results
    """
    # Initialize Saxon processor
    with PySaxonProcessor(license=False) as proc:
        # Compile the Schematron XSLT
        xslt_executable = proc.new_xslt30_processor()
        executable = xslt_executable.compile_stylesheet(stylesheet_file=xsl_file)

        # Load the XML document
        source = proc.parse_xml(xml_file_name=xml_file)

        # Apply the transformation to get SVRL output
        svrl_xml = executable.transform_to_string(xdm_node=source)

        # Parse the result to extract failed assertions
        svrl_doc = proc.parse_xml(xml_text=svrl_xml)

        # Create XPath processor
        xpath_processor = proc.new_xpath_processor()
        xpath_processor.declare_namespace('svrl', 'http://purl.oclc.org/dsdl/svrl')

        # Extract failed assertions
        failed_asserts = []
        xpath_processor.set_context(xdm_item=svrl_doc)
        failed_nodes = xpath_processor.evaluate('//svrl:failed-assert')
        if failed_nodes:
            for node in failed_nodes:
                xpath_processor.set_context(xdm_item=node)
                text = xpath_processor.evaluate('svrl:text/text()').head.get_string_value(encoding="UTF-8").strip()
                location = xpath_processor.evaluate('@location').head.get_string_value(encoding="UTF-8").replace('Q{}', '').strip()
                failed_asserts.append(f"{location}: {text}")

        return {
            'success': len(failed_asserts) == 0,
            'failed_asserts': failed_asserts,
            'svrl_output': svrl_xml
        }

def main():
    parser = argparse.ArgumentParser(
        description='Validate XML against a transpiled Schematron schema',
        epilog='Exit code 0 if valid, 1 if there are failed assertions'
    )
    parser.add_argument(
        'xsl_file',
        help='Path to the transpiled Schematron XSLT file'
    )
    parser.add_argument(
        'xml_file',
        help='Path to the XML document to validate'
    )
    parser.add_argument(
        '-q', '--quiet',
        action='store_true',
        help='Suppress output of failed assertions (still returns appropriate exit code)'
    )
    parser.add_argument(
        '-o', '--output-svrl',
        help='Save the raw SVRL output to a file'
    )
    args = parser.parse_args()

    # Run validation
    result = validate_xml(args.xml_file, args.xsl_file)

    # Save SVRL output if requested
    if args.output_svrl:
        with open(args.output_svrl, 'w', encoding='utf-8') as f:
            f.write(result['svrl_output'])

    # Report results
    if result['success']:
        if not args.quiet:
            print(f"{args.xml_file} validates with {args.xsl_file}", file=sys.stderr)
        sys.exit(0)
    else:
        if not args.quiet:
            failed_count = len(result['failed_asserts'])
            print(f"{args.xml_file} fails to validate with {args.xsl_file}", file=sys.stderr)

            for i, failed in enumerate(result['failed_asserts'], 1):
                print(failed, file=sys.stderr)
        sys.exit(1)

if __name__ == '__main__':
    main()