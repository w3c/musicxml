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
      <xsl:apply-templates select="xs:schema/xs:simpleType">
        <xsl:with-param name="name" select="()"/>
      </xsl:apply-templates>
      <xsl:apply-templates mode="xs-ref" select="xs:schema//xs:attribute[@ref]"/>
      <xsl:apply-templates mode="xs-type" select="xs:schema//xs:attribute[starts-with(@type, 'xs:')]"/>
    </xsl:variable>
    <xsl:sequence select="array:fold-left(array{$datatypes}, map{}, function($m, $v) { map:put($m, fn:replace(fn:replace($v('name'), ':', '-'), 'xs-', 'xsd-'), $v) })"/>
  </xsl:template>

  <xsl:template match="xs:simpleType" as="map(*)*">
    <xsl:param name="name"/>
    <xsl:variable name="base" select="xs:string(xs:restriction/@base)"/>
    <xsl:sequence select="map {
      'name': if (@name) then xs:string(@name) else $name,
      'documentation': xs:annotation/xs:documentation/text(),
      'base': $base,
      'type': if (xs:restriction[xs:enumeration]) then 'values'
        else if (xs:restriction[xs:pattern]) then 'regex'
        else if (xs:restriction[xs:minInclusive or xs:maxInclusive or xs:minExclusive or xs:maxExclusive]) then 'range'
        else (),
      'value': if (xs:restriction[xs:enumeration]) then fn:fold-left(xs:restriction/xs:enumeration, array{}, function($a, $v) {
        array:append($a, map {
          'value': xs:string($v/@value),
          'documentation': $v/xs:annotation/xs:documentation/text()
        })
      }) else if (xs:restriction[xs:pattern]) then xs:string(xs:restriction/xs:pattern/@value)
      else if (xs:restriction[xs:minInclusive or xs:maxInclusive or xs:minExclusive or xs:maxExclusive]) then fn:fold-left(xs:restriction/*, map{}, function($m, $v) {
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

  <xsl:template mode="xs-ref" match="xs:attribute[@ref]">
    <xsl:variable name="schema" select="if (fn:tokenize(@ref , ':')[1] = 'xlink') then $xlink else $xml"/>
    <xsl:apply-templates mode="xs-schema" select="$schema//xs:attribute[@name=fn:tokenize(current()/@ref , ':')[2]]">
      <xsl:with-param name="schema" select="fn:tokenize(@ref , ':')[1]"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template mode="xs-schema" match="xs:attribute">
    <xsl:param name="schema"/>
    <xsl:choose>
      <xsl:when test="xs:simpleType">
        <xsl:apply-templates select="xs:simpleType">
          <xsl:with-param name="name" select="$schema || ':' || xs:string(@name)"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="map {
          'name': $schema || ':' || xs:string(@name),
          'documentation': (),
          'base': xs:string(@type),
          'type': (),
          'value': ()
        }"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template mode="xs-type" match="xs:attribute[@type]">
    <xsl:sequence select="map {
      'name': xs:string(@type),
      'documentation': 'See the [definition in the W3C XML Schema standard](https://www.w3.org/TR/xmlschema-2/#' || fn:tokenize(@type, ':')[2] || ').'
    }"/>
  </xsl:template>
</xsl:stylesheet>
