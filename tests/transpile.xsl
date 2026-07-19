<!--
Copyright (C) by David Maus <dmaus@dmaus.name>

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-->
<transform version="3.0" expand-text="yes" exclude-result-prefixes="schxslt sch xs" xpath-default-namespace="http://www.w3.org/1999/XSL/Transform"
               xmlns:alias="http://www.w3.org/1999/XSL/TransformAlias"
               xmlns:schxslt="http://dmaus.name/ns/2023/schxslt"
               xmlns:sch="http://purl.oclc.org/dsdl/schematron"
               xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns="http://www.w3.org/1999/XSL/Transform">

  <namespace-alias result-prefix="#default" stylesheet-prefix="alias"/>

  <param name="schxslt:debug" static="yes" select="false()">
    <!--
        Enable or disable debugging. When debugging is enable, the validation stylesheet is indented. Defaults to false.
    -->
  </param>

  <output indent="yes" use-when="$schxslt:debug"/>

  <variable name="schxslt:version" as="xs:string"
                select="if (starts-with('1.11.1', '$')) then 'development' else '1.11.1'"/>

  <param name="schxslt:phase" as="xs:string" select="'#DEFAULT'">
    <!--
        Name of the validation phase. The value '#DEFAULT' selects the pattern in the sch:schema/@defaultPhase attribute
        or '#ALL' if this attribute is not present. The value '#ALL' selects all patterns. Defaults to '#DEFAULT'.
    -->
  </param>

  <param name="schxslt:expand-text" as="xs:boolean" select="false()">
    <!--
        When set to boolean true, the validation stylesheet globally enables text value templates and you may use them
        in assertion or diagnostic messages. Defaults to false.
    -->
  </param>

  <param name="schxslt:streamable" as="xs:boolean" select="false()" static="yes">
    <!--
        Set to boolean true to create a streamable validation stylesheet. This *does not* check the streamability of
        XPath expressions in rules, assertions, variables etc. It merely declares the modes in the validation stylesheet
        to be streamable and removes the @location attribute from the SVRL output when no location function is given
        because the default fn:path() is not streamable. Defaults to false.
    -->
  </param>

  <param name="schxslt:location-function" as="xs:string?" select="()" static="yes">
    <!--
        Name of a function f($context as node()) as xs:string that provides location information for the SVRL
        report. Defaults to fn:path() when not set.
    -->
  </param>

  <param name="schxslt:fail-early" as="xs:boolean" select="false()" static="yes">
    <!--
        When set to boolean true, the validation stylesheet stops as soon as it encounters the first failed assertion
        or successful report. Defaults to false.
    -->
  </param>

  <param name="schxslt:terminate-validation-on-error" as="xs:boolean" select="true()" static="yes">
    <!--
        When set to boolean true, the validation stylesheet terminates the XSLT processor when it encounters a dynamic
        error. Defaults to true.
    -->
  </param>

  <param name="schxslt:report-active-pattern" as="xs:boolean" select="true()" static="yes">
    <!--
        When set to boolean true, the validation stylesheet reports active patterns and groups. Defaults to true.
    -->
  </param>

  <param name="schxslt:report-fired-rule" as="xs:boolean" select="true()" static="yes">
    <!--
        When set to boolean true, the validation stylesheet reports fired rules. Defaults to true.
    -->
  </param>

  <param name="schxslt:report-suppressed-rule" as="xs:boolean" select="true()" static="yes">
    <!--
        When set to boolean true, the validation stylesheet reports suppressed rules. Defaults to true.
    -->
  </param>

  <param name="schxslt:report-skipped-assertion" as="xs:boolean" select="true()" static="yes">
    <!--
        When set to boolean true, the validation stylesheet reports assertions that are skipped. Defaults to true.
    -->
  </param>

  <param name="schxslt:compact-report" as="xs:boolean" select="false()" static="yes">
    <!--
        When set to boolean true, the validation stylesheet only reports failed assertions, successful reports and
        errors. Defaults to false.
    -->
  </param>

  <param name="schxslt:severity-threshold" as="xs:string" select="'info'">
    <!--
        Assertions with a severity lesser than the threshold are not checked. One of 'info', 'warning', 'error', or
        'fatal'. Defaults to 'info'.
    -->
  </param>

  <param name="schxslt:default-severity" as="xs:string" select="'fatal'">
    <!--
        Severity of assertions without an @severity attribute. One of 'info', 'warning', 'error', or 'fatal'. Defaults
        to 'fatal'.
    -->
  </param>

  <param name="schxslt:default-from" as="xs:string" select="'root()'">
    <!--
        Default value of the expression that selects the subset of the document to be validate. Can be overwritten on a
        per-phase basis by the @from attribute.  The default from expression also applies to the phase '#ALL'. Defaults
        to 'root()'.
    -->
  </param>

  <param name="schxslt:check-assembled-schema" as="xs:boolean" select="false()" static="yes">
    <!--
        When set to boolean `true`, the transpiler performs some plausability checks after all external definitions are
        included. It terminates with an error if it finds errors in the assembled schema. Defaults to `false`.
    -->
  </param>

  <param name="schxslt:handle-dynamic-errors" as="xs:boolean" select="true()">
    <!--
        When set to boolean `true`, the validation stylesheet writes dynamic errors as a `svrl:error` element to the validation
        report and terminates with a `schxslt:ValidationError` error. When set to `false`, dynamic errors bubble up to the XSLT
        processor. Defaults to `true`.
    -->
  </param>

  <variable name="schxslt:avt-attributes" as="xs:QName*">
    <sequence select="QName('', 'role')"/>
    <sequence select="QName('', 'flag')"/>
    <sequence select="QName('', 'severity')"/>
  </variable>

  <variable name="schxslt:var-attributes" as="xs:QName*">
    <sequence select="QName('', 'role')"/>
    <sequence select="QName('', 'flag')"/>
    <sequence select="QName('', 'severity')"/>
  </variable>

  <variable name="schxslt:document-uri-expression" as="xs:string" select="'(document-uri(.), base-uri(root()))[1]'"/>

  <mode name="schxslt:expand-abstract-rules" on-no-match="shallow-copy"/>
  <mode name="schxslt:assemble-schema" on-no-match="shallow-copy"/>
  <mode name="schxslt:instantiate-abstract-patterns" on-no-match="shallow-copy"/>
  <mode name="schxslt:compose-schema" on-no-match="shallow-copy"/>
  <mode name="schxslt:transpile" on-no-match="shallow-skip"/>
  <mode name="schxslt:create-phase-selector" on-no-match="shallow-skip"/>

  <mode on-no-match="shallow-skip"/>
  <mode name="schxslt:copy-verbatim" on-no-match="shallow-copy"/>
  <mode name="schxslt:copy-message-content" on-no-match="shallow-copy"/>

  <template match="sch:schema" as="element(Q{http://www.w3.org/1999/XSL/Transform}stylesheet)">

    <variable name="schema" as="element(sch:schema)">
      <apply-templates mode="schxslt:compose-schema" select="."/>
    </variable>

    <apply-templates select="$schema" mode="schxslt:transpile"/>

  </template>

  <template match="sch:schema" as="element(sch:schema)" mode="schxslt:compose-schema">
    <variable name="phase" as="xs:string" select="if ($schxslt:phase = ('#DEFAULT', '')) then (@defaultPhase, '#ALL')[1] else $schxslt:phase"/>
    <if test="$phase eq '#ANY'">
      <variable name="message" as="xs:string+">
        This version of SchXslt2 does not support dynamic phase selection.
      </variable>
      <message terminate="yes">
        <text/>
        <value-of select="normalize-space(string-join($message))"/>
      </message>
    </if>

    <variable name="assembled-schema" as="element(sch:schema)">
      <call-template name="schxslt:assemble-schema">
        <with-param name="schema" as="element(sch:schema)" select="."/>
      </call-template>
    </variable>

    <variable name="assembled-schema-errors" as="element(svrl:error)*" use-when="$schxslt:check-assembled-schema">
      <apply-templates select="$assembled-schema" mode="schxslt:check-assembled-schema"/>
    </variable>

    <if test="not(empty($assembled-schema-errors))" use-when="$schxslt:check-assembled-schema">
      <message terminate="yes" select="$assembled-schema-errors"/>
    </if>

    <call-template name="schxslt:reduce-schema">
      <with-param name="schema" as="element(sch:schema)">
        <call-template name="schxslt:expand-abstract-rules">
          <with-param name="schema" as="element(sch:schema)">
            <call-template name="schxslt:instantiate-abstract-patterns">
              <with-param name="schema" as="element(sch:schema)">
                <call-template name="schxslt:denormalize-schema">
                  <with-param name="schema" as="element(sch:schema)" select="$assembled-schema"/>
                </call-template>
              </with-param>
            </call-template>
          </with-param>
        </call-template>
      </with-param>
      <with-param name="phase" as="xs:string" select="$phase"/>
    </call-template>
  </template>

  <template name="schxslt:assemble-schema" as="element(sch:schema)" visibility="private">
    <param name="schema" as="element(sch:schema)" required="yes"/>
    <apply-templates select="$schema" mode="schxslt:assemble-schema"/>
  </template>

  <template name="schxslt:expand-abstract-rules" as="element(sch:schema)" visibility="private">
    <param name="schema" as="element(sch:schema)" required="yes"/>
    <apply-templates select="$schema" mode="schxslt:expand-abstract-rules"/>
  </template>

  <template name="schxslt:instantiate-abstract-patterns" as="element(sch:schema)" visibility="private">
    <param name="schema" as="element(sch:schema)" required="yes"/>
    <apply-templates select="$schema" mode="schxslt:instantiate-abstract-patterns"/>
  </template>

  <template name="schxslt:denormalize-schema" as="element(sch:schema)" visibility="private">
    <param name="schema" as="element(sch:schema)" required="yes"/>
    <apply-templates select="$schema" mode="schxslt:denormalize-schema"/>
  </template>

  <!-- BEGIN Mode schxslt:create-phase-selector -->

  <template match="sch:schema" as="element(Q{http://www.w3.org/1999/XSL/Transform}stylesheet)" mode="schxslt:create-phase-selector">
    <alias:stylesheet version="3.0">
      <for-each select="sch:ns">
        <namespace name="{@prefix}" select="@uri"/>
      </for-each>
      <apply-templates select="sch:let | sch:param" mode="schxslt:transpile"/>
      <alias:template match="root()" as="Q{{http://www.w3.org/2001/XMLSchema}}string">
        <choose>
          <when test="exists(sch:phase[@when])">
            <alias:choose>
              <for-each select="sch:phase/@when">
                <alias:when test="{.}">{../@id}</alias:when>
              </for-each>
              <alias:otherwise>#ALL</alias:otherwise>
            </alias:choose>
          </when>
          <otherwise>#ALL</otherwise>
        </choose>
      </alias:template>
    </alias:stylesheet>
  </template>

  <!-- END Mode schxslt:create-phase-selector -->

  <!-- BEGIN Mode schxslt:assemble-schema -->

  <template match="sch:include" as="element()" mode="schxslt:assemble-schema">
    <variable name="external" as="element()" select="schxslt:load-external(@href)"/>
    <apply-templates select="$external" mode="#current">
      <with-param name="sourceLanguage" as="xs:string" select="schxslt:in-scope-language(.)"/>
      <with-param name="targetNamespaces" as="element(sch:ns)*" select="$external/ancestor::sch:schema/sch:ns"/>
    </apply-templates>
  </template>

  <template match="sch:library/sch:extends[@href]" as="node()*" mode="schxslt:assemble-schema">
    <variable name="external" as="element()" select="schxslt:load-external(@href)"/>
    <if test="(namespace-uri($external) ne 'http://purl.oclc.org/dsdl/schematron') or (local-name($external) ne 'library')">
      <variable name="message" as="xs:string+">
        The @href attribute of a top-level &lt;extends&gt; element of a library must be an IRI reference to an external
        well-formed XML document or to an element in an external well-formed XML document that is a Schematron
        &lt;library&gt; element. This @href points to a Q{{{namespace-uri($external)}}}{local-name($external)} element.
      </variable>
      <message terminate="yes">
        <text/>
        <value-of select="normalize-space(string-join($message))"/>
      </message>
    </if>
    <apply-templates select="$external/node()" mode="#current">
      <with-param name="sourceLanguage" select="schxslt:in-scope-language(.)"/>
      <with-param name="targetNamespaces" as="element(sch:ns)*" select="$external/../../sch:ns"/>
    </apply-templates>
  </template>

  <template match="sch:schema/sch:extends[@href]" as="node()*" mode="schxslt:assemble-schema">
    <variable name="external" as="element()" select="schxslt:load-external(@href)"/>
    <if test="(namespace-uri($external) ne 'http://purl.oclc.org/dsdl/schematron') or (not(local-name($external) = ('library', 'schema')))">
      <variable name="message" as="xs:string+">
        The @href attribute of a top-level &lt;extends&gt; element of a schema must be an IRI reference to an external
        well-formed XML document or to an element in an external well-formed XML document that is a Schematron
        &lt;library&gt; or a &lt;schema&gt; element. This @href points to a
        Q{{{namespace-uri($external)}}}{local-name($external)} element.
      </variable>
      <message terminate="yes">
        <text/>
        <value-of select="normalize-space(string-join($message))"/>
      </message>
    </if>
    <apply-templates select="$external/node()" mode="#current">
      <with-param name="sourceLanguage" select="schxslt:in-scope-language(.)"/>
      <with-param name="targetNamespaces" as="element(sch:ns)*" select="$external/../../sch:ns"/>
    </apply-templates>
  </template>

  <template match="sch:rule/sch:extends[@href]" as="node()*" mode="schxslt:assemble-schema">
    <variable name="external" as="element()" select="schxslt:load-external(@href)"/>
    <if test="(namespace-uri($external) ne 'http://purl.oclc.org/dsdl/schematron') or (local-name($external) ne 'rule')">
      <variable name="message" as="xs:string+">
        The @href attribute of an &lt;extends&gt; element of a rule must be an IRI reference to an external well-formed
        XML document or to an element in an external well-formed XML document that is a Schematron &lt;rule&gt;
        element. This @href points to a Q{{{namespace-uri($external)}}}{local-name($external)} element.
      </variable>
      <message terminate="yes">
        <text/>
        <value-of select="normalize-space(string-join($message))"/>
      </message>
    </if>
    <apply-templates select="$external/node()" mode="#current">
      <with-param name="sourceLanguage" select="schxslt:in-scope-language(.)"/>
      <with-param name="targetNamespaces" as="element(sch:ns)*" select="$external/../../sch:ns"/>
    </apply-templates>
  </template>

  <!-- END Mode schxslt:assemble-schema -->

  <!-- BEGIN Mode schxslt:denormalize-schema -->

  <mode name="schxslt:denormalize-schema" on-no-match="shallow-copy"/>

  <template match="sch:diagnostics | sch:properties" as="empty-sequence()" mode="schxslt:denormalize-schema"/>

  <template match="sch:rule" as="element(sch:rule)" mode="schxslt:denormalize-schema">
    <variable name="diagnostics" as="xs:string*" select="(sch:assert | sch:report)/@diagnostics ! tokenize(.)"/>
    <variable name="properties" as="xs:string*" select="(sch:assert | sch:report)/@properties ! tokenize(.)"/>
    <copy>
      <sequence select="@*"/>
      <sequence select="node()"/>
      <where-populated>
        <sch:diagnostics>
          <apply-templates select="../../sch:diagnostics/sch:diagnostic[@id = $diagnostics]" mode="#current"/>
        </sch:diagnostics>
      </where-populated>
      <where-populated>
        <sch:properties>
          <apply-templates select="../../sch:properties/sch:property[@id = $properties]" mode="#current"/>
        </sch:properties>
      </where-populated>
    </copy>
  </template>

  <!-- END Mode schxslt:denormalize-schema -->

  <!-- BEGIN Mode schxslt:instantiate-abstract-patterns -->

  <template match="(sch:pattern | sch:group)[@abstract = 'true']" as="empty-sequence()" mode="schxslt:instantiate-abstract-patterns"/>
  <template match="(sch:pattern | sch:group)/sch:param" as="empty-sequence()" mode="schxslt:instantiate-abstract-patterns"/>

  <template match="(sch:pattern | sch:group)[@is-a]" as="element()" mode="schxslt:instantiate-abstract-patterns">
    <variable name="is-a" as="element()?" select="../(sch:pattern | sch:group)[local-name() = local-name(current())][@abstract = 'true'][@id = current()/@is-a]"/>
    <if test="empty($is-a)">
      <variable name="message" as="xs:string+">
        The current schema does not define an abstract {local-name()} with an id of '{@is-a}'.
      </variable>
      <message terminate="yes">
        <text/>
        <value-of select="normalize-space(string-join($message))"/>
      </message>
    </if>

    <!-- Check if all declared parameters are supplied -->
    <variable name="params-supplied" as="element(sch:param)*" select="sch:param"/>
    <variable name="params-declared" as="element(sch:param)*" select="$is-a/sch:param"/>
    <if test="exists($params-declared[empty(@value)][not(@name = $params-supplied/@name)])">
      <variable name="message" as="xs:string+">
        Some abstract pattern parameters of '{@is-a}' are declared but not supplied: {$params-declared[not(@name = $params-supplied/@name)]/@name}.
      </variable>
      <message terminate="yes">
        <text/>
        <value-of select="normalize-space(string-join($message))"/>
      </message>
    </if>

    <variable name="instance" as="node()*">
      <apply-templates select="$is-a/node()" mode="#current">
        <with-param name="sourceLanguage" as="xs:string" select="schxslt:in-scope-language(.)"/>
        <with-param name="params" as="element(sch:param)*" select="($params-supplied, $params-declared[not(@name = $params-supplied/@name)][@value])" tunnel="yes"/>
      </apply-templates>
    </variable>

    <copy>
      <apply-templates select="@* except (@is-a)" mode="#current">
        <with-param name="params" as="element(sch:param)*" select="sch:param" tunnel="yes"/>
      </apply-templates>
      <if test="empty(@documents)">
        <apply-templates select="$is-a/@documents" mode="#current">
          <with-param name="params" as="element(sch:param)*" select="sch:param" tunnel="yes"/>
        </apply-templates>
      </if>
      <if test="empty(@xml:lang) and (schxslt:in-scope-language(.) ne schxslt:in-scope-language($is-a))">
        <attribute name="xml:lang" select="schxslt:in-scope-language($is-a)"/>
      </if>
      <sequence select="$instance"/>
      <apply-templates select="node()" mode="#current"/>
    </copy>

  </template>

  <template match="sch:assert/@test | sch:report/@test | sch:rule/@context | sch:value-of/@select | (sch:pattern | sch:group)/@documents | sch:name/@path | sch:let/@value | Q{http://www.w3.org/1999/XSL/Transform}copy-of[ancestor::sch:property]/@select" mode="schxslt:instantiate-abstract-patterns">
    <param name="params" as="element(sch:param)*" tunnel="yes"/>
    <attribute name="{name()}" select="schxslt:replace-params(., $params)"/>
  </template>

  <function name="schxslt:replace-params" as="xs:string?">
    <param name="src" as="xs:string"/>
    <param name="params" as="element(sch:param)*"/>
    <choose>
      <when test="empty($params)">
        <value-of select="$src"/>
      </when>
      <otherwise>
        <variable name="paramsSorted" as="element(sch:param)*">
          <for-each select="$params">
            <sort select="string-length(@name)" order="descending"/>
            <sequence select="."/>
          </for-each>
        </variable>

        <variable name="value" select="replace(replace($paramsSorted[1]/@value, '\\', '\\\\'), '\$', '\\\$')"/>
        <variable name="src" select="replace($src, concat('(\W*)\$', $paramsSorted[1]/@name, '(\W*)'), concat('$1', $value, '$2'))"/>
        <value-of select="schxslt:replace-params($src, $paramsSorted[position() > 1])"/>
      </otherwise>
    </choose>
  </function>

  <!-- END Mode schxslt:instantiate-abstract-patterns -->

  <template match="*" mode="schxslt:assemble-schema schxslt:denormalize-schema schxslt:instantiate-abstract-patterns schxslt:expand-abstract-rules">
    <param name="sourceLanguage" as="xs:string" select="schxslt:in-scope-language(.)"/>
    <param name="targetNamespaces" as="element(sch:ns)*"/>
    <variable name="inScopeLanguage" as="xs:string" select="schxslt:in-scope-language(.)"/>

    <copy>
      <for-each select="$targetNamespaces">
        <namespace name="{@prefix}" select="@uri"/>
      </for-each>
      <apply-templates select="@*" mode="#current"/>
      <if test="not(@xml:lang) and not($inScopeLanguage eq $sourceLanguage)">
        <attribute name="xml:lang" select="$inScopeLanguage"/>
      </if>
      <apply-templates select="node()" mode="#current"/>
    </copy>
  </template>

  <!-- BEGIN Mode schxslt:expand-abstract-rules -->

  <template match="sch:rule[@abstract = 'true']" as="empty-sequence()" mode="schxslt:expand-abstract-rules"/>

  <template match="sch:rule/sch:extends[@rule]" as="node()*" mode="schxslt:expand-abstract-rules">
    <variable name="abstract-rule" as="element(sch:rule)*"
                  select="(../../sch:rule, ../../../(sch:pattern | sch:group | sch:rules)/sch:rule)[@abstract = 'true'][@id = current()/@rule]"/>
    <if test="empty($abstract-rule)">
      <variable name="message" as="xs:string+">
        The current schema defines no abstract rule named '{@rule}'.
      </variable>
      <message terminate="yes">
        <text/>
        <value-of select="normalize-space(string-join($message))"/>
      </message>
    </if>
    <apply-templates select="$abstract-rule/node()" mode="#current">
      <with-param name="sourceLanguage" as="xs:string" select="schxslt:in-scope-language(.)"/>
    </apply-templates>
  </template>

  <!-- END Mode schxslt:expand-abstract-rules -->

  <!-- Reduce schema such that only patterns and groups of the
       selected phase are present. -->
  <template name="schxslt:reduce-schema" as="element(sch:schema)" visibility="private">
    <param name="schema" as="element(sch:schema)" required="yes"/>
    <param name="phase" as="xs:string" required="yes"/>
    <variable name="excluded-patterns" as="element(sch:pattern)*"
              select="if ($phase eq '#ALL') then () else $schema/sch:pattern[not(@id = $schema/sch:phase[@id = $phase]/sch:active/@pattern)]"/>
    <variable name="excluded-groups" as="element(sch:group)*"
              select="if ($phase eq '#ALL') then () else $schema/sch:group[not(@id = $schema/sch:phase[@id = $phase]/sch:active/@pattern)]"/>
    <variable name="excluded-phases" as="element(sch:phase)*"
              select="if ($phase eq '#ALL') then () else $schema/sch:phase[@id != $phase]"/>
    <element name="schema" namespace="http://purl.oclc.org/dsdl/schematron">
      <sequence select="$schema/@* except $schema/@defaultPhase"/>
      <if test="$phase ne '#ALL'">
        <attribute name="defaultPhase" select="$phase"/>
      </if>
      <sequence select="$schema/node() except ($excluded-patterns, $excluded-groups, $excluded-phases)"/>
    </element>
  </template>

  <!-- BEGIN Mode schxslt:transpile -->

  <template match="sch:library" as="empty-sequence()" mode="schxslt:transpile">
    <message terminate="yes">This version of SchXslt2 does not transpile ISO Schematron libraries</message>
  </template>

  <template match="sch:schema" as="element(Q{http://www.w3.org/1999/XSL/Transform}stylesheet)" mode="schxslt:transpile">
    <param name="phase" as="xs:string" select="(@defaultPhase, '#ALL')[1]"/>

    <variable name="root" as="xs:string" select="(sch:phase[@id = $phase]/@from, $schxslt:default-from)[1]"/>
    <variable name="patterns" as="map(xs:string, element()+)">
      <map>
        <for-each-group select="if ($phase = '#ALL') then (sch:pattern | sch:group) else (sch:pattern | sch:group)[@id = current()/sch:phase[@id = $phase]/sch:active/@pattern]" group-by="string(@documents)">
          <map-entry key="concat('group.', generate-id(current-group()[1]))" select="current-group()"/>
        </for-each-group>
      </map>
    </variable>
    <variable name="patterns-subordinate" as="xs:string*">
      <for-each select="Q{http://www.w3.org/2005/xpath-functions/map}keys($patterns)">
        <if test="Q{http://www.w3.org/2005/xpath-functions/map}get($patterns, .)/@documents">
          <value-of select="."/>
        </if>
      </for-each>
    </variable>

    <alias:stylesheet version="3.0" expand-text="{$schxslt:expand-text}">
      <for-each select="sch:ns">
        <namespace name="{@prefix}" select="@uri"/>
      </for-each>

      <alias:variable name="Q{{http://dmaus.name/ns/2023/schxslt}}phase" as="Q{{http://www.w3.org/2001/XMLSchema}}string" select="'{$phase}'"/>

      <if test="$schxslt:debug">
        <alias:output indent="true"/>
      </if>

      <apply-templates select="(sch:param, sch:let)" mode="#current"/>
      <apply-templates select="sch:phase[@id = $phase]/sch:let" mode="#current"/>

      <sequence select="Q{http://www.w3.org/1999/XSL/Transform}accumulator | Q{http://www.w3.org/1999/XSL/Transform}function | Q{http://www.w3.org/1999/XSL/Transform}include | Q{http://www.w3.org/1999/XSL/Transform}import | Q{http://www.w3.org/1999/XSL/Transform}import-schema | Q{http://www.w3.org/1999/XSL/Transform}key | Q{http://www.w3.org/1999/XSL/Transform}use-package"/>

      <variable name="accumulators" as="xs:string" select="string-join(Q{http://www.w3.org/1999/XSL/Transform}accumulator/@name, ' ')"/>

      <alias:mode use-accumulators="{$accumulators}"/>
      <alias:mode name="Q{{http://dmaus.name/ns/2023/schxslt}}validate" use-accumulators="{$accumulators}" on-no-match="shallow-skip"/>

      <for-each select="Q{http://www.w3.org/2005/xpath-functions/map}keys($patterns)">
        <alias:mode name="{.}" on-no-match="shallow-skip" streamable="{$schxslt:streamable}" use-accumulators="{$accumulators}"/>
        <alias:template match="* | root()" mode="{.}" priority="-10">
          <alias:apply-templates select="@*" mode="#current"/>
          <alias:apply-templates select="node()" mode="#current"/>
        </alias:template>
        <apply-templates select="Q{http://www.w3.org/2005/xpath-functions/map}get($patterns, .)/sch:let" mode="#current"/>
        <apply-templates select="Q{http://www.w3.org/2005/xpath-functions/map}get($patterns, .)/sch:rule" mode="#current">
          <with-param name="group" as="xs:string" select="."/>
        </apply-templates>
      </for-each>

      <alias:template match="root()" as="element(svrl:schematron-output)">
        <svrl:schematron-output>
          <call-template name="schxslt:copy-attributes">
            <with-param name="attributes" as="attribute()*" select="(@schemaVersion, @schematronEdition)"/>
          </call-template>
          <attribute name="phase" select="$phase"/>
          <where-populated>
            <attribute name="title" select="sch:title"/>
          </where-populated>
          <for-each select="sch:ns" use-when="not($schxslt:compact-report)">
            <svrl:ns-prefix-in-attribute-values prefix="{@prefix}" uri="{@uri}"/>
          </for-each>
          <for-each select="sch:p" use-when="not($schxslt:compact-report)">
            <svrl:text>
              <sequence select="(@xml:*, @icon)"/>
              <sequence select="node()"/>
            </svrl:text>
          </for-each>
          <comment>SchXslt2 {$schxslt:version}</comment>

          <variable name="main-template-content" as="node()*">
            <for-each select="$patterns-subordinate">
              <variable name="groupId" as="xs:string" select="."/>
              <variable name="patterns" as="element()+" select="Q{http://www.w3.org/2005/xpath-functions/map}get($patterns, .)"/>
              <for-each select="$patterns">
                <call-template name="schxslt:active-pattern"/>
                <alias:for-each select="{$patterns[1]/@documents}">
                  <alias:source-document href="{{.}}">
                    <alias:apply-templates select="." mode="{$groupId}"/>
                  </alias:source-document>
                </alias:for-each>
              </for-each>
            </for-each>

            <alias:apply-templates select="." mode="Q{{http://dmaus.name/ns/2023/schxslt}}validate"/>

            <if test="$schxslt:fail-early">
              <alias:catch errors="Q{{http://dmaus.name/ns/2023/schxslt}}CatchFailEarly">
                <alias:sequence select="$Q{{http://www.w3.org/2005/xqt-errors}}value"/>
              </alias:catch>
            </if>

            <if test="$schxslt:handle-dynamic-errors">
              <alias:catch>
                <svrl:error code="{{$Q{{http://www.w3.org/2005/xqt-errors}}code}}">
                  <alias:if test="{$schxslt:document-uri-expression}">
                    <alias:attribute name="document" select="{$schxslt:document-uri-expression}"/>
                  </alias:if>
                  <alias:if test="$Q{{http://www.w3.org/2005/xqt-errors}}line-number">
                    <alias:attribute name="line-number" select="$Q{{http://www.w3.org/2005/xqt-errors}}line-number"/>
                  </alias:if>
                  <alias:if test="$Q{{http://www.w3.org/2005/xqt-errors}}column-number">
                    <alias:attribute name="column-number" select="$Q{{http://www.w3.org/2005/xqt-errors}}column-number"/>
                  </alias:if>
                  <alias:if test="$Q{{http://www.w3.org/2005/xqt-errors}}description">
                    <alias:value-of select="$Q{{http://www.w3.org/2005/xqt-errors}}description"/>
                  </alias:if>
                </svrl:error>
                <if test="$schxslt:terminate-validation-on-error">
                  <alias:variable name="message" as="Q{{http://www.w3.org/2001/XMLSchema}}string+" expand-text="yes">
                    Running the ISO Schematron validation failed with a dynamic error.
                    Error code: {{$Q{{http://www.w3.org/2005/xqt-errors}}code}} Reason: {{$Q{{http://www.w3.org/2005/xqt-errors}}description}}
                  </alias:variable>
                  <alias:message terminate="yes" error-code="Q{{{{http://dmaus.name/ns/2023/schxslt}}}}ValidationError">
                    <alias:text/>
                    <alias:value-of select="normalize-space(string-join($message))"/>
                  </alias:message>
                </if>
              </alias:catch>
            </if>
          </variable>

          <choose>
            <when test="$main-template-content[self::catch]">
              <alias:try>
                <sequence select="$main-template-content"/>
              </alias:try>
            </when>
            <otherwise>
              <sequence select="$main-template-content"/>
            </otherwise>
          </choose>

        </svrl:schematron-output>
      </alias:template>

      <alias:template match="root()" as="element()*" mode="Q{{http://dmaus.name/ns/2023/schxslt}}validate">
          <for-each select="Q{http://www.w3.org/2005/xpath-functions/map}keys($patterns)[not(. = $patterns-subordinate)]">
            <variable name="groupId" as="xs:string" select="."/>
            <for-each select="Q{http://www.w3.org/2005/xpath-functions/map}get($patterns, $groupId)">
              <call-template name="schxslt:active-pattern"/>
            </for-each>

            <alias:apply-templates select="{$root}" mode="{$groupId}"/>

          </for-each>
      </alias:template>

      <alias:function name="Q{{http://dmaus.name/ns/2023/schxslt}}numeric-severity" as="Q{{http://www.w3.org/2001/XMLSchema}}integer">
        <alias:param name="severity" as="Q{{http://www.w3.org/2001/XMLSchema}}string"/>
        <alias:sequence select="(index-of(('info', 'warning', 'error', 'fatal'), $severity), 4)[1]"/>
      </alias:function>

    </alias:stylesheet>

  </template>

  <template match="sch:rule[parent::sch:group]" as="element(Q{http://www.w3.org/1999/XSL/Transform}template)" mode="schxslt:transpile">
    <param name="group" as="xs:string" required="yes"/>

    <alias:template match="{@context}" mode="{$group}" priority="{last() - position()}">
      <alias:param name="Q{{http://dmaus.name/ns/2023/schxslt}}pattern" as="Q{{http://www.w3.org/2001/XMLSchema}}string*" select="()"/>
      <alias:variable name="Q{{http://dmaus.name/ns/2023/schxslt}}rule-context" as="node()" select="."/>
      <call-template name="schxslt:fired-rule"/>
      <alias:next-match>
        <alias:with-param name="Q{{http://dmaus.name/ns/2023/schxslt}}pattern" as="Q{{http://www.w3.org/2001/XMLSchema}}string*" select="$Q{{http://dmaus.name/ns/2023/schxslt}}pattern"/>
      </alias:next-match>
    </alias:template>
  </template>

  <template match="sch:rule[parent::sch:pattern]" as="element(Q{http://www.w3.org/1999/XSL/Transform}template)" mode="schxslt:transpile">
    <param name="group" as="xs:string" required="yes"/>

    <alias:template match="{@context}" mode="{$group}" priority="{last() - position()}">
      <alias:param name="Q{{http://dmaus.name/ns/2023/schxslt}}pattern" as="Q{{http://www.w3.org/2001/XMLSchema}}string*" select="()"/>
      <alias:variable name="Q{{http://dmaus.name/ns/2023/schxslt}}rule-context" as="node()" select="."/>
      <alias:choose>
        <alias:when test="'{generate-id(..)}' = $Q{{http://dmaus.name/ns/2023/schxslt}}pattern">
          <element name="svrl:suppressed-rule" use-when="$schxslt:report-suppressed-rule and not($schxslt:compact-report)">
            <call-template name="schxslt:copy-attributes">
              <with-param name="attributes" as="attribute()*" select="(@id, @role, @flag, @visit-each, @context)"/>
            </call-template>
            <alias:if test="{$schxslt:document-uri-expression}">
              <alias:attribute name="document" select="{$schxslt:document-uri-expression}"/>
            </alias:if>
          </element>
          <alias:next-match/>
        </alias:when>
        <alias:otherwise>
          <call-template name="schxslt:fired-rule"/>
          <alias:next-match>
            <alias:with-param name="Q{{http://dmaus.name/ns/2023/schxslt}}pattern" as="Q{{http://www.w3.org/2001/XMLSchema}}string*" select="('{generate-id(..)}', $Q{{http://dmaus.name/ns/2023/schxslt}}pattern)"/>
          </alias:next-match>
        </alias:otherwise>
      </alias:choose>
    </alias:template>

  </template>

  <template match="sch:schema/sch:let | sch:schema/sch:param" as="element(Q{http://www.w3.org/1999/XSL/Transform}param)" mode="schxslt:transpile">
    <alias:param name="{@name}">
      <call-template name="schxslt:copy-attributes">
        <with-param name="attributes" as="attribute()*" select="(@as)"/>
      </call-template>
      <!-- Nota bene: The 4th edition of ISO Schematron requires the @value attribute to be present on a
           sch:schema/sch:param element. We do NOT check this requirement here. It is up to a conformant validator to
           ensure schema validity. dmaus, 2025-10-25 -->
      <choose>
        <when test="@value">
          <attribute name="select" select="@value"/>
        </when>
        <otherwise>
          <if test="not(@as)">
            <attribute name="as">node()*</attribute>
          </if>
          <apply-templates select="node()" mode="schxslt:copy-verbatim"/>
        </otherwise>
      </choose>
    </alias:param>
  </template>

  <template match="sch:let" as="element(Q{http://www.w3.org/1999/XSL/Transform}variable)" mode="schxslt:transpile">
    <alias:variable name="{@name}">
      <call-template name="schxslt:copy-attributes">
        <with-param name="attributes" as="attribute()*" select="(@as)"/>
      </call-template>
      <choose>
        <when test="@value">
          <attribute name="select" select="@value"/>
        </when>
        <otherwise>
          <if test="not(@as)">
            <attribute name="as">node()*</attribute>
          </if>
          <apply-templates select="node()" mode="schxslt:copy-verbatim"/>
        </otherwise>
      </choose>
    </alias:variable>
  </template>

  <template match="sch:assert" as="element(Q{http://www.w3.org/1999/XSL/Transform}choose)" mode="schxslt:transpile">
    <alias:choose>
      <alias:when test="Q{{http://www.w3.org/2005/xpath-functions/map}}get($Q{{http://dmaus.name/ns/2023/schxslt}}severity, '{generate-id()}') ge Q{{http://dmaus.name/ns/2023/schxslt}}numeric-severity('{$schxslt:severity-threshold}')">
        <alias:if test="not({@test})">
          <alias:variable name="failed-assert" as="element(svrl:failed-assert)">
            <svrl:failed-assert>
              <call-template name="schxslt:failed-assertion-content">
                <!-- Pass the current assertion as a tunnel parameter so that it can be used in attached diagnostics and
                     properties. -->
                <with-param name="assertion" as="element(sch:assert)" select="." tunnel="yes"/>
              </call-template>
            </svrl:failed-assert>
          </alias:variable>
          <if test="$schxslt:fail-early">
            <alias:sequence select="error(QName('http://dmaus.name/ns/2023/schxslt', 'CatchFailEarly'), '', $failed-assert)"/>
          </if>
          <alias:sequence select="$failed-assert"/>
        </alias:if>
      </alias:when>
      <alias:otherwise>
        <element name="svrl:skipped-assert" use-when="$schxslt:report-skipped-assertion and not($schxslt:compact-report)">
          <attribute name="severityThreshold" select="$schxslt:severity-threshold"/>
          <call-template name="schxslt:failed-assertion-attributes">
            <with-param name="assertion" as="element(sch:assert)" select="." tunnel="yes"/>
          </call-template>
        </element>
      </alias:otherwise>
    </alias:choose>
  </template>

  <template match="sch:report" as="element(Q{http://www.w3.org/1999/XSL/Transform}choose)" mode="schxslt:transpile">
    <alias:choose>
      <alias:when test="Q{{http://www.w3.org/2005/xpath-functions/map}}get($Q{{http://dmaus.name/ns/2023/schxslt}}severity, '{generate-id()}') ge Q{{http://dmaus.name/ns/2023/schxslt}}numeric-severity('{$schxslt:severity-threshold}')">
        <alias:if test="{@test}">
          <alias:variable name="successful-report" as="element(svrl:successful-report)">
            <svrl:successful-report>
              <call-template name="schxslt:failed-assertion-content">
                <!-- Pass the current assertion as a tunnel parameter so that it can be used in attached diagnostics and
                     properties. -->
                <with-param name="assertion" as="element(sch:report)" select="." tunnel="yes"/>
              </call-template>
            </svrl:successful-report>
          </alias:variable>
          <if test="$schxslt:fail-early">
            <alias:sequence select="error(QName('http://dmaus.name/ns/2023/schxslt', 'CatchFailEarly'), '', $successful-report)"/>
          </if>
          <alias:sequence select="$successful-report"/>
        </alias:if>
      </alias:when>
      <alias:otherwise>
        <element name="svrl:skipped-report" use-when="$schxslt:report-skipped-assertion and not($schxslt:compact-report)">
          <attribute name="severityThreshold" select="$schxslt:severity-threshold"/>
          <call-template name="schxslt:failed-assertion-attributes">
            <with-param name="assertion" as="element(sch:report)" select="." tunnel="yes"/>
          </call-template>
        </element>
      </alias:otherwise>
    </alias:choose>
  </template>

  <!-- END Mode schxslt:transpile -->

  <!-- BEGIN Mode schxslt:copy-message-content -->

  <template match="sch:dir" as="element(svrl:dir)" mode="schxslt:copy-message-content">
    <svrl:dir>
      <if test="@value">
        <attribute name="dir" select="@value"/>
      </if>
      <sequence select="@xml:*"/>
      <apply-templates select="node()" mode="#current"/>
    </svrl:dir>
  </template>

  <template match="sch:emph" as="element(svrl:emph)" mode="schxslt:copy-message-content">
    <svrl:emph>
      <sequence select="@xml:*"/>
      <apply-templates select="node()" mode="#current"/>
    </svrl:emph>
  </template>

  <template match="sch:span" as="element(svrl:span)" mode="schxslt:copy-message-content">
    <svrl:span>
      <sequence select="@class, @xml:*"/>
      <apply-templates select="node()" mode="#current"/>
    </svrl:span>
  </template>

  <template match="*" as="element()" mode="schxslt:copy-verbatim schxslt:copy-message-content">
    <alias:element name="{local-name()}" namespace="{namespace-uri()}">
      <apply-templates select="@*" mode="#current"/>
      <apply-templates select="node()" mode="#current"/>
    </alias:element>
  </template>

  <template match="@*" as="element()" mode="schxslt:copy-verbatim schxslt:copy-message-content">
    <alias:attribute name="{local-name()}" namespace="{namespace-uri()}">{.}</alias:attribute>
  </template>

  <template match="Q{http://www.w3.org/1999/XSL/Transform}copy-of[ancestor::sch:property]" as="element(Q{http://www.w3.org/1999/XSL/Transform}copy-of)" mode="schxslt:copy-message-content">
    <copy>
      <sequence select="@*"/>
      <sequence select="node()"/>
    </copy>
  </template>

  <template match="sch:name[@path]" as="element(Q{http://www.w3.org/1999/XSL/Transform}for-each)" mode="schxslt:copy-message-content">
    <param name="assertion" as="element()" tunnel="yes"/>
    <alias:for-each select="{($assertion/@subject, $assertion/../@subject, '.')[1]}[1]">
      <alias:value-of select="{@path}"/>
    </alias:for-each>
  </template>

  <template match="sch:name[not(@path)]" as="element(Q{http://www.w3.org/1999/XSL/Transform}value-of)" mode="schxslt:copy-message-content">
    <param name="assertion" as="element()" tunnel="yes"/>
    <alias:value-of select="name({($assertion/@subject, $assertion/../@subject, '.')[1]})"/>
  </template>

  <template match="sch:value-of" as="element(Q{http://www.w3.org/1999/XSL/Transform}for-each)" mode="schxslt:copy-message-content">
    <param name="assertion" as="element()" tunnel="yes"/>
    <alias:for-each select="{($assertion/@subject, $assertion/../@subject, '.')[1]}[1]">
      <alias:value-of select="{@select}"/>
    </alias:for-each>
  </template>

  <!-- END Mode schxslt:copy-message-content -->

  <template name="schxslt:active-pattern" as="element()?" visibility="private">
    <element name="svrl:active-{local-name()}" use-when="$schxslt:report-active-pattern and not($schxslt:compact-report)">
      <call-template name="schxslt:copy-attributes">
        <with-param name="attributes" as="attribute()*" select="(@id, @documents, @role)"/>
      </call-template>
      <if test="sch:title">
        <alias:attribute name="name">{sch:title}</alias:attribute>
      </if>
    </element>
  </template>

  <template name="schxslt:fired-rule" as="element()+"  visibility="private">
    <element name="svrl:fired-rule" use-when="$schxslt:report-fired-rule and not($schxslt:compact-report)">
      <call-template name="schxslt:copy-attributes">
        <with-param name="attributes" as="attribute()*" select="(@id, @role, @flag, @visit-each, @context)"/>
      </call-template>
      <alias:if test="{$schxslt:document-uri-expression}">
        <alias:attribute name="document" select="{$schxslt:document-uri-expression}"/>
      </alias:if>
    </element>
    <!-- This variable maps an assertion to a numeric representation of its severity. It is later used to decide if an
         assertion test should run. -->
    <alias:variable name="Q{{http://dmaus.name/ns/2023/schxslt}}severity" as="map(Q{{http://www.w3.org/2001/XMLSchema}}string, Q{{http://www.w3.org/2001/XMLSchema}}integer)">
      <alias:map>
        <for-each select="sch:assert | sch:report">
          <alias:map-entry key="'{generate-id()}'">
            <alias:variable name="severity" as="Q{{http://www.w3.org/2001/XMLSchema}}string">
              <attribute name="select">
                <choose>
                  <when test="not(@severity)">'{$schxslt:default-severity}'</when>
                  <when test="matches(@severity, '^\$') and (substring-after(@severity, '$') castable as xs:Name)">{@severity}</when>
                  <when test="starts-with(@severity, '{') and ends-with(@severity, '}')">{substring(@severity, 2, string-length(@severity) - 2)}</when>
                  <otherwise>'{@severity}'</otherwise>
                </choose>
              </attribute>
            </alias:variable>
            <alias:sequence select="Q{{http://dmaus.name/ns/2023/schxslt}}numeric-severity($severity)"/>
          </alias:map-entry>
        </for-each>
      </alias:map>
    </alias:variable>
    <alias:for-each select="{(@visit-each, '.')[1]}">
      <apply-templates select="sch:let" mode="#current"/>
      <apply-templates select="sch:assert | sch:report" mode="#current"/>
    </alias:for-each>
  </template>

  <template name="schxslt:report-message" as="element(svrl:text)" visibility="private">
    <svrl:text>
      <sequence select="@xml:*"/>
      <call-template name="schxslt:copy-attributes">
        <with-param name="attributes" as="attribute()*" select="(@see, @icon, @fpi)"/>
      </call-template>
      <apply-templates select="node()" mode="schxslt:copy-message-content"/>
    </svrl:text>
  </template>

  <template name="schxslt:report-diagnostics" as="element(svrl:diagnostic-reference)*" visibility="private">
    <variable name="diagnostics" as="xs:string*" select="tokenize(normalize-space(@diagnostics))"/>
    <for-each select="../sch:diagnostics/sch:diagnostic[@id = $diagnostics]">
      <svrl:diagnostic-reference diagnostic="{schxslt:protect-curlies(@id)}">
        <svrl:text>
          <if test="schxslt:in-scope-language(.) ne schxslt:in-scope-language(ancestor::sch:schema)">
            <attribute name="xml:lang" select="schxslt:in-scope-language(.)"/>
          </if>
          <sequence select="@xml:space"/>
          <call-template name="schxslt:copy-attributes">
            <with-param name="attributes" as="attribute()*" select="(@see, @icon, @fpi)"/>
          </call-template>
          <apply-templates select="node()" mode="schxslt:copy-message-content"/>
        </svrl:text>
      </svrl:diagnostic-reference>
    </for-each>
  </template>

  <template name="schxslt:report-properties" as="element(svrl:property-reference)*" visibility="private">
    <variable name="properties" as="xs:string*" select="tokenize(normalize-space(@properties))"/>
    <for-each select="../sch:properties/sch:property[@id = $properties]">
      <svrl:property-reference property="{schxslt:protect-curlies(@id)}">
        <call-template name="schxslt:copy-attributes">
          <with-param name="attributes" as="attribute()*" select="(@role, @scheme)"/>
        </call-template>
        <svrl:text>
          <if test="schxslt:in-scope-language(.) ne schxslt:in-scope-language(ancestor::sch:schema)">
            <attribute name="xml:lang" select="schxslt:in-scope-language(.)"/>
          </if>
          <sequence select="@xml:space"/>
          <call-template name="schxslt:copy-attributes">
            <with-param name="attributes" as="attribute()*" select="(@see, @icon, @fpi)"/>
          </call-template>
          <apply-templates select="node()" mode="schxslt:copy-message-content"/>
        </svrl:text>
      </svrl:property-reference>
    </for-each>
  </template>

  <template name="schxslt:failed-assertion-content" as="node()+" visibility="private">
    <call-template name="schxslt:failed-assertion-attributes"/>
    <call-template name="schxslt:report-diagnostics"/>
    <call-template name="schxslt:report-properties"/>
    <call-template name="schxslt:report-message"/>
  </template>

  <template name="schxslt:failed-assertion-attributes" as="node()*" visibility="private">
    <param name="assertion" as="element()" tunnel="yes"/>
    <call-template name="schxslt:copy-attributes">
      <with-param name="attributes" as="attribute()*" select="(@flag, @id, @role, @severity, @test)"/>
    </call-template>
    <where-populated>
      <attribute name="ruleId" select="../@id"/>
    </where-populated>
    <where-populated>
      <attribute name="{local-name(../..)}Id" select="../../@id"/>
    </where-populated>
    <if test="schxslt:in-scope-language(.) ne schxslt:in-scope-language(ancestor::sch:schema)">
      <attribute name="xml:lang" select="schxslt:in-scope-language(.)"/>
    </if>
    <if test="not($schxslt:streamable) or exists($schxslt:location-function)">
      <alias:where-populated>
        <!-- The variable schxslt:rule-context will be available at this part of the validation stylesheet. -->
        <alias:attribute name="location" select="{($schxslt:location-function, 'path')[1]}({($assertion/@subject, $assertion/../@subject, '$Q{http://dmaus.name/ns/2023/schxslt}rule-context')[1]})"/>
      </alias:where-populated>
    </if>
  </template>

  <template name="schxslt:copy-attributes" as="attribute()*" visibility="private">
    <param name="attributes" as="attribute()*" required="yes"/>
    <for-each select="$attributes">
      <attribute name="{name()}" select="schxslt:copy-attribute-value(.)"/>
    </for-each>
  </template>

  <function name="schxslt:copy-attribute-value" as="xs:string" visibility="private">
    <param name="attribute" as="attribute()"/>
    <choose>
      <when test="(node-name($attribute) = $schxslt:var-attributes) and starts-with(normalize-space($attribute), '$') and (substring(normalize-space($attribute), 2) castable as xs:Name)">
        <value-of select="concat('{', normalize-space($attribute), '}')"/>
      </when>
      <when test="node-name($attribute) = $schxslt:avt-attributes">
        <value-of select="$attribute"/>
      </when>
      <otherwise>
        <value-of select="schxslt:protect-curlies($attribute)"/>
      </otherwise>
    </choose>
  </function>

  <function name="schxslt:in-scope-language" as="xs:string?" visibility="private">
    <param name="context" as="node()"/>
    <value-of select="lower-case($context/ancestor-or-self::*[@xml:lang][1]/@xml:lang)"/>
  </function>

  <function name="schxslt:protect-curlies" as="xs:string" visibility="private">
    <param name="value" as="xs:string"/>
    <value-of select="$value => replace('\{', '{{') => replace('\}', '}}')"/>
  </function>

  <function name="schxslt:load-external" as="element()" visibility="private">
    <param name="href" as="attribute(href)"/>

    <variable name="uriParts" as="xs:string+" select="tokenize(string($href), '#')"/>
    <variable name="document" as="document-node()" select="document($uriParts[1], $href)"/>

    <choose>
      <when test="count($uriParts) gt 1">
        <variable name="elements" as="element()*" select="(id($uriParts[2], $document), $document//sch:*[@id = $uriParts[2]])"/>
        <if test="count($elements) eq 0">
          <variable name="message" as="xs:string+">
            The URI {string($href)} does not point to an element.
          </variable>
          <message terminate="yes">
            <text/>
            <value-of select="normalize-space(string-join($message))"/>
          </message>
        </if>
        <if test="count($elements) gt 1">
          <variable name="message" as="xs:string+">
            The URI {string($href)} points to more than one element.
          </variable>
          <message terminate="yes">
            <text/>
            <value-of select="normalize-space(string-join($message))"/>
          </message>
        </if>
        <sequence select="$elements"/>
      </when>
      <otherwise>
        <sequence select="$document/*[1]"/>
      </otherwise>
    </choose>
  </function>

  <!-- BEGIN Mode schxslt:check-assembled-schema -->
  <mode name="schxslt:check-assembled-schema" on-no-match="shallow-skip" use-accumulators="unique-ids"/>

  <accumulator name="unique-ids" as="map(xs:string, xs:boolean)" initial-value="map{}">
    <accumulator-rule match="sch:*[@id]" select="Q{http://www.w3.org/2005/xpath-functions/map}put($value, string(@id), Q{http://www.w3.org/2005/xpath-functions/map}contains($value, string(@id)))"/>
  </accumulator>

  <template match="sch:schema" mode="schxslt:check-assembled-schema" as="element(svrl:error)*">
    <apply-templates mode="#current"/>
    <variable name="unique-ids" as="map(xs:string, xs:boolean)" select="accumulator-after('unique-ids')"/>
    <for-each select="Q{http://www.w3.org/2005/xpath-functions/map}keys($unique-ids)">
      <if test="Q{http://www.w3.org/2005/xpath-functions/map}get($unique-ids, .)">
        <svrl:error code="Q{{http://dmaus.name/ns/2023/schxslt}}DuplicateId">The id {.} is not unique in the assembled schema.</svrl:error>
      </if>
    </for-each>
  </template>

  <template match="sch:phase/sch:active" mode="schxslt:check-assembled-schema" as="element(svrl:error)*">
    <variable name="pattern" as="element()*" select="../../(sch:pattern | sch:group)[@id = current()/@pattern]"/>
    <choose>
      <when test="empty($pattern)">
        <svrl:error code="Q{{http://dmaus.name/ns/2023/schxslt}}PatternNotFound">The phase {../@id} references the pattern {@pattern}, but this pattern is not defined.</svrl:error>
      </when>
      <when test="count($pattern) gt 1"/>
      <when test="$pattern/@abstract = 'true'">
        <svrl:error code="Q{{http://dmaus.name/ns/2023/schxslt}}InvalidPatternReference">The phase {../@id} references a pattern {@pattern}, but this pattern is declared to be abstract.</svrl:error>
      </when>
    </choose>
  </template>

  <template match="sch:pattern[@is-a] | sch:group[@is-a]" mode="schxslt:check-assembled-schema" as="element(svrl:error)*">
    <variable name="template" as="element()*" select="../(sch:pattern | sch:group)[@id = current()/@is-a]"/>
    <choose>
      <when test="empty($template)">
        <svrl:error code="Q{{http://dmaus.name/ns/2023/schxslt}}PatternNotFound">The pattern {@id} references the abstract pattern {@is-a}, but this pattern is not defined.</svrl:error>
      </when>
      <when test="count($template) gt 1"/>
      <when test="not($template/@abstract = 'true')">
        <svrl:error code="Q{{http://dmaus.name/ns/2023/schxslt}}InvalidPatternReference">The pattern {@id} references the abstract pattern {@is-a}, but the pattern is not defined as an abstract pattern.</svrl:error>
      </when>
      <when test="local-name(.) ne local-name($template)">
        <svrl:error code="Q{{http://dmaus.name/ns/2023/schxslt}}InvalidPatternReference">The pattern {@id} references the abstract pattern {@is-a}, but the pattern is not of the same type .</svrl:error>
      </when>
      <otherwise>
        <variable name="instance" as="element()" select="."/>
        <for-each select="$template/sch:param[not(@value)]">
          <if test="empty($instance/sch:param[@name = current()/@name])">
            <svrl:error code="Q{{http://dmaus.name/ns/2023/schxslt}}MissingPatternParameter">The abstract pattern {$template/@id} requires the parameter {@name} to be set.</svrl:error>
          </if>
        </for-each>
        <for-each select="$instance/sch:param">
          <if test="empty($template/sch:param[@name = current()/@name])">
            <svrl:error code="Q{{http://dmaus.name/ns/2023/schxslt}}UndeclaredPatternParameter">The pattern {@id} declares a parameter {@name}, but the abstract pattern {$template/@id} does not define a parameter with this name.</svrl:error>
          </if>
        </for-each>
      </otherwise>
    </choose>

  </template>

  <template match="sch:rule/sch:extends" mode="schxslt:check-assembled-schema" as="element(svrl:error)*">
    <if test="empty(../../../(sch:pattern | sch:group | sch:rules)/sch:rule[@id = current()/@rule])">
      <svrl:error code="Q{{http://dmaus.name/ns/2023/schxslt}}RuleNotFound">The rule {../@id} extends a rule {@rule}, but this rule is not defined.</svrl:error>
    </if>
  </template>

  <template match="sch:assert | sch:report" mode="schxslt:check-assembled-schema" as="element(svrl:error)*">
    <variable name="schema" as="element(sch:schema)" select="../../.."/>
    <variable name="id" as="xs:string" select="string(@id)"/>

    <for-each select="tokenize(@diagnostics)">
      <variable name="diagnostic" as="element(sch:diagnostic)*" select="$schema/sch:diagnostics/sch:diagnostic[@id = current()]"/>
      <choose>
        <when test="empty($diagnostic)">
          <svrl:error code="Q{{http://dmaus.name/ns/2023/schxslt}}DiagnosticNotFound">The assertion {$id} references a diagnostic {.}, but the diagnostic is not defined.</svrl:error>
        </when>
        <when test="count($diagnostic) gt 1"/>
      </choose>
    </for-each>

    <for-each select="tokenize(@properties)">
      <variable name="property" as="element(sch:property)*" select="$schema/sch:properties/sch:property[@id = current()]"/>
      <choose>
        <when test="empty($property)">
          <svrl:error code="Q{{http://dmaus.name/ns/2023/schxslt}}PropertyNotFound">The assertion {$id} references a property {.}, but the property is not defined.</svrl:error>
        </when>
        <when test="count($property) gt 1"/>
      </choose>
    </for-each>
  </template>

  <!-- END Mode schxslt:check-assembled-schema -->

</transform>
