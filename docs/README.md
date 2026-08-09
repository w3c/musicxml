# MusicXML Docs

This is the build system for the MusicXML site. It is based on the [Astro content publishing system](https://astro.build/).

## Information architecture
The site provides the following sections:
- Overview and tutorial
- XML Schema references
- File listings
- Version history

The site layout includes the following navigation sections:
- Header
- Site navigation sidebar
- Main content area
- Page navigation menu

## Overview and tutorial section
This is a set of Markdown files that include code listings and image snapshots of score renderings.

## File listings section
Each XSD, XML and XSL file in `schema/` is displayed in this section.

## Version history section
This is a simple collection of Markdown files detailing the changes for each version of the MusicXML spec, including links to the relevant GitHub issues where applicable.

## XML Schema references sections
The MusicXML spec includes 4 XML Schema definitions:
- The core MusicXML schema `musicxml.xsd`
- The Container schema `container.xsd` which packages multiple scores and other assets in a compressed zip format
- The Opus schema `opus.xsd` which represents logical collections of works
- The Sounds schema `sounds.xsd` which represents collections of instrument sounds for application interchange

For each of these schemas, 3 sections are defined in the site:
- A reference of all schema elements, organized in alphabetical and hierarchical order
- A reference of all data types used by the above elements
- A list of examples illustrating the usage of various elements

## XML Schema elements and data types
These sections take their corresponding XML Schema as source of truth, transforming each schema into Astro pages via a multi-step process:
- Transform the XML Schema into a linear JSON listing of all elements and their relevant attributes, via XSL transformation [`elements.xsl`](./src/xsl/elements.xsl).
- Transform the XML Schema into a hierarchical JSON listing for the tree view, via XSL transformation [`elements-tree.xsl`](./src/xsl/elements-tree.xsl).
- Transform the XML Schema into a linear JSON listing of all data types, via XSL transformation [`datatypes.xsl`](./src/xsl/datatypes.xsl).
- Read the above JSON listings into [Astro content collections](https://docs.astro.build/en/guides/content-collections/).
- Generate listing and detail pages for each collection using standard Astro constructs.
- The Astro components `Element.astro` and `ElementContent.astro` are responsible for rendering XML Schema elements.
- Illustrative images for elements are found in `docs/src/assets/img/elements/[schema]`. An image is included in an element detail page when its filename matches the element name.
- Additional Markdown notes for elements are found in `docs/data/notes/[schema]`. A note is included in an element detail page when its filename matches the element name.
- The Astro components `DataType.astro` and `DataTypeValueRow.astro` are responsible for rendering XML Schema data types.
- Illustrative images for data type enumeration values are found in `docs/src/assets/img/datatypes/[schema]`. An image is shown for an enumeration value when its filename matches the datatype-value name.

## XML Schema examples
For each schema, a folder of Markdown examples in `docs/src/data/examples/[schema]` is read into an Astro collection. The examples are expected to follow a specific format to be recognized:
```markdown
---
title: Title of the example
elements:
- elements
- to-be
- highlighted
description: Narrative describing the example.
---
'''xml
<score-partwise version="4.1"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:noNamespaceSchemaLocation="http://www.musicxml.org/xsd/musicxml.xsd">
   <part-list>
      <score-part id="P1">
         <part-name>Soprano Alto</part-name>
[..]
'''
```
MusicXML examples can also be stored in the same folder `docs/src/data/examples/[schema]` with extension `.musicxml`. The MusicXML file overrides the above `xml` snippet when its filename matches the example Markdown. Similarly, illustrative images are found in `docs/src/assets/img/examples/[schema]`. An image is included in an example when their filenames match.

## Development
- To build the full site: `npm i && npm run build`
- To develop and hot-reload: `npm run start`
- To rebuild the JSON listings from modified XSD schema files: `npm run build:schema`
- To debug an XSL transformation against a given schema: `npm run debug:xsl transformation schema-file` (without file extensions)
- To validate a modified XSD schema (requires `xmllint`): `npm run debug:xsd schema-file` (without file extension)

## Deployment
- Set `ORIGIN` environment variable to be your host URL's origin (default is https://w3c-cg.github.io). `.env` works too.
- If `ORIGIN` is left unset or blank, the GitHub CI/CD will not proceed with build / deploy steps.
