---
title: '<instrument-link>'
elements: instrument-link
---
```xml
<part-list>
   <score-part id="P1">
      <part-link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="p1.musicxml" xlink:title="Clarinet 1" xlink:show="new">
         <instrument-link id="P1-I1"/>
         <group-link>parts</group-link>
      </part-link>
      <part-link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="p2.musicxml" xlink:title="Clarinet 2" xlink:show="new">
         <instrument-link id="P1-I2"/>
         <group-link>parts</group-link>
      </part-link>
      <part-name>Clarinets 1&2</part-name>
      <part-abbreviation>Cl. 1&2</part-abbreviation>
      <group>score</group>
      <score-instrument id="P1-I1">
         <instrument-name>ARIA Player</instrument-name>
         <instrument-sound>wind.reed.clarinet.bflat</instrument-sound>
         <virtual-instrument>
            <virtual-library>Garritan Personal Orchestra 5</virtual-library>
            <virtual-name>Notation/01 Woodwinds/03 Clarinets/n-Bb Clarinet Plr1</virtual-name>
         </virtual-instrument>
      </score-instrument>
      <score-instrument id="P1-I2">
         <instrument-name>ARIA Player</instrument-name>
         <instrument-sound>wind.reed.clarinet.bflat</instrument-sound>
         <virtual-instrument>
            <virtual-library>Garritan Personal Orchestra 5</virtual-library>
            <virtual-name>Notation/01 Woodwinds/03 Clarinets/n-Bb Clarinet Plr2</virtual-name>
         </virtual-instrument>
      </score-instrument>
   </score-part>
</part-list>
```
