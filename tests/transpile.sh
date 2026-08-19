#!/bin/bash

# - Download latest SchXslt2 Schematron to XSLT 3.0 transpiler
# - Transpile all .sch files into .xsl
wget https://codeberg.org/SchXslt/schxslt2/raw/branch/main/src/main/resources/content/transpile.xsl -O transpile.xsl
for f in validations/*.sch
do
  echo "$f"
  ./transpile.py "$f" > "${f/.sch/.xsl}"
done
