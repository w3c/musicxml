---
title: 'Tutorial: Chopin Prelude'
image: chopin.png
tutorial: true
---
```xml
<score-partwise version="4.1">
   <identification>
      <encoding>
         <software>Finale v28.0 for Mac</software>
         <encoding-date>2024-04-16</encoding-date>
         <supports element="print" attribute="new-system" type="yes" value="yes"/>
         <supports element="print" attribute="new-page" type="yes" value="yes"/>
         <supports element="accidental" type="yes"/>
         <supports element="beam" type="yes"/>
         <supports element="stem" type="yes"/>
      </encoding>
   </identification>
   <defaults>
      <scaling>
         <millimeters>6.35</millimeters>
         <tenths>40</tenths>
      </scaling>
      <page-layout>
         <page-height>1760</page-height>
         <page-width>1360</page-width>
         <page-margins type="both">
            <left-margin>80</left-margin>
            <right-margin>80</right-margin>
            <top-margin>80</top-margin>
            <bottom-margin>80</bottom-margin>
         </page-margins>
      </page-layout>
      <system-layout>
         <system-margins>
            <left-margin>0</left-margin>
            <right-margin>0</right-margin>
         </system-margins>
         <system-distance>130</system-distance>
         <top-system-distance>70</top-system-distance>
      </system-layout>
      <staff-layout>
         <staff-distance>60</staff-distance>
      </staff-layout>
      <appearance>
         <line-width type="stem">0.8333</line-width>
         <line-width type="beam">5</line-width>
         <line-width type="staff">1.25</line-width>
         <line-width type="light barline">1.875</line-width>
         <line-width type="heavy barline">5</line-width>
         <line-width type="leger">1.875</line-width>
         <line-width type="ending">0.8333</line-width>
         <line-width type="wedge">1.25</line-width>
         <line-width type="enclosure">1.25</line-width>
         <line-width type="tuplet bracket">0.8333</line-width>
         <note-size type="grace">60</note-size>
         <note-size type="cue">60</note-size>
         <distance type="hyphen">60</distance>
         <distance type="beam">7.5</distance>
      </appearance>
      <music-font font-family="Maestro,engraved" font-size="18"/>
      <word-font font-family="Times New Roman" font-size="9"/>
   </defaults>
   <part-list>
      <score-part id="P1">
         <part-name print-object="no">Piano</part-name>
         <group>score</group>
         <score-instrument id="P1-I2">
            <instrument-name>Acoustic Grand Piano</instrument-name>
         </score-instrument>
         <midi-instrument id="P1-I2">
            <midi-channel>2</midi-channel>
            <midi-program>1</midi-program>
            <volume>80</volume>
            <pan>0</pan>
         </midi-instrument>
      </score-part>
   </part-list>
   <part id="P1">
      <measure number="1" width="457">
         <print>
            <page-layout>
               <page-height>1760</page-height>
               <page-width>1360</page-width>
               <page-margins>
                  <left-margin>80</left-margin>
                  <right-margin>703</right-margin>
                  <top-margin>80</top-margin>
                  <bottom-margin>80</bottom-margin>
               </page-margins>
            </page-layout>
            <system-layout>
               <system-margins>
                  <left-margin>120</left-margin>
                  <right-margin>0</right-margin>
               </system-margins>
               <top-system-distance>230</top-system-distance>
            </system-layout>
            <measure-numbering>system</measure-numbering>
         </print>
         <attributes>
            <divisions>4</divisions>
            <key>
               <fifths>-3</fifths>
               <mode>minor</mode>
            </key>
            <time symbol="common">
               <beats>4</beats>
               <beat-type>4</beat-type>
            </time>
            <staves>2</staves>
            <clef number="1">
               <sign>F</sign>
               <line>4</line>
            </clef>
            <clef number="2">
               <sign>F</sign>
               <line>4</line>
            </clef>
         </attributes>
         <sound tempo="40"/>
         <direction placement="below">
            <direction-type>
               <dynamics default-y="-72" halign="left" relative-x="-10">
                  <ff/>
               </dynamics>
            </direction-type>
            <staff>1</staff>
            <sound dynamics="112"/>
         </direction>
         <note default-x="136">
            <pitch>
               <step>G</step>
               <octave>3</octave>
            </pitch>
            <duration>4</duration>
            <voice>1</voice>
            <type>quarter</type>
            <stem default-y="-40">down</stem>
            <staff>1</staff>
            <notations>
               <slur number="1" type="start" placement="above" default-x="6" default-y="50" bezier-x="38" bezier-y="50"/>
            </notations>
         </note>
         <note default-x="136">
            <chord/>
            <pitch>
               <step>C</step>
               <octave>4</octave>
            </pitch>
            <duration>4</duration>
            <voice>1</voice>
            <type>quarter</type>
            <stem>down</stem>
            <staff>1</staff>
         </note>
         <note default-x="136">
            <chord/>
            <pitch>
               <step>E</step>
               <alter>-1</alter>
               <octave>4</octave>
            </pitch>
            <duration>4</duration>
            <voice>1</voice>
            <type>quarter</type>
            <stem>down</stem>
            <staff>1</staff>
         </note>
         <note default-x="136">
            <chord/>
            <pitch>
               <step>G</step>
               <octave>4</octave>
            </pitch>
            <duration>4</duration>
            <voice>1</voice>
            <type>quarter</type>
            <stem>down</stem>
            <staff>1</staff>
         </note>
         <note default-x="211">
            <pitch>
               <step>A</step>
               <alter>-1</alter>
               <octave>3</octave>
            </pitch>
            <duration>4</duration>
            <voice>1</voice>
            <type>quarter</type>
            <stem default-y="-35">down</stem>
            <staff>1</staff>
         </note>
         <note default-x="211">
            <chord/>
            <pitch>
               <step>C</step>
               <octave>4</octave>
            </pitch>
            <duration>4</duration>
            <voice>1</voice>
            <type>quarter</type>
            <stem>down</stem>
            <staff>1</staff>
         </note>
         <note default-x="211">
            <chord/>
            <pitch>
               <step>E</step>
               <alter>-1</alter>
               <octave>4</octave>
            </pitch>
            <duration>4</duration>
            <voice>1</voice>
            <type>quarter</type>
            <stem>down</stem>
            <staff>1</staff>
         </note>
         <note default-x="211">
            <chord/>
            <pitch>
               <step>A</step>
               <alter>-1</alter>
               <octave>4</octave>
            </pitch>
            <duration>4</duration>
            <voice>1</voice>
            <type>quarter</type>
            <stem>down</stem>
            <staff>1</staff>
         </note>
         <note default-x="288">
            <pitch>
               <step>E</step>
               <alter>-1</alter>
               <octave>4</octave>
            </pitch>
            <duration>3</duration>
            <voice>1</voice>
            <type>eighth</type>
            <dot/>
            <stem default-y="63">up</stem>
            <staff>1</staff>
            <beam number="1">begin</beam>
         </note>
         <note default-x="288">
            <chord/>
            <pitch>
               <step>G</step>
               <octave>4</octave>
            </pitch>
            <duration>3</duration>
            <voice>1</voice>
            <type>eighth</type>
            <dot/>
            <stem>up</stem>
            <staff>1</staff>
         </note>
         <note default-x="349">
            <pitch>
               <step>D</step>
               <octave>4</octave>
            </pitch>
            <duration>1</duration>
            <voice>1</voice>
            <type>16th</type>
            <stem default-y="60">up</stem>
            <staff>1</staff>
            <beam number="1">end</beam>
            <beam number="2">backward hook</beam>
         </note>
         <note default-x="349">
            <chord/>
            <pitch>
               <step>F</step>
               <octave>4</octave>
            </pitch>
            <duration>1</duration>
            <voice>1</voice>
            <type>16th</type>
            <stem>up</stem>
            <staff>1</staff>
         </note>
         <note default-x="379">
            <pitch>
               <step>E</step>
               <alter>-1</alter>
               <octave>3</octave>
            </pitch>
            <duration>4</duration>
            <voice>1</voice>
            <type>quarter</type>
            <stem default-y="-50">down</stem>
            <staff>1</staff>
            <notations>
               <slur number="1" type="stop" default-x="6" default-y="40" bezier-x="-21" bezier-y="58"/>
            </notations>
         </note>
         <note default-x="379">
            <chord/>
            <pitch>
               <step>G</step>
               <octave>3</octave>
            </pitch>
            <duration>4</duration>
            <voice>1</voice>
            <type>quarter</type>
            <stem>down</stem>
            <staff>1</staff>
         </note>
         <note default-x="379">
            <chord/>
            <pitch>
               <step>C</step>
               <octave>4</octave>
            </pitch>
            <duration>4</duration>
            <voice>1</voice>
            <type>quarter</type>
            <stem>down</stem>
            <staff>1</staff>
         </note>
         <note default-x="379">
            <chord/>
            <pitch>
               <step>E</step>
               <alter>-1</alter>
               <octave>4</octave>
            </pitch>
            <duration>4</duration>
            <voice>1</voice>
            <type>quarter</type>
            <stem>down</stem>
            <staff>1</staff>
         </note>
         <backup>
            <duration>16</duration>
         </backup>
         <forward>
            <duration>8</duration>
            <voice>2</voice>
            <staff>1</staff>
         </forward>
         <note default-x="288">
            <pitch>
               <step>G</step>
               <octave>3</octave>
            </pitch>
            <duration>4</duration>
            <voice>2</voice>
            <type>quarter</type>
            <stem default-y="-40">down</stem>
            <staff>1</staff>
         </note>
         <note default-x="288">
            <chord/>
            <pitch>
               <step>B</step>
               <octave>3</octave>
            </pitch>
            <duration>4</duration>
            <voice>2</voice>
            <type>quarter</type>
            <accidental>natural</accidental>
            <stem>down</stem>
            <staff>1</staff>
         </note>
         <forward>
            <duration>4</duration>
            <voice>2</voice>
            <staff>1</staff>
         </forward>
         <backup>
            <duration>16</duration>
         </backup>
         <note default-x="136">
            <pitch>
               <step>C</step>
               <octave>2</octave>
            </pitch>
            <duration>4</duration>
            <voice>3</voice>
            <type>quarter</type>
            <stem default-y="10">up</stem>
            <staff>2</staff>
         </note>
         <note default-x="136">
            <chord/>
            <pitch>
               <step>C</step>
               <octave>3</octave>
            </pitch>
            <duration>4</duration>
            <voice>3</voice>
            <type>quarter</type>
            <stem>up</stem>
            <staff>2</staff>
         </note>
         <note default-x="211">
            <pitch>
               <step>F</step>
               <octave>1</octave>
            </pitch>
            <duration>4</duration>
            <voice>3</voice>
            <type>quarter</type>
            <stem default-y="-10">up</stem>
            <staff>2</staff>
         </note>
         <note default-x="211">
            <chord/>
            <pitch>
               <step>F</step>
               <octave>2</octave>
            </pitch>
            <duration>4</duration>
            <voice>3</voice>
            <type>quarter</type>
            <stem>up</stem>
            <staff>2</staff>
         </note>
         <note default-x="288">
            <pitch>
               <step>G</step>
               <octave>1</octave>
            </pitch>
            <duration>4</duration>
            <voice>3</voice>
            <type>quarter</type>
            <stem default-y="-5">up</stem>
            <staff>2</staff>
         </note>
         <note default-x="288">
            <chord/>
            <pitch>
               <step>G</step>
               <octave>2</octave>
            </pitch>
            <duration>4</duration>
            <voice>3</voice>
            <type>quarter</type>
            <stem>up</stem>
            <staff>2</staff>
         </note>
         <note default-x="379">
            <pitch>
               <step>C</step>
               <octave>2</octave>
            </pitch>
            <duration>4</duration>
            <voice>3</voice>
            <type>quarter</type>
            <stem default-y="10">up</stem>
            <staff>2</staff>
         </note>
         <note default-x="379">
            <chord/>
            <pitch>
               <step>G</step>
               <octave>2</octave>
            </pitch>
            <duration>4</duration>
            <voice>3</voice>
            <type>quarter</type>
            <stem>up</stem>
            <staff>2</staff>
         </note>
         <note default-x="379">
            <chord/>
            <pitch>
               <step>C</step>
               <octave>3</octave>
            </pitch>
            <duration>4</duration>
            <voice>3</voice>
            <type>quarter</type>
            <stem>up</stem>
            <staff>2</staff>
         </note>
      </measure>
   </part>
</score-partwise>
```
