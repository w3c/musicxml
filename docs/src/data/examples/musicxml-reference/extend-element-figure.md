---
title: '<extend> (Figured Bass)'
elements: extend
image: extend-element-figure.png
---
```xml
<measure number="74">
   <figured-bass default-y="-80">
      <figure>
         <prefix>flat</prefix>
         <figure-number>7</figure-number>
         <extend type="start"/>
      </figure>
   </figured-bass>
   <note default-x="109">
      <pitch>
         <step>B</step>
         <octave>2</octave>
      </pitch>
      <duration>4</duration>
      <voice>1</voice>
      <type>half</type>
      <stem default-y="10.5">up</stem>
   </note>
   <figured-bass>
      <figure>
         <extend type="stop"/>
      </figure>
   </figured-bass>
   <note default-x="175">
      <pitch>
         <step>D</step>
         <octave>3</octave>
      </pitch>
      <duration>2</duration>
      <voice>1</voice>
      <type>quarter</type>
      <stem default-y="-55">down</stem>
   </note>
</measure>
```
