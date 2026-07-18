#!/usr/bin/env python3
"""
Schematron to XSLT transpiler using schxslt2 and SaxonC HE.
Transpiles a .sch file to .xsl and outputs to stdout.
"""

import sys
import argparse
from saxonche import PySaxonProcessor

# Don't print stack trace with exception.
sys.tracebacklimit = 0

def transpile_schematron(sch_file: str, transpile_xsl: str) -> str:
    """
    Transpile a Schematron file to XSLT using the schxslt2 transpile.xsl.

    Args:
        sch_file: Path to the .sch Schematron file
        transpile_xsl: Path to the schxslt2 transpile.xsl file

    Returns:
        The resulting XSLT as a string
    """
    # Initialize Saxon processor
    with PySaxonProcessor(license=False) as proc:
        # Parse the transpile XSLT
        xslt_executable = proc.new_xslt30_processor()

        # Prepare static parameters as a dictionary
        xslt_executable.set_parameter('{http://dmaus.name/ns/2023/schxslt}report-fired-rule', proc.make_boolean_value(False))
        xslt_executable.set_parameter('{http://dmaus.name/ns/2023/schxslt}compact-report', proc.make_boolean_value(True))

        # Compile stylesheet with static parameters
        executable = xslt_executable.compile_stylesheet(stylesheet_file=transpile_xsl)

        # Load the Schematron source
        source = proc.parse_xml(xml_file_name=sch_file)

        # Apply the transformation
        return executable.transform_to_string(xdm_node=source)

def main():
    parser = argparse.ArgumentParser(
        description='Transpile Schematron (.sch) to XSLT (.xsl) using schxslt2'
    )
    parser.add_argument(
        'sch_file',
        help='Path to the Schematron file (.sch) to transpile'
    )
    parser.add_argument(
        '-t', '--transpile-xsl',
        default='transpile.xsl',
        help='Path to the schxslt2 transpile.xsl file (default: ./transpile.xsl)'
    )
    args = parser.parse_args()

    # Transpile and output to stdout
    result = transpile_schematron(args.sch_file, args.transpile_xsl)
    print(result)

if __name__ == '__main__':
    main()