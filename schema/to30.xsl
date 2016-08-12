<?xml version="1.0" encoding="UTF-8"?>

<!--
	MusicXML to30.xsl stylesheet
	
	Version 3.1 Draft
	
	Copyright © 2004-2016 the Contributors to the MusicXML 
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
  
  <xsl:template 
    match="accidental/@smufl | accidental-mark/@smufl"/>
  
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
  
  <xsl:template 
    match="accidental-text/@smufl"/>
  
  <!-- Additions in direction.mod -->

  <xsl:template 
    match="image/@height | image/@width"/>

  <!-- Additions in layout.mod -->
  
  <!-- Additions in score.mod -->

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
