---
title: '<measure-repeat>'
elements: measure-repeat
---
```xml
<part id="P1">
   <measure number="2">
      <attributes>
         <measure-style>
            <measure-repeat type="start">1</measure-repeat>
         </measure-style>
      </attributes>
      <note>
         <pitch>
            <step>C</step>
            <octave>4</octave>
         </pitch>
         <duration>8</duration>
         <voice>1</voice>
         <type>whole</type>
      </note>
   </measure>
   <measure number="3">
      <note>
         <pitch>
            <step>C</step>
            <octave>4</octave>
         </pitch>
         <duration>8</duration>
         <voice>1</voice>
         <type>whole</type>
      </note>
   </measure>
   <measure number="4">
      <note>
         <pitch>
            <step>C</step>
            <octave>4</octave>
         </pitch>
         <duration>8</duration>
         <voice>1</voice>
         <type>whole</type>
      </note>
   </measure>
   <measure number="5">
      <attributes>
         <measure-style>
            <measure-repeat type="stop"/>
         </measure-style>
      </attributes>
      <note>
         <rest measure="yes"/>
         <duration>8</duration>
         <voice>1</voice>
      </note>
   </measure>
</part>
```
