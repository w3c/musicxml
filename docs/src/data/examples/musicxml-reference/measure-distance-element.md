---
title: '<measure-distance>'
elements: measure-distance
image: measure-distance-element.png
---
```xml
<measure number="9" width="219">
   <print>
      <measure-layout>
         <measure-distance>118</measure-distance>
      </measure-layout>
   </print>
   <attributes>
      <key print-object="yes">
         <fifths>1</fifths>
         <mode>major</mode>
      </key>
      <clef print-object="yes">
         <sign>G</sign>
         <line>2</line>
      </clef>
   </attributes>
   <direction placement="above">
      <direction-type>
         <coda default-x="-44" default-y="28"/>
      </direction-type>
      <sound coda="11" divisions="2"/>
   </direction>
   <direction placement="above">
      <direction-type>
         <words default-y="34" font-size="12" font-style="italic" relative-x="-48">Coda</words>
      </direction-type>
   </direction>
   <note default-x="36">
      <pitch>
         <step>D</step>
         <octave>4</octave>
      </pitch>
      <duration>1</duration>
      <voice>1</voice>
      <type>eighth</type>
      <stem default-y="20">up</stem>
      <beam number="1">begin</beam>
   </note>
   <note default-x="63">
      <pitch>
         <step>C</step>
         <octave>5</octave>
      </pitch>
      <duration>1</duration>
      <voice>1</voice>
      <type>eighth</type>
      <stem default-y="20">up</stem>
      <beam number="1">continue</beam>
   </note>
   <note default-x="88">
      <pitch>
         <step>A</step>
         <octave>4</octave>
      </pitch>
      <duration>1</duration>
      <voice>1</voice>
      <type>eighth</type>
      <stem default-y="20">up</stem>
      <beam number="1">continue</beam>
   </note>
   <note default-x="115">
      <pitch>
         <step>F</step>
         <alter>1</alter>
         <octave>4</octave>
      </pitch>
      <duration>1</duration>
      <voice>1</voice>
      <type>eighth</type>
      <stem default-y="20">up</stem>
      <beam number="1">end</beam>
   </note>
   <note default-x="141">
      <pitch>
         <step>G</step>
         <octave>4</octave>
      </pitch>
      <duration>4</duration>
      <voice>1</voice>
      <type>half</type>
      <stem default-y="5">up</stem>
   </note>
   <barline location="right">
      <bar-style>light-heavy</bar-style>
   </barline>
</measure>
```
