<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
  <sch:title>MusicXML Measure Beat Validation</sch:title>
  
  <sch:pattern id="measure-beats">
    <sch:rule context="measure/*[self::note or self::forward][voice and not(voice = preceding-sibling::*[self::note or self::forward]/voice)]">
      <sch:let name="measure" value="ancestor::measure[1]"/>
      <sch:let name="voice-number" value="voice"/>
      <!-- Find the most recent time signature (current or from preceding measures) -->
      <sch:let name="beats-numerator" value="number(((($measure/preceding-sibling::measure/attributes/time) | ($measure/attributes/time))[last()])/beats)"/>
      <sch:let name="beat-type-denominator" value="number(((($measure/preceding-sibling::measure/attributes/time) | ($measure/attributes/time))[last()])/beat-type)"/>
      <sch:let name="divisions" value="number(((($measure/preceding-sibling::measure/attributes/divisions) | ($measure/attributes/divisions))[last()]))"/>
      
      <!-- Calculate expected duration in divisions -->
      <!-- Formula: (beats * divisions * 4) / beat-type -->
      <sch:let name="expected-duration" value="($beats-numerator * $divisions * 4) div $beat-type-denominator"/>
      
      <!-- Sum the durations for the current voice line in the measure -->
      <sch:let name="actual-duration" value="sum($measure/*[self::note or self::forward][voice = $voice-number and not(chord)]/duration)"/>
      
      <!-- Allow small floating point errors -->
      <sch:let name="tolerance" value="0.5"/>
      
      <sch:assert test="((($measure/preceding-sibling::measure/attributes/time) | ($measure/attributes/time))[last()]) and (($actual-duration - $expected-duration) &lt; $tolerance and ($expected-duration - $actual-duration) &lt; $tolerance)">
        Measure <sch:value-of select="@number"/> has incorrect beat count on voice <sch:value-of select="$voice-number"/>. 
        Expected duration: <sch:value-of select="$expected-duration"/> divisions, 
        but got: <sch:value-of select="$actual-duration"/> divisions 
        (Time signature: <sch:value-of select="concat($beats-numerator, '/', $beat-type-denominator)"/>)
      </sch:assert>
    </sch:rule>
  </sch:pattern>
  
</sch:schema>
