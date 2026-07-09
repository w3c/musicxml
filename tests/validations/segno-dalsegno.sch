<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">

  <sch:title>sound[@segno/@dalsegno]</sch:title>

  <sch:p>This schema validates that every sound element with a @dalsegno attribute has a corresponding
     sound element with a @segno attribute where both attribute values match.</sch:p>

  <!-- Pattern 1: Check that every @dalsegno has a matching @segno -->
  <sch:pattern id="dalsegno-segno-matching">
    <sch:rule context="sound[@dalsegno]">
      <sch:let name="dalsegno_value" value="@dalsegno"/>
      <sch:assert test="count(//sound[@segno = $dalsegno_value]) = 1">
        Sound element with @dalsegno="<sch:value-of select="$dalsegno_value"/>"
        must have exactly one corresponding sound element with @segno="<sch:value-of select="$dalsegno_value"/>".
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Pattern 2: Check that every @segno has one matching @dalsegno -->
  <sch:pattern id="segno-dalsegno-matching">
    <sch:rule context="sound[@segno]">
      <sch:let name="segno_value" value="@segno"/>
      <sch:assert test="count(//sound[@dalsegno = $segno_value]) = 1">
        Sound element with @segno="<sch:value-of select="$segno_value"/>"
        must have exactly one corresponding sound element with @dalsegno="<sch:value-of select="$segno_value"/>".
      </sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
