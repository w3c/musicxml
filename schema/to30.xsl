<?xml version="1.0" encoding="UTF-8"?>

<!--
	MusicXML to30.xsl stylesheet

	Version 3.1
	
	Copyright © 2004-2017 the Contributors to the MusicXML 
	Specification, published by the W3C Music Notation Community
	Group under the W3C Community Final Specification Agreement 
	(FSA): 
	
	   https://www.w3.org/community/about/agreements/final/
	
	A human-readable summary is available:
	
	   https://www.w3.org/community/about/agreements/fsa-deed/
-->

<!--
	To30.xsl converts from MusicXML 3.1 to 3.0 for
	compatibility with older products.
-->

<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!--
    XML output, with a DOCTYPE refering the partwise DTD.
    Here we use the full Internet URL.
  -->

  <xsl:output method="xml" indent="yes" encoding="UTF-8"
	omit-xml-declaration="no" standalone="no"
	doctype-system="http://www.musicxml.org/dtds/partwise.dtd"
	doctype-public="-//Recordare//DTD MusicXML 3.0 Partwise//EN" />

  <!--
    For the root, only look for score-partwise. Anything else
    as a root element gets ignored.
  -->
  <xsl:template match="/">
    <xsl:apply-templates select="./score-partwise"/>
  </xsl:template>

  <!--
    Transformations that remove post-3.0 elements and
    attributes.
  -->

  <!-- Additions in note.mod -->

  <!--
    Earlier versions of MusicXML allow notes to have a 
    grace or cue element, but not both. Remove any cue
    element that follows a grace element.
  -->  
  <xsl:template 
    match="note/cue[preceding-sibling::grace]"/>

  <!-- Remove new MusicXML 3.1 elements -->
  <xsl:template
    match="arrowhead | brass-bend | flip | golpe | 
			half-muted | harmon-mute | haydn |
			inverted-vertical-turn | open | 
			smear | soft-accent"/>

  <!-- Remove new id attributes -->
  <xsl:template 
    match="note/@id | beam/@id | 
			notations/@id | tied/@id |
			slur/@id | tuplet/@id | 
			glissando/@id | slide/@id |
			other-notation/@id | ornaments/@id |
			accidental-mark/@id | technical/@id |
			articulations/@id | arpeggiate/@id |
			non-arpeggiate/@id | lyric/@id | 
			figured-bass/@id"/>

  <!--
    Remove accidental and accidental-mark elements with
    the new accidental values.
  -->
  <xsl:template
    match="accidental[. = 'double-sharp-down' or
			. = 'double-sharp-up' or . = 'flat-flat-down' or
			. = 'flat-flat-up' or . = 'arrow-down' or
			. = 'arrow-up' or . = 'other']"/>

  <xsl:template
    match="accidental-mark[. = 'double-sharp-down' or
			. = 'double-sharp-up' or . = 'flat-flat-down' or
			. = 'flat-flat-up' or . = 'arrow-down' or
			. = 'arrow-up' or . = 'other']"/>

<!--
    Remove tied elements which use the new let-ring
    type for single-ended ties.
  -->
  <xsl:template
    match="tied[@type = 'let-ring']"/>

