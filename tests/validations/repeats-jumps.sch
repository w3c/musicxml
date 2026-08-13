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

  <!-- Check that every @dalsegno has a matching @segno -->
  <sch:pattern id="dalsegno-segno-matching">
    <sch:rule context="sound[@dalsegno]">
      <sch:let name="dalsegno" value="@dalsegno"/>
      <sch:assert test="count(//sound[@segno = $dalsegno]) = 1">
        sound element with @dalsegno="<sch:value-of select="$dalsegno"/>" must have exactly one corresponding sound element with @segno="<sch:value-of select="$dalsegno"/>".
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Check that every @segno has one matching @dalsegno -->
  <sch:pattern id="segno-dalsegno-matching">
    <sch:rule context="sound[@segno]">
      <sch:let name="segno" value="@segno"/>
      <sch:assert test="count(//sound[@dalsegno = $segno]) = 1">
        sound element with @segno="<sch:value-of select="$segno"/>" must have exactly one corresponding sound element with @dalsegno="<sch:value-of select="$segno"/>".
      </sch:assert>
    </sch:rule>
  </sch:pattern>

</sch:schema>
