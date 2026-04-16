---
title: '<sound>'
element: sound
---
In this example, MusicXML has two sound IDs for a single application sound. The primary attribute for the `<sound>` element specifies which MusicXML sound ID to use when exporting a MusicXML file.

```xml
<sounds>
   <sound primary="yes" id="wind.reed.clarinet.a">
      <solo>9d3e28eb-0640-41f7-9144-0fdef3046d7c</solo>
   </sound>
   <sound primary="yes" id="wind.reed.clarinet.bflat">
      <solo>a16af0c1-8df8-476d-8d74-0d6e1972846b</solo>
   </sound>
</sounds>
```
