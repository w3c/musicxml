---
title: '<principal-voice>'
elements: principal-voice
image: principal-voice-element.png
---
```xml
<measure number="97" width="167">
   <direction placement="above">
      <direction-type>
         <principal-voice symbol="Hauptstimme" type="start" default-y="11" halign="center"/>
      </direction-type>
   </direction>
   <note default-x="13">
      <pitch>
         <step>C</step>
         <octave>5</octave>
      </pitch>
      <duration>4</duration>
      <voice>1</voice>
      <type>half</type>
      <stem default-y="-50">down</stem>
   </note>
   <note default-x="82">
      <pitch>
         <step>F</step>
         <alter>1</alter>
         <octave>5</octave>
      </pitch>
      <duration>2</duration>
      <voice>1</voice>
      <type>quarter</type>
      <accidental>sharp</accidental>
      <stem default-y="-35">down</stem>
   </note>
   <note default-x="124">
      <rest/>
      <duration>2</duration>
      <voice>1</voice>
      <type>quarter</type>
   </note>
   <direction placement="above">
      <direction-type>
         <principal-voice symbol="plain" type="stop" default-y="11" halign="center" relative-x="-10"/>
      </direction-type>
   </direction>
</measure>
```
