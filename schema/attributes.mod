<!--
	MusicXML attributes.mod module

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
	The attributes DTD module contains the attributes element
	and its children, such as key and time signatures.
-->

<!-- Entities -->

<!--
	The time-separator entity indicates how to display the
	arrangement between the beats and beat-type values in a
	time signature. The default value is none. The horizontal,
	diagonal, and vertical values represent horizontal, diagonal
	lower-left to upper-right, and vertical lines respectively. 
	For these values, the beats and beat-type values are arranged
	on either side of the separator line. The none value represents
	no separator with the beats and beat-type arranged vertically.
	The adjacent value represents no separator with the beats and
	beat-type arranged horizontally.
-->
<!ENTITY % time-separator
	"separator (none | horizontal | diagonal | 
		vertical | adjacent) #IMPLIED">

<!--
	The time-symbol entity indicates how to display a time
	signature. The normal value is the usual fractional display,
	and is the implied symbol type if none is specified. Other
	options are the common and cut time symbols, as well as a
	single number with an implied denominator. The note symbol
	indicates that the beat-type should be represented with
	the corresponding downstem note rather than a number. The
	dotted-note symbol indicates that the beat-type should be
	represented with a dotted downstem note that corresponds to
	three times the beat-type value, and a numerator that is
	one third the beats value.
-->
<!ENTITY % time-symbol
	"symbol (common | cut | single-number | 
			 note | dotted-note | normal) #IMPLIED">

<!-- Elements -->

<!--
	The attributes element contains musical information that
	typically changes on measure boundaries. This includes
	key and time signatures, clefs, transpositions, and staving.
	When attributes are changed mid-measure, it affects the
	music in score order, not in MusicXML document order.
-->
<!ELEMENT attributes (%editorial;, divisions?, key*, time*,
	staves?, part-symbol?, instruments?, clef*, staff-details*,
	(transpose* | for-part*), directive*, measure-style*)>

<!--	
	Traditional key signatures are represented by the number
	of flats and sharps, plus an optional mode for major/
	minor/mode distinctions. Negative numbers are used for
	flats and positive numbers for sharps, reflecting the
	key's placement within the circle of fifths (hence the
	element name). A cancel element indicates that the old
	key signature should be cancelled before the new one
	appears. This will always happen when changing to C major
	or A minor and need not be specified then. The cancel
	value matches the fifths value of the cancelled key
	signature (e.g., a cancel of -2 will provide an explicit
	cancellation for changing from B flat major to F major).
	The optional location attribute indicates where a key
	signature cancellation appears relative to a new key
	signature: to the left, to the right, or before the barline
	and to the left. It is left by default. For mid-measure key
	elements, a cancel location of before-barline should be
	treated like a cancel location of left.
	
	Non-traditional key signatures are represented using a list
	of altered tones. The key-step and key-alter elements are
	represented the same way as the step and alter elements are
	in the pitch element in the note.mod file. The optional
	key-accidental element is represented the same way as the
	accidental element in the note.mod file. It is used for
	disambiguating microtonal accidentals. The different element
	names indicate the different meaning of altering notes in a
	scale versus altering a sounding pitch.
	
	Valid mode values include major, minor, dorian, phrygian,
	lydian, mixolydian, aeolian, ionian, locrian, and none.

	The optional number attribute refers to staff numbers, 
	from top to bottom on the system. If absent, the key
	signature applies to all staves in the part.

	The optional list of key-octave elements is used to specify
	in which octave each element of the key signature appears.
	The content specifies the octave value using the same
	values as the display-octave element. The number attribute
	is a positive integer that refers to the key signature
	element in left-to-right order. If the cancel attribute is
	set to yes, then this number refers to the canceling key
	signature specified by the cancel element in the parent key
	element. The cancel attribute cannot be set to yes if there is
	no corresponding cancel element within the parent key element.
	It is no by default.

	Key signatures appear at the start of each system unless
	the print-object attribute has been set to "no".
-->
<!ELEMENT key (((cancel?, fifths, mode?) |
	((key-step, key-alter, key-accidental?)*)), key-octave*)>
<!ATTLIST key
    number CDATA #IMPLIED
    %print-style;
    %print-object;
    %optional-unique-id;
