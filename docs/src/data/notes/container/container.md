---
---
The MusicXML zip file format is compatible with the zip format used by the java.util.zip package and Java JAR files. It is based on the Info-ZIP format described at:

http://www.info-zip.org/doc/appnote-19970311-iz.zip

The JAR file format is specified at:

https://docs.oracle.com/javase/8/docs/technotes/guides/jar/jar.html

Note that, compatible with JAR files, file names should be encoded in UTF-8 format.

Files with the zip container are compressed the DEFLATE algorithm. The DEFLATE Compressed Data Format (RFC 1951) is specified at:

https://www.ietf.org/rfc/rfc1951.txt

The recommended media type for a compressed MusicXML file is:

    application/vnd.recordare.musicxml

The recommended media type for an uncompressed MusicXML file is:

    application/vnd.recordare.musicxml+xml

The first file in the zip container should be a file named mimetype. The contents of this file should be the MIME media type string

    application/vnd.recordare.musicxml

encoded in US-ASCII. The mimetype file must not be compressed or encrypted, and there must not be an extra field in its zip header. The contents of the mimetype file must not contain any leading padding or white space and must not begin with a byte order mark. Older versions of MusicXML did not specify this mimetype file, so applications may see containers without a mimetype file.

The recommended file extension for compressed MusicXML files is .mxl. The recommended file extension for uncompressed MusicXML files is .musicxml. Older versions of MusicXML use .xml as the extension for uncompressed MusicXML files, so it is recommended that applications be prepared to read files with the .xml extension as well.

It is recommended that applications that run on macOS and iOS use the following Uniform Type Identifier for MusicXML files:

```xml
<array>
    <dict>
        <key>UTTypeIdentifier</key>
        <string>com.recordare.musicxml.uncompressed</string>
        <key>UTTypeReferenceURL</key>
        <string>http://www.musicxml.org/</string>
        <key>UTTypeDescription</key>
        <string>MusicXML File</string>
        <key>UTTypeTagSpecification</key>
        <dict>
            <key>public.filename-extension</key>
            <array>
                <string>musicxml</string>
            </array>
            <key>public.mime-type</key>
            <array>
                <string>application/vnd.recordare.musicxml+xml</string>
            </array>
        </dict>
        <key>UTTypeConformsTo</key>
        <array>
            <string>public.xml</string>
        </array>
    </dict>
    <dict>
        <key>UTTypeIdentifier</key>
        <string>com.recordare.musicxml</string>
        <key>UTTypeReferenceURL</key>
        <string>http://www.musicxml.org/</string>
        <key>UTTypeDescription</key>
        <string>MusicXML File</string>
        <key>UTTypeTagSpecification</key>
        <dict>
            <key>public.filename-extension</key>
            <array>
                <string>mxl</string>
            </array>
            <key>public.mime-type</key>
            <array>
                <string>application/vnd.recordare.musicxml</string>
            </array>
        </dict>
        <key>UTTypeConformsTo</key>
        <array>
            <string>public.zip-archive</string>
        </array>
    </dict>
</array>
```
