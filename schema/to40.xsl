<?xml version="1.0" encoding="UTF-8"?>

<!--
  MusicXML to40.xsl stylesheet

  Version 4.1 Draft

  Copyright © 2004-2024 the Contributors to the MusicXML
  Specification, published by the W3C Music Notation Community
  Group under the W3C Community Contributor License Agreement
  (CLA):

     https://www.w3.org/community/about/agreements/cla/

  A human-readable summary is available:

     https://www.w3.org/community/about/agreements/cla-deed/
-->

<!--
  To40.xsl converts from MusicXML 4.1 to 4.0 for
  compatibility with older products.
-->

<xsl:stylesheet
  version="1.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!--
    XML output, with a DOCTYPE referring the partwise DTD.
    Here we use the older musicxml.org Internet URL.
  -->

  <xsl:output method="xml" indent="yes" encoding="UTF-8"
	  omit-xml-declaration="no" standalone="no"
	  doctype-system="http://www.musicxml.org/dtds/partwise.dtd"
	  doctype-public="-//Recordare//DTD MusicXML 4.0 Partwise//EN"/>

  <!--
    For the root, only look for score-partwise. Anything else
    as a root element gets ignored.
  -->
  <xsl:template match="/">
    <xsl:apply-templates select="./score-partwise"/>
  </xsl:template>

  <!--
    Transformations that remove post-4.0 elements and
    attributes.
  -->

  <!-- Remove new attributes. -->
  <xsl:template
    match="score-partwise/@xsi:schemaLocation"/>

  <xsl:template
    match="harmonic/@number"/>

  <!--
    Convert score version attribute to 4.0.
  -->
  <xsl:template
    match="score-partwise/@version">
    <xsl:attribute name="version">4.0</xsl:attribute>
  </xsl:template>

  <!--
    The identity transformation. Used for everything that
    stays the same in 4.0.
  -->
  <xsl:template match="text()">
    <xsl:value-of select="." />
  </xsl:template>

  <!-- Copy elements -->
  <xsl:template match="*" priority="-1">
    <xsl:element name="{name()}">
        <xsl:apply-templates select="node()|@*"/>
    </xsl:element>
  </xsl:template>

  <!-- Copy all other nodes -->
  <xsl:template match="node()|@*" priority="-2">
    <xsl:copy />
  </xsl:template>

</xsl:stylesheet>
