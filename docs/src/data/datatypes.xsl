<?xml version="1.0" encoding="UTF-8"?>

<!--
  Generate a JSON listing of all data types in an XSD schema.
-->

<xsl:stylesheet
  version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:fn="http://www.w3.org/2005/xpath-functions"
  exclude-result-prefixes="#all"
>
  <xsl:output method="json" indent="yes" encoding="UTF-8"/>

  <!-- Build an XML listing of data types based on the XSD schema. -->
  <xsl:mode on-no-match="deep-skip"/>
  <xsl:variable name="xlink" select="fn:doc(fn:replace(fn:document-uri(), fn:tokenize(fn:document-uri(), '/')[last()], 'xlink.xsd'))"/>
  <xsl:variable name="xml" select="fn:doc(fn:replace(fn:document-uri(), fn:tokenize(fn:document-uri(), '/')[last()], 'xml.xsd'))"/>

  <xsl:template match="/">
    <xsl:variable name="datatypes" as="map(*)*">
      <xsl:apply-templates select="xs:schema/xs:simpleType | xs:schema//xs:attribute[@ref]">
        <xsl:with-param name="schema" select="''"/>
      </xsl:apply-templates>
    </xsl:variable>
    <xsl:sequence select="array:fold-left(array{$datatypes}, map{}, function($m, $v) { map:put($m, fn:replace($v('name'), ':', '-'), $v) })"/>
  </xsl:template>

  <xsl:template match="xs:simpleType | xs:attribute[@name]" as="map(*)*">
    <xsl:param name="schema"/>
    <xsl:variable name="base" select="if (.//xs:restriction[@base]) then xs:string(.//xs:restriction/@base) else xs:string(@type)"/>
    <xsl:sequence select="map {
      'name': $schema || xs:string(@name),
      'documentation': .//xs:annotation/xs:documentation/text(),
      'base': $base,
      'type': if (.//xs:restriction[xs:enumeration]) then 'values'
        else if (.//xs:restriction[xs:pattern]) then 'regex'
        else if (.//xs:restriction[xs:minInclusive or xs:maxInclusive or xs:minExclusive or xs:maxExclusive]) then 'range'
        else 'unknown',
      'value': if (.//xs:restriction[xs:enumeration]) then fn:fold-left(.//xs:restriction/xs:enumeration, array{}, function($a, $v) {
        array:append($a, map {
          'value': xs:string($v/@value),
          'documentation': $v//xs:annotation/xs:documentation/text()
        })
      }) else if (.//xs:restriction[xs:pattern]) then xs:string(.//xs:restriction/xs:pattern/@value)
      else if (.//xs:restriction[xs:minInclusive or xs:maxInclusive or xs:minExclusive or xs:maxExclusive]) then fn:fold-left(.//xs:restriction/*, map{}, function($m, $v) {
        map:put($m, $v/local-name(), xs:string($v/@value))
      }) else ()
    }"/>
    <xsl:if test="starts-with($base, 'xs:')">
      <xsl:sequence select="map {
        'name': $base,
        'documentation': 'See the [definition in the W3C XML Schema standard](https://www.w3.org/TR/xmlschema-2/#' || fn:tokenize($base, ':')[2] || ').'
      }"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="xs:attribute[@ref]">
    <xsl:variable name="schema" select="if (fn:tokenize(@ref , ':')[1] = 'xlink') then $xlink else $xml"/>
    <xsl:apply-templates select="$schema//xs:attribute[@name=fn:tokenize(current()/@ref , ':')[2]]">
      <xsl:with-param name="schema" select="fn:tokenize(@ref , ':')[1] || ':'"/>
    </xsl:apply-templates>
  </xsl:template>
</xsl:stylesheet>
