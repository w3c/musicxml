<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">

  <sch:title>sound[@coda/@tocoda]</sch:title>

  <sch:p>This schema validates that every sound element with a @tocoda attribute has a corresponding
     sound element with a @coda attribute where both attribute values match.</sch:p>

  <!-- Pattern 1: Check that every @tocoda has a matching @coda -->
  <sch:pattern id="tocoda-coda-matching">
    <sch:rule context="sound[@tocoda]">
      <sch:let name="tocoda_value" value="@tocoda"/>
      <sch:assert test="//sound[@coda = $tocoda_value]">
        Sound element with @tocoda="<sch:value-of select="$tocoda_value"/>"
        has no corresponding sound element with @coda="<sch:value-of select="$tocoda_value"/>".
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Pattern 2: Check that every @coda has at least one matching @tocoda -->
  <sch:pattern id="coda-tocoda-matching">
    <sch:rule context="sound[@coda]">
      <sch:let name="coda_value" value="@coda"/>
      <sch:report test="//sound[@tocoda = $coda_value]" role="WARN">
        Sound element with @coda="<sch:value-of select="$coda_value"/>"
        has no corresponding sound element with @tocoda="<sch:value-of select="$coda_value"/>".
      </sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>
