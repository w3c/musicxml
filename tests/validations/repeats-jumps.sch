<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">

  <sch:title>Repeats and jumps</sch:title>

  <sch:p>This schema validates constructs for repeats and jumps, such as barline repeats, voltas, segnos, codas, etc.</sch:p>

  <!-- Check that every @tocoda has one matching @coda -->
  <sch:pattern id="tocoda-coda-matching">
    <sch:rule context="sound[@tocoda]">
      <sch:let name="tocoda" value="@tocoda"/>
      <sch:assert test="count(//sound[@coda = $tocoda]) = 1">
        sound element with @tocoda="<sch:value-of select="$tocoda"/>" must have exactly one corresponding sound element with @coda="<sch:value-of select="$tocoda"/>".
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Check that every @coda has one matching @tocoda -->
  <sch:pattern id="coda-tocoda-matching">
    <sch:rule context="sound[@coda]">
      <sch:let name="coda" value="@coda"/>
      <sch:assert test="count(//sound[@tocoda = $coda]) = 1">
        sound element with @coda="<sch:value-of select="$coda"/>" must have exactly one corresponding sound element with @tocoda="<sch:value-of select="$coda"/>".
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Check that segno and coda do not co-occur within a barline. -->
  <sch:pattern id="barline-segno-coda-cooccur">
    <sch:rule context="barline">
      <sch:assert test="not(coda and segno)">
        coda and segno elements cannot co-occur within a barline.
      </sch:assert>
    </sch:rule>
  </sch:pattern>

</sch:schema>
