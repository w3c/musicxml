---
title: '<grouping>'
elements:
- grouping
- feature
image: grouping-element.png
---
```xml
<part id="P8">
   <measure number="1">
      <grouping type="start">
         <feature type="motif">Fate knocking at the door</feature>
      </grouping>
      <note default-x="129">
         <rest/>
         <duration>4</duration>
         <voice>1</voice>
         <type>eighth</type>
      </note>
      <direction placement="below">
         <direction-type>
            <dynamics>
               <ff/>
            </dynamics>
         </direction-type>
      </direction>
      <note default-x="229">
         <pitch>
            <step>G</step>
            <octave>4</octave>
         </pitch>
         <duration>4</duration>
         <voice>1</voice>
         <type>eighth</type>
         <stem default-y="5">up</stem>
         <beam number="1">begin</beam>
      </note>
      <note default-x="330">
         <pitch>
            <step>G</step>
            <octave>4</octave>
         </pitch>
         <duration>4</duration>
         <voice>1</voice>
         <type>eighth</type>
         <stem default-y="5">up</stem>
         <beam number="1">continue</beam>
      </note>
      <note default-x="430">
         <pitch>
            <step>G</step>
            <octave>4</octave>
         </pitch>
         <duration>4</duration>
         <voice>1</voice>
         <type>eighth</type>
         <stem default-y="5">up</stem>
         <beam number="1">end</beam>
      </note>
   </measure>
   <measure number="2">
      <note default-x="97">
         <pitch>
            <step>E</step>
            <alter>-1</alter>
            <octave>4</octave>
         </pitch>
         <duration>16</duration>
         <voice>1</voice>
         <type>half</type>
         <stem default-y="-5">up</stem>
         <notations>
            <fermata type="upright"/>
         </notations>
      </note>
      <grouping type="stop"/>
   </measure>
</part>
```
