---
title: '<midi-instrument>'
elements:
- midi-instrument
- midi-channel
- midi-program
- volume
- pan
---
```xml
<score-part id="P2">
   <part-name print-object="no">Guitar</part-name>
   <score-instrument id="P2-I2">
      <instrument-name>Acoustic Guitar (steel)</instrument-name>
      <instrument-sound>pluck.guitar</instrument-sound>
   </score-instrument>
   <midi-instrument id="P2-I2">
      <midi-channel>2</midi-channel>
      <midi-program>26</midi-program>
      <volume>80</volume>
      <pan>-10</pan>
   </midi-instrument>
</score-part>
```
