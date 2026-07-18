<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">

  <sch:title>Parts and groups</sch:title>

  <sch:p>This schema validates structural constructs for parts and groups.</sch:p>

  <!-- Check that staff numbers correspond to the staves declaration. -->
  <sch:pattern id="staff-number-staves">
    <sch:rule context="part-symbol">
      <sch:let name="staves" value="(ancestor::attributes/staves/number(), ancestor::measure/preceding-sibling::measure[attributes/staves][last()]/attributes/staves/number(), 1)[1]"/>
      <sch:assert test="number(@top-staff) &lt;= $staves">
        part-symbol/@top-staff=<sch:value-of select="@top-staff"/> should be within staves=<sch:value-of select="$staves"/>.
      </sch:assert>
      <sch:assert test="number(@bottom-staff) &lt;= $staves">
        part-symbol/@bottom-staff=<sch:value-of select="@bottom-staff"/> should be within staves=<sch:value-of select="$staves"/>.
      </sch:assert>
    </sch:rule>
  </sch:pattern>

</sch:schema>
