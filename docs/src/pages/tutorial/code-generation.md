---
title: Code Generation
---

Many MusicXML developers now use code generation or data binding tools to automatically generate code from the musicxml.xsd schema file. These tools typically generate classes based on the schema data structures in a particular programming language, and automate reading and writing to MusicXML files. A few examples available as of June 2021 are:

- xjc, included in the Java Architecture for XML Binding (JAXB)
- CodeSynthesis XSD and XSD/e tools for generating C++ data bindings
- xsData data binding library for Python

There are some issues in MusicXML's design that often cause some difficulties for data binding tools. This is because MusicXML's design pre-dates not only these tools, but the W3C XML Schema recommendation itself. Later versions of MusicXML maintain full compatibility with MusicXML 1.0, so we cannot change these parts of the schema to make things work more easily with these tools.

These problems are common among code generation and data binding tools:

- Incomplete support for XML catalogs that keep the xlink and xml schemas from being imported correctly.
- Confusion between the coda attribute and the [`<coda>`](../../musicxml-reference/elements/coda/) child element in the [`<barline>`](../../musicxml-reference/elements/barline/) element.
- Confusion between the segno attribute and the [`<segno>`](../../musicxml-reference/elements/segno/) child element in the `<barline>` element.
- Confusion between the two different placements of the [`<link>`](../../musicxml-reference/elements/link/) and [`<bookmark>`](../../musicxml-reference/elements/bookmark/) child elements within the [`<credit>`](../../musicxml-reference/elements/credit/) element.

Fortunately there are straightforward workarounds for these issues. Let's take the example of the xjc tool included with Java SE versions up through Java 8. We try to compile the code from the terminal using

```bash
xjc -catalog catalog.xml musicxml.xsd
```

Our first problem is that even though xjc has a catalog parameter, the Java 8 implementation of this feature is incomplete and does not work with MusicXML. We will get warning messages and errors about the xlink.xsd and xml.xsd files that will keep it from parsing.

This can be worked around by editing the version of the musicxml.xsd file you use to generate the bindings to reference local copies directly, rather than via the XML catalog.

```xml
<xs:import namespace="http://www.w3.org/XML/1998/namespace" schemaLocation="xml.xsd"/>
<xs:import namespace="http://www.w3.org/1999/xlink" schemaLocation="xlink.xsd"/>
```

This will let xjc parse the schema. Now it will encounter the other problems listed above. We will get error messages like these:

```bash
- \[ERROR\] Element "link" shows up in more than one properties.
- \[ERROR\] Property "Segno" is already defined. Use <jaxb:property> to resolve this conflict.
- \[ERROR\] Property "Segno" is already defined. Use <jaxb:property> to resolve this conflict.
```

JAXB and xjc allow you to specify an external bindings file to guide the choice of data bindings. These files typically have an .xjb file extension. You can then specify the external bindings file in the -b parameter when running xjc from the command line.

Let's create a musicxml.xjb external bindings file with the following content:

```
<bindings xmlns="http://java.sun.com/xml/ns/jaxb" xmlns:xsi="http://www.w3.org/2000/10/XMLSchema-instance" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.1">
    <bindings schemaLocation="musicxml.xsd" version="1.0">
        <!-- Customize the package name -->
        <schemaBindings>
            <package name="org.musicxml"/>
        </schemaBindings>

        <bindings node="//xs:complexType\[@name='barline'\]">
            <bindings node=".//xs:attribute\[@name='segno'\]">
                <property name="segnoAttribute"/>
            </bindings>
        </bindings>

        <bindings node="//xs:complexType\[@name='barline'\]">
            <bindings node=".//xs:attribute\[@name='coda'\]">
                <property name="codaAttribute"/>
            </bindings>
        </bindings>

        <bindings node="//xs:complexType\[@name='credit'\]">
            <bindings node="./xs:sequence/xs:element\[@name='link'\]">
                <property name="firstLink"/>
            </bindings>
            <bindings node="./xs:sequence/xs:element\[@name='bookmark'\]">
                <property name="firstBookmark"/>
            </bindings>
        </bindings>
    </bindings>
</bindings>
```

Now we can run xjc using this external bindings file:

```bash
xjc -catalog catalog.xml -b musicxml.xjb musicxml.xsd
```

When we do this, xjc runs without any error messages, and the .java files are placed in the org/musicxml folder.

Other code generation and binding tools may encounter related problems, and the solutions are often similar. Usually you can provide some type of external information to resolve conflicts that can come up in automatic code generation.