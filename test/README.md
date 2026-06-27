# MusicXML Tests

## Dependencies
- [xmllint](https://gitlab.gnome.org/GNOME/libxml2)
- [lxml](https://lxml.de/)
- [jq](https://jqlang.org/)

## Getting started
```shell
sudo apt-get update && sudo apt-get install libxml2-utils python3-lxml jq
git clone --recurse-submodules git@github.com:w3c-cg/musicxml.git
cd test && ./test.sh
```

## Theory of operation
The test suite is run by Bash script `test.sh`. It performs 3 types of validations:

- The MusicXML schemas (`../schema/*.xsd`) are _syntactically_ valid with `XMLSchema.xsd` (a copy of the [official XML Schema 1.0 for XML Schemas](https://www.w3.org/2001/XMLSchema))
- The MusicXML test files (`musicxmlTestSuite/xmlFiles/*.xml`) are _syntactically_ valid with `musicxml.xsd`
- The MusicXML test files are _semantically_ valid with selected [Schematron validations](https://www.schematron.com/) at `validations/*.sch`

## Skip, pass or fail?
Some MusicXML test files are intentionally invalid, whether syntactically or semantically. In those cases, the test suite should correctly detect failures without failing the test run. We would also like to skip selected test files with selected validations.

To determine which test files are expected to skip / pass / fail against a given validation, the file `assertions.json` is used. It contains entries such as:

```json
{
  "41g-PartNoId.xml": {
    "musicxml.xsd": "fail"
  },
  "74a-FiguredBass.xml": {
    "musicxml.xsd": "fail"
  },
  "99d-AccordionInvalid.xml": {
    "musicxml.xsd": "fail"
  },
  "99e-Repeats.xml": {
    "coda-tocoda.sch": "fail"
  }
}
```

By default, any test file is expected to `pass` against `musicxml.xsd` unless otherwise noted in `assertions.json`. Also by default, any test file is expected to `skip` any Schematron validation `.sch` unless otherwise noted.
