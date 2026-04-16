---
title: '<solo>'
elements: solo
description: In this example, the application has two sounds for a single MusicXML sound ID. The primary attribute for the `<solo>` element specifies which application sound ID to use when importing a MusicXML file.
---
```xml
<sounds>
   <sound primary="yes" id="brass.euphonium">
      <solo primary="yes">c4b56ec1-51d3-4f98-b740-7d613dd893f9</solo>
      <solo primary="no">8b775b5f-90be-4922-8dee-2b82d3ac294b</solo>
   </sound>
</sounds>
```
