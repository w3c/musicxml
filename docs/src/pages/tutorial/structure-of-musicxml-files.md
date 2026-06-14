---
title: The Structure of MusicXML Files
---

## Adapting Musical Scores to a Hierarchy

Say we have a piece of music for two or more people to play. It has multiple parts, one per player, and multiple measures. XML represents data in a hierarchy, but musical scores are more like a lattice. How do we reconcile this? Should the horizontal organization of musical parts be primary, or should the vertical organization of musical measures?

The answer is different for every music application. David Huron, a music cognition specialist and the inventor of Humdrum, advised us to make sure we could represent music both ways, and be able to switch between them easily.

This is why MusicXML has two different score formats, each with its own root element. For a partwise document, the root element is [`<score-partwise>`](../../musicxml-reference/elements/score-partwise/). The musical part is primary, and measures are contained within each part. For a timewise document, the root element is [`<score-timewise>`](../../musicxml-reference/elements/score-timewise/). The measure is primary, and musical parts are contained within each measure.

Having two different structures does not work well if there is no automatic way to switch between them. MusicXML provides two XSLT stylesheets to convert back and forth between the two document types. The [parttime.xsl](../../listings/parttime.xsl/) stylesheet converts from `<score-partwise>` to `<score-timewise>`, while the [timepart.xsl](../../listings/timepart.xsl/) stylesheet converts from `<score-timewise>` to `<score-partwise>`.

An application reading MusicXML can choose which format is primary, and check for that document type. If it is your root element, just proceed. If not, check to see if it is the other MusicXML root element. If so, apply the appropriate XSLT stylesheet to create a new MusicXML document in your preferred format, and then proceed. If it is neither of the two top-level document types, you do not have a MusicXML score, and can return an appropriate error message.

When your application writes to MusicXML, simply write to whichever format best meets your needs. Let the program reading the MusicXML convert it if necessary.

In practice, most of today's MusicXML applications use the `<score-partwise>` format. If all else is equal, that would be the format of choice for your application.

## Top-Level Elements

Each of the top-level formats contains a group of elements called the score header, followed by the musical data. The only difference between the two formats is the way that the `<part>` and `<measure>` elements are arranged. A `<score-partwise>` document contains one or more [`<part>`](../../musicxml-reference/elements/part-partwise/) elements, and each `<part>` element contains one or more [`<measure>`](../../musicxml-reference/elements/measure-partwise/) elements. The `<score-timewise>` document reverses the ordering of [`<measure>`](../../musicxml-reference/elements/measure-timewise/) and [`<part>`](../../musicxml-reference/elements/part-timewise/) elements.

In either case, the lower-level elements are filled with a group of elements referred to as music data. This contains the actual music in the score, including zero or more of the following elements:

- [`<note>`](../../musicxml-reference/elements/note/)
- [`<backup>`](../../musicxml-reference/elements/backup/)
- [`<forward>`](../../musicxml-reference/elements/forward/)
- [`<direction>`](../../musicxml-reference/elements/direction/)
- [`<attributes>`](../../musicxml-reference/elements/attributes/)
- [`<harmony>`](../../musicxml-reference/elements/harmony/)
- [`<figured-bass>`](../../musicxml-reference/elements/figured-bass/)
- [`<print>`](../../musicxml-reference/elements/print/)
- [`<sound>`](../../musicxml-reference/elements/sound/)
- [`<listening>`](../../musicxml-reference/elements/listening/)
- [`<barline>`](../../musicxml-reference/elements/barline/)
- [`<grouping>`](../../musicxml-reference/elements/grouping/)
- [`<link>`](../../musicxml-reference/elements/link/)
- [`<bookmark>`](../../musicxml-reference/elements/bookmark/)

The score header may contain the following elements:

