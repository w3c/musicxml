---
title: '<beam>'
elements: beam
image: beam-element.png
---
```xml
<measure number="42">
   <note default-x="10">
      <pitch>
         <step>F</step>
         <octave>4</octave>
      </pitch>
      <duration>8</duration>
      <voice>1</voice>
      <type>eighth</type>
      <time-modification>
         <actual-notes>3</actual-notes>
         <normal-notes>2</normal-notes>
      </time-modification>
      <stem default-y="0">up</stem>
      <beam number="1">begin</beam>
      <notations>
         <tuplet number="1" placement="above" type="start"/>
      </notations>
   </note>
   <note default-x="41">
      <pitch>
         <step>F</step>
         <octave>4</octave>
      </pitch>
      <duration>8</duration>
      <voice>1</voice>
      <type>eighth</type>
      <time-modification>
         <actual-notes>3</actual-notes>
         <normal-notes>2</normal-notes>
      </time-modification>
      <stem default-y="0">up</stem>
      <beam number="1">continue</beam>
   </note>
   <note default-x="71">
      <pitch>
         <step>F</step>
         <octave>4</octave>
      </pitch>
      <duration>8</duration>
      <voice>1</voice>
      <type>eighth</type>
      <time-modification>
         <actual-notes>3</actual-notes>
         <normal-notes>2</normal-notes>
      </time-modification>
      <stem default-y="0">up</stem>
      <beam number="1">end</beam>
      <notations>
         <tuplet number="1" type="stop"/>
      </notations>
   </note>
   <note default-x="101">
      <pitch>
         <step>F</step>
         <octave>4</octave>
      </pitch>
      <duration>12</duration>
      <voice>1</voice>
      <type>eighth</type>
      <stem default-y="8">up</stem>
      <beam number="1">begin</beam>
   </note>
   <note default-x="173">
      <pitch>
         <step>F</step>
         <octave>4</octave>
      </pitch>
      <duration>12</duration>
      <voice>1</voice>
      <type>eighth</type>
      <stem default-y="8">up</stem>
      <beam number="1">end</beam>
   </note>
   <note default-x="213">
      <pitch>
         <step>F</step>
         <octave>4</octave>
      </pitch>
      <duration>12</duration>
      <voice>1</voice>
      <type>eighth</type>
      <stem default-y="0">up</stem>
      <beam number="1">begin</beam>
   </note>
   <note default-x="253">
      <pitch>
         <step>F</step>
         <octave>4</octave>
      </pitch>
      <duration>6</duration>
      <voice>1</voice>
      <type>16th</type>
      <stem default-y="0">up</stem>
      <beam number="1">continue</beam>
      <beam number="2">begin</beam>
   </note>
   <note default-x="278">
      <pitch>
         <step>F</step>
         <octave>4</octave>
      </pitch>
      <duration>6</duration>
      <voice>1</voice>
      <type>16th</type>
      <stem default-y="0">up</stem>
      <beam number="1">end</beam>
      <beam number="2">end</beam>
   </note>
</measure>
```
