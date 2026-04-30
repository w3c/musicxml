<?xml version="1.0" encoding="UTF-8"?>

<!--
  Generate a JSON listing of all elements in an XSD schema.
-->

<xsl:stylesheet
  version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:fn="http://www.w3.org/2005/xpath-functions"
  xmlns:musicxml="http://www.w3.org/2021/06/musicxml40"
  exclude-result-prefixes="#all"
>
  <xsl:output method="json" indent="yes" encoding="UTF-8"/>

  <!-- Build an XML hierarchy of elements based on the XSD schema. -->
  <xsl:mode on-no-match="deep-skip"/>
  <xsl:mode name="hierarchy" on-no-match="deep-skip"/>
  <xsl:mode name="attributes" on-no-match="deep-skip"/>
  <xsl:mode name="children" on-no-match="deep-skip"/>

  <xsl:param name="element" select="()"/>

  <xsl:template match="/">
    <xsl:variable name="hierarchy" as="element()*">
      <xsl:choose>
        <xsl:when test="$element">
          <xsl:apply-templates select="//xs:element[@name=$element]" mode="hierarchy">
            <xsl:with-param name="parents" select="()"/>
          </xsl:apply-templates>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="xs:schema/xs:element" mode="hierarchy">
            <xsl:with-param name="parents" select="()"/>
          </xsl:apply-templates>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:call-template name="output">
      <xsl:with-param name="hierarchy" select="$hierarchy"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="xs:element" mode="hierarchy">
    <xsl:param name="parents" as="xs:string*"/>
    <xsl:variable name="element-name" select="musicxml:elementName($parents, .)"/>
    <xsl:element name="{$element-name}">
      <xsl:attribute name="attribute" select="false()"/>
      <xsl:attribute name="parents" select="$parents"/>
      <xsl:attribute name="documentation">
        <xsl:value-of select="(
          xs:annotation/xs:documentation/text(),
          /xs:schema/xs:complexType//xs:element[@name=current()/@name]/xs:annotation/xs:documentation/text(),
          ''
        )[1]"/>
      </xsl:attribute>
      <xsl:variable name="children" as="map(*)*">
        <xsl:choose>
          <xsl:when test="@type and not(/xs:schema/xs:complexType[@name=current()/@type])">
            <xsl:sequence select="map {
              'type': 'type',
              'value': xs:string(@type)
            }"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="
              xs:element |
              xs:complexType |
              xs:sequence |
              xs:group[@ref] |
              xs:choice |
              /xs:schema/xs:complexType[@name=current()/@type]
            " mode="children">
              <xsl:with-param name="parents" select="($parents, $element-name)"/>
              <xsl:with-param name="cardinality" select="map{}"/>
            </xsl:apply-templates>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:attribute name="children">
        <xsl:value-of select="xs:string(fn:serialize($children, map { 'method': 'json' }))"/>
      </xsl:attribute>
      <xsl:apply-templates select="
        xs:attribute |
        xs:attributeGroup |
        xs:complexType |
        xs:sequence |
        xs:choice |
        /xs:schema/xs:complexType[@name=current()/@type]
      " mode="attributes"/>
      <xsl:if test="not($parents = $element-name)">
        <xsl:apply-templates select="
          xs:element |
          xs:complexType |
          xs:sequence |
          xs:group[@ref] |
          xs:choice |
          /xs:schema/xs:complexType[@name=current()/@type]
        " mode="#current"
        >
          <xsl:with-param name="parents" select="($parents, $element-name)"/>
        </xsl:apply-templates>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <xsl:template match="xs:element" mode="children" as="map(*)">
    <xsl:param name="parents"/>
    <xsl:param name="cardinality"/>
    <xsl:variable name="element-name" select="musicxml:elementName($parents, .)"/>
    <xsl:sequence select="map:merge((map {
        'type': 'element',
        'value': xs:string($element-name)
      }, musicxml:cardinality($cardinality, map {
        'min': xs:string((@minOccurs, '1')[1]),
        'max': xs:string((@maxOccurs, '1')[1])
      })
    ))"/>
  </xsl:template>

  <xsl:template match="xs:complexType | xs:group[@name]" mode="children" as="map(*)*">
    <xsl:param name="parents"/>
    <xsl:param name="cardinality"/>
    <xsl:apply-templates select="xs:element | xs:complexType | xs:sequence | xs:group[@ref] | xs:choice | xs:complexContent | xs:simpleContent" mode="#current">
      <xsl:with-param name="parents" select="$parents"/>
      <xsl:with-param name="cardinality" select="$cardinality"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="xs:sequence" mode="children" as="map(*)*">
    <xsl:param name="parents"/>
    <xsl:param name="cardinality"/>
    <xsl:variable name="sequence" as="map(*)*">
      <xsl:apply-templates select="xs:element | xs:complexType | xs:sequence | xs:group[@ref] | xs:choice" mode="#current">
        <xsl:with-param name="parents" select="$parents"/>
        <xsl:with-param name="cardinality" select="map{}"/>
      </xsl:apply-templates>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="count($sequence) = 1">
        <xsl:sequence select="map:merge((map {
            'type': $sequence[1]('type'),
            'value': $sequence[1]('value')
          }, musicxml:cardinality($cardinality, map {
            'min': $sequence[1]('min'),
            'max': $sequence[1]('max')
          })
        ))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="map:merge((map {
            'type': 'sequence',
            'value': array{$sequence}
          }, musicxml:cardinality($cardinality, map {
            'min': xs:string((@minOccurs, '1')[1]),
            'max': xs:string((@maxOccurs, '1')[1])
          })
        ))"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="xs:choice" mode="children" as="map(*)*">
    <xsl:param name="parents"/>
    <xsl:param name="cardinality"/>
    <xsl:variable name="choice" as="map(*)*">
      <xsl:apply-templates select="xs:element | xs:complexType | xs:sequence | xs:group[@ref] | xs:choice" mode="#current">
        <xsl:with-param name="parents" select="$parents"/>
        <xsl:with-param name="cardinality" select="map{}"/>
      </xsl:apply-templates>
    </xsl:variable>
    <xsl:sequence select="map:merge((map {
        'type': 'choice',
        'value': array{$choice}
      }, musicxml:cardinality($cardinality, map {
        'min': xs:string((@minOccurs, '1')[1]),
        'max': xs:string((@maxOccurs, '1')[1])
      })
    ))"/>
  </xsl:template>

  <xsl:template match="xs:group[@ref]" mode="children">
    <xsl:param name="parents"/>
    <xsl:param name="cardinality"/>
    <xsl:apply-templates select="/xs:schema/xs:group[@name=current()/@ref]" mode="#current">
      <xsl:with-param name="parents" select="$parents"/>
      <xsl:with-param name="cardinality" select="musicxml:cardinality($cardinality, map {
        'min': xs:string(@minOccurs),
        'max': xs:string(@maxOccurs)
      })"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="xs:simpleContent[xs:extension[@base]]" mode="children">
    <xsl:param name="parents"/>
    <xsl:param name="cardinality"/>
    <xsl:sequence select="map {
      'type': 'type',
      'value': xs:string(xs:extension/@base)
    }"/>
  </xsl:template>

  <xsl:template match="xs:complexContent[xs:extension[@base]]" mode="children">
    <xsl:param name="parents"/>
    <xsl:param name="cardinality"/>
    <xsl:apply-templates select="/xs:schema/xs:complexType[@name=current()/xs:extension/@base]" mode="#current">
      <xsl:with-param name="parents" select="$parents"/>
      <xsl:with-param name="cardinality" select="map{}"/>
    </xsl:apply-templates>
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

  <xsl:template match="xs:complexType | xs:sequence | xs:choice | xs:simpleContent | xs:complexContent" mode="attributes">
    <xsl:apply-templates select="xs:attribute | xs:attributeGroup | xs:simpleContent | xs:complexContent | xs:extension" mode="#current"/>
  </xsl:template>

  <xsl:template match="xs:extension" mode="attributes">
    <xsl:apply-templates select="/xs:schema/xs:simpleType[@name=current()/@base] | /xs:schema/xs:complexType[@name=current()/@base]" mode="#current"/>
    <xsl:apply-templates select="xs:attribute | xs:attributeGroup | xs:simpleContent | xs:complexContent | xs:extension" mode="#current"/>
  </xsl:template>

  <xsl:template match="xs:attribute" mode="attributes">
    <xsl:element name="{@name|@ref}">
      <xsl:attribute name="attribute" select="true()"/>
      <xsl:attribute name="type" select="(@type,@ref)[1]"/>
      <xsl:attribute name="default" select="@default"/>
      <xsl:attribute name="use" select="@use"/>
      <xsl:attribute name="documentation">
        <xsl:value-of select="(
          xs:annotation/xs:documentation/text(),
          ''
        )[1]"/>
      </xsl:attribute>
    </xsl:element>
  </xsl:template>

  <xsl:template match="xs:attributeGroup[not(@ref)]" mode="attributes">
    <xsl:apply-templates select="xs:attribute | xs:attributeGroup" mode="#current"/>
  </xsl:template>

  <xsl:template match="xs:attributeGroup[@ref]" mode="attributes">
    <xsl:apply-templates select="/xs:schema/xs:attributeGroup[@name=current()/@ref]" mode="#current"/>
  </xsl:template>

  <!-- Convert the element hierarchy to final output. -->
  <xsl:template name="output" as="map(*)">
    <xsl:param name="hierarchy"/>
    <xsl:variable name="entries" as="array(*)*">
      <xsl:apply-templates select="$hierarchy">
        <xsl:with-param name="parent" select="()"/>
      </xsl:apply-templates>
    </xsl:variable>
    <xsl:sequence select="fn:fold-left(array:flatten($entries), map{}, function($m, $v) {
      let $k := $v('name'),
          $vv := if (map:contains($m, $k)) then map:put($v, 'parents', array{ fn:distinct-values(array:flatten(($v('parents'), $m($k)('parents')))) }) else $v
      return map:put($m, $k, $vv)
    })"/>
  </xsl:template>

  <xsl:template match="node()[@attribute=false()]" as="array(*)">
    <xsl:param name="parent" as="element()*"/>
    <xsl:param name="this" select="current()"/>
    <xsl:variable name="children" as="array(*)*">
      <xsl:for-each-group select="*[@attribute=false()]" group-by="node-name()">
        <xsl:apply-templates select=".">
          <xsl:with-param name="parent" select="$this"/>
        </xsl:apply-templates>
      </xsl:for-each-group>
    </xsl:variable>
    <xsl:variable name="attributes" as="map(*)*">
      <xsl:for-each-group select="*[@attribute=true()]" group-by="node-name()">
        <xsl:apply-templates select="."/>
      </xsl:for-each-group>
    </xsl:variable>
    <xsl:sequence select="
      let $m1 := map {
        'name': node-name(),
        'documentation': xs:string(@documentation),
        'children': fn:parse-json(@children),
        'parents': if ($parent) then array { $parent/node-name() } else array {}
      },
      $a := array{$attributes},
      $m2 := if (array:size($a) > 0) then map:put($m1, 'attributes', $a) else $m1
      return array:join((array{$m2}, $children))
    "/>
  </xsl:template>

  <xsl:template match="node()[@attribute=true()]" as="map(*)*">
    <xsl:sequence select="
      let $m1 := map {
        'name': node-name(),
        'documentation': xs:string(@documentation),
        'type': xs:string(@type),
        'required': if (@use = 'required') then true() else false()
      },
      $m2 := if (not(@default='')) then map:put($m1, 'default', xs:string(@default)) else $m1
      return $m2
    "/>
  </xsl:template>

  <xsl:function name="musicxml:cardinality">
    <xsl:param name="parent" as="map(*)"/>
    <xsl:param name="current" as="map(*)"/>
    <xsl:sequence select="map {
      'min': ($parent('min'), $current('min'))[1],
      'max': ($parent('max'), $current('max'))[1]
    }"/>
  </xsl:function>

  <xsl:function name="musicxml:elementName">
    <xsl:param name="parents" as="xs:string*"/>
    <xsl:param name="current" as="element()"/>
    <!--
      SPECIAL CASE!! We need to differentiate between <measure> and <part>
      in their <score-partwise> and <score-timewise> version, so we "invent"
      new tag names for each. We will need to do the opposite work on the frontend,
      i.e. bring those invented tag names back to the real ones.
    -->
    <xsl:sequence select="
      if ($current/@name = 'part') then (
        if ($parents = 'score-partwise') then 'part-partwise' else 'part-timewise'
      ) else if ($current/@name = 'measure') then (
        if ($parents = 'score-timewise') then 'measure-timewise' else 'measure-partwise'
      ) else $current/@name
    "/>
  </xsl:function>
</xsl:stylesheet>
