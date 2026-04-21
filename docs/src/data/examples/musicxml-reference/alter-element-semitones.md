---
title: '<alter> (Semitones)'
elements: alter
---
```xml
<measure number="5">
   <note>
      <pitch>
         <step>A</step>
         <octave>5</octave>
      </pitch>
      <duration>8</duration>
      <voice>1</voice>
      <type>half</type>
      <stem default-y="-73">down</stem>
   </note>
   <note>
      <chord/>
      <pitch>
         <step>A</step>
         <octave>4</octave>
      </pitch>
      <duration>4</duration>
      <voice>1</voice>
      <type>quarter</type>
      <stem>down</stem>
   </note>
   <note>
      <chord/>
      <pitch>
         <step>D</step>
         <octave>4</octave>
      </pitch>
      <duration>4</duration>
      <voice>1</voice>
      <type>quarter</type>
   </note>
   <note>
      <pitch>
         <step>A</step>
         <octave>5</octave>
      </pitch>
      <duration>1</duration>
      <voice>1</voice>
      <type>16th</type>
      <stem default-y="-35">down</stem>
      <beam number="1">begin</beam>
      <beam number="2">begin</beam>
      <notations>
         <slur bezier-x="8" bezier-y="6" default-x="6" default-y="20" number="1" placement="above" type="start"/>
      </notations>
   </note>
   <note>
      <pitch>
         <step>G</step>
         <octave>5</octave>
      </pitch>
      <duration>1</duration>
      <voice>1</voice>
      <type>16th</type>
      <stem default-y="-35">down</stem>
      <beam number="1">continue</beam>
      <beam number="2">continue</beam>
      <notations>
         <slur bezier-x="-4" bezier-y="9" default-x="6" default-y="15" number="1" type="stop"/>
      </notations>
   </note>
   <note>
      <pitch>
         <step>F</step>
         <alter>1</alter>
         <octave>5</octave>
      </pitch>
      <duration>1</duration>
      <voice>1</voice>
      <type>16th</type>
      <stem default-y="-35">down</stem>
      <beam number="1">continue</beam>
      <beam number="2">continue</beam>
      <notations>
         <articulations>
            <staccato default-x="4" default-y="10" placement="above"/>
         </articulations>
      </notations>
   </note>
   <note>
      <pitch>
         <step>G</step>
         <octave>5</octave>
      </pitch>
      <duration>1</duration>
      <voice>1</voice>
      <type>16th</type>
      <stem default-y="-35">down</stem>
      <beam number="1">end</beam>
      <beam number="2">end</beam>
      <notations>
         <articulations>
            <staccato default-x="4" default-y="15" placement="above"/>
         </articulations>
      </notations>
   </note>
   <note>
      <pitch>
         <step>A</step>
         <octave>5</octave>
      </pitch>
      <duration>1</duration>
      <voice>1</voice>
      <type>16th</type>
      <stem default-y="-25">down</stem>
      <beam number="1">begin</beam>
      <beam number="2">begin</beam>
      <notations>
         <slur bezier-x="5" bezier-y="9" default-x="7" default-y="20" number="1" placement="above" type="start"/>
      </notations>
   </note>
   <note>
      <pitch>
         <step>B</step>
         <octave>5</octave>
      </pitch>
      <duration>1</duration>
      <voice>1</voice>
      <type>16th</type>
      <stem default-y="-25">down</stem>
      <beam number="1">continue</beam>
      <beam number="2">continue</beam>
      <notations>
         <slur bezier-x="-9" bezier-y="6" default-x="7" default-y="25" number="1" type="stop"/>
      </notations>
   </note>
   <note>
      <pitch>
         <step>A</step>
         <octave>5</octave>
      </pitch>
      <duration>1</duration>
      <voice>1</voice>
      <type>16th</type>
      <stem default-y="-25">down</stem>
      <beam number="1">continue</beam>
      <beam number="2">continue</beam>
      <notations>
         <slur bezier-x="5" bezier-y="9" default-x="6" default-y="20" number="1" placement="above" type="start"/>
      </notations>
   </note>
   <note>
      <pitch>
         <step>B</step>
         <octave>5</octave>
      </pitch>
      <duration>1</duration>
      <voice>1</voice>
      <type>16th</type>
      <stem default-y="-25">down</stem>
      <beam number="1">end</beam>
      <beam number="2">end</beam>
      <notations>
         <slur bezier-x="-9" bezier-y="6" default-x="6" default-y="25" number="1" type="stop"/>
      </notations>
   </note>
</measure>
```