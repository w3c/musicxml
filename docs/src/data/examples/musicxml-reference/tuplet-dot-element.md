---
title: '<tuplet-dot>'
elements: tuplet-dot
image: tuplet-dot-element.png
---
```xml
<note default-x="82">
   <pitch>
      <step>E</step>
      <octave>5</octave>
   </pitch>
   <duration>27</duration>
   <voice>1</voice>
   <type>eighth</type>
   <dot/>
   <time-modification>
      <actual-notes>10</actual-notes>
      <normal-notes>6</normal-notes>
      <normal-type>eighth</normal-type>
   </time-modification>
   <stem default-y="-40">down</stem>
   <beam number="1">begin</beam>
   <notations>
      <tuplet number="1" type="start" show-number="both" show-type="both" placement="below">
         <tuplet-actual>
            <tuplet-number>10</tuplet-number>
            <tuplet-type>eighth</tuplet-type>
         </tuplet-actual>
         <tuplet-normal>
            <tuplet-number>2</tuplet-number>
            <tuplet-type>quarter</tuplet-type>
            <tuplet-dot/>
         </tuplet-normal>
      </tuplet>
   </notations>
</note>
```
