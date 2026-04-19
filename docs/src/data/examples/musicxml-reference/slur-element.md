---
title: '<slur>'
elements: slur
image: slur-element.png
---
```xml
<measure number="13">
   <note default-x="80">
      <pitch>
         <step>F</step>
         <octave>4</octave>
      </pitch>
      <duration>2</duration>
      <voice>1</voice>
      <type>eighth</type>
      <stem default-y="5">up</stem>
      <beam number="1">begin</beam>
      <notations>
         <slur number="1" type="start" placement="below"/>
      </notations>
   </note>
   <note default-x="100">
      <pitch>
         <step>G</step>
         <octave>4</octave>
      </pitch>
      <duration>2</duration>
      <voice>1</voice>
      <type>eighth</type>
      <stem default-y="6.5">up</stem>
      <beam number="1">continue</beam>
   </note>
   <note default-x="120">
      <pitch>
         <step>A</step>
         <octave>4</octave>
      </pitch>
      <duration>2</duration>
      <voice>1</voice>
      <type>eighth</type>
      <stem default-y="8.5">up</stem>
      <beam number="1">continue</beam>
   </note>
   <note default-x="140">
      <pitch>
         <step>B</step>
         <octave>4</octave>
      </pitch>
      <duration>2</duration>
      <voice>1</voice>
      <type>eighth</type>
      <stem default-y="10">up</stem>
      <beam number="1">end</beam>
      <notations>
         <slur number="1" type="stop"/>
      </notations>
   </note>
</measure>
```
