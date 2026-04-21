---
title: '<metronome-note>'
elements:
- metronome-note
- metronome-type
- metronome-beam
- metronome-tuplet
- actual-notes
- normal-notes
- normal-type
---
```xml
<direction placement="above">
   <direction-type>
      <metronome>
         <metronome-note>
            <metronome-type>eighth</metronome-type>
            <metronome-beam number="1">begin</metronome-beam>
         </metronome-note>
         <metronome-note>
            <metronome-type>eighth</metronome-type>
            <metronome-beam number="1">end</metronome-beam>
         </metronome-note>
         <metronome-relation>equals</metronome-relation>
         <metronome-note>
            <metronome-type>quarter</metronome-type>
            <metronome-tuplet bracket="yes" show-number="actual" type="start">
               <actual-notes>3</actual-notes>
               <normal-notes>2</normal-notes>
               <normal-type>eighth</normal-type>
            </metronome-tuplet>
         </metronome-note>
         <metronome-note>
            <metronome-type>eighth</metronome-type>
            <metronome-tuplet type="stop">
               <actual-notes>3</actual-notes>
               <normal-notes>2</normal-notes>
               <normal-type>eighth</normal-type>
            </metronome-tuplet>
         </metronome-note>
      </metronome>
   </direction-type>
   <sound>
      <swing>
         <first>2</first>
         <second>1</second>
      </swing>
   </sound>
</direction>
```
