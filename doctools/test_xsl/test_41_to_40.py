from lxml import etree

xml_file = 'endings_41.musicxml'
xslt_file = '../../schema/to40.xsl'

xml = etree.parse(xml_file)
xslt = etree.parse(xslt_file)
transform = etree.XSLT(xslt)
new_xml = transform(xml)

print(str(new_xml))
