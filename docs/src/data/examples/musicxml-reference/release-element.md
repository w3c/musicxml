---
title: '<release>'
elements: release
image: release-element.png
---
```xml
<note>
   <pitch>
      <step>E</step>
      <octave>4</octave>
   </pitch>
   <duration>2</duration>
   <voice>1</voice>
   <type>eighth</type>
   <stem>none</stem>
   <notations>
      <technical>
         <string>2</string>
         <fret>5</fret>
         <bend shape="curved">
            <bend-alter>2</bend-alter>
         </bend>
         <bend shape="curved">
            <bend-alter>-2</bend-alter>
            <release offset="1"/>
         </bend>
      </technical>
   </notations>
</note>
```
