<?xml version="1.0" encoding="UTF-8"?>

<!--
	MusicXML to30.xsl stylesheet

	Version 3.1 Draft

	Copyright © 2004-2017 the Contributors to the MusicXML
	Specification, published by the W3C Music Notation Community
	Group under the W3C Community Contributor License Agreement
	(CLA):

	   https://www.w3.org/community/about/agreements/cla/

	A human-readable summary is available:

	   https://www.w3.org/community/about/agreements/cla-deed/
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

  <!-- Remove new MusicXML 3.1 elements -->
  <xsl:template
    match="inverted-vertical-turn | haydn | soft-accent"/>

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
    Remove notehead elements with new notehead values.
  -->
  <xsl:template
    match="notehead[. = 'other']"/>

  <!--
    Remove time-only attribute from lyric element.
  -->
  <xsl:template
    match="lyrics/@time-only"/>

  <!-- Remove smufl attributes -->
  <xsl:template
    match="accidental/@smufl | accidental-mark/@smufl |
			other-articulation/@smufl | other-notation/@smufl |
			other-ornament/@smufl | other-technical/@smufl |
			notehead/@smufl"/>

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

  <!-- Additions in attributes.mod -->

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

  <!-- Additions in barline.mod -->

  <!-- Additions in common.mod -->

  <!-- Remove n, pf, and sfzp elements -->
  <xsl:template
    match="n | pf | sfzp"/>

  <!-- Remove accidental-text elements with new other value -->
  <xsl:template
    match="accidental-text[.='other']"/>

  <!-- Remove smufl attributes -->
  <xsl:template
    match="accidental-text/@smufl | other-dynamics/@smufl"/>

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

  <!--
    For safety, remove entire direction that has a new
    MusicXML 3.1 direction-type child.
  -->
  <xsl:template
    match="direction[direction-type[staff-divide]]"/>

  <!-- 
    For safety, remove entire direction that has a new 
    enumeration value in percussion child elements.
  -->
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
        . = 'musical saw' or . = 'shell bells']]]]"/>

  <xsl:template 
    match="direction[direction-type[percussion[wood[
        . = 'bamboo scraper' or . = 'castanets with handle' or
        . = 'football rattle' or . = 'quijada' or
        . = 'rainstick' or . = 'reco-reco' or
        . = 'whip']]]]"/>

  <!-- Remove new image attributes -->
  <xsl:template
    match="image/@height | image/@width"/>

  <!-- Remove smufl attributes -->
  <xsl:template
    match="other-direction/@smufl | other-percussion/@smufl"/>

  <!-- Additions in layout.mod -->

  <!-- Remove glyph elements -->
  <xsl:template
    match="glyph"/>

  <!-- Additions in score.mod -->

  <!-- Remove new image attributes -->
  <xsl:template
    match="credit-image/@height | credit-image/@width"/>

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
