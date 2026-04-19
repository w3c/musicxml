---
title: '<virtual-instrument>'
elements:
- virtual-instrument
- virtual-library
- virtual-name
---
```xml
<score-part id="P1">
   <part-name>Flute 1</part-name>
   <part-abbreviation>Fl. 1</part-abbreviation>
   <score-instrument id="P1-I1">
      <instrument-name>Flute Player 1</instrument-name>
      <virtual-instrument>
         <virtual-library>Garritan Instruments for Finale</virtual-library>
         <virtual-name>001. Woodwinds/1. Flutes/Flute Plr1</virtual-name>
      </virtual-instrument>
   </score-instrument>
   <midi-device>ARIA Player</midi-device>
   <midi-instrument id="P1-I1">
      <midi-channel>1</midi-channel>
      <midi-program>1</midi-program>
      <volume>80</volume>
      <pan>-70</pan>
   </midi-instrument>
</score-part>
```
