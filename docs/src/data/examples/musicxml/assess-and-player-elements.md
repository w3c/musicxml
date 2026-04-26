---
title: '<assess> and <player>'
elements:
- player
- player-name
- listen
- assess
description: A women's choral part is set up so that on three-way splits, first sopranos should sing the top note, second sopranos should sing the middle note, and all altos should sing the bottom note. A listening application can then see if the pitch is correct based on which player is selected.
---
```xml
<score-partwise version="4.1">
   <part-list>
      <score-part id="P1">
         <part-name>Soprano Alto</part-name>
         <part-name-display>
            <display-text xml:space="preserve">Soprano
Alto</display-text>
         </part-name-display>
         <score-instrument id="P1-I1">
            <instrument-name>ARIA Player</instrument-name>
            <instrument-sound>voice.soprano</instrument-sound>
         </score-instrument>
         <score-instrument id="P1-I2">
            <instrument-name>ARIA Player</instrument-name>
            <instrument-sound>voice.alto</instrument-sound>
         </score-instrument>
         <player id="P1-M1">
            <player-name>Soprano 1</player-name>
         </player>
         <player id="P1-M2">
            <player-name>Soprano 2</player-name>
         </player>
         <player id="P1-M3">
            <player-name>Alto 1</player-name>
         </player>
         <player id="P1-M4">
            <player-name>Alto 2</player-name>
         </player>
      </score-part>
   </part-list>
   <part id="P1">
      <measure number="1" width="191">
         <attributes>
            <divisions>2</divisions>
            <key>
               <fifths>0</fifths>
               <mode>minor</mode>
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
         <note default-x="83">
            <pitch>
               <step>A</step>
               <octave>4</octave>
            </pitch>
            <duration>8</duration>
            <instrument id="P1-I2"/>
            <voice>1</voice>
            <type>whole</type>
            <lyric default-y="-62" justify="left" number="1">
               <syllabic>single</syllabic>
               <text>Ah</text>
               <extend type="start"/>
            </lyric>
            <listen>
               <assess type="no" player="P1-M1"/>
               <assess type="no" player="P1-M2"/>
            </listen>
         </note>
         <note default-x="83">
            <chord/>
            <pitch>
               <step>C</step>
               <octave>5</octave>
            </pitch>
            <duration>8</duration>
            <instrument id="P1-I1"/>
            <voice>1</voice>
            <type>whole</type>
            <listen>
               <assess type="no" player="P1-M3"/>
               <assess type="no" player="P1-M4"/>
            </listen>
         </note>
      </measure>
      <measure number="2" width="120">
         <note default-x="13">
            <pitch>
               <step>A</step>
               <octave>4</octave>
            </pitch>
            <duration>8</duration>
            <instrument id="P1-I2"/>
            <voice>1</voice>
            <type>whole</type>
            <lyric number="1">
               <extend type="stop"/>
            </lyric>
            <listen>
               <assess type="no" player="P1-M1"/>
               <assess type="no" player="P1-M2"/>
            </listen>
         </note>
         <note default-x="13">
            <chord/>
            <pitch>
               <step>C</step>
               <octave>5</octave>
            </pitch>
            <duration>8</duration>
            <instrument id="P1-I1"/>
            <voice>1</voice>
            <type>whole</type>
            <listen>
               <assess type="no" player="P1-M1"/>
               <assess type="no" player="P1-M3"/>
               <assess type="no" player="P1-M4"/>
            </listen>
         </note>
         <note default-x="13">
            <chord/>
            <pitch>
               <step>E</step>
               <octave>5</octave>
            </pitch>
            <duration>8</duration>
            <instrument id="P1-I1"/>
            <voice>1</voice>
            <type>whole</type>
            <listen>
               <assess type="no" player="P1-M2"/>
               <assess type="no" player="P1-M3"/>
               <assess type="no" player="P1-M4"/>
            </listen>
         </note>
      </measure>
   </part>
</score-partwise>
```
