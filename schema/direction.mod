<!--
	MusicXML direction.mod module

	Version 4.0
	
	Copyright © 2004-2021 the Contributors to the MusicXML 
	Specification, published by the W3C Music Notation Community
	Group under the W3C Community Final Specification Agreement 
	(FSA): 
	
	   https://www.w3.org/community/about/agreements/final/
	
	A human-readable summary is available:
	
	   https://www.w3.org/community/about/agreements/fsa-deed/

	The DTD version of the MusicXML format is deprecated
	as of Version 4.0. Use the musicxml.xsd W3C XML Schema
	definition instead.
-->

<!--
	This direction DTD module contains the direction element
	and its children. Directions are generally not note-specific,
	but instead are associated with a part or the overall score.
	
	Harmony indications and general print and sound
	suggestions are likewise not necessarily attached to
	particular note elements, and are included here as well.
-->

<!-- Entities -->

<!--
	The harmony-arrangement entity indicates how stacked chords
	and bass notes are displayed within a harmony element. The
	vertical value specifies that the second element appears
	below the first. The horizontal value specifies that the
	second element appears to the right of the first. The 
	diagonal value specifies that the second element appears
	both below and to the right of the first.
-->
<!ENTITY % harmony-arrangement
	"arrangement (vertical | horizontal | diagonal) #IMPLIED">

<!--
	The tip-direction entity represents the direction in which
	the tip of a stick or beater points, using Unicode arrow
	terminology.
-->
<!ENTITY % tip-direction 
	"(up | down | left | right | 
	  northwest | northeast | southeast | southwest)">

<!-- Elements -->

<!--
	A direction is a musical indication that is not necessarily
	attached to a specific note. Two or more may be combined to
	indicate words followed by the start of a dashed line, the
	end of a wedge followed by dynamics, etc. For applications
	where a specific direction is indeed attached to a specific
	note, the direction element can be associated with the first
	note element that follows it in score order that is not in a
	different voice.

	By default, a series of direction-type elements and a 
	series of child elements of a direction-type within a 
	single direction element follow one another in sequence
	visually. For a series of direction-type children, non-
	positional formatting attributes are carried over from
	the previous element by default.
-->
<!ELEMENT direction (direction-type+, offset?,
	%editorial-voice;, staff?, sound?, listening?)>
<!ATTLIST direction
    %placement; 
    %directive;
    %system-relation;
    %optional-unique-id;
>

<!--
	Textual direction types may have more than 1 component
	due to multiple fonts. The dynamics element may also be
	used in the notations element, and is defined in the
	common.mod file.
-->
<!ELEMENT direction-type (rehearsal+ | segno+ | coda+ |
	(words | symbol)+ | wedge | dynamics+ | dashes |
	bracket | pedal | metronome | octave-shift | harp-pedals |
	damp | damp-all | eyeglasses | string-mute |
	scordatura | image | principal-voice | percussion+ |
	accordion-registration | staff-divide | other-direction)>
<!ATTLIST direction-type
    %optional-unique-id;
>

<!--
	Entities related to print suggestions apply to the
	individual direction-type, not to the overall direction.
-->

<!--
	The rehearsal element specifies letters, numbers, and 
	section names that are notated in the score for reference
	during rehearsal. The enclosure is square if not specified.
	The language is Italian ("it") if not specified. Left
	justification is used if not specified.
