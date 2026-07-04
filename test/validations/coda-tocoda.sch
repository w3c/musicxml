<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">

  <sch:title>sound[@coda/@tocoda]</sch:title>

  <sch:p>This schema validates that every sound element with a @tocoda attribute has a corresponding
     sound element with a @coda attribute where both attribute values match.</sch:p>

  <!-- Pattern 1: Check that every @tocoda has one matching @coda -->
  <sch:pattern id="tocoda-coda-matching">
    <sch:rule context="sound[@tocoda]">
      <sch:let name="tocoda_value" value="@tocoda"/>
      <sch:assert test="count(//sound[@coda = $tocoda_value]) = 1">
        Sound element with @tocoda="<sch:value-of select="$tocoda_value"/>"
        must have exactly one corresponding sound element with @coda="<sch:value-of select="$tocoda_value"/>".
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Pattern 2: Check that every @coda has one matching @tocoda -->
  <sch:pattern id="coda-tocoda-matching">
    <sch:rule context="sound[@coda]">
      <sch:let name="coda_value" value="@coda"/>
      <sch:assert test="count(//sound[@tocoda = $coda_value]) = 1">
        Sound element with @coda="<sch:value-of select="$coda_value"/>"
        must have exactly one corresponding sound element with @tocoda="<sch:value-of select="$coda_value"/>".
      </sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
