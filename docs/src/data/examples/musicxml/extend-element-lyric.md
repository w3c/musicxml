---
title: '<extend> (Lyric)'
elements: extend
---
```xml
<measure number="80">
   <note default-x="14">
      <pitch>
         <step>F</step>
         <octave>4</octave>
      </pitch>
      <duration>4</duration>
      <voice>1</voice>
      <type>eighth</type>
      <stem default-y="20">up</stem>
      <beam number="1">begin</beam>
      <notations>
         <slur number="1" placement="below" type="start"/>
      </notations>
      <lyric default-y="-73" justify="left" name="verse" number="1">
         <syllabic>single</syllabic>
         <text>I</text>
         <extend type="start"/>
      </lyric>
   </note>
   <note default-x="40">
      <pitch>
         <step>C</step>
         <octave>5</octave>
      </pitch>
      <duration>4</duration>
      <voice>1</voice>
      <type>eighth</type>
      <stem default-y="20">up</stem>
      <beam number="1">continue</beam>
      <notations>
         <slur number="1" type="stop"/>
      </notations>
      <lyric name="verse" number="1">
         <extend type="stop"/>
      </lyric>
   </note>
</measure>
```
