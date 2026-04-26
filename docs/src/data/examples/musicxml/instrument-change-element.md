---
title: '<instrument-change>'
elements:
- instrument-change
- instrument-sound
- solo
- virtual-instrument
- virtual-library
- virtual-name
---
```xml
<score-partwise version="4.1">
   <defaults>
      <scaling>
         <millimeters>7.2319</millimeters>
         <tenths>40</tenths>
      </scaling>
   </defaults>
   <part-list>
      <score-part id="P1">
         <part-name>Clarinet in Bb</part-name>
         <part-name-display>
            <display-text>Clarinet in B</display-text>
            <accidental-text>flat</accidental-text>
         </part-name-display>
         <part-abbreviation>Bb Cl.</part-abbreviation>
         <part-abbreviation-display>
            <display-text>B</display-text>
            <accidental-text>flat</accidental-text>
            <display-text> Cl.</display-text>
         </part-abbreviation-display>
         <group>score</group>
         <score-instrument id="P1-I1">
            <instrument-name>ARIA Player</instrument-name>
            <instrument-sound>wind.reed.clarinet.bflat</instrument-sound>
            <solo/>
            <virtual-instrument>
               <virtual-library>Garritan Jazz and Big Band 3</virtual-library>
               <virtual-name>Notation/01 Saxes and Woodwinds/Clarinets/n-Bb Clarinet 1</virtual-name>
            </virtual-instrument>
         </score-instrument>
         <midi-device>ARIA Player</midi-device>
         <midi-instrument id="P1-I1">
            <midi-channel>1</midi-channel>
            <midi-program>1</midi-program>
            <volume>80</volume>
            <pan>0</pan>
         </midi-instrument>
      </score-part>
   </part-list>
   <part id="P1">
      <measure number="1" width="225">
         <print>
            <measure-numbering>system</measure-numbering>
         </print>
         <attributes>
            <divisions>2</divisions>
            <key>
               <fifths>-1</fifths>
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
               <diatonic>-1</diatonic>
               <chromatic>-2</chromatic>
            </transpose>
         </attributes>
         <note default-x="108">
            <pitch>
               <step>C</step>
               <octave>5</octave>
            </pitch>
            <duration>8</duration>
            <voice>1</voice>
            <type>whole</type>
         </note>
      </measure>
      <measure number="2" width="130">
         <direction placement="above">
            <direction-type>
               <words default-y="19" relative-x="-10">To Alto Sax</words>
            </direction-type>
         </direction>
         <note>
            <rest measure="yes"/>
            <duration>8</duration>
            <voice>1</voice>
         </note>
      </measure>
      <measure number="3" width="130">
         <note>
            <rest measure="yes"/>
            <duration>8</duration>
            <voice>1</voice>
         </note>
      </measure>
      <measure number="4" width="159">
         <note>
            <rest measure="yes"/>
            <duration>8</duration>
            <voice>1</voice>
         </note>
      </measure>
      <measure number="5" width="206">
         <print new-system="yes">
            <part-name-display>
               <display-text>Alto Sax</display-text>
            </part-name-display>
            <part-abbreviation-display>
               <display-text>A. Sx.</display-text>
            </part-abbreviation-display>
         </print>
         <attributes>
            <key>
               <fifths>0</fifths>
               <mode>major</mode>
            </key>
            <transpose>
               <diatonic>-5</diatonic>
               <chromatic>-9</chromatic>
            </transpose>
         </attributes>
         <sound>
            <instrument-change id="P1-I1">
               <instrument-sound>wind.reed.saxophone.alto</instrument-sound>
               <solo/>
               <virtual-instrument>
                  <virtual-library>Garritan Jazz and Big Band 3</virtual-library>
                  <virtual-name>Notation/01 Saxes and Woodwinds/Saxophones/n-Alto Sax 1</virtual-name>
               </virtual-instrument>
            </instrument-change>
         </sound>
         <note default-x="51">
            <pitch>
               <step>C</step>
               <octave>5</octave>
            </pitch>
            <duration>8</duration>
            <voice>1</voice>
            <type>whole</type>
         </note>
      </measure>
      <measure number="6" width="169">
         <note>
            <rest measure="yes"/>
            <duration>8</duration>
            <voice>1</voice>
         </note>
      </measure>
      <measure number="7" width="169">
         <note>
            <rest measure="yes"/>
            <duration>8</duration>
            <voice>1</voice>
         </note>
      </measure>
      <measure number="8" width="168">
         <note>
            <rest measure="yes"/>
            <duration>8</duration>
            <voice>1</voice>
         </note>
      </measure>
   </part>
</score-partwise>
```
