<?xml version="1.0" encoding="UTF-8"?>

<!--
	MusicXML to31.xsl stylesheet

	Version 4.0 Draft
	
	Copyright © 2004-2021 the Contributors to the MusicXML 
	Specification, published by the W3C Music Notation Community
	Group under the W3C Community Contributor License Agreement 
	(CLA): 
	
	   https://www.w3.org/community/about/agreements/cla/
	
	A human-readable summary is available:
	
	   https://www.w3.org/community/about/agreements/cla-deed/
-->

<!--
	To31.xsl converts from MusicXML 4.0 to 3.1 for
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
	doctype-public="-//Recordare//DTD MusicXML 3.1 Partwise//EN" />

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

  <!-- 
    Remove accidental SMuFL attributes with new values.
  -->
  <xsl:template 
    match="accidental/@smufl[not(starts-with(., 'acc'))]"/>

  <!-- Remove new attributes. -->
  <xsl:template 
    match="bend/@shape | figured-bass/@placement"/>

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
    match="for-part"/>
  
  <!-- Additions in barline.mod -->

  <!-- Remove new attributes. -->
  <xsl:template 
    match="ending/@system"/>

  <!-- Additions in common.mod -->

  <!-- 
    Remove enclosure attributes with inverted-bracket value.
  -->
  <xsl:template 
    match="@enclosure[. = 'inverted-bracket']"/>

  <!-- Additions in direction.mod -->

  <!-- 
    For safety, remove entire direction that has a new
    pedal type.
  -->
  <xsl:template priority="1"
    match="direction[direction-type[pedal[@type = 'discontinue']]]"/>
  
  <!-- Remove new elements. -->
  <xsl:template
    match="instrument-change | swing"/>
  
  <!-- Remove new attributes. -->
  <xsl:template 
    match="direction/@system | harmony/@system |
      measure-numbering/@system | measure-numbering/@staff |
      measure-numbering/@multiple-rest-always | 
      measure-numbering/@multiple-rest-range"/>
  
  <!-- Additions in score.mod -->

  <!-- Remove new elements. -->
  <xsl:template
    match="concert-score | part-link"/>
  
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
