---
title: '<tap>'
elements: tap
image: tap-element.png
---
```xml
<measure number="10" width="162">
   <note default-x="13">
      <pitch>
         <step>F</step>
         <alter>1</alter>
         <octave>5</octave>
      </pitch>
      <duration>1</duration>
      <voice>1</voice>
      <type>eighth</type>
      <stem>none</stem>
      <notations>
         <slur number="1" type="start" placement="above" bezier-x="13" bezier-y="12" default-x="10" default-y="10"/>
         <technical>
            <tap hand="right" placement="above" default-x="7" default-y="22"/>
            <string>1</string>
            <fret>14</fret>
         </technical>
      </notations>
   </note>
   <note default-x="43">
      <pitch>
         <step>B</step>
         <octave>4</octave>
      </pitch>
      <duration>1</duration>
      <voice>1</voice>
      <type>eighth</type>
      <stem>none</stem>
      <notations>
         <technical>
            <string>1</string>
            <fret>7</fret>
         </technical>
      </notations>
   </note>
   <note default-x="60">
      <pitch>
         <step>D</step>
         <octave>5</octave>
      </pitch>
      <duration>1</duration>
      <voice>1</voice>
      <type>eighth</type>
      <stem>none</stem>
      <notations>
         <slur number="1" type="stop" bezier-x="-13" bezier-y="12" default-x="10" default-y="10"/>
         <technical>
            <tap hand="left" placement="above" default-x="3" default-y="21"/>
            <string>1</string>
            <fret>10</fret>
         </technical>
      </notations>
   </note>
   <note print-object="no">
      <rest/>
      <duration>1</duration>
      <voice>1</voice>
      <type>eighth</type>
   </note>
   <note print-object="no">
      <rest/>
      <duration>2</duration>
      <voice>1</voice>
      <type>quarter</type>
   </note>
   <note print-object="no">
      <rest/>
      <duration>1</duration>
      <voice>1</voice>
      <type>eighth</type>
   </note>
   <note print-object="no">
      <rest/>
      <duration>1</duration>
      <voice>1</voice>
      <type>eighth</type>
   </note>
</measure>
```