- [`<work>`](../../musicxml-reference/elements/work/)
- [`<movement-number>`](../../musicxml-reference/elements/movement-number/)
- [`<movement-title>`](../../musicxml-reference/elements/movement-title/)
- [`<identification>`](../../musicxml-reference/elements/identification/)
- [`<defaults>`](../../musicxml-reference/elements/defaults/)
- [`<credit>`](../../musicxml-reference/elements/credit/)
- [`<part-list>`](../../musicxml-reference/elements/part-list/) (Required)

We will now look at the score header in more detail. If the example in the preceding “Hello World” section gave you enough information, you may want to skip ahead to the next section that starts describing music data.

## Score Header

The score header contains some basic metadata about a musical score, such as the title and composer. It also contains the `<part-list>`, which lists all the parts or instruments in a musical score.

As an example, take our MusicXML encoding of “Mut,” the 22nd song from Franz Schubert’s song cycle _Winterreise_. Here is a sample score header for that work:

```xml
<work>
	<work-number>D. 911</work-number>
	<work-title>Winterreise</work-title>
</work>
<movement-number>22</movement-number>
<movement-title>Mut</movement-title>
<identification>
	<creator type="composer">Franz Schubert</creator>
	<creator type="poet">Wilhelm Müller</creator>
	<rights>Copyright © 2001 Recordare LLC</rights>
	<encoding>
		<encoding-date>2002-02-16</encoding-date>
		<encoder>Michael Good</encoder>
		<software>Finale 2002 for Windows</software>
		<encoding-description>MusicXML 1.0 example</encoding-description>
	</encoding>
	<source>Based on Breitkopf &amp; Härtel edition of 1895</source>
</identification>
<part-list>
	<score-part id="P1">
		<part-name>Singstimme.</part-name>
	</score-part>
	<score-part id="P2">
		<part-name>Pianoforte.</part-name>
	</score-part>
</part-list>
```

You see that this score header has all five of the possible top-level elements in the score header: the `<work>`, `<movement-number,>` `<movement-title>`, `<identification>`, and `<part-list>`. Only the part-list is required, all other elements are optional. Let’s look at each element in turn:

```xml
<work>
	<work-number>D. 911</work-number>
	<work-title>Winterreise</work-title>
</work>
```

In MusicXML, individual movements are usually represented as separate files. The [`<work>`](../../musicxml-reference/elements/work/) element is used to identify the larger work of which this movement is a part. Schubert’s works are more commonly referred to via D. numbers than opus numbers, so that is what we use in the [`<work-number>`](../../musicxml-reference/elements/work-number/) element; the [`<work-title>`](../../musicxml-reference/elements/work-title/) contains the name of the larger work. If you have all the movements in a work represented, you can use the [`<opus>`](../../musicxml-reference/elements/opus-reference/) element to link to the MusicXML [opus file](../../opus-reference/elements/opus/) that in turn contains links to all the movements in the work.

```xml
<movement-number>22</movement-number>
```

_Winterreise_ is a cycle of 24 songs. We use the [`<movement-number>`](../../musicxml-reference/elements/movement-number/) to identify that “Mut” is the 22nd song in the cycle – it is not restricted to use for movements in a symphony.

```xml
<movement-title>Mut</movement-title>
```

Similarly, we use the [`<movement-title>`](../../musicxml-reference/elements/movement-title/) element for the title of the individual song. If you have a single song that is not part of a collection, you will usually put the title of the song in the `<movement-title>` element, and not use either the `<work>` or `<movement-number>` elements.

```xml
<identification>
	<creator type="composer">Franz Schubert</creator>
	<creator type="poet">Wilhelm Müller</creator>
```

