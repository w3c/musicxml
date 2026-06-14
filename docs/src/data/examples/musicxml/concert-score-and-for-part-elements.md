---
title: '<concert-score> and <for-part>'
elements:
- concert-score
- transpose
- diatonic
- chromatic
- octave-change
- for-part
- part-clef
- sign
- line
- part-transpose
---
```xml
<score-partwise version="4.1">
   <movement-title>C Sounds</movement-title>
   <defaults>
      <scaling>
         <millimeters>7.2319</millimeters>
         <tenths>40</tenths>
      </scaling>
      <concert-score/>
      <page-layout>
         <page-height>1545</page-height>
         <page-width>1194</page-width>
      </page-layout>
   </defaults>
   <credit page="1">
      <credit-type>part name</credit-type>
      <credit-words default-x="105" default-y="1353" font-size="12" valign="top">Score in C</credit-words>
   </credit>
   <part-list>
      <part-group number="1" type="start">
         <group-symbol default-x="-5">bracket</group-symbol>
         <group-barline>yes</group-barline>
      </part-group>
      <score-part id="P1">
         <part-name>Piccolo</part-name>
         <group>score</group>
      </score-part>
      <score-part id="P2">
         <part-name>Oboe</part-name>
         <group>score</group>
      </score-part>
      <score-part id="P3">
         <part-name>Bass Clarinet</part-name>
         <group>score</group>
      </score-part>
      <part-group number="1" type="stop"/>
   </part-list>
   <part id="P1">
      <measure number="1" width="142">
         <attributes>
            <divisions>2</divisions>
            <key>
               <fifths>0</fifths>
               <mode>major</mode>
            </key>
            <time>
               <beats>4</beats>
               <beat-type>4</beat-type>
            </time>
            <clef>
               <sign>G</sign>
               <line>2</line>
            </clef>
            <transpose>
               <diatonic>0</diatonic>
               <chromatic>0</chromatic>
               <octave-change>1</octave-change>
            </transpose>
         </attributes>
         <note default-x="84">
            <pitch>
               <step>C</step>
               <octave>5</octave>
            </pitch>
            <duration>8</duration>
            <voice>1</voice>
            <type>whole</type>
         </note>
      </measure>
   </part>
   <part id="P2">
      <measure number="1" width="142">
         <attributes>
            <divisions>2</divisions>
            <key>
               <fifths>0</fifths>
               <mode>major</mode>
            </key>
            <time>
               <beats>4</beats>
               <beat-type>4</beat-type>
            </time>
            <clef>
               <sign>G</sign>
               <line>2</line>
            </clef>
         </attributes>
         <note default-x="84">
            <pitch>
               <step>C</step>
               <octave>5</octave>
            </pitch>
            <duration>8</duration>
            <voice>1</voice>
            <type>whole</type>
         </note>
      </measure>
   </part>
   <part id="P3">
      <measure number="1" width="142">
         <attributes>
            <divisions>2</divisions>
            <key>
               <fifths>0</fifths>
               <mode>major</mode>
            </key>
            <time>
               <beats>4</beats>
               <beat-type>4</beat-type>
            </time>
            <clef>
               <sign>F</sign>
               <line>4</line>
            </clef>
            <for-part>
               <part-clef>
                  <sign>G</sign>
                  <line>2</line>
               </part-clef>
               <part-transpose>
                  <diatonic>-1</diatonic>
                  <chromatic>-2</chromatic>
                  <octave-change>-1</octave-change>
               </part-transpose>
            </for-part>
         </attributes>
         <note default-x="84">
            <pitch>
               <step>C</step>
               <octave>3</octave>
            </pitch>
            <duration>8</duration>
            <voice>1</voice>
            <type>whole</type>
         </note>
      </measure>
   </part>
</score-partwise>
```
