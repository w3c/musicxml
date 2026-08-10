<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">

  <sch:title>Beams and ties</sch:title>

  <sch:p>This schema validates constructs spanning multiple notes such as beams and ties.</sch:p>

  <!-- Check that beam/@fan attribute is consistent in a beaming group. -->
  <sch:pattern id="beam-group-fan">
    <sch:rule context="note/beam[@fan]">
      <sch:assert test="not(preceding-sibling::beam[@fan]) or preceding-sibling::beam/@fan = current()/@fan">
        beam group contains inconsistent value of @fan="<sch:value-of select="./@fan"/>". Either declare a single @fan entry for the whole group, or ensure all @fan values are equal.
      </sch:assert>
    </sch:rule>
  </sch:pattern>

</sch:schema>