The [`<identification>`](../../musicxml-reference/elements/identification/) element contains basic metadata elements based on the [Dublin Core](https://dublincore.org/specifications/dublin-core/). In this song, as many others, there are two creators: in this case, the composer and the poet. Therefore, we use two [`<creator>`](../../musicxml-reference/elements/creator/) elements, and distinguish their roles with the type attribute. The type attribute should still be used even for an instrumental work with just one composer.

```xml
<rights>Copyright © 2001 Recordare LLC</rights>
```

The [`<rights>`](../../musicxml-reference/elements/rights/) element contains the copyright notice. You may have multiple `<rights>` elements if multiple copyrights are involved, say for the words and the music. As with the `<creator>` element, these can have type attributes to indicate what type of copyright is involved. In this example, both the words and music to Mut are in the public domain, but this element specifies a copyright to the electronic edition of the work.

```xml
<encoding>
	<encoding-date>2002-02-16</encoding-date>
	<encoder>Michael Good</encoder>
	<software>Finale 2002 for Windows</software>
	<encoding-description>MusicXML 1.0 example</encoding-description>
</encoding>
```

The [`<encoding>`](../../musicxml-reference/elements/encoding/) element contains information about how the MusicXML file was created. Here we are using all four of the available sub-elements to describe the encoding. You can have multiple instances of these elements, and they can appear in any order.

```xml
	<source>Based on Breitkopf &amp; Härtel edition of 1895</source>
</identification>
```

Different editions of music will contain different musical information. In our case, we used the Dover reprint of the Breitkopf & Härtel edition of _Winterreise_ as our starting point, correcting some errors in that published score.

The `<identification>` element also may contain a [`<miscellaneous>`](../../musicxml-reference/elements/miscellaneous/) element. This in turn contains [`<miscellaneous-field>`](../../musicxml-reference/elements/miscellaneous-field/) elements, each with a name attribute. This can be helpful if your software contains some identification information not present in the MusicXML schema that you want to preserve when saving and reading from MusicXML.

```xml
<part-list>
	<score-part id="P1">
		<part-name>Singstimme.</part-name>
	</score-part>
	<score-part id="P2">
		<part-name>Pianoforte.</part-name>
	</score-part>
</part-list>
```

The [`<part-list>`](../../musicxml-reference/elements/part-list/) is the one element in the score header that is required in all MusicXML scores. It is made up of a series of [`<score-part>`](../../musicxml-reference/elements/score-part/) elements, each with a required id attribute and [`<part-name>`](../../musicxml-reference/elements/part-name/) element. By convention, apps often number the parts as “P1”, “P2”, etc. to create the id attributes. You may use whatever technique you like as long as it produces unique names for each `<score-part>`.

In addition to the `<part-name>`, there are many optional elements that can be included in a `<score-part>`:

- An `<identification>` element, helpful if individual parts come from different sources.
- One or more [`<part-link>`](../../musicxml-reference/elements/part-link/) elements, used to link a part document from a score document.
- A [`<part-name-display>`](../../musicxml-reference/elements/part-name-display/) element for exact formatting of a part name.
- A [`<part-abbreviation>`](../../musicxml-reference/elements/part-abbreviation/) element. Often, you will use the `<part-name>` for the name used at the start of the score, and the `<part-abbreviation>` for the abbreviated name used in succeeding systems.
- A [`<part-abbreviation-display>`](../../musicxml-reference/elements/part-abbreviation-display/) element for exact formatting of a part abbreviation.
- A [`<group>`](../../musicxml-reference/elements/group/) element, used when different parts can be used for different purposes. Different parts may be used for a printed score, a printed part, a MIDI sound file, or for data analysis.
- One or more [`<score-instrument>`](../../musicxml-reference/elements/score-instrument/) elements, used to describe instrument sounds and virtual instrument settings, as well as to define multiple instruments within a `<score-part>`. This element serves as a reference point for MIDI instrument changes.
- One or more [`<player>`](../../musicxml-reference/elements/player/) elements for use in listening applications.
- One or more [`<midi-device>`](../../musicxml-reference/elements/midi-device/) elements for identifying the MIDI devices or ports that are being used in a multi-port configuration. Multiple devices let you get beyond MIDI 1.0’s 16-channel barrier.
- One or more [`<midi-instrument>`](../../musicxml-reference/elements/midi-instrument/) elements, specifying the initial MIDI setup for each `<score-instrument>` within a part.

Next: [The MIDI-Compatible Part of MusicXML](../midi-compatible-part/)