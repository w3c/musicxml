<?xml version="1.0" encoding="UTF-8"?>

<!--
  MIDI XML midixml.xsl for sorting MIDI files with
  absolute timestamps.

  Version 4.0

  Copyright © 2004-2021 the Contributors to the MusicXML 
  Specification, published by the W3C Music Notation Community
  Group under the W3C Community Final Specification Agreement 
  (FSA): 

     https://www.w3.org/community/about/agreements/final/

  A human-readable summary is available:

     https://www.w3.org/community/about/agreements/fsa-deed/

  The MIDI XML file format is deprecated as of Version 4.0.
-->

<!--
  XSL Stylesheet for sorting MIDI XML by absolute timestamp.
-->

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!--
	  The identity transformation. Used for everything aside
	  from the track element.
  -->

  <xsl:template match="text()">
    <xsl:value-of select="." />
  </xsl:template>
  
  <xsl:template match="*|@*|comment()|processing-instruction()">
    <xsl:copy>
      <xsl:apply-templates
        select="*|@*|comment()|processing-instruction()|text()"/>
    </xsl:copy>
  </xsl:template>

  <!--
	  When we get to a Track, sort all events within the track
	  by their Absolute timestamp.
  -->

  <xsl:template match="Track">
    <xsl:element name="Track">
      <xsl:apply-templates>
        <xsl:sort data-type="number" select="Absolute" />
      </xsl:apply-templates>
    </xsl:element>
  </xsl:template>
 
</xsl:stylesheet>