<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
        schemaVersion="iso"
        defaultPhase="check-coda"
        queryBinding="xslt3"
        xml:lang="en"
        fpi="-//PYSCHEMATRON//DTD XML 1.0//EN">

    <!-- <title>Coda</title>
    <ns prefix="c" uri="">
    <p>This checks that if there is a coda, there is exactly one tocoda, and vice-versa.</p> -->
<!--
    <!-- Showing dynamic variables. -->
    <let name="max-weight" value="xs:integer(/c:cargo/c:vehicles[1]/c:apple[1]/@weight)"/> <!-- kg -->
    <let name="max-volume" value="xs:integer(200) * $max-weight"/> <!-- m3 -->


    <!-- Showcasing pattern with external extends -->
    <pattern id="pa_check-weights">
        <title>Weight check</title>
        <let name="test-variable-in-pattern" value="42"/>
        <let name="second-test-variable-in-pattern"><html xmlns="http://www.w3.org/1999/xhtml">info</html></let>
        <rule context="c:*[@type='vehicle']">
            <extends href="check_weights.sch"/>
        </rule>
        <rule context="c:*[@type='fruit']">
            <extends href="check_weights.sch"/>
        </rule>
        <rule context="c:*">
            <!-- Blank rule to check if we only match nodes once. -->
        </rule>
    </pattern>


    <!-- Showcasing pattern with abstract rules -->
    <pattern id="pa_check-volumes">
        <title>Volume check</title>
        <rule context="c:*[@type='vehicle']">
            <extends rule="ru_abstract-volume-check"/>
        </rule>
        <rule context="c:*[@type='fruit']">
            <extends rule="ru_abstract-volume-check"/>
        </rule>
    </pattern>

    <!-- Showing the use of subject in a rule, and check -->
    <pattern id="pa_check-banana">
        <p>Just a check on the banana's.</p>
        <rule subject="/c:cargo[1]" context="c:banana">
            <report test="@type = 'fruit'">Banana is a fruit.</report>
            <report subject="." test="@weight = 1">And the weight of the banana shall be 1.</report>
        </rule>
    </pattern>

    <pattern>
        <rule abstract="true" id="ru_abstract-volume-check">
            <assert test="xs:integer(@volume) le $max-volume" properties="pr_maxVolume pr_volume">
                Volume not correct (<value-of select="@volume"/> vs <value-of select="$max-volume"/> at <name/>).
                Testing name with path: <name path="//c:cargo"/>
            </assert>
            <report test="xs:integer(@volume) gt $max-volume">
                We report an item with a volume greater than allowed.
            </report>
        </rule>
    </pattern>

    <!-- Showcasing that we support checks on processing instructions. -->
    <pattern id="pa_processing-instructions-test">
        <rule id="ru_processing-instructions-test" context="processing-instruction('xml-model')">
            <assert test="contains(.,'foobar')">
                XML model processing instruction does not include foobar.
            </assert>
        </rule>
    </pattern>

    <!-- Showcasing that we support checks on comments. -->
    <pattern id="pa_comments-test">
        <rule id="ru_comments-test" context="comment()">
            <assert test="starts-with(., ' Comment: ')">
                This comment does not start with "Comment: ".
            </assert>
        </rule>
    </pattern>

    <!-- Showcasing that we support checks on attributes. -->
    <pattern id="pa_attribute-test">
        <rule id="ru_attribute-test" context="@id">
            <assert test="starts-with(., 'id_')">
                The id attribute does not starts with "id_".
            </assert>
        </rule>
    </pattern>

    <!-- Show that we can check the root and check the namespace -->
    <pattern id="pa_root-test">
        <rule id="ru_root-test" context="c:cargo">
            <assert test="@id">
                The root node does not have an ID.
            </assert>
            <assert test="namespace-uri-for-prefix('test', .) = 'http://www.test.com'">
                The namespace for "test" should be "http://www.test.com".
            </assert>
        </rule>
    </pattern>

    <!-- Showcasing abstract patterns -->
    <pattern is-a="pa_check-category" id="pa_check-category-vehicles">
        <p>Check for all the vehicles if they are in the right category.</p>
        <param name="pv_items" value="c:*[@type='vehicle']"/>
        <param name="pv_category" value="c:vehicles"/>
    </pattern>

    <pattern is-a="pa_check-category" id="pa_check-category-fruits">
        <p>Check for all the fruits if they are in the right category.</p>
        <param name="pv_items" value="c:*[@type='fruit']"/>
        <param name="pv_category" value="c:fruits"/>
    </pattern>

    <pattern abstract="true" id="pa_check-category">
        <p>Check if items are in the right category ($pv_category).</p>
        <rule context="$pv_items">
            <assert test="parent::$pv_category">
                   The item <name/> is in the wrong category ($pv_category).
                   Extra data <value-of select="count(parent::$pv_category)"/>
            </assert>
            <extends href="abstract_extends.sch"/>
        </rule>
    </pattern>

    <!-- Showcasing phases -->
    <phase id="check-weights">
        <p>Only check the cargo items for weight.</p>
        <active pattern="pa_check-weights">Check for weights</active>
        <let name="demonstration-of-let-in-phase" value="xs:integer(0)"/>
    </phase>

    <phase id="check-volumes">
        <p>Only check the cargo items for volume.</p>
        <active pattern="pa_check-volumes"/>
    </phase>

    <phase id="check-categories">
        <p>Only check the cargo for the right category.</p>
        <active pattern="pa_check-category-vehicles"/>
        <active pattern="pa_check-category-fruits"/>
    </phase>


    <!-- Showcasing properties -->
    <properties>
        <property id="pr_maxWeight" scheme="kg"><value-of select="$max-weight"/></property>
        <property id="pr_maxVolume" scheme="m3"><value-of select="$max-volume"/></property>
        <property id="pr_weight" scheme="kg"><value-of select="@weight"/></property>
        <property id="pr_volume" scheme="m3"><value-of select="@volume"/></property>
    </properties>


    <!-- Showcasing include -->
    <include href="diagnostics.sch"/> -->
    -->
</schema>