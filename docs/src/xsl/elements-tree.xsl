<?xml version="1.0" encoding="UTF-8"?>

<!--
  Generate a hierarchical JSON listing of all elements in an XSD schema.
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

  <!-- Build an XML hierarchy of elements based on the XSD schema. -->
  <xsl:mode on-no-match="deep-skip"/>
  <xsl:mode name="hierarchy" on-no-match="deep-skip"/>
  <xsl:mode name="attributes" on-no-match="deep-skip"/>

  <xsl:template match="/">
    <xsl:variable name="hierarchy" as="element()*">
      <xsl:apply-templates select="xs:schema/xs:element" mode="hierarchy">
        <xsl:with-param name="parents" select="()"/>
      </xsl:apply-templates>
    </xsl:variable>
    <xsl:call-template name="output">
      <xsl:with-param name="hierarchy" select="$hierarchy"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="xs:element" mode="hierarchy">
    <xsl:param name="parents"/>
    <!--
      SPECIAL CASE!! We need to differentiate between <measure> and <part>
      in their <score-partwise> and <score-timewise> version, so we "invent"
      new tag names for each. We will need to do the opposite work on the frontend,
      i.e. bring those invented tag names back to the real ones.
    -->
    <xsl:variable name="element-name" select="
      if (@name = 'part') then (
        if ($parents = 'score-partwise') then 'part-partwise' else 'part-timewise'
      ) else if (@name = 'measure') then (
        if ($parents = 'score-timewise') then 'measure-timewise' else 'measure-partwise'
      ) else @name
    "/>
    <xsl:element name="{$element-name}">
      <xsl:if test="not($parents = $element-name)">
        <xsl:apply-templates select="
          xs:element |
          xs:complexType |
          xs:sequence |
          xs:group[@ref] |
          xs:choice |
          /xs:schema/xs:complexType[@name=current()/@type]
        " mode="#current">
          <xsl:with-param name="parents" select="($parents, $element-name)"/>
        </xsl:apply-templates>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <xsl:template match="xs:complexType | xs:sequence | xs:choice | xs:group[@name]" mode="hierarchy">
    <xsl:param name="parents"/>
    <xsl:apply-templates select="xs:element | xs:complexType | xs:sequence | xs:group[@ref] | xs:choice" mode="#current">
      <xsl:with-param name="parents" select="$parents"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="xs:group[@ref]" mode="hierarchy">
    <xsl:param name="parents"/>
    <xsl:apply-templates select="/xs:schema/xs:group[@name=current()/@ref]" mode="#current">
      <xsl:with-param name="parents" select="$parents"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- Convert the element hierarchy to final output. -->
  <xsl:template name="output">
    <xsl:param name="hierarchy"/>
    <xsl:variable name="root" as="item()*">
      <xsl:apply-templates select="$hierarchy"/>
    </xsl:variable>
    <xsl:sequence select="fn:fold-left($root, map{}, function($m, $v) { map:merge(($m, $v)) })"/>
  </xsl:template>

  <xsl:template match="node()">
    <xsl:variable name="children" as="map(*)*">
      <xsl:for-each-group select="*" group-by="node-name()">
        <xsl:apply-templates select="."/>
      </xsl:for-each-group>
    </xsl:variable>
    <xsl:sequence select="map {
      xs:string(node-name()): fn:fold-left($children, map{}, function($m, $v) { map:merge(($m, $v)) })
    }"/>
  </xsl:template>
</xsl:stylesheet>
