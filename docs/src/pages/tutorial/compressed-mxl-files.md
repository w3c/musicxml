---
title: Compressed .MXL Files
---

Regular, plain text MusicXML files can be very large - much larger than the original music notation application files, or corresponding MIDI files. This was not a big problem for using MusicXML as an interchange format, but it inhibited MusicXML’s use as a sheet music distribution format.

MusicXML 2.0 introduced a new compressed format which reduces MusicXML file sizes to roughly the same size as the corresponding MIDI files. The format uses zip compression and a special .mxl file suffix and Internet media type to identify files as MusicXML files vs. generic XML files. This section describes how the compressed format works.

## Compressed File Format

MusicXML uses a zip-based XML format similar to that used by Open Office and many other XML formats. The MusicXML 4.0 and later zip file format is compatible with the zip format used by the java.util.zip package and Java JAR files. It is based on the Info-ZIP format described at:

[http://www.info-zip.org/doc/appnote-19970311-iz.zip](http://www.info-zip.org/doc/appnote-19970311-iz.zip)

The JAR file format is specified at:

[https://docs.oracle.com/javase/8/docs/technotes/guides/jar/jar.html](https://docs.oracle.com/javase/8/docs/technotes/guides/jar/jar.html)

Note that, compatible with JAR files, file names should be encoded in UTF-8 format.

Files with the zip container are compressed the DEFLATE algorithm. The DEFLATE Compressed Data Format (RFC 1951) is specified at:

[https://www.ietf.org/rfc/rfc1951.txt](https://www.ietf.org/rfc/rfc1951.txt)

By making these choices, software can usually use the zip libraries available for Java and most other programming languages to create the compressed zip files.

## File Suffixes and Media Types

The recommended file suffixes for MusicXML files are .mxl for compressed files and .musicxml for uncompressed files. Using unique file suffixes lets programs distinguish MusicXML files from generic XML files in a way that using the .xml suffix for uncompressed files does not.

Many XML editing tools such as XMLSpy and Oxygen now support the editing of zip-compressed XML files. All that is necessary is to let the editor application know that .mxl files are a zip-based format. The editor will then let you edit both the structure of the .mxl file as well as the .musicxml files that are contained within the zip archive.

MusicXML has registered media types available for both compressed .mxl and uncompressed .musicxml files. The recommended media type for a compressed MusicXML file is:

`application/vnd.recordare.musicxml`

The recommended media type for an uncompressed MusicXML file is:

`application/vnd.recordare.musicxml+xml`

## Zip Archive Structure

Following the example of many zip-based XML formats, MusicXML has a strictly defined way to determine where the root MusicXML file is within an archive. Each MusicXML zip archive has a file located at META-INF/container.xml. This container describes the starting point for the MusicXML version of the file, as well as alternate renditions such as PDF and audio versions of the musical score.

The container.xml file is defined by the container.dtd file. Given the simplicity of the format, there is no corresponding .xsd file at this time.

As an example, let us look at the Dichterliebe01.mxl file available on the MakeMusic web site. Here is its META-INF/container.xml file:

```xml
<?xml version="1.0" encoding="UTF-8">
<container>
  <rootfiles>
    <rootfile full-path="Dichterliebe01.musicxml" media-type="application/vnd.recordare.musicxml+xml"/>
  </rootfiles>
</container>
```

The [`<container>`](../../container-reference/elements/container/) element is the document element for this file. It contains a single [`<rootfiles>`](../../container-reference/elements/rootfiles/) element. The `<rootfiles>` element in turn contains one or more [`<rootfile>`](../../container-reference/elements/rootfile/) elements. The MusicXML root must be described in the first `<rootfile>` element. The full-path attribute provides the path relative to the root folder of the zip file. A MusicXML file used as a `<rootfile>` may have [`<score-partwise>`](../../musicxml-reference/elements/score-partwise/), [`<score-timewise>`](../../musicxml-reference/elements/score-timewise/), or [`<opus>`](../../opus-reference/elements/opus/) as its document element.

Additional `<rootfile>` elements can describe alternate versions such as PDF and audio files. Multiple `<rootfile>` elements can be distinguished by each one having a different media-type attribute value. For instance, if the Dichterliebe01.mxl file contained a PDF rendition as well as the MusicXML file, the container.xml file would look like this:

```xml
<?xml version="1.0" encoding="UTF-8">
<container>
  <rootfiles>
    <rootfile full-path="Dichterliebe01.musicxml" media-type="application/vnd.recordare.musicxml+xml"/>
    <rootfile full-path="Dichterliebe01.pdf" media-type="application/pdf"/>
  </rootfiles>
</container>
```

If no media-type value is present, a MusicXML file is assumed. However, if multiple rootfiles are present, it will probably make things more clear to include the media-type attribute for all `<rootfile>` elements.

The zip archive can also include images that are referenced with the MusicXML [`<image>`](../../musicxml-reference/elements/image/) and [`<credit-image>`](../../musicxml-reference/elements/credit-image/) elements, parts that are referenced with the MusicXML [`<part-link>`](../../musicxml-reference/elements/part-link/) element, or other media that are referenced using the MusicXML link element. MusicXML 4.0 and later does not specify where these files need to be located in the zip file, but it is probably least confusing if images or other files of a similar type are grouped together in a subfolder within the zip archive.

The first file in the zip container should be a file named mimetype. The contents of this file should be the MIME media type string

`application/vnd.recordare.musicxml`

The mimetype file should be encoded in US-ASCII and must not be compressed or encrypted, and there must not be an extra field in its zip header. The contents of the mimetype file must not contain any leading padding or white space, and must not begin with a byte order mark.

The mimetype file helps applications identify a compressed MusicXML file by reading the first few bytes of the file. EPUB and other zip-based formats also use a mimetype file for the same reason. Older versions of MusicXML before version 3.1 did not specify this mimetype file, so applications may still see containers without it.

Next: [Code Generation](../code-generation/)