>
<!ELEMENT cancel (#PCDATA)>
<!ATTLIST cancel
    location (left | right | before-barline) #IMPLIED
>
<!ELEMENT fifths (#PCDATA)>
<!ELEMENT mode (#PCDATA)>
<!ELEMENT key-step (#PCDATA)>
<!ELEMENT key-alter (#PCDATA)>
<!ELEMENT key-accidental (#PCDATA)>
<!ATTLIST key-accidental
    %smufl;
>
<!ELEMENT key-octave (#PCDATA)>
<!ATTLIST key-octave
    number NMTOKEN #REQUIRED
    cancel %yes-no; #IMPLIED
>

<!--
	Musical notation duration is commonly represented as
	fractions. The divisions element indicates how many 
	divisions per quarter note are used to indicate a note's
	duration. For example, if duration = 1 and divisions = 2,
	this is an eighth note duration. Duration and divisions
	are used directly for generating sound output, so they
	must be chosen to take tuplets into account. Using a
	divisions element lets us use just one number to 
	represent a duration for each note in the score, while
	retaining the full power of a fractional representation.
	For maximum compatibility with Standard MIDI Files, the
	divisions value should not exceed 16383.
-->
<!ELEMENT divisions (#PCDATA)>

<!--
	Time signatures are represented by two elements. The
	beats element indicates the number of beats, as found in
	the numerator of a time signature. The beat-type element
	indicates the beat unit, as found in the denominator of
	a time signature.

	Multiple pairs of beats and beat-type elements are used for
	composite time signatures with multiple denominators, such
	as 2/4 + 3/8. A composite such as 3+2/8 requires only one
	beats/beat-type pair. 

	The interchangeable element is used to represent the second
	in a pair of interchangeable dual time signatures, such as
	the 6/8 in 3/4 (6/8). A separate symbol attribute value is
	available compared to the time element's symbol attribute,
	which applies to the first of the dual time signatures.
	The time-relation element indicates the symbol used to
	represent the interchangeable aspect of the time signature.
	Valid values are parentheses, bracket, equals, slash, space,
	and hyphen.

	A senza-misura element explicitly indicates that no time
	signature is present. The optional element content
	indicates the symbol to be used, if any, such as an X.
	The time element's symbol attribute is not used when a
	senza-misura element is present.

	The print-object attribute allows a time signature to be
	specified but not printed, as is the case for excerpts
	from the middle of a score. The value is "yes" if
	not present. The optional number attribute refers to staff
	numbers within the part, from top to bottom on the system. 
	If absent, the time signature applies to all staves in the 
	part.
-->
<!ELEMENT time
	(((beats, beat-type)+, interchangeable?) | senza-misura)>
<!ATTLIST time
    number CDATA #IMPLIED
    %time-symbol;
    %time-separator;
    %print-style-align;
    %print-object;
    %optional-unique-id;
>
<!ELEMENT interchangeable (time-relation?, (beats, beat-type)+)>
<!ATTLIST interchangeable
    %time-symbol;
    %time-separator;
>
<!ELEMENT beats (#PCDATA)>
<!ELEMENT beat-type (#PCDATA)>
<!ELEMENT senza-misura (#PCDATA)>
<!ELEMENT time-relation (#PCDATA)>

<!--
	Staves are used if there is more than one staff
	represented in the given part (e.g., 2 staves for
	typical piano parts). If absent, a value of 1 is assumed.
	Staves are ordered from top to bottom in a part in
	numerical order, with staff 1 above staff 2.
-->
<!ELEMENT staves (#PCDATA)>

<!--
	The part-symbol element indicates how a symbol for a
	multi-staff part is indicated in the score. Values include
	none, brace, line, bracket, and square; brace is the default.
	The top-staff and bottom-staff attributes are used when the
	brace does not extend across the entire part. For example, in
	a 3-staff organ part, the top-staff will typically be 1 for
	the right hand, while the bottom-staff will typically be 2
	for the left hand. Staff 3 for the pedals is usually outside
	the brace. By default, the presence of a part-symbol element
	that does not extend across the entire part also indicates a 
	corresponding change in the common barlines within a part.
 -->
<!ELEMENT part-symbol (#PCDATA)>
<!ATTLIST part-symbol
	top-staff CDATA #IMPLIED
	bottom-staff CDATA #IMPLIED
    %position;
    %color;
>

<!--
	Instruments are only used if more than one instrument is
	represented in the part (e.g., oboe I and II where they
	play together most of the time). If absent, a value of 1
	is assumed.
-->
<!ELEMENT instruments (#PCDATA)>

<!--
	Clefs are represented by the sign, line, and
	clef-octave-change elements. Sign values include G,
	F, C, percussion, TAB, jianpu, and none. 
	
	The jianpu sign indicates that the music that follows
	should be in jianpu numbered notation, just as the TAB
	sign indicates that the music that follows should be in
	tablature notation. Unlike TAB, a jianpu sign does not
	correspond to a visual clef notation.
	
	The none sign is deprecated as of MusicXML 4.0. Use the clef
	element's print-object attribute instead. When the none sign
	is used, notes should be displayed as if in treble clef.

	Line numbers are counted from the bottom of the staff.
	They are only needed with the G, F, and C signs in order
	to position a pitch correctly on the staff. Standard
	values are 2 for the G sign (treble clef), 4 for the F
	sign (bass clef), and 3 for the C sign (alto clef). Line
	values can be used to specify positions outside the staff,
	such as a C clef positioned in the middle of a grand staff.
	
	The clef-octave-change element is used for transposing
	clefs. A treble clef for tenors would have a value of -1.
	
	The optional number attribute refers to staff numbers
	within the part, from top to bottom on the system. A
	value of 1 is assumed if not present. 

	Sometimes clefs are added to the staff in non-standard
	line positions, either to indicate cue passages, or when
	there are multiple clefs present simultaneously on one
	staff. In this situation, the additional attribute is set to
	"yes" and the line value is ignored. The size attribute
	is used for clefs where the additional attribute is "yes".
	It is typically used to indicate cue clefs.

	Sometimes clefs at the start of a measure need to appear
	after the barline rather than before, as for cues or for
	use after a repeated section. The after-barline attribute
	is set to "yes" in this situation. The attribute is ignored
	for mid-measure clefs.

	Clefs appear at the start of each system unless the 
	print-object attribute has been set to "no" or the 
	additional attribute has been set to "yes".
-->
<!ELEMENT clef (sign, line?, clef-octave-change?)>
<!ATTLIST clef
    number CDATA #IMPLIED
    additional %yes-no; #IMPLIED
    size %symbol-size; #IMPLIED
    after-barline %yes-no; #IMPLIED
    %print-style;
    %print-object;
    %optional-unique-id;
>
<!ELEMENT sign (#PCDATA)>
<!ELEMENT line (#PCDATA)>
<!ELEMENT clef-octave-change (#PCDATA)>

<!--
	The staff-details element is used to indicate different
	types of staves. 
	
	The staff-type element can be ossia, editorial, cue,
	alternate, or regular. An ossia staff represents music
	that can be played instead of what appears on the regular
	staff. An editorial staff also represents musical 
	alternatives, but is created by an editor rather than the
	composer. It can be used for suggested interpretations or
	alternatives from other sources. A cue staff represents
	music from another part. An alternate staff shares the
	same music as the prior staff, but displayed differently
	(e.g., treble and bass clef, standard notation and
	tablature). It is not included in playback. An alternate
	staff provides more information to an application reading a
	file than encoding the same music in separate parts, so its
	use is preferred in this situation if feasible. A regular
	staff is the standard default staff-type.
	
	The staff-lines element specifies the number of lines and
	is usually used for a non 5-line staff. If the staff-lines
	element is present, the appearance of each line may be
	individually specified with a line-detail element. Staff
	lines are numbered from bottom to top. The print-object
	attribute allows lines to be hidden within a staff. This
	is used in special situations such as a widely-spaced
	percussion staff where a note placed below the higher line
	is distinct from a note placed above the lower line. Hidden
	staff lines are included when specifying clef lines and
	determining display-step / display-octave values, but are
	not counted as lines for the purposes of the system-layout
	and staff-layout elements.
	
	The staff-tuning and capo elements are used to specify tuning
	when using tablature notation.
	
	The optional number attribute specifies the staff number from
	top to bottom on the system, as with clef. The optional
	show-frets attribute indicates whether to show tablature
	frets as numbers (0, 1, 2) or letters (a, b, c). The default
	choice is numbers. The print-object attribute is used to
	indicate when a staff is not printed in a part, usually in
	large scores where empty parts are omitted. It is yes by 
	default. If print-spacing is yes while print-object is no,
	the score is printed in cutaway format where vertical space
	is left for the empty part.
-->
<!ELEMENT staff-details
    (staff-type?, (staff-lines, line-detail*)?, staff-tuning*,
     capo?, staff-size?)>
<!ATTLIST staff-details
    number         CDATA                #IMPLIED
    show-frets     (numbers | letters)  #IMPLIED
    %print-object;
    %print-spacing;
>
<!ELEMENT staff-type (#PCDATA)>
<!ELEMENT staff-lines (#PCDATA)>

<!ELEMENT line-detail EMPTY>
<!ATTLIST line-detail
    line    CDATA       #REQUIRED
    width   %tenths;    #IMPLIED
    %color;
    %line-type;
    %print-object;
>

<!--
	The tuning-step, tuning-alter, and tuning-octave
	elements are defined in the common.mod file. Staff
	lines are numbered from bottom to top.
-->
<!ELEMENT staff-tuning
	(tuning-step, tuning-alter?, tuning-octave)>
<!ATTLIST staff-tuning
    line CDATA #REQUIRED
>

<!--
	The capo element indicates at which fret a capo should
	be placed on a fretted instrument. This changes the
	open tuning of the strings specified by staff-tuning
	by the specified number of half-steps.
-->
<!ELEMENT capo (#PCDATA)>

<!--
	The staff-size element indicates how large a staff space
	is on this staff, expressed as a percentage of the work's
	default scaling. Values less than 100 make the staff space
	smaller while values over 100 make the staff space larger.
	A staff-type of cue, ossia, or editorial implies a
	staff-size of less than 100, but the exact value is
	implementation-dependent unless specified here. Staff size
	affects staff height only, not the relationship of the staff
	to the left and right margins.
	
	In some cases, a staff-size different than 100 also scales
	the notation on the staff, such as with a cue staff. In
	other cases, such as percussion staves, the lines may be
	more widely spaced without scaling the notation on the
	staff. The scaling attribute allows these two cases to be
	distinguished. It specifies the percentage scaling that 
	applies to the notation. Values less that 100 make the
	notation smaller while values over 100 make the notation
	larger. The staff-size content and scaling attribute are
	both non-negative decimal values.
-->
<!ELEMENT staff-size (#PCDATA)>
<!ATTLIST staff-size
    scaling CDATA #IMPLIED
>

<!--
	If the part is being encoded for a transposing instrument
	in written vs. concert pitch, the transposition must be
	encoded in the transpose element. The transpose element
	represents what must be added to the written pitch to get
	the correct sounding pitch.

	The transposition is represented by chromatic steps
	(required) and three optional elements: diatonic pitch
	steps, octave changes, and doubling an octave down. 
	
	The chromatic element represents the number of semitones
	needed to get from written to sounding pitch. The diatonic
	element specifies the number of pitch steps needed to go
	from written to sounding pitch. This allows for correct
	spelling of enharmonic transpositions. The octave-change
	element indicates how many octaves to add to get from
	written pitch to sounding pitch. Neither the chromatic nor
	the diatonic element include octave-change values; the
	values for both elements need to be added to the written
	pitch to get the correct sounding pitch. The octave-change
	element should be included when using transposition
	intervals of an octave or more, and should not be present
	for intervals of less than an octave. 
	
	If the double element is present, it indicates that the
	music is doubled one octave from what is currently written.
	If the above attribute is set to yes, the doubling is one
	octave above what is written, as for mixed flute / piccolo
	parts in band literature. Otherwise the doubling is one
	octave below what is written, as for mixed cello / bass
	parts in orchestral literature.
	
	The optional number attribute refers to staff numbers, 
	from top to bottom on the system. If absent, the
	transposition applies to all staves in the part. Per-staff 
	transposition is most often used in parts that represent
	multiple instruments. 
-->
<!ELEMENT transpose
	(diatonic?, chromatic, octave-change?, double?)>
<!ATTLIST transpose
    number CDATA #IMPLIED
    %optional-unique-id;
>
<!ELEMENT diatonic (#PCDATA)>
<!ELEMENT chromatic (#PCDATA)>
<!ELEMENT octave-change (#PCDATA)>
<!ELEMENT double EMPTY>
<!ATTLIST double
    above %yes-no; #IMPLIED
>

<!--
	The for-part element is used in a concert score to indicate
	the transposition for a transposed part created from that
	score. It is only used in score files that contain a
	concert-score element in the defaults. This allows concert
	scores with transposed parts to be represented in a single
	uncompressed MusicXML file.

	The child elements for the part-clef and part-transpose
	elements have the same meaning as for the clef and transpose
	elements. However that meaning applies to a transposed part
	created from the existing score file.

	The optional number attribute refers to staff numbers, 
	from top to bottom on the system. If absent, the child
	elements apply to all staves in the created part.

	The chromatic element in a part-transpose element will 
	usually have a non-zero value, since octave transpositions
	can be represented in concert scores using the transpose
	element.

	The part-clef element is used for transpositions that also
	include a change of clef, as for instruments such as
	bass clarinet.
-->
<!ELEMENT for-part (part-clef?, part-transpose)>
<!ATTLIST for-part
    number CDATA #IMPLIED
    %optional-unique-id;
>

<!ELEMENT part-clef (sign, line?, clef-octave-change?)>

<!ELEMENT part-transpose
	(diatonic?, chromatic, octave-change?, double?)>

<!--
	Directives are like directions, but can be grouped together 
	with attributes for convenience. This is typically used for
	tempo markings at the beginning of a piece of music. This
	element was deprecated in Version 2.0 in favor of the
	direction element's directive attribute. Language names
	come from ISO 639, with optional country subcodes from
	ISO 3166.
-->
<!ELEMENT directive (#PCDATA)>
<!ATTLIST directive
    %print-style;
    xml:lang CDATA #IMPLIED
>

<!--
	A measure-style indicates a special way to print partial
	to multiple measures within a part. This includes multiple
	rests over several measures, repeats of beats, single, or
	multiple measures, and use of slash notation.
	
	The multiple-rest and measure-repeat elements indicate the
	number of measures covered in the element content. The
	beat-repeat and slash elements can cover partial measures.
	All but the multiple-rest element use a type attribute to 
	indicate starting and stopping the use of the style. The
	optional number attribute specifies the staff number from
	top to bottom on the system, as with clef.
-->
<!ELEMENT measure-style (multiple-rest | 
	measure-repeat | beat-repeat | slash)>
<!ATTLIST measure-style
    number CDATA #IMPLIED
    %font;
    %color;
    %optional-unique-id;
>

<!--
	The slash-type and slash-dot elements are optional children
	of the beat-repeat and slash elements. They have the same
	values as the type and dot elements, and define what the
	beat is for the display of repetition marks. If not present,
	the beat is based on the current time signature.
-->
<!ELEMENT slash-type (#PCDATA)>
<!ELEMENT slash-dot EMPTY>

<!--
	The except-voice element is used to specify a combination
	of slash notation and regular notation. Any note elements
	that are in voices specified by the except-voice elements
	are displayed in normal notation, in addition to the slash
	notation that is always displayed.
-->
<!ELEMENT except-voice (#PCDATA)>

<!--
	The text of the multiple-rest element indicates the number
	of measures in the multiple rest. Multiple rests may use
	the 1-bar / 2-bar / 4-bar rest symbols, or a single shape.
	The use-symbols attribute indicates which to use; it is no
	if not specified.
-->
<!ELEMENT multiple-rest (#PCDATA)>
<!ATTLIST multiple-rest
    use-symbols %yes-no; #IMPLIED
>

<!--
	The measure-repeat and beat-repeat element specify a
	notation style for repetitions. The actual music being
	repeated needs to be repeated within the MusicXML file.
	These elements specify the notation that indicates the
	repeat.
-->

<!--
	The measure-repeat element specifies a notation style for 
	repetitions. The actual music being repeated needs to be 
	repeated within each measure of the MusicXML file. This 
	element specifies the notation that indicates the repeat.
	It is used for both single and multiple measure repeats.
	The text of the element indicates the number of measures
	to be repeated in a single pattern. The slashes attribute
	specifies the number of slashes to use in the repeat sign.
	It is 1 if not specified. 
	
	The stop type indicates the first measure where the repeats
	are no longer displayed. Both the start and the stop of the
	measure-repeat should be specified unless the repeats are
	displayed through the end of the part.
-->
<!ELEMENT measure-repeat (#PCDATA)>
<!ATTLIST measure-repeat
    type %start-stop; #REQUIRED
    slashes NMTOKEN #IMPLIED
>

<!--
	The beat-repeat element is used to indicate that a single
	beat (but possibly many notes) is repeated. The slashes
	attribute specifies the number of slashes to use in the 
	symbol. The use-dots attribute indicates whether or not to
	use dots as well (for instance, with mixed rhythm patterns).
	The value for slashes is 1 and the value for use-dots is no
	if not specified.
	
	The stop type indicates the first beat where the repeats
	are no longer displayed. Both the start and stop of the
	beat being repeated should be specified unless the repeats
	are displayed through the end of the part.
	
-->
<!ELEMENT beat-repeat ((slash-type, slash-dot*)?, except-voice*)>
<!ATTLIST beat-repeat
    type %start-stop; #REQUIRED
    slashes NMTOKEN #IMPLIED
    use-dots %yes-no; #IMPLIED
>

<!--
	The slash element is used to indicate that slash notation
	is to be used. If the slash is on every beat, use-stems is
	no (the default). To indicate rhythms but not pitches,
	use-stems is set to yes. The type attribute indicates
	whether this is the start or stop of a slash notation
	style. The use-dots attribute works as for the beat-repeat
	element, and only has effect if use-stems is no.
-->
<!ELEMENT slash ((slash-type, slash-dot*)?, except-voice*)>
<!ATTLIST slash
    type %start-stop; #REQUIRED
    use-dots %yes-no; #IMPLIED
    use-stems %yes-no; #IMPLIED
>
