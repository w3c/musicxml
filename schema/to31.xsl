<?xml version="1.0" encoding="UTF-8"?>

<!--
  MusicXML to31.xsl stylesheet

  Version 4.0

  Copyright © 2004-2021 the Contributors to the MusicXML 
  Specification, published by the W3C Music Notation Community
  Group under the W3C Community Final Specification Agreement 
  (FSA): 

     https://www.w3.org/community/about/agreements/final/

  A human-readable summary is available:

     https://www.w3.org/community/about/agreements/fsa-deed/
-->

<!--
  To31.xsl converts from MusicXML 4.0 to 3.1 for
  compatibility with older products.
-->

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!--
    XML output, with a DOCTYPE referring the partwise DTD.
    Here we use the full Internet URL.
  -->

  <xsl:output method="xml" indent="yes" encoding="UTF-8"
	  omit-xml-declaration="no" standalone="no"
	  doctype-system="http://www.musicxml.org/dtds/partwise.dtd"
	  doctype-public="-//Recordare//DTD MusicXML 3.1 Partwise//EN"/>

  <!--
    For the root, only look for score-partwise. Anything else
    as a root element gets ignored.
  -->
  <xsl:template match="/">
    <xsl:apply-templates select="./score-partwise"/>
  </xsl:template>

  <!--
    Transformations that remove post-3.1 elements and
    attributes.
  -->

  <!-- Additions in note.mod -->

  <!-- Remove new elements. -->
  <xsl:template
    match="listen"/>
  
  <!-- Remove all but the first instrument element -->
  <xsl:template 
    match="instrument[position() > 1]"/>

  <!-- 
    Remove accidental SMuFL attributes with new values.
  -->
  <xsl:template 
    match="accidental/@smufl[not(starts-with(., 'acc'))]"/>

  <!-- 
    Remove elements with number attributes greater than 6.
  -->
  <xsl:template 
    match="arpeggiate[number(@number) > 6] |
    glissando[number(@number) > 6] |
    hammer-on[number(@number) > 6] |
    non-arpeggiate[number(@number) > 6] |
    other-notation[number(@number) > 6] |
    pull-off[number(@number) > 6] |
    slide[number(@number) > 6] |
    slur[number(@number) > 6] |
    tied[number(@number) > 6] |
    tuplet[number(@number) > 6]"/>

  <!-- Remove new attributes. -->
  <xsl:template 
    match="arpeggiate/@unbroken | bend/@shape | 
      figured-bass/@halign | figured-bass/@valign |
      figured-bass/@placement | release/@offset"/>

  <!-- Additions in attributes.mod -->

  <!-- 
    Remove double elements that have an above value other
    than no, then remove the above attribute altogether.
    Make sure the tests have the right priority so the
    doubles are removed first, before the above attribute
    is removed.
  -->
  <xsl:template
    match="double/@above"/>

  <xsl:template priority="1"
    match="double[@above != 'no']"/>

  <!-- Remove new elements. -->
  <xsl:template
    match="for-part | line-detail"/>
  
  <!-- Remove new attributes. -->
  <xsl:template 
    match="staff-size/@scaling"/>
  
  <!-- Additions in barline.mod -->

  <!-- Remove new attributes. -->
  <xsl:template 
    match="ending/@system | repeat/@after-jump"/>

  <!-- Additions in common.mod -->

  <!-- 
    Remove level elements that have a type other than
    single, then remove the type attribute altogether.
    Make sure the tests have the right priority so the
    levels are removed first, before the type attribute
    is removed.
  -->
  <xsl:template 
    match="level/@type"/>

  <xsl:template priority="1"
    match="level[@type != 'single']"/>

  <!-- 
    Remove enclosure attributes with inverted-bracket value.
  -->
  <xsl:template 
    match="@enclosure[. = 'inverted-bracket']"/>

  <!-- 
    Remove elements with number attributes greater than 6.
  -->
  <xsl:template priority="1"
    match="wavy-line[number(@number) > 6]"/>
  
  <!-- Remove new attributes. -->
  <xsl:template 
    match="wavy-line/@smufl"/>
  
  <!-- Additions in direction.mod -->

  <!--
    Convert discontinue pedal types to stop pedal types,
    and resume pedal types to start pedal types. We do this
    instead of removing the entire element so that we do not
    leave dangling pedal elements after the conversion.
  -->
  <xsl:template 
    match="pedal/@type[. = 'discontinue']">
    <xsl:attribute name="type">stop</xsl:attribute>
  </xsl:template>
  <xsl:template 
    match="pedal/@type[. = 'resume']">
    <xsl:attribute name="type">start</xsl:attribute>
  </xsl:template>
  
  <!-- 
    Remove entire harmony that has a new numeral child element.
  -->
  <xsl:template
    match="harmony[numeral]"/>
  
  <!-- 
    Remove elements with number attributes greater than 6.
  -->
  <xsl:template 
    match="direction[direction-type/bracket[number(@number) > 6]] |
      direction[direction-type/dashes[number(@number) > 6]] |
      direction[direction-type/octave-shift[number(@number) > 6]] |
      direction[direction-type/pedal[number(@number) > 6]] |
      direction[direction-type/wedge[number(@number) > 6]]"/>
  
  <!-- Remove new elements. -->
  <xsl:template
    match="bass-separator | instrument-change | 
      listening | swing"/>
  
  <!-- Remove new attributes. -->
  <xsl:template 
    match="direction/@system | harmony/@system |
      harmony/@arrangement | bass/@arrangement | 
      inversion/@text | metronome/@print-object | 
      measure-numbering/@system | measure-numbering/@staff |
      measure-numbering/@multiple-rest-always | 
      measure-numbering/@multiple-rest-range |
      effect/@smufl | membrane/@smufl | metal/@smufl | 
      timpani/@smufl | wood/@smufl"/>
  
  <!-- Additions in score.mod -->

  <!-- Remove new elements. -->
  <xsl:template
    match="concert-score | part-link | player"/>
  
  <!--
    Convert score version attribute to 3.1.
  -->
  <xsl:template
    match="score-partwise/@version">
    <xsl:attribute name="version">3.1</xsl:attribute>
  </xsl:template>

  <!--
    The identity transformation. Used for everything that
    stays the same in 3.1.
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
