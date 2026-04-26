import { createMarkdownProcessor } from '@astrojs/markdown-remark';

/**
 * Formats the MusicXML element as a title.
 *
 * SPECIAL CASE!! \<measure\> and \<part\> are treated differently in partwise and timewise scores.
 * To differentiate between them, the elements-musicxml.json listing calls them
 * \<measure-partwise\> and \<measure-timewise\>, respectively, and same for \<part-partwise\> and \<part-timewise\>.
 */
export function elementName(tag: string): string {
  const name =
    tag === 'part-partwise' ? '<part> (partwise)' : (
    tag === 'part-timewise' ? '<part> (timewise)' : (
    tag === 'measure-partwise' ? '<measure> (partwise)' : (
    tag === 'measure-timewise' ? '<measure> (timewise)' :
    `<${tag}>`
  )));
  return name;
}

/**
 * Processes XML Schema `xs:documentation` annotations to convert them to proper markdown.
 */
export async function annotationMarkdown(annotation: string): Promise<string> {
  const processor = await createMarkdownProcessor();
  return (await processor.render(
    annotation.trim().replaceAll('<', '`<').replaceAll('>', '>`')
  )).code;
}
