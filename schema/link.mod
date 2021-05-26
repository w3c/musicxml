<!--
	MusicXML link.mod module

	Version 4.0
	
	Copyright © 2004-2021 the Contributors to the MusicXML 
	Specification, published by the W3C Music Notation Community
	Group under the W3C Community Final Specification Agreement 
	(FSA): 
	
	   https://www.w3.org/community/about/agreements/final/
	
	A human-readable summary is available:
	
	   https://www.w3.org/community/about/agreements/fsa-deed/

	The DTD version of the MusicXML format is deprecated
	as of Version 4.0. Use the musicxml.xsd W3C XML Schema
	definition instead.
-->

<!--
	This DTD module describes the entity and elements used for
	simple XLink support. The link element serves as an outgoing
	XLink. The bookmark element serves as a well-defined target
	for an incoming XLink. The link-attributes entity is also
	used to connect a MusicXML score with MusicXML parts or a 
	MusicXML opus. If a relative link is used within a document
	that is part of a compressed MusicXML file, the link is 
	relative to the root folder of the zip file.
-->

<!-- Entities -->

<!--
	Namespace entity for the XLink recommendation.
-->
<!ENTITY % xlink.ns "http://www.w3.org/1999/xlink">

<!--
	The link-attributes entity includes all the simple XLink
	attributes supported in the MusicXML format.
-->
<!ENTITY % link-attributes
	"xmlns:xlink  CDATA    #FIXED     '%xlink.ns;'
	 xlink:href   CDATA    #REQUIRED
	 xlink:type   (simple) #FIXED     'simple'
	 xlink:role   CDATA    #IMPLIED
	 xlink:title  CDATA    #IMPLIED
	 xlink:show   (new | replace | embed | other | none)
		'replace'
	 xlink:actuate	(onRequest | onLoad | other | none)
		'onRequest'">

<!-- Elements -->

<!--
	The element and position attributes are new as of Version
	2.0. They allow for bookmarks and links to be positioned at
	higher resolution than the level of music-data elements.
	When no element and position attributes are present, the
	bookmark or link element refers to the next sibling element
	in the MusicXML file. The element attribute specifies an
	element type for a descendant of the next sibling element
	that is not a link or bookmark. The position attribute
	specifies the position of this descendant element, where
	the first position is 1. The position attribute is ignored
	if the element attribute is not present. For instance, an
	element value of "beam"  and a position value of "2" defines
	the link or bookmark to refer to the second beam descendant
	of the next sibling element that is not a link or bookmark.
	This is equivalent to an XPath test of [.//beam[2]] done
	in the context of the sibling element.
-->

<!ELEMENT link EMPTY>
<!ATTLIST link
    %link-attributes;
    name  CDATA  #IMPLIED
    element  NMTOKEN #IMPLIED
    position NMTOKEN #IMPLIED
    %position;
>
	
<!ELEMENT bookmark EMPTY>
<!ATTLIST bookmark
    id    ID     #REQUIRED
    name  CDATA  #IMPLIED
    element  NMTOKEN #IMPLIED
    position NMTOKEN #IMPLIED
>
