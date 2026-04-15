---
title: Overview
---
The MusicXML 4.1 schemas and stylesheets are contained in the schema folder within the release. The key files are listed here:

- [musicxml.xsd](../musicxml.xsd), the MusicXML W3C XML Schema Definition
- [xlink.xsd](../xlink.xsd), the W3C XML Schema Definition for the xlink namespace subset used in MusicXML
- [xml.xsd](../xml.xsd), the W3C XML Schema Definition for the xml namespace subset used in MusicXML
- [container.xsd](../container.xsd), the MusicXML container W3C XML Schema Definition
- [opus.xsd](../opus.xsd), the MusicXML opus W3C XML Schema Definition
- [sounds.xsd](../sounds.xsd), the MusicXML sounds W3C XML Schema Definition
- [sounds.xml](../sounds.xml), listing all the MusicXML standard sound identifiers
- [catalog.xml](../catalog.xml), the standard XML catalog for use with reading MusicXML files
- [to40.xsl](../to40.xsl), the XSLT stylesheet for converting from MusicXML 4.1 to MusicXML 4.0
- [to31.xsl](../to31.xsl), the XSLT stylesheet for converting from MusicXML 4.0 to MusicXML 3.1
- [to30.xsl](../to30.xsl), the XSLT stylesheet for converting from MusicXML 3.1 to MusicXML 3.0
- [to20.xsl](../to20.xsl), the XSLT stylesheet for converting from MusicXML 3.0 to MusicXML 2.0
- [to11.xsl](../to11.xsl), the XSLT stylesheet for converting from MusicXML 2.0 to MusicXML 1.1
- [to10.xsl](../to10.xsl), the XSLT stylesheet for converting from MusicXML 1.1 to MusicXML 1.0
- [parttime.xsl](../parttime.xsl), the XSLT stylesheet for converting from `<score-partwise>` to `<score-timewise>` files
- [timepart.xsl](../timepart.xsl), the XSLT stylesheet for converting from `<score-partwise>` to `<score-timewise>` files

Several deprecated files are also included in the schema folder for compatibility with older software. The contents of these files are not included this report.

The following files make up the deprecated Document Type Definition version of MusicXML 4.1:

- partwise.dtd
- timewise.dtd
- opus.dtd
- container.dtd
- sounds.dtd
- attributes.mod
- barline.mod
- common.mod
- direction.mod
- identity.mod
- layout.mod
- link.mod
- note.mod
- score.mod
- isolat1.ent
- isolat2.ent

The following files are used for the deprecated XML representation of Standard MIDI 1.0 Files:
- midixml.dtd
- midixml.xsl
