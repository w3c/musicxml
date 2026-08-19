# MusicXML Tests

## Dependencies
- Python 3
- [SaxonC-HE](https://pypi.org/project/saxonche/)
- [xmllint](https://gitlab.gnome.org/GNOME/libxml2)
- [jq](https://jqlang.org/)

## Getting started
```shell
sudo apt-get update && sudo apt-get install libxml2-utils python3-pip jq && pip install saxonche
git clone --recurse-submodules git@github.com:w3c-cg/musicxml.git
cd tests && ./test.sh
```

## Theory of operation
The test suite is run by Bash script `test.sh`. It performs the following types of validations:

- The MusicXML schemas (`../schema/*.xsd`) are _syntactically_ valid with `XMLSchema.xsd` (a copy of the [official XML Schema 1.0 for XML Schemas](https://www.w3.org/2001/XMLSchema))
- The MusicXML test files (`files/**/*.xml,*.musicxml`) are _syntactically_ valid with `musicxml.xsd`
- Select MusicXML test files are _semantically_ valid with [Schematron validations](https://www.schematron.com/) at `validations/*.sch`
- Select MusicXML test files, when downgraded to the previous MusicXML schema version (via `../schema/toXY.xsl`), are _syntactically_ valid with the corresponding previous version of `musicxml.xsd` (as per the `git` tag `vX.Y`)

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
  "repeats-jumps-invalid.musicxml": {
    "repeats-jumps.sch": "pass"
  },
  "repeats-jumps-invalid.musicxml": {
    "repeats-jumps.sch": "fail"
  },
  "harmonic-element.musicxml": {
    "to40.xsl": "pass"
  }
}
```

By default, any test file is expected to `pass` against `musicxml.xsd` unless otherwise noted in `assertions.json`. Also by default, any test file is expected to `skip` any Schematron validation `.sch` and any version downgrading `toXY.xsl` unless otherwise noted.

## Writing new Schematron validations
- Identify an existing `.sch` validation whose topic matches best your desired validation, or create a new one.
- In your assertions, you can use XPath 3.0 expressions.
- Transpile the `.sch` to `.xsl`:
```shell
$ ./transpile.py validations/validation-name.sch > validations/validation-name.xsl
```
- Add relevant test cases to `files`. The convention is to add 2 files, one named `validation-name.musicxml` for valid cases, another called `validation-name-invalid.musicxml` for invalid cases.
- Add the relevant entries to `assertions.json`
- Test your validations:
```shell
$ TEST=schematron ./test.sh
```
- Download the latest Schematron transpiler and update the validations:
```shell
$ ./transpile.sh
```

## Credits
- The repo [`musicxmlTestSuite`](https://github.com/w3c-cg/musicxmlTestSuite) was generously donated by [Michael Asato Cuthbert](https://www.trecento.com), former MusicXML spec editor and W3C Music Notation Community Group co-chair.
- The [Schematron transpiler](./transpile.xsl) is part of the [`schxslt2`](https://codeberg.org/SchXslt/schxslt2) repo, maintained by David Maus.