-->
<!ELEMENT rehearsal (#PCDATA)>
<!ATTLIST rehearsal
    %text-formatting;
    %optional-unique-id;
>

<!--
	The words element specifies a standard text direction. The
	enclosure is none if not specified. The language is Italian
	("it") if not specified. Left justification is used if not
	specified. 
-->
<!ELEMENT words (#PCDATA)>
<!ATTLIST words
    %text-formatting;
    %optional-unique-id;
>

<!--
	The symbol element specifies a musical symbol using a
	canonical SMuFL glyph name. It is used when an occasional
	musical symbol is interspersed into text. It should not be
	used in place of semantic markup, such as metronome marks
	that mix text and symbols. Left justification is used if
	not specified. Enclosure is none if not specified.
-->
<!ELEMENT symbol (#PCDATA)>
<!ATTLIST symbol
    %symbol-formatting;
    %optional-unique-id;
>
<!--
	Wedge spread is measured in tenths of staff line space.
	The type is crescendo for the start of a wedge that is
	closed at the left side, and diminuendo for the start
	of a wedge that is closed on the right side. Spread 
	values at the start of a crescendo wedge or end of a
	diminuendo wedge are ignored. The niente attribute is yes
	if a circle appears at the point of the wedge, indicating
	a crescendo from nothing or diminuendo to nothing. It is 
	no by default, and used only when the type is crescendo,
	or the type is stop for a wedge that began with a diminuendo
	type. The line-type is solid if not specified. The continue
	type is used for formatting wedges over a system break, or
	for other situations where a single wedge is divided into
	multiple segments.
-->
<!ELEMENT wedge EMPTY>
<!ATTLIST wedge
    type (crescendo | diminuendo | stop | continue) #REQUIRED
    number %number-level; #IMPLIED
    spread %tenths; #IMPLIED
    niente %yes-no; #IMPLIED
    %line-type;
    %dashed-formatting;
    %position;
    %color;
    %optional-unique-id;
>

<!--
	Dashes, used for instance with cresc. and dim. marks.
-->
<!ELEMENT dashes EMPTY>
<!ATTLIST dashes
    type %start-stop-continue; #REQUIRED
    number %number-level; #IMPLIED
    %dashed-formatting;
    %position;
    %color;
    %optional-unique-id;
>

<!--
	Brackets are combined with words in a variety of
	modern directions. The line-end attribute specifies
	if there is a jog up or down (or both), an arrow,
	or nothing at the start or end of the bracket. If
	the line-end is up or down, the length of the jog
	can be specified using the end-length attribute.
	The line-type is solid if not specified.
-->
<!ELEMENT bracket EMPTY>
<!ATTLIST bracket
    type %start-stop-continue; #REQUIRED
    number %number-level; #IMPLIED
    line-end (up | down | both | arrow | none) #REQUIRED
    end-length %tenths; #IMPLIED
    %line-type;
    %dashed-formatting;
    %position;
    %color;
    %optional-unique-id;
>

<!-- 
	The pedal element represents piano pedal marks, including
	damper and sostenuto pedal marks. The soft pedal is not
	included here because there is no special symbol or graphic
	used for it beyond what can be specified with words and
	bracket elements.
	
	The start type indicates the start of a damper pedal, while
	the sostenuto type indicates the start of a sostenuto pedal.
	The other types can be used with either the damper or
	sostenuto pedal.

	The line attribute is yes if pedal lines are used. The sign
	attribute is yes if Ped, Sost, and * signs are used. For
	compatibility with older versions, the sign attribute is yes
	by default if the line attribute is no, and is no by default
	if the line attribute is yes. If the sign attribute is set
	to yes and the type is start or sostenuto, the abbreviated
	attribute is yes if the short P and S signs are used, and
	no if the full Ped and Sost signs are used. It is no by
	default. Otherwise the abbreviated attribute is ignored.
	The alignment attributes are ignored if the sign attribute
	is no.

	The change, continue, discontinue, and resume types are used
	when the line attribute is yes. The change type indicates a
	pedal lift and retake indicated with an inverted V marking.
	The continue type allows more precise formatting across
	system breaks and for more complex pedaling lines. The
	discontinue type indicates the end of a pedal line that does
	not include the explicit lift represented by the stop type.
	The resume type indicates the start of a pedal line that
	does not include the downstroke represented by the start
	type. It can be used when a line resumes after being
	discontinued, or to start a pedal line that is preceded
	by a text or symbol representation of the pedal.
-->
<!ELEMENT pedal EMPTY>
<!ATTLIST pedal
    type (start | stop | sostenuto | change |
          continue | discontinue | resume) #REQUIRED
    number %number-level; #IMPLIED
    line %yes-no; #IMPLIED
    sign %yes-no; #IMPLIED
    abbreviated %yes-no; #IMPLIED
    %print-style-align; 
    %optional-unique-id;
>

<!--
	Metronome marks and other metric relationships.
	
	The beat-unit values are the same as for a type element,
	and the beat-unit-dot works like the dot element. The
	beat-unit-tied type indicates a beat-unit that is tied to
	the preceding beat-unit. The per-minute element can be a
	number, or a text description including numbers. The
	parentheses attribute indicates whether or not to put the
	metronome mark in parentheses; its value is no if not
	specified. The print-object attribute is set to no in
	cases where the metronome element represents a relationship
	or range that is not displayed in the music notation.
	
	If a font is specified for the per-minute element,
	it overrides the font specified for the overall metronome
	element. This allows separate specification of a music font
	for beat-unit and a text font for the numeric value in cases
	where a single metronome font is not used.

	The metronome-note and metronome-relation elements allow
	for the specification of metric modulations and other metric
	relationships, such as swing tempo marks where two eighths
	are equated to a quarter note / eighth note triplet. If the
	metronome-arrows element is present, it indicates that metric
	modulation arrows are displayed on both sides of the metronome
	mark. The metronome-type, metronome-beam, metronome-dot, and
	metronome-tied elements work like the type, beam, dot, and tied
	elements. The metronome-tuplet element uses the same element
	structure as the time-modification element along with some
	attributes from the tuplet element. The metronome-relation
	element describes the relationship symbol that goes between the
	two sets of metronome-note elements. The currently allowed
	value is equals, but this may expand in future versions.
	If the element is empty, the equals value is used. The 
	metronome-relation and the following set of metronome-note
	elements are optional to allow display of an isolated
	Grundschlagnote.
-->
<!ELEMENT metronome 
	((beat-unit, beat-unit-dot*, beat-unit-tied*,
	 (per-minute | 
	  (beat-unit, beat-unit-dot*, beat-unit-tied*))) |
	(metronome-arrows?, metronome-note+,
	 (metronome-relation, metronome-note+)?))>
<!ATTLIST metronome
    %print-style-align;
    %print-object;
    %justify;
    parentheses %yes-no; #IMPLIED
    %optional-unique-id;
>
<!ELEMENT beat-unit (#PCDATA)>
<!ELEMENT beat-unit-dot EMPTY>
<!ELEMENT beat-unit-tied
	(beat-unit, beat-unit-dot*)>
<!ELEMENT per-minute (#PCDATA)> 
<!ATTLIST per-minute
    %font;
>

<!ELEMENT metronome-note
	(metronome-type, metronome-dot*,
	 metronome-beam*, metronome-tied?, 
	 metronome-tuplet?)>
<!ELEMENT metronome-relation (#PCDATA)>
<!ELEMENT metronome-type (#PCDATA)>
<!ELEMENT metronome-arrows EMPTY>
<!ELEMENT metronome-dot EMPTY>
<!ELEMENT metronome-beam (#PCDATA)>
<!ATTLIST metronome-beam
    number %beam-level; "1"
>
<!ELEMENT metronome-tied EMPTY>
<!ATTLIST metronome-tied
    type %start-stop; #REQUIRED
>
<!ELEMENT metronome-tuplet
	(actual-notes, normal-notes, 
	 (normal-type, normal-dot*)?)>
<!ATTLIST metronome-tuplet
    type %start-stop; #REQUIRED
    bracket %yes-no; #IMPLIED
    show-number (actual | both | none) #IMPLIED
>

<!--
	Octave shifts indicate where notes are shifted up or down
	from their true pitched values because of printing
	difficulty. Thus a treble clef line noted with 8va will
	be indicated with an octave-shift down from the pitch
	data indicated in the notes. A size of 8 indicates one
	octave; a size of 15 indicates two octaves.
-->
<!ELEMENT octave-shift EMPTY>
<!ATTLIST octave-shift
    type (up | down | stop | continue) #REQUIRED
    number %number-level; #IMPLIED
    size CDATA "8"
    %dashed-formatting;
    %print-style; 
    %optional-unique-id;
>

<!-- 
	The harp-pedals element is used to create harp pedal
	diagrams. The pedal-step and pedal-alter elements use
	the same values as the step and alter elements. For
	easiest reading, the pedal-tuning elements should follow
	standard harp pedal order, with pedal-step values of
	D, C, B, E, F, G, and A.
-->
<!ELEMENT harp-pedals (pedal-tuning)+>
<!ATTLIST harp-pedals
    %print-style-align; 
    %optional-unique-id;
>
<!ELEMENT pedal-tuning (pedal-step, pedal-alter)>
<!ELEMENT pedal-step (#PCDATA)>
<!ELEMENT pedal-alter (#PCDATA)>

<!-- Harp damping marks -->
<!ELEMENT damp EMPTY>
<!ATTLIST damp
    %print-style-align; 
    %optional-unique-id;
>
<!ELEMENT damp-all EMPTY>
<!ATTLIST damp-all
    %print-style-align; 
    %optional-unique-id;
>

<!-- Eyeglasses, common in commercial music. -->
<!ELEMENT eyeglasses EMPTY>
<!ATTLIST eyeglasses
    %print-style-align; 
    %optional-unique-id;
>

<!-- String mute on and mute off symbols -->
<!ELEMENT string-mute EMPTY>
<!ATTLIST string-mute
    type (on | off) #REQUIRED
    %print-style-align; 
    %optional-unique-id;
>

<!-- 
	Scordatura string tunings are represented by a series
	of accord elements. The tuning-step, tuning-alter, 
	and tuning-octave elements are also used with the 
	staff-tuning element, and are defined in the common.mod
	file. Strings are numbered from high to low.
-->
<!ELEMENT scordatura (accord+)>
<!ATTLIST scordatura
    %optional-unique-id;
>
<!ELEMENT accord
	(tuning-step, tuning-alter?, tuning-octave)>
<!ATTLIST accord
    string CDATA #REQUIRED
>

<!--
	The image element is used to include graphical images
	in a score. The required source attribute is the URL
	for the image file. The required type attribute is the
	MIME type for the image file format. Typical choices
	include application/postscript, image/gif, image/jpeg,
	image/png, and image/tiff. The optional height and width
	attributes are used to size and scale an image. The image
	should be scaled independently in X and Y if both height
	and width are specified. If only one attribute is specified,
	the image should be scaled proportionally to fit in the
	specified dimension.
-->
<!ELEMENT image EMPTY>
<!ATTLIST image
    source CDATA #REQUIRED
    type CDATA #REQUIRED
    height %tenths; #IMPLIED
    width %tenths; #IMPLIED
    %position;
    %halign;
    %valign-image; 
    %optional-unique-id;
>

<!-- 
	The principal-voice element represents principal and
	secondary voices in a score, either for analysis or for
	square bracket symbols that appear in a score. The element
	content is used for analysis and may be any text value.
	The symbol attribute indicates the type of symbol used.
	Valid values are Hauptstimme, Nebenstimme, plain (for a
	plain square bracket), and none. When used for analysis
	separate from any printed score markings, it should be set
	to none. Otherwise if the type is stop it should be set to
	plain.
-->
<!ELEMENT principal-voice (#PCDATA)>
<!ATTLIST principal-voice
    type %start-stop; #REQUIRED
    symbol (Hauptstimme | Nebenstimme | plain | none) #REQUIRED
    %print-style-align;
    %optional-unique-id;
>

<!--
	The accordion-registration element is used for accordion
	registration symbols. These are circular symbols divided
	horizontally into high, middle, and low sections that
	correspond to 4', 8', and 16' pipes. Each accordion-high,
	accordion-middle, and accordion-low element represents
	the presence of one or more dots in the registration
	diagram. The accordion-middle element may have text
	values of 1, 2, or 3, corresponding to have 1 to 3 dots
	in the middle section. If no dots are present in a section
	of the registration diagram, the corresponding element is
	omitted. An accordion-registration element needs to have at
	least one of the child elements present.
-->
<!ELEMENT accordion-registration
	(accordion-high?, accordion-middle?, accordion-low?)>
<!ATTLIST accordion-registration
    %print-style-align; 
    %optional-unique-id;
>
<!ELEMENT accordion-high EMPTY>
<!ELEMENT accordion-middle (#PCDATA)>
<!ELEMENT accordion-low EMPTY>

<!-- 
	The staff-divide element is used for staff division symbols.
	The down, up, and up-down type values correspond to SMuFL
	code points U+E00B, U+E00C, and U+E00D respectively.
-->
<!ELEMENT staff-divide EMPTY>
<!ATTLIST staff-divide
    type (down | up | up-down) #REQUIRED
    %print-style-align; 
    %optional-unique-id;
>

<!--
	The percussion element is used to define percussion
	pictogram symbols. Definitions for these symbols can be
	found in Kurt Stone's "Music Notation in the Twentieth
	Century" on pages 206-212 and 223. Some values are
	added to these based on how usage has evolved in
	the 30 years since Stone's book was published.
-->
<!ELEMENT percussion
	(glass | metal | wood | pitched | membrane | effect |
	 timpani | beater | stick | stick-location | 
	 other-percussion)>
<!ATTLIST percussion
    %print-style-align;
    %enclosure; 
    %optional-unique-id;
>

<!--
	The glass element represents pictograms for glass percussion
	instruments. Valid values are glass harmonica, glass harp,
	and wind chimes. The smufl attribute is used to distinguish
	different SMuFL glyphs for wind chimes in the Chimes pictograms
	range, including those made of materials other than glass.
-->
<!ELEMENT glass (#PCDATA)>
<!ATTLIST glass
    %smufl;
>

<!--
	The metal element represents pictograms for metal percussion
	instruments. Valid values are agogo, almglocken, bell,
	bell plate, bell tree, brake drum, cencerro, chain rattle,
	Chinese cymbal, cowbell, crash cymbals, crotale, cymbal tongs,
	domed gong, finger cymbals, flexatone, gong, hi-hat,
	high-hat cymbals, handbell, jaw harp, jingle bells,
	musical saw, shell bells, sistrum, sizzle cymbal, sleigh bells,
	suspended cymbal, tam tam, tam tam with beater, triangle, and
	Vietnamese hat. The hi-hat value refers to a pictogram like
	Stone's high-hat cymbals, but without the long vertical line
	at the bottom. The smufl attribute is used to distinguish
	different SMuFL stylistic alternates.
-->
<!ELEMENT metal (#PCDATA)>
<!ATTLIST metal
    %smufl;
>

<!--
	The wood element represents pictograms for wood percussion
	instruments. Valid values are bamboo scraper, board clapper,
	cabasa, castanets, castanets with handle, claves,
	football rattle, guiro, log drum, maraca, maracas, quijada,
	rainstick, ratchet, reco-reco, sandpaper blocks, slit drum,
	temple block, vibraslap, whip, and wood block. The maraca and
	maracas values distinguish the one- and two-maraca versions
	of the pictogram.  The smufl attribute is used to
	distinguish different SMuFL stylistic alternates.
-->
<!ELEMENT wood (#PCDATA)>
<!ATTLIST wood
    %smufl;
>

<!--
	The pitched element represents pictograms for pitched
	percussion instruments. Valid values are celesta, chimes,
	glockenspiel, lithophone, mallet, marimba, steel drums,
	tubaphone, tubular chimes, vibraphone, and xylophone.
	The chimes and tubular chimes values distinguish the
	single-line and double-line versions of the pictogram.
	The smufl attribute is used to distinguish different SMuFL
	glyphs for a particular pictogram within the Tuned mallet
	percussion pictograms range.
-->
<!ELEMENT pitched (#PCDATA)>
<!ATTLIST pitched
    %smufl;
>

<!--
	The membrane element represents pictograms for membrane
	percussion instruments. Valid values are bass drum,
	bass drum on side, bongos, Chinese tomtom, conga drum,
	cuica, goblet drum, Indo-American tomtom, Japanese tomtom,
	military drum, snare drum, snare drum snares off, tabla,
	tambourine, tenor drum, timbales, and tomtom. The smufl
	attribute is used to distinguish different SMuFL stylistic
	alternates.
-->
<!ELEMENT membrane (#PCDATA)>
<!ATTLIST membrane
    %smufl;
>

<!--
	The effect element represents pictograms for sound effect
	percussion instruments. Valid values are anvil, auto horn,
	bird whistle, cannon, duck call, gun shot, klaxon horn,
	lions roar, lotus flute, megaphone, police whistle, siren,
	slide whistle, thunder sheet, wind machine, and wind whistle.
	The cannon, lotus flute, and megaphone values are in addition
	to Stone's list. The smufl attribute is used to distinguish
	different SMuFL stylistic alternates.
-->
<!ELEMENT effect (#PCDATA)>
<!ATTLIST effect
    %smufl;
>

<!--
	The timpani element represents the timpani pictogram. The
	smufl attribute is used to distinguish different SMuFL
	stylistic alternates.
-->
<!ELEMENT timpani EMPTY>
<!ATTLIST timpani
    %smufl;
>

<!--
	The beater element represents pictograms for beaters,
	mallets, and sticks that do not have different materials
	represented in the pictogram. Valid values are bow,
	chime hammer, coin, drum stick, finger, fingernail, fist,
	guiro scraper, hammer, hand, jazz stick, knitting needle,
	metal hammer, slide brush on gong, snare stick, spoon mallet,
	superball, triangle beater, triangle beater plain, and
	wire brush. The jazz stick value refers to Stone's plastic
	tip snare stick. The triangle beater plain value refers to
	the plain line version of the pictogram. The tip attribute
	represents the direction in which the tip of a beater points.
-->

<!ELEMENT beater (#PCDATA)>
<!ATTLIST beater
	tip %tip-direction; #IMPLIED 
>

<!--
	The stick element represents pictograms where the material
	in the stick, mallet, or beater is included. Valid values
	for stick-type are bass drum, double bass drum, glockenspiel,
	gum, hammer, superball, timpani, wound, xylophone, and yarn.
	Valid values for stick-material are soft, medium, hard,
	shaded, and x. The shaded and x values reflect different
	uses for brass, wood, and steel core beaters of different
	types. The tip attribute represents the direction in which
	the tip of a stick points. The parentheses and dashed-circle
	attributes indicate the presence of these marks around the
	round beater part of a pictogram. Values for these attributes
	are "no" if not present.

-->

<!ELEMENT stick (stick-type, stick-material)>
<!ATTLIST stick
	tip %tip-direction; #IMPLIED
	parentheses %yes-no; #IMPLIED 
	dashed-circle %yes-no; #IMPLIED 
>
<!ELEMENT stick-type (#PCDATA)>
<!ELEMENT stick-material (#PCDATA)>

<!--
	The stick-location element represents pictograms for the
	location of sticks, beaters, or mallets on cymbals, gongs,
	drums, and other instruments. Valid values are center,
	rim, cymbal bell, and cymbal edge.
-->
<!ELEMENT stick-location (#PCDATA)>

<!--
	The other-percussion element represents percussion
	pictograms not defined elsewhere.
-->
<!ELEMENT other-percussion (#PCDATA)>
<!ATTLIST other-percussion
    %smufl;
>

<!--
	The other-direction element is used to define any direction
	symbols not yet in the MusicXML format. The smufl attribute
	can be used to specify a particular direction symbol, allowing
	application interoperability without requiring every SMuFL
	glyph to have a MusicXML element equivalent. Using the
	other-direction type without the smufl attribute allows
	for extended representation, though without application
	interoperability.
-->
<!ELEMENT other-direction (#PCDATA)>
<!ATTLIST other-direction
	%print-object;
    %print-style-align;
    %smufl; 
    %optional-unique-id;
>

<!--
	An offset is represented in terms of divisions, and
	indicates where the direction will appear relative to
	the current musical location. The current musical location
	is always within the current measure, even at the end of
	a measure.
	
	The offset affects the visual appearance of the direction.
	If the sound attribute is "yes", then the offset affects 
	playback and listening too. If the sound attribute is "no",
	then any sound or listening associated with the direction
	takes effect at the current location. The sound attribute
	is "no" by default for compatibility with earlier versions
	of the MusicXML format. If an element within a direction
	includes a default-x attribute, the offset value will be
	ignored when determining the appearance of that element.
-->
<!ELEMENT offset (#PCDATA)>
<!ATTLIST offset
    sound %yes-no; #IMPLIED
>

<!-- Harmony -->

<!--
	The harmony element represents harmony analysis, including
	chord symbols in popular music as well as functional harmony
	analysis in classical music.
	
	If there are alternate harmonies possible, this can be
	specified using multiple harmony elements differentiated
	by type. Explicit harmonies have all note present in the
	music; implied have some notes missing but implied;
	alternate represents alternate analyses. 
	
	The print-object attribute controls whether or not anything
	is printed due to the harmony element. The print-frame
	attribute controls printing of a frame or fretboard diagram.
	The print-style entity sets the default for the harmony,
	but individual elements can override this with their own
	print-style values.
	
	A harmony element can contain many stacked chords (e.g.
	V of II). A sequence of harmony-chord entities is used for
	this type of secondary function, where V of II would be
	represented by a harmony-chord with a 5 numeral followed by
	a harmony-chord with a 2 numeral. The arrangement attribute
	specifies how multiple harmony-chord entities are arranged
	relative to each other. Harmony-chords with vertical
	arrangement are separated by horizontal lines. Harmony-
	chords with diagonal or horizontal arrangement are separated
	by diagonal lines or slashes.
-->
<!ENTITY % harmony-chord "((root | numeral | function),
	kind, inversion?, bass?, degree*)">

<!ELEMENT harmony ((%harmony-chord;)+, frame?, 
	offset?, %editorial;, staff?)>
<!ATTLIST harmony
    type (explicit | implied | alternate) #IMPLIED
    %print-object;
    print-frame  %yes-no; #IMPLIED
    %harmony-arrangement;
    %print-style;
    %placement;
    %system-relation;
    %optional-unique-id;
>

<!--
	A root is a pitch name like C, D, E, while a numeral is
	a scale degree like 1, 2, 3. The root element is generally
	used with pop chord symbols, while the numeral element
	is generally used with classical functional harmony and
	Nashville numbers. It is an either/or choice to avoid data
	inconsistency. The function element, which represents Roman
	numerals with roman numeral text, has been deprecated as of
	MusicXML 4.0.

	The root element has a root-step and optional root-alter 
	element similar to the step and alter elements in a pitch,
	but renamed to distinguish the different musical meanings.
	The root-step text attribute indicates how the root should
	appear in a score if not using the element contents.
	In some chord styles, this will include the root-alter
	information as well. In that case, the print-object
	attribute of the root-alter element can be set to no.
	The root-alter location attribute indicates whether
	the alteration should appear to the left or the right
	of the root-step; it is right if not specified.
-->
<!ELEMENT root (root-step, root-alter?)>
<!ELEMENT root-step (#PCDATA)>
<!ATTLIST root-step
    text CDATA #IMPLIED
    %print-style;
>
<!ELEMENT root-alter (#PCDATA)>
<!ATTLIST root-alter
    %print-object;
    %print-style;
    location %left-right; #IMPLIED
>
	
<!--
	The numeral element represents the Roman numeral or 
	Nashville number part of a harmony. It requires that the
	key be specified in the encoding, either with a key or
	numeral-key element.
	
	The numeral-root element represents the Roman numeral or
	Nashville number as a positive integer from 1 to 7. The
	text attribute indicates how the numeral should appear in
	the score. A numeral-root value of 5 with a kind of major
	would have a text attribute of "V" if displayed as a Roman
	numeral, and "5" if displayed as a Nashville number. If the
	text attribute is not specified, the display is application-
	dependent.
	
	The numeral-alter element represents an alteration to the
	numeral-root, similar to the alter element for a pitch.
	The print-object attribute can be used to hide an alteration
	in cases such as when the MusicXML encoding of a 6 or 7
	numeral-root in a minor key requires an alteration that
	is not displayed. The location attribute indicates whether
	the alteration should appear to the left or the right of
	the numeral-root; it is left by default.
	
	The numeral-key element is used when the key for the numeral
	is different than the key specified by the key signature.
	The numeral-fifths element specifies the key in the same way
	as the fifths element. The numeral-mode element specifies
	the mode similar to the mode element, but with a restricted
	set of values: major, minor, natural minor, melodic minor,
	and harmonic minor. The different minor values are used to
	interpret numeral-root values of 6 and 7 when present in
	a minor key. The harmonic minor value sharpens the 7 and
	the melodic minor value sharpens both 6 and 7. If a minor
	mode is used without qualification, either in the mode or
	numeral-mode elements, natural minor is used.
-->
<!ELEMENT numeral (numeral-root, numeral-alter?, numeral-key?)>
<!ELEMENT numeral-root (#PCDATA)>
<!ATTLIST numeral-root
    text CDATA #IMPLIED
    %print-style;
>
<!ELEMENT numeral-alter (#PCDATA)>
<!ATTLIST numeral-alter
    %print-object;
    %print-style;
    location %left-right; #IMPLIED
>

<!ELEMENT numeral-key (numeral-fifths, numeral-mode)>
<!ATTLIST numeral-key
    %print-object;
>
<!ELEMENT numeral-fifths (#PCDATA)>
<!ELEMENT numeral-mode (#PCDATA)>

<!--
    The function element represents classical functional
	harmony with an indication like I, II, III rather than
	C, D, E. It represents the Roman numeral part of a
	functional harmony rather than the complete function
	itself. It has been deprecated as of MusicXML 4.0 in
	favor of the numeral element.
-->
<!ELEMENT function (#PCDATA)>
<!ATTLIST function
    %print-style;
>

<!--
	Kind indicates the type of chord. Degree elements
	can then add, subtract, or alter from these
	starting points. Values include:
	
	Triads:
	    major (major third, perfect fifth)
	    minor (minor third, perfect fifth)
	    augmented (major third, augmented fifth)
	    diminished (minor third, diminished fifth)
	Sevenths:
	    dominant (major triad, minor seventh)
	    major-seventh (major triad, major seventh)
	    minor-seventh (minor triad, minor seventh)
	    diminished-seventh
	        (diminished triad, diminished seventh)
	    augmented-seventh
	        (augmented triad, minor seventh)
	    half-diminished
	        (diminished triad, minor seventh)
	    major-minor
	        (minor triad, major seventh)
	Sixths:
	    major-sixth (major triad, added sixth)
	    minor-sixth (minor triad, added sixth)
	Ninths:
	    dominant-ninth (dominant-seventh, major ninth)
	    major-ninth (major-seventh, major ninth)
	    minor-ninth (minor-seventh, major ninth)
	11ths (usually as the basis for alteration):
	    dominant-11th (dominant-ninth, perfect 11th)
	    major-11th (major-ninth, perfect 11th)
	    minor-11th (minor-ninth, perfect 11th)
	13ths (usually as the basis for alteration):
	    dominant-13th (dominant-11th, major 13th)
	    major-13th (major-11th, major 13th)
	    minor-13th (minor-11th, major 13th)
	Suspended:
	    suspended-second (major second, perfect fifth)
	    suspended-fourth (perfect fourth, perfect fifth)
	Functional sixths:
	    Neapolitan
	    Italian
	    French
	    German
	Other:
	    pedal (pedal-point bass)
	    power (perfect fifth)
	    Tristan
	
	The "other" kind is used when the harmony is entirely
	composed of add elements. 
	
	The "none" kind is used to explicitly encode absence of
	chords or functional harmony. In this case, the root,
	numeral, or function element has no meaning. When using
	the root or numeral element, the root-step or numeral-step
	text attribute should be set to the empty string to keep
	the root or numeral from being displayed.

	The attributes are used to indicate the formatting
	of the symbol. Since the kind element is the constant
	in all the harmony-chord entities that can make up
	a polychord, many formatting attributes are here.

	The use-symbols attribute is yes if the kind should be
	represented when possible with harmony symbols rather
	than letters and numbers. These symbols include:

	    major: a triangle, like Unicode 25B3
	    minor: -, like Unicode 002D
	    augmented: +, like Unicode 002B
	    diminished: °, like Unicode 00B0
	    half-diminished: ø, like Unicode 00F8

	For the major-minor kind, only the minor symbol is used when
	use-symbols is yes. The major symbol is set using the symbol
	attribute in the degree-value element. The corresponding
	degree-alter value will usually be 0 in this case.

	The text attribute describes how the kind should be spelled
	in a score. If use-symbols is yes, the value of the text
	attribute follows the symbol. The stack-degrees attribute
	is yes if the degree elements should be stacked above each
	other. The parentheses-degrees attribute is yes if all the
	degrees should be in parentheses. The bracket-degrees 
	attribute is yes if all the degrees should be in a bracket.
	If not specified, these values are implementation-specific.
	The alignment attributes are for the entire harmony-chord
	entity of which this kind element is a part.
	
	The text attribute may use strings such as "13sus" that
	refer to both the kind and one or more degree elements.
	In this case, the corresponding degree elements should
	have the print-object attribute set to "no" to keep 
	redundant alterations from being displayed.
-->
<!ELEMENT kind (#PCDATA)>
<!ATTLIST kind
    use-symbols          %yes-no;   #IMPLIED
    text                 CDATA      #IMPLIED
    stack-degrees        %yes-no;   #IMPLIED
    parentheses-degrees  %yes-no;   #IMPLIED
    bracket-degrees      %yes-no;   #IMPLIED
    %print-style;
    %halign;
    %valign;
>

<!--
	Inversion is a number indicating which inversion is used:
	0 for root position, 1 for first inversion, etc. The text
	attribute indicates how the inversion should be displayed
	in a score.
-->
<!ELEMENT inversion (#PCDATA)>
<!ATTLIST inversion
    text CDATA #IMPLIED
    %print-style;
>

<!--
	Bass is used to indicate a bass note in popular music
	chord symbols, e.g. G/C. It is generally not used in
	functional harmony, as inversion is generally not used
	in pop chord symbols. As with root, it is divided into
	step and alter elements, similar to pitches. The attributes
	for bass-step and bass-alter work the same way as the
	corresponding attributes for root-step and root-alter.
	The arrangement attribute specifies where the bass is
	displayed relative to what precedes it. The optional
	bass-separator element indicates that text, rather than a
	line or slash, separates the bass from what precedes it.
-->
<!ELEMENT bass (bass-separator?, bass-step, bass-alter?)>
<!ATTLIST bass
    %harmony-arrangement;
>

<!ELEMENT bass-separator (#PCDATA)>
<!ATTLIST bass-separator
    %print-style;
>

<!ELEMENT bass-step (#PCDATA)>
<!ATTLIST bass-step
    text CDATA #IMPLIED
    %print-style;
>
<!ELEMENT bass-alter (#PCDATA)>
<!ATTLIST bass-alter
    %print-object;
    %print-style;
    location %left-right; #IMPLIED
>

<!--
	The degree element is used to add, alter, or subtract
	individual notes in the chord. The degree-value element
	is a number indicating the degree of the chord (1 for
	the root, 3 for third, etc). The degree-alter element
	is like the alter element in notes: 1 for sharp, -1 for
	flat, etc. The degree-type element can be add, alter, or
	subtract. If the degree-type is alter or subtract, the
	degree-alter is relative to the degree already in the
	chord based on its kind element. If the degree-type is
	add, the degree-alter is relative to a dominant chord
	(major and perfect intervals except for a minor 
	seventh). The print-object attribute can be used to
	keep the degree from printing separately when it has
	already taken into account in the text attribute of
	the kind element. The plus-minus attribute is used to
	indicate if plus and minus symbols should be used
	instead of sharp and flat symbols to display the degree
	alteration. It is no if not specified. 

	The degree-value and degree-type text attributes specify
	how the value and type of the degree should be displayed.
	The degree-value symbol attribute indicates that a symbol
	should be used in specifying the degree. If the symbol
	attribute is present, the value of the text attribute
	follows the symbol. 
	
	A harmony of kind "other" can be spelled explicitly by
	using a series of degree elements together with a root.
-->
<!ELEMENT degree (degree-value, degree-alter, degree-type)>
<!ATTLIST degree
    %print-object;
>
<!ELEMENT degree-value (#PCDATA)>
<!ATTLIST degree-value
    symbol (major | minor | augmented | 
            diminished | half-diminished) #IMPLIED
    text CDATA #IMPLIED
    %print-style;
>
<!ELEMENT degree-alter (#PCDATA)>
<!ATTLIST degree-alter
    %print-style;
    plus-minus %yes-no; #IMPLIED
>
<!ELEMENT degree-type (#PCDATA)>
<!ATTLIST degree-type
    text CDATA #IMPLIED
    %print-style;
>

<!--
	The frame element represents a frame or fretboard diagram
	used together with a chord symbol. The representation is
	based on the NIFF guitar grid with additional information.
	The frame-strings and frame-frets elements give the 
	overall size of the frame in vertical lines (strings) and 
	horizontal spaces (frets).

	The frame element's unplayed attribute indicates what to
	display above a string that has no associated frame-note
	element. Typical values are x and the empty string. If the
	attribute is not present, the display of the unplayed
	string is application-defined. 
-->
<!ELEMENT frame 
	(frame-strings, frame-frets, first-fret?, frame-note+)>
<!ATTLIST frame 
    %position;
    %color;
    %halign;
    %valign-image;
    height  %tenths;  #IMPLIED
    width   %tenths;  #IMPLIED
    unplayed CDATA    #IMPLIED
    %optional-unique-id;
>
<!ELEMENT frame-strings (#PCDATA)>
<!ELEMENT frame-frets (#PCDATA)>

<!--
	The first-fret indicates which fret is shown in the top
	space of the frame; it is fret 1 if the element is not
	present. The optional text attribute indicates how this
	is represented in the fret diagram, while the location
	attribute indicates whether the text appears to the left
	or right of the frame.
-->
<!ELEMENT first-fret (#PCDATA)>
<!ATTLIST first-fret
    text CDATA #IMPLIED
    location %left-right; #IMPLIED
>

<!--
	The frame-note element represents each note included in
	the frame. The definitions for string, fret, and fingering
	are found in the common.mod file. An open string will
	have a fret value of 0, while a muted string will not be
	associated with a frame-note element.
-->
<!ELEMENT frame-note (string, fret, fingering?, barre?)>

<!-- 
	The barre element indicates placing a finger over 
	multiple strings on a single fret. The type is "start" 
	for the lowest pitched string (e.g., the string with 
	the highest MusicXML number) and is "stop" for the 
	highest pitched string.
-->
<!ELEMENT barre EMPTY>
<!ATTLIST barre
    type %start-stop; #REQUIRED
    %color;
>

<!--
	The grouping element is used for musical analysis. When
	the element type is "start" or "single", it usually contains
	one or more feature elements. The number attribute is used
	for distinguishing between overlapping and hierarchical
	groupings. The member-of attribute allows for easy
	distinguishing of what grouping elements are in what
	hierarchy. Feature elements contained within a "stop"
	type of grouping may be ignored.
	
	This element is flexible to allow for non-standard analyses.
	Future versions of the MusicXML format may add elements
	that can represent more standardized categories of analysis
	data, allowing for easier data sharing.
-->
<!ELEMENT grouping ((feature)*)>
<!ATTLIST grouping
    type %start-stop-single; #REQUIRED
    number CDATA "1"
    member-of CDATA #IMPLIED
    %optional-unique-id;
>
<!ELEMENT feature (#PCDATA)>
<!ATTLIST feature
    type CDATA #IMPLIED
>

<!--
	The print element contains general printing parameters,
	including the layout elements defined in the layout.mod
	file. The part-name-display and part-abbreviation-display
	elements used in the score.mod file may also be used here
	to change how a part name or abbreviation is displayed over
	the course of a piece. They take effect when the current
	measure or a succeeding measure starts a new system.
	
	The new-system and new-page attributes indicate whether
	to force a system or page break, or to force the current
	music onto the same system or page as the preceding music.
	Normally this is the first music data within a measure.
	If used in multi-part music, they should be placed in the
	same positions within each part, or the results are
	undefined. The page-number attribute sets the number of a
	new page; it is ignored if new-page is not "yes". Version
	2.0 adds a blank-page attribute. This is a positive integer
	value that specifies the number of blank pages to insert
	before the current measure. It is ignored if new-page is
	not "yes". These blank pages have no music, but may have
	text or images specified by the credit element. This is
	used to allow a combination of pages that are all text,
	or all text and images, together with pages of music.

	Staff spacing between multiple staves is measured in
	tenths of staff lines (e.g. 100 = 10 staff lines). This is
	deprecated as of Version 1.1; the staff-layout element
	should be used instead. If both are present, the
	staff-layout values take priority.

	Common-layout entity elements in a print element only
	apply to the current page, system, or staff. Music that
	follows continues to take the default values from the
	layout determined by the defaults element.
-->
<!ELEMENT print (%common-layout;,
    measure-layout?, measure-numbering?,
    part-name-display?, part-abbreviation-display?)>
<!ATTLIST print
    staff-spacing %tenths; #IMPLIED
    new-system %yes-no; #IMPLIED
    new-page %yes-no; #IMPLIED
    blank-page NMTOKEN #IMPLIED
    page-number CDATA #IMPLIED	
    %optional-unique-id;
>

<!--
	The measure-numbering element describes how measure numbers
	are displayed on this part. Values may be none, measure, or
	system. The text attribute from the measure element is used 
	for display, or the number attribute if the text attribute
	is not present. Measures with an implicit attribute set to 
	"yes" never display a measure number, regardless of the 
	measure-numbering setting. 
	
	The optional staff attribute refers to staff numbers within
	the part, from top to bottom on the system. It indicates
	which staff is used as the reference point for vertical
	positioning. A value of 1 is assumed if not present.

	The optional system attribute distinguishes measure numbers
	that are associated with a system rather than the particular
	part where the element appears. A value of only-top or
	only-bottom indicates that the number should appear only on
	the top or bottom part of the current system, respectively.
	A value of also-top or also-bottom indicates that the number
	should appear on both the current part and the top or bottom
	part of the current system, respectively. If these values
	appear in a score, when parts are created the number should
	only appear once in this part, not twice. A value of none
	indicates that the number is associated only with the
	current part, not with the system.
	
	The optional multiple-rest-always and multiple-rest-range 
	attributes describe how measure numbers are shown on 
	multiple rests when the measure-numbering value is not set
	to none. The multiple-rest-always attribute is set to yes
	when the measure number should always be shown, even if the
	multiple rest starts midway through a system when measure
	numbering is set to system level. The multiple-rest-range
	attribute is set to yes when measure numbers on multiple
	rests display the range of numbers for the first and last
	measure, rather than just the number of the first measure.
-->
<!ELEMENT measure-numbering (#PCDATA)>
<!ATTLIST measure-numbering
    system (none | only-top | also-top | 
            only-bottom | also-bottom) #IMPLIED
    staff CDATA #IMPLIED
    multiple-rest-always %yes-no; #IMPLIED
    multiple-rest-range %yes-no; #IMPLIED
    %print-style-align;
>

<!-- 
	The sound element contains general playback parameters.
	They can stand alone within a part/measure, or be a
	component element within a direction.
	
	Tempo is expressed in quarter notes per minute. If 0,
	the sound-generating program should prompt the user at the
	time of compiling a sound (MIDI) file.
	
	Dynamics (or MIDI velocity) are expressed as a percentage
	of the default forte value (90 for MIDI 1.0).
	
	Dacapo indicates to go back to the beginning of the
	movement. When used it always has the value "yes".
	
	Segno and dalsegno are used for backwards jumps to a
	segno sign; coda and tocoda are used for forward jumps
	to a coda sign. If there are multiple jumps, the value
	of these parameters can be used to name and distinguish
	them. If segno or coda is used, the divisions attribute
	can also be used to indicate the number of divisions
	per quarter note. Otherwise sound and MIDI generating
	programs may have to recompute this.
	
	By default, a dalsegno or dacapo attribute indicates that
	the jump should occur the first time through, while a 
	tocoda attribute indicates the jump should occur the second
	time through. The time that jumps occur can be changed by
	using the time-only attribute.
	
	The forward-repeat attribute indicates that a forward
	repeat sign is implied but not displayed. It is used for
	example in two-part forms with repeats, such as a minuet
	and trio where no repeat is displayed at the start of the
	trio. This usually occurs after a barline. When used it
	always has the value of "yes".
	
	The fine attribute follows the final note or rest in a
	movement with a da capo or dal segno direction. If numeric,
	the value represents the actual duration of the final note or
	rest, which can be ambiguous in written notation and 
	different among parts and voices. The value may also be 
	"yes" to indicate no change to the final duration.
	
	If the sound element applies only particular times through a
	repeat, the time-only attribute indicates which times to apply
	the sound element. The value is a comma-separated list of
	positive integers arranged in ascending order, indicating
	which times through the repeated section that the element
	applies.
	
	Pizzicato in a sound element effects all following notes.
	Yes indicates pizzicato, no indicates arco.

	The pan and elevation attributes are deprecated in 
	Version 2.0. The pan and elevation elements in
	the midi-instrument element should be used instead.
	The meaning of the pan and elevation attributes is
	the same as for the pan and elevation elements. If
	both are present, the mid-instrument elements take
	priority.
	
	The damper-pedal, soft-pedal, and sostenuto-pedal 
	attributes effect playback of the three common piano
	pedals and their MIDI controller equivalents. The yes
	value indicates the pedal is depressed; no indicates 
	the pedal is released. A numeric value from 0 to 100
	may also be used for half pedaling. This value is the
	percentage that the pedal is depressed. A value of 0 is
	equivalent to no, and a value of 100 is equivalent to yes.
	
	Instrument changes, MIDI devices, MIDI instruments, and
	playback techniques are changed using the instrument-change
	element and elements defined in the common.mod file. When
	there are multiple instances of these elements, they should
	be grouped together by instrument using the id attribute
	values.

	The offset element is used to indicate that the sound takes
	place offset from the current score position. If the sound
	element is a child of a direction element, the sound offset
	element overrides the direction offset element if both 
	elements are present. Note that the offset reflects the
	intended musical position for the change in sound. It
	should not be used to compensate for latency issues in 
	particular hardware configurations.
-->
<!ELEMENT sound ((instrument-change?, midi-device?, 
    midi-instrument?, play?)*, swing?, offset?)>
<!ATTLIST sound
    tempo CDATA #IMPLIED
    dynamics CDATA #IMPLIED
    dacapo %yes-no; #IMPLIED
    segno CDATA #IMPLIED
    dalsegno CDATA #IMPLIED
    coda CDATA #IMPLIED
    tocoda CDATA #IMPLIED
    divisions CDATA #IMPLIED
    forward-repeat %yes-no; #IMPLIED
    fine CDATA #IMPLIED
    %time-only;
    pizzicato %yes-no; #IMPLIED
    pan CDATA #IMPLIED
    elevation CDATA #IMPLIED
    damper-pedal %yes-no-number; #IMPLIED
    soft-pedal %yes-no-number; #IMPLIED
    sostenuto-pedal %yes-no-number; #IMPLIED
    %optional-unique-id;
>

<!--
	The instrument-change element changes the virtual instrument
	sound for a given score-instrument. The id attribute refers
	to the score-instrument affected by the change. The
	virtual-instrument-data entity is defined in the common.mod
	file. All instrument-change child elements can also be
	initially specified within the score-instrument element.
-->
<!ELEMENT instrument-change %virtual-instrument-data;>
<!ATTLIST instrument-change
    id IDREF #REQUIRED
>

<!--
	The swing element specifies whether or not to use swing
	playback, where consecutive on-beat / off-beat eighth or 
	16th notes are played with unequal nominal durations. 
	
	The straight element specifies that no swing is present,
	so consecutive notes have equal durations.
	
	The first and second elements are positive integers that 
	specify the ratio between durations of consecutive notes.
	For example, a first element with a value of 2 and a second
	element with a value of 1 applied to eighth notes specifies
	a quarter note / eighth note tuplet playback, where the
	first note is twice as long as the second note. Ratios
	should be specified with the smallest integers possible.
	For example, a ratio of 6 to 4 should be specified as 3 to 2
	instead.
	
	The optional swing-type element specifies the note type, 
	either eighth or 16th, to which the ratio is applied. The
	value is eighth if this element is not present.
	
	The optional swing-style element is a string describing the
	style of swing used.

	The swing element has no effect for playback of grace notes,
	notes where a type element is not present, and notes where
	the specified duration is different than the nominal value
	associated with the specified type. If a swung note has
	attack and release attributes, those values modify the
	swung playback.
-->
<!ELEMENT swing ((straight | (first, second, swing-type?)),
    swing-style?)>

<!ELEMENT straight EMPTY>
<!ELEMENT first (#PCDATA)>
<!ELEMENT second (#PCDATA)>
<!ELEMENT swing-type (#PCDATA)>
<!ELEMENT swing-style (#PCDATA)>

<!-- 
	The listen and listening elements, new in Version 4.0,
	specify different ways that a score following or machine
	listening application can interact with a performer. The
	listening element handles interactions that change the state
	of the listening application from the specified point in
	the performance onward. If multiple child elements of the
	same type are present, they should have distinct player
	and/or time-only attributes.
	
	The offset element is used to indicate that the listening
	change takes place offset from the current score position.
	If the listening element is a child of a direction element,
	the listening offset element overrides the direction offset
	element if both elements are present. Note that the offset
	reflects the intended musical position for the change in
	state. It should not be used to compensate for latency
	issues in particular hardware configurations.
-->
<!ELEMENT listening ((sync | other-listening)+, offset?)>

<!-- 
	The sync element specifies the style that a score following
	application should use to synchronize an accompaniment with
	a performer. The none type indicates no synchronization to
	the performer. The tempo type indicates synchronization
	based on the performer tempo rather than individual events
	in the score. The event type indicates synchronization by
	following the performance of individual events in the score
	rather than the performer tempo. The mostly-tempo and
	mostly-event types combine these two approaches, with
	mostly-tempo giving more weight to tempo and mostly-event
	giving more weight to performed events. The always-event
	type provides the strictest synchronization by not being
	forgiving of missing performed events. If this element is
	not included in a score, default synchronization depends
	on the application.
	
	The optional latency attribute specifies a time in 
	milliseconds that the listening application should expect
	from the performer. The optional player and time-only
	attributes restrict the element to apply to a single player
	or set of times through a repeated section, respectively.
-->
<!ELEMENT sync EMPTY>
<!ATTLIST sync
    type (none | tempo | mostly-tempo | 
          mostly-event | event | always-event) #REQUIRED
    latency CDATA #IMPLIED
    player IDREF #IMPLIED
    %time-only;
>

<!-- 
	The other-listening element represents other types of
	listening control and interaction. The required type
	attribute indicates the type of listening to which the
	element content applies. The optional player and time-only
	attributes restrict the element to apply to a single player
	or set of times through a repeated section, respectively.
-->
<!ELEMENT other-listening (#PCDATA)>
<!ATTLIST other-listening
    type CDATA #REQUIRED
    player IDREF #IMPLIED
    %time-only;
>