<!--
    Remove tremolo elements which use the new unmeasured
    type for unmeasured tremolos.
  -->
  <xsl:template
    match="tremolo[@type = 'unmeasured']"/>

  <!--
    Remove notehead elements with new notehead values.
  -->
  <xsl:template
    match="notehead[. = 'circled' or . = 'other']"/>

  <!--
    Remove handbell elements with new handbell values.
  -->
  <xsl:template
    match="handbell[. = 'belltree']"/>

  <!--
    Remove new figured bass elements.
  -->
  <xsl:template
    match="figure/footnote | figure/level"/>

  <!--
    Remove new element-specific attributes.
  -->
  <xsl:template
    match="accidental-mark/@parentheses | 
			accidental-mark/@bracket | accidental-mark/@size | 
			lyric/@time-only | note/@print-leger |
			tap/@hand"/>

  <!--
    Remove line-length attribute from articulation elements.
  -->
  <xsl:template
    match="doit/@line-length | falloff/@line-length |
			plop/@line-length | scoop/@line-length"/>

  <!-- Remove smufl attributes -->
  <xsl:template
    match="accidental/@smufl | accidental-mark/@smufl |
			arrow/@smufl | elision/@smufl |
			notehead/@smufl | stopped/@smufl |
			tremolo/@smufl |
			other-articulation/@smufl | other-notation/@smufl |
			other-ornament/@smufl | other-technical/@smufl"/>

  <!--
    Do not copy text for caesura elements, or for breath-mark 
    elements with new values.
  -->
  <xsl:template
    match="caesura | breath-mark[. = 'upbow' or . = 'salzedo']">
    <xsl:copy><xsl:apply-templates
      select="*|@*|comment()|processing-instruction()"
    /></xsl:copy>
  </xsl:template>

  <!--
    Convert grace-cue sizes to grace size. This is consistent
    with our removal of the cue element from notes that
    contain both grace and cue elements.
  -->
  <xsl:template 
    match="@size[. = 'grace-cue']">
    <xsl:attribute name="size">grace</xsl:attribute>
  </xsl:template>

  <!-- Additions in attributes.mod -->

  <!-- Remove new id attributes -->
  <xsl:template 
    match="key/@id | time/@id | 
			clef/@id | transpose/@id |
			measure-style/@id"/>

  <!--
    Remove key-accidental elements with new accidental values.
  -->
  <xsl:template
    match="key-accidental[. = 'double-sharp-down' or
			. = 'double-sharp-up' or . = 'flat-flat-down' or
			. = 'flat-flat-up' or . = 'arrow-down' or
			. = 'arrow-up' or . = 'other']"/>

  <xsl:template
    match="key-accidental/@smufl"/>

  <!-- Remove except-voice elements -->
  <xsl:template
    match="except-voice"/>

  <!-- Additions in barline.mod -->

  <!-- Remove new id attributes -->
  <xsl:template 
    match="barline/@id"/>

  <!-- Additions in common.mod -->

  <!-- Replace the n, pf, and sfzp elements with other-dynamics -->
  <xsl:template match="n">
    <xsl:element name="other-dynamics">
      <xsl:text>n</xsl:text>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="pf">
    <xsl:element name="other-dynamics">
      <xsl:text>pf</xsl:text>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="sfzp">
    <xsl:element name="other-dynamics">
      <xsl:text>sfzp</xsl:text>
    </xsl:element>
  </xsl:template>
  
  <!-- Remove new id attributes -->
  <xsl:template 
    match="fermata/@id | segno/@id | 
		coda/@id | dynamics/@id"/>

  <!--
    Remove accidental-text elements with new accidental values.
  -->
  <xsl:template
    match="accidental-text[. = 'double-sharp-down' or
			. = 'double-sharp-up' or . = 'flat-flat-down' or
			. = 'flat-flat-up' or . = 'arrow-down' or
			. = 'arrow-up' or . = 'other']"/>

  <!-- Remove smufl attributes -->
  <xsl:template
    match="accidental-text/@smufl | other-dynamics/@smufl |
		coda/@smufl | segno/@smufl"/>

  <!-- 
    Remove enclosure attributes that have values of pentagon,
    hexagon, heptagon, octagon, nonagon, or decagon.
  -->
  <xsl:template 
    match="@enclosure[. = 'pentagon' or . = 'hexagon' or
		. = 'heptagon' or . = 'octagon' or
		. = 'nonagon' or . = 'decagon']"/>

  <!--
    Do not copy text for fermata elements with new values.
  -->
  <xsl:template
    match="fermata[. = 'double-angled' or
      . = 'double-square' or . = 'double-dot' or
      . = 'half-curve' or . = 'curlew']">
    <xsl:copy><xsl:apply-templates
      select="*|@*|comment()|processing-instruction()"
    /></xsl:copy>
  </xsl:template>
    
  <!-- Additions in direction.mod -->

  <!-- Remove new id attributes -->
  <xsl:template 
    match="direction/@id | direction-type/@id | 
			rehearsal/@id | words/@id |
			wedge/@id | dashes/@id |
			bracket/@id | pedal/@id |
			metronome/@id | octave-shift/@id |
			harp-pedals/@id | damp/@id |
			damp-all/@id | eyeglasses/@id |
			string-mute/@id | scordatura/@id |
			image/@id | principal-voice/@id |
			accordion-registration/@id |
			percussion/@id | other-direction/@id |
			harmony/@id | frame/@id |
			grouping/@id | print/@id |
			sound/@id"/>

  <!-- Remove smufl attributes -->
  <xsl:template
    match="glass/@smufl | pitched/@smufl |
			other-direction/@smufl | 
			other-percussion/@smufl"/>

  <!--
    For safety, remove entire direction that has a new
    MusicXML 3.1 direction-type child.
  -->
  <xsl:template
    match="direction[direction-type[staff-divide]]"/>

  <xsl:template
    match="direction[direction-type[symbol]]"/>

  <!--
    Convert sostenuto pedal types to start (damper) pedal
    types. We do this instead of removing the entire element
    so that we do not leave a dangling pedal element with a
    stop type after the conversion.
  -->
  <xsl:template 
    match="pedal/@type[. = 'sostenuto']">
    <xsl:attribute name="type">start</xsl:attribute>
  </xsl:template>

  <!-- 
    Remove pedal elements that have a number greater
    than 1, then remove the number and abbreviated
    attributes altogether. Make sure the tests have
    the right priority so the directions are removed
    first, before the number attribute is removed.
  -->
  <xsl:template
    match="pedal/@number | pedal/@abbreviated"/>

  <xsl:template priority="1"
    match="direction[direction-type[pedal[@number != '1']]]"/>

  <!-- Remove new optional elements -->
  <xsl:template
    match="beat-unit-tied | metronome-arrows | 
			metronome-tied"/>

  <!-- 
    For safety, remove entire direction that has a new 
    enumeration value in percussion child elements.
  -->
  <xsl:template 
    match="direction[direction-type[percussion[beater[
        . = 'drum stick' or . = 'slide brush on gong' or
        . = 'superball']]]]"/>

  <xsl:template 
    match="direction[direction-type[percussion[effect[
        . = 'lotus flute' or . = 'megaphone']]]]"/>

  <xsl:template 
    match="direction[direction-type[percussion[glass[
        . = 'glass harmonica' or . = 'glass harp']]]]"/>

  <xsl:template 
    match="direction[direction-type[percussion[membrane[
        . = 'Chinese tomtom' or . = 'cuica' or
        . = 'Indo-American tomtom' or . = 'Japanese tomtom' or
        . = 'tabla']]]]"/>

  <xsl:template 
    match="direction[direction-type[percussion[metal[
        . = 'agogo' or . = 'bell tree' or
        . = 'cencerro' or . = 'chain rattle' or
        . = 'jaw harp' or . = 'jingle bells' or
        . = 'musical saw' or . = 'shell bells' or
        . = 'tam tam with beater']]]]"/>

  <xsl:template 
    match="direction[direction-type[percussion[pitched[
        . = 'celesta' or . = 'lithophone' or
        . = 'steel drums' or . = 'tubaphone']]]]"/>

  <xsl:template 
    match="direction[direction-type[percussion[stick[stick-type[
        . = 'glockenspiel' or . = 'gum' or
        . = 'hammer' or . = 'superball' or
        . = 'wound']]]]]"/>

  <xsl:template 
    match="direction[direction-type[percussion[wood[
        . = 'bamboo scraper' or . = 'castanets with handle' or
        . = 'football rattle' or . = 'quijada' or
        . = 'rainstick' or . = 'reco-reco' or
        . = 'whip']]]]"/>

  <!-- Remove stick attributes -->
  <xsl:template
    match="stick/@parentheses | stick/@dashed-circle"/>

  <!-- Remove new image attributes -->
  <xsl:template
    match="image/@height | image/@width"/>

  <!-- Additions in layout.mod -->

  <!-- Remove glyph elements -->
  <xsl:template
    match="glyph"/>

  <!-- 
    Remove note-size element with a grace-cue type.
  -->
  <xsl:template 
    match="note-size[@type = 'grace-cue']"/>

  <!-- Additions in score.mod -->

  <!-- Remove credit-symbol elements -->
  <xsl:template
    match="credit-symbol"/>

  <!-- Remove new id attributes -->
  <xsl:template 
    match="credit/@id | credit-image/@id | 
			credit-words/@id | measure/@id"/>

  <!-- Remove new image attributes -->
  <xsl:template
    match="credit-image/@height | credit-image/@width"/>

  <!-- Remove new measure attributes -->
  <xsl:template
    match="measure/@text"/>

  <!--
    Convert score version attribute to 3.0
  -->
  <xsl:template
    match="score-partwise/@version | score-timewise/@version">
    <xsl:attribute name="version">3.0</xsl:attribute>
  </xsl:template>

  <!--
    The identity transformation. Used for everything that
    stays the same in 3.0.
  -->

  <xsl:template match="text()">
    <xsl:value-of select="." />
  </xsl:template>

  <!--
    Whitespace within an xsl:copy could cause problems with
    empty elements.
  -->
  <xsl:template match="*|@*|comment()|processing-instruction()">
    <xsl:copy><xsl:apply-templates
        select="*|@*|comment()|processing-instruction()|text()"
    /></xsl:copy>
  </xsl:template>

</xsl:stylesheet>
