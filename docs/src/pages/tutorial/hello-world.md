---
title: '"Hello World" in MusicXML'
pagefindMeta: 'Tutorial: "Hello World" in MusicXML'
---

Brian Kernighan and Dennis Ritchie popularized the practice of writing a program that prints the words "hello, world" as the first program to write when learning a new programming language. It is the minimal program that tests how to build a program and display its results.

In MusicXML, a song with the lyrics "hello, world" is actually more complicated than we need for a simple MusicXML file. Let us keep things even simpler: a one-measure piece of music that contains a whole note on middle C, based in 4/4 time:

![Middle C](../../assets/img/tutorial/tutorial-hello-world.png)

Here it is in MusicXML:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE score-partwise PUBLIC
    "-//Recordare//DTD MusicXML 4.1 Partwise//EN"
    "http://www.musicxml.org/dtds/partwise.dtd">
<score-partwise version="4.1">
  <part-list>
    <score-part id="P1">
      <part-name>Music</part-name>
    </score-part>
  </part-list>
  <part id="P1">
    <measure number="1">
      <attributes>
        <divisions>1</divisions>
        <key>
          <fifths>0</fifths>
        </key>
        <time>
          <beats>4</beats>
          <beat-type>4</beat-type>
        </time>
        <clef>
          <sign>G</sign>
          <line>2</line>
        </clef>
      </attributes>
      <note>
        <pitch>
          <step>C</step>
          <octave>4</octave>
        </pitch>
        <duration>4</duration>
        <type>whole</type>
      </note>
    </measure>
  </part>
</score-partwise>
```

Let's look at each element in turn.

## XML Declaration

```xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
```

This is the XML declaration required of all XML documents. We have specified that the characters are written in the Unicode encoding UTF-8. This encoding provides backwards compatibility with ASCII.

## Doctype and Schema

```xml
<!DOCTYPE score-partwise PUBLIC
    "-//Recordare//DTD MusicXML 4.1 Partwise//EN"
    "http://www.musicxml.org/dtds/partwise.dtd">
```

This is the document type declaration for applications that use XML Document Type Definitions (DTDs). It lets those applications know this is a MusicXML file. When using a document type declaration, we also set the value of standalone to "no" in the XML declaration since we are defining the document with an external definition in another file.

The MusicXML DTDs are deprecated as of Version 4.0 in favor of the W3C XML Schema Definition (XSD). However there are still applications using DTDs. When writing MusicXML files, writing the document type declaration makes it easier for all applications - XSD or DTD based - to validate MusicXML files.

This public document type declaration includes an Internet location for the DTD. The URL in this declaration is just for reference. Most applications will know that they are expecting a MusicXML file and will want to validate against their own local copy of the MusicXML schemas. Use MusicXML's XML catalog to validate against the local copy, rather than reading the XSD or DTD definitions slowly over the network.

## Score Partwise

```xml
<score-partwise version="4.1">
```

This is the root document type. The `<score-partwise>` element is made up of parts, where each part is made up of measures. There is also a `<score-timewise>` option which is made up of measures, where each measure is made up of parts. The version attribute lets programs distinguish what version of MusicXML is being used more easily. Leave it out if you are writing MusicXML 1.0 files.

## Part List

```xml
<part-list>
	<score-part id="P1">
		<part-name>Part 1</part-name>
	</score-part>
</part-list>
```

Whether you have a partwise or timewise score, a MusicXML file starts off with a header that lists the different musical parts in the score. The above example is the minimal part-list possible: it contains one `<score-part>` element, the required id attribute for the score-part, and the required `<part-name>` element.

## Part

```xml
<part id="P1">
```

We are now beginning the first (and only, in this case) part within the document. The id attribute here must refer to an id attribute for a score-part in the header. Every part must have a unique id attribute. Because ids cannot start with a number, they are often created by starting with the letter P and adding the part number, starting with 1: P1, P2, P3, etc.

## Measure

```xml
<measure number="1">
```

We are starting the first measure in the first part.

## Attributes

```xml
<attributes>
```

The `<attributes>` element contains key information needed to interpret the notes and musical data that follow in this part.

### Divisions

```xml
<divisions>1</divisions>
```

Each note in MusicXML has a `<duration>` element. The `<divisions>` element provides the unit of measure for the duration element in terms of divisions per quarter note. Since all we have in this file is one whole note, we never have to divide a quarter note, so we set the divisions value to 1.

Musical durations are typically expressed as fractions, such as "quarter" and "eighth" notes. MusicXML durations are fractions, too. Since the denominator rarely needs to change, it is represented separately in the divisions element, so that only the numerator needs to be associated with each individual note. This is similar to the scheme used in MIDI to represent note durations.

### Key

```xml
<key>
	<fifths>0</fifths>
</key>
```

The `<key>` element is used to represent a key signature. Here we are in the key of C major, with no flats or sharps, so the `<fifths>` element is 0. If we were in the key of D major with 2 sharps, fifths would be set to 2. If we were in the key of F major with 1 flat, fifths would be set to -1. The name "fifths" comes from the representation of a key signature along the circle of fifths. It lets us represent standard key signatures with one element, instead of separate elements for sharps and flats.

### Time

```xml
<time>
	<beats>4</beats>
	<beat-type>4</beat-type>
</time>
```

The `<time>` element represents a time signature. Its two component elements, `<beats>` and `<beat-type>`, are the numerator and denominator of the time signature, respectively.

### Clef

```xml
<clef>
	<sign>G</sign>
	<line>2</line>
</clef>
```

MusicXML allows for many different clefs, including many no longer used today. Here, the standard treble clef is represented by a G clef on the second line of the staff (e.g., the second line from the bottom of the staff is a G).

## Note

```xml
</attributes>
<note>
```

We are done with the attributes, and are ready to begin the first note.

### Pitch

```xml
<pitch>
	<step>C</step>
	<octave>4</octave>
</pitch>
```

The `<pitch>` element must have a `<step>` and an `<octave>` element. Optionally it can have an `<alter>` element, if there is a flat or sharp involved. These elements represent the pitch that is played, so the `<alter>` element must always be included if used, even if the alteration is in the key signature. In this case, we have no alteration. The pitch step is C. The octave of 4 indicates the octave that starts with middle C. Thus this note is a middle C.

### Duration

```xml
<duration>4</duration>
```

Our divisions value is 1 division per quarter note, so the duration of 4 is the length of 4 quarter notes.

The `<duration>` element should reflect the intended duration, not a longer or shorter duration specific to a certain performance. The `<note>` element has attack and release attributes specify how to change a note's start and stop times from the times represented through a sequence of durations.

### Type

```xml
<type>whole</type>
```

The `<type>` element tells us that this is notated as a whole note. You could probably derive this from the duration in this case, but it is easier to work with both notation and performance applications if the notation and performance data is represented separately.

The order in which these elements appear does matter. In the `<note>` element, the `<pitch>` element must precede the `<duration>` element, and the `<type>` element must come afterwards. The correct order is specified throughout the documentation.

One limitation of XML's document type definitions is that if you want to limit the number of elements within another element, you generally must also restrict how they are ordered. In the attributes, for instance, we want no more than one `<divisions>` element. For the note's pitch, we want one and only one `<step>` element and `<octave>` element. In order to do this, the order in which these elements appear must be constrained as well.

```xml
</note>
```

We are done with the note.

```xml
</measure>
```

We are done with the measure.

```xml
</part>
```

We are done with the part.

```xml
</score-partwise>
```

And we are done with the score.

Next: [The Structure of MusicXML Files](../structure-of-musicxml-files/)