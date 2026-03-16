<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
        schemaVersion="iso"
        queryBinding="xslt3"
        xml:lang="en"
		phaseID="test"
        fpi="-//PYSCHEMATRON//DTD XML 1.0//EN">

   <title>Coda</title>
    <ns prefix="c" uri="" />
    <p>This checks that if there is a coda, there are an equal number of tocodas.</p> -->
    
    <pattern id="check-coda">
        <rule context="score-partwise">
             <!-- <assert test="(not(coda) and not(tocoda)) or (count(coda) = 1 and count(tocoda) = 1)">If there is a coda, there must be exactly one tocoda, and if there is a tocoda, there must be a coda.</assert> -->
			<!-- <assert test="descendant::coda">There is a coda attribute.</assert> -->
			<!-- <assert test="count(.//coda) = count(.//tocoda)">The number of &lt;coda&gt; elements {count(.//coda)} must equal the number of &lt;tocoda&gt; elements ({count(.//tocoda)}) within &lt;score-partwise&gt;.</assert> -->
			<assert test="count(.//coda) = count(.//tocoda)">The number of &lt;coda&gt; elements must equal the number of &lt;tocoda&gt; elements within &lt;score-partwise&gt;.</assert>
        </rule>
    </pattern>
    <phase id="test">
        <active pattern="check-coda"/>
    </phase>
   
<!--
   	<xs:complexType name="coda">
		<xs:annotation>
			<xs:documentation>The coda type is the visual indicator of a coda sign. The exact glyph can be specified with the smufl attribute. A sound element is also needed to guide playback applications reliably.</xs:documentation>
		</xs:annotation>
		<xs:attributeGroup ref="print-style-align"/>
		<xs:attributeGroup ref="optional-unique-id"/>
		<xs:attribute name="smufl" type="smufl-coda-glyph-name"/>
	</xs:complexType>

    <xs:complexType name="barline">
		<xs:annotation>
			<xs:documentation>If a barline is other than a normal single barline, it should be represented by a barline type that describes it. This includes information about repeats and multiple endings, as well as line style. Barline data is on the same level as the other musical data in a score - a child of a measure in a partwise score, or a part in a timewise score. This allows for barlines within measures, as in dotted barlines that subdivide measures in complex meters. The two fermata elements allow for fermatas on both sides of the barline (the lower one inverted).

Barlines have a location attribute to make it easier to process barlines independently of the other musical data in a score. It is often easier to set up measures separately from entering notes. The location attribute must match where the barline element occurs within the rest of the musical data in the score. If location is left, it should be the first element in the measure, aside from the print, bookmark, and link elements. If location is right, it should be the last element, again with the possible exception of the print, bookmark, and link elements. If no location is specified, the right barline is the default. The segno, coda, and divisions attributes work the same way as in the sound element. They are used for playback when barline elements contain segno or coda child elements.</xs:documentation>
		</xs:annotation>
		<xs:sequence>
			<xs:element name="bar-style" type="bar-style-color" minOccurs="0"/>
			<xs:group ref="editorial"/>
			<xs:element name="wavy-line" type="wavy-line" minOccurs="0"/>
			<xs:element name="segno" type="segno" minOccurs="0"/>
			<xs:element name="coda" type="coda" minOccurs="0"/>
			<xs:element name="fermata" type="fermata" minOccurs="0" maxOccurs="2"/>
			<xs:element name="ending" type="ending" minOccurs="0"/>
			<xs:element name="repeat" type="repeat" minOccurs="0"/>
		</xs:sequence>
		<xs:attribute name="location" type="right-left-middle" default="right"/>
		<xs:attribute name="segno" type="xs:token"/>
		<xs:attribute name="coda" type="xs:token"/>
		<xs:attribute name="divisions" type="divisions"/>
		<xs:attributeGroup ref="optional-unique-id"/>
	</xs:complexType>

    
			<xs:choice maxOccurs="unbounded">
				<xs:element name="words" type="formatted-text-id">
					<xs:annotation>
						<xs:documentation>The words element specifies a standard text direction. The enclosure is none if not specified. The language is Italian ("it") if not specified. Left justification is used if not specified.</xs:documentation>
					</xs:annotation>
				</xs:element>
				<xs:element name="symbol" type="formatted-symbol-id">
					<xs:annotation>
						<xs:documentation>The symbol element specifies a musical symbol using a canonical SMuFL glyph name. It is used when an occasional musical symbol is interspersed into text. It should not be used in place of semantic markup, such as metronome marks that mix text and symbols. Left justification is used if not specified. Enclosure is none if not specified.</xs:documentation>
					</xs:annotation>
				</xs:element>
			</xs:choice>
			<xs:element name="wedge" type="wedge"/>
			<xs:element name="dynamics" type="dynamics" maxOccurs="unbounded"/>
			<xs:element name="dashes" type="dashes"/>
			<xs:element name="bracket" type="bracket"/>
			<xs:element name="pedal" type="pedal"/>
			<xs:element name="metronome" type="metronome"/>
			<xs:element name="octave-shift" type="octave-shift"/>
			<xs:element name="harp-pedals" type="harp-pedals"/>
			<xs:element name="damp" type="empty-print-style-align-id">
				<xs:annotation>
					<xs:documentation>The damp element specifies a harp damping mark.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="damp-all" type="empty-print-style-align-id">
				<xs:annotation>
					<xs:documentation>The damp-all element specifies a harp damping mark for all strings.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="eyeglasses" type="empty-print-style-align-id">
				<xs:annotation>
					<xs:documentation>The eyeglasses element represents the eyeglasses symbol, common in commercial music.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="string-mute" type="string-mute"/>
			<xs:element name="scordatura" type="scordatura"/>
			<xs:element name="image" type="image"/>
			<xs:element name="principal-voice" type="principal-voice"/>
			<xs:element name="percussion" type="percussion" maxOccurs="unbounded"/>
			<xs:element name="accordion-registration" type="accordion-registration"/>
			<xs:element name="staff-divide" type="staff-divide"/>
			<xs:element name="other-direction" type="other-direction"/>
		</xs:choice>
		<xs:attributeGroup ref="optional-unique-id"/>
	</xs:complexType>


    	<xs:complexType name="sound">
		<xs:annotation>
			<xs:documentation>The sound element contains general playback parameters. They can stand alone within a part/measure, or be a component element within a direction.

Tempo is expressed in quarter notes per minute. If 0, the sound-generating program should prompt the user at the time of compiling a sound (MIDI) file.

Dynamics (or MIDI velocity) are expressed as a percentage of the default forte value (90 for MIDI 1.0).

Dacapo indicates to go back to the beginning of the movement. When used it always has the value "yes".

Segno and dalsegno are used for backwards jumps to a segno sign; coda and tocoda are used for forward jumps to a coda sign. If there are multiple jumps, the value of these parameters can be used to name and distinguish them. If segno or coda is used, the divisions attribute can also be used to indicate the number of divisions per quarter note. Otherwise sound and MIDI generating programs may have to recompute this.

By default, a dalsegno or dacapo attribute indicates that the jump should occur the first time through, while a tocoda attribute indicates the jump should occur the second time through. The time that jumps occur can be changed by using the time-only attribute.

The forward-repeat attribute indicates that a forward repeat sign is implied but not displayed. It is used for example in two-part forms with repeats, such as a minuet and trio where no repeat is displayed at the start of the trio. This usually occurs after a barline. When used it always has the value of "yes".

The fine attribute follows the final note or rest in a movement with a da capo or dal segno direction. If numeric, the value represents the actual duration of the final note or rest, which can be ambiguous in written notation and different among parts and voices. The value may also be "yes" to indicate no change to the final duration.

If the sound element applies only particular times through a repeat, the time-only attribute indicates which times to apply the sound element.

Pizzicato in a sound element effects all following notes. Yes indicates pizzicato, no indicates arco.

The pan and elevation attributes are deprecated in Version 2.0. The pan and elevation elements in the midi-instrument element should be used instead. The meaning of the pan and elevation attributes is the same as for the pan and elevation elements. If both are present, the mid-instrument elements take priority.

The damper-pedal, soft-pedal, and sostenuto-pedal attributes effect playback of the three common piano pedals and their MIDI controller equivalents. The yes value indicates the pedal is depressed; no indicates the pedal is released. A numeric value from 0 to 100 may also be used for half pedaling. This value is the percentage that the pedal is depressed. A value of 0 is equivalent to no, and a value of 100 is equivalent to yes.

Instrument changes, MIDI devices, MIDI instruments, and playback techniques are changed using the instrument-change, midi-device, midi-instrument, and play elements. When there are multiple instances of these elements, they should be grouped together by instrument using the id attribute values.

The offset element is used to indicate that the sound takes place offset from the current score position. If the sound element is a child of a direction element, the sound offset element overrides the direction offset element if both elements are present. Note that the offset reflects the intended musical position for the change in sound. It should not be used to compensate for latency issues in particular hardware configurations.</xs:documentation>
		</xs:annotation>
		<xs:sequence>
			<xs:sequence minOccurs="0" maxOccurs="unbounded">
				<xs:element name="instrument-change" type="instrument-change" minOccurs="0"/>
				<xs:element name="midi-device" type="midi-device" minOccurs="0"/>
				<xs:element name="midi-instrument" type="midi-instrument" minOccurs="0"/>
				<xs:element name="play" type="play" minOccurs="0"/>
			</xs:sequence>
			<xs:element name="swing" type="swing" minOccurs="0"/>
			<xs:element name="offset" type="offset" minOccurs="0"/>
		</xs:sequence>
		<xs:attribute name="tempo" type="non-negative-decimal"/>
		<xs:attribute name="dynamics" type="non-negative-decimal"/>
		<xs:attribute name="dacapo" type="yes-no"/>
		<xs:attribute name="segno" type="xs:token"/>
		<xs:attribute name="dalsegno" type="xs:token"/>
		<xs:attribute name="coda" type="xs:token"/>
		<xs:attribute name="tocoda" type="xs:token"/>
		<xs:attribute name="divisions" type="divisions"/>
		<xs:attribute name="forward-repeat" type="yes-no"/>
		<xs:attribute name="fine" type="xs:token"/>
		<xs:attribute name="time-only" type="time-only"/>
		<xs:attribute name="pizzicato" type="yes-no"/>
		<xs:attribute name="pan" type="rotation-degrees"/>
		<xs:attribute name="elevation" type="rotation-degrees"/>
		<xs:attribute name="damper-pedal" type="yes-no-number"/>
		<xs:attribute name="soft-pedal" type="yes-no-number"/>
		<xs:attribute name="sostenuto-pedal" type="yes-no-number"/>
		<xs:attributeGroup ref="optional-unique-id"/>
	</xs:complexType>

 <constraintSpec ident="slur_start-_and_end-type_attributes_required" scheme="schematron">
<constraint>
<sch:rule context="mei:slur">
<sch:assert test="@startid or @tstamp or @tstamp.ges or @tstamp.real">Must have one of the attributes: startid, tstamp, tstamp.ges or tstamp.real.</sch:assert>
<sch:assert test="@dur or @dur.ges or @endid or @tstamp2">Must have one of the attributes: dur, dur.ges, endid, or tstamp2.</sch:assert>
</sch:rule>
</constraint>
</constraintSpec>
-->
</schema>