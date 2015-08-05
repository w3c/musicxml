<?xml version="1.0" encoding="UTF-8"?>

<!--
	MusicXML to06c.xsl
	
	Version 1.0 - 7 January 2004
	
	Copyright © 2004 Recordare LLC.
	http://www.recordare.com/
	
	This MusicXML work is being provided by the copyright
	holder under the MusicXML Document Type Definition 
	Public License Version 1.02, available from:
	
		http://www.recordare.com/dtds/license.html
-->

<!--
	To06c.xsl converts from MusicXML 1.0 to 0.6c for
	compatibility with Dolet Light for Finale 2003.
-->

<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!--
    XML output, with a DOCTYPE refering the partwise DTD.
    Here we use a relative URL for doctype-system. You can
    change this to another relative URL, or to the full
    Internet URL:
		
	 http://www.musicxml.org/dtds/partwise.dtd
  -->

  <xsl:output method="xml" indent="yes" encoding="UTF-8"
	 omit-xml-declaration="no" standalone="no"
	 doctype-system="/musicxml/partwise.dtd"
	 doctype-public="-//Recordare//DTD MusicXML 0.6c Partwise//EN" />

  <!--
    For the root, only look for score-partwise. Anything else 
    as a root element gets ignored.
  -->  
  <xsl:template match="/">
    <xsl:apply-templates select="./score-partwise"/>
  </xsl:template>

  <!--
    Transformations that remove post-0.6c elements and attributes.
  -->
  
  <!-- Additions in note.dtd -->
  <xsl:template 
    match="normal-dot | non-arpeggiate | other-notation |
           tuplet-actual | tuplet-normal | other-ornament |
           bend | tap | other-technical | natural | artificial |
           base-pitch | touching-pitch | sounding-pitch |
           scoop | plop | doit | falloff | other-articulation"/>
  
  <xsl:template 
    match="lyric/footnote | lyric/level | notations/footnote |
           notations/level | notations/accidental-mark"/>
  
  <xsl:template 
    match="note/@release | accidental/@size | tuplet/@show-type | 
           notehead/@* | text/@* | hammer-on/@font-family |
           hammer-on/@font-style | hammer-on/@font-size |
           hammer-on/@font-weight | pull-off/@font-family |
           pull-off/@font-style | pull-off/@font-size |
           pull-off/@font-weight | stem/@* | 
           note/@time-only | fingering/@alternate | 
           fingering/@font-family | fingering/@font-style |
           fingering/@font-size | fingering/@font-weight |
           accidental/@relative-x | accidental/@relative-y |
           accidental/@default-x | accidental/@default-y |
           dot/@relative-x | dot/@relative-y |
           dot/@default-x | dot/@default-y"/>
  
  <xsl:template match="slur[@type='continue']"/>
  <xsl:template 
    match="slur/@bezier-offset | slur/@bezier-offset2 |
           slur/@bezier-x | slur/@bezier-x2 |
           slur/@bezier-y | slur/@bezier-y2"/>

  <!-- Additions in attributes.dtd -->
  <xsl:template match="measure-style | staff-details/@show-frets"/>
  
  <!-- Additions in common.dtd -->
  <xsl:template 
    match="midi-unpitched | wavy-line/@number | level/@*"/>
  <xsl:template match="wavy-line[@type='stop']"/>

  <!-- Additions in identity.dtd -->
  <xsl:template match="supports"/>

  <!-- Additions in link.dtd -->
  <xsl:template match="link | bookmark"/>

  <!-- Additions in direction.dtd -->
  <xsl:template 
    match="direction[direction-type/bracket | 
                     direction-type/damp | 
                     direction-type/damp-all | 
                     direction-type/eyeglasses |
                     direction-type/other-direction]"/>

  <xsl:template
    match="direction[direction-type/metronome[not(per-minute)]]"/>

  <xsl:template 
    match="frame | wedge/@number | octave-shift/@number | 
           dashes/@number | pedal/@line | bracket/@end-length | 
           sound/@pan | sound/@elevation | 
           sound/@time-only | sound/@damper-pedal |
           sound/@soft-pedal | sound/@sostenuto-pedal |
           harmony/@relative-x | harmony/@relative-y | 
    			 harmony/@default-x | harmony/@default-y | 
    			 harmony/@placement | harmony/@print-object |
    			 harmony/@print-frame | harmony/footnote |
    			 harmony/level"/>

  <!-- 
    Changes in score.dtd that we can't automatically process.
  -->
  <xsl:template match="group"/>

  <!-- 
    Remove the tie element from grace notes. MusicXML 0.6c
    only used the tied element with grace notes.
  -->
  <xsl:template match="tie[../grace]"/>

  <!--
    Convert 1.0 schleifer into 0.6c slide element,
    and 1.0 slide into 0.6c glissando element.
  -->
  
  <xsl:template match="schleifer">
    <xsl:element name="slide">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="slide">
    <xsl:element name="glissando">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <!--
    Convert 1.0 rf into 0.6c other-dynamics.
  -->
  
  <xsl:template match="rf">
    <xsl:element name="other-dyanamics">
      <xsl:text>rf</xsl:text>
      <xsl:apply-templates
        select="@type | @number | @line-type | @default-x |
                @default-y | @relative-x | @relative-y"/>
    </xsl:element>
  </xsl:template>
    
  <!--
    The identity transformation. Used for everything that
    stays the same in 0.6c.
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
