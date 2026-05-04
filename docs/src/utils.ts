import { createMarkdownProcessor } from '@astrojs/markdown-remark';
import { siteInfo } from './site.config';

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
 * Processes XML Schema <xs:documentation> annotations.
 *
 * - Transform tags to Markdown code backticks
 * - Render the Markdown
 * - Catch SMuFL chars and render them with a special class
 * - Remove surrounding <p> that the Markdown processor automatically adds
 */
export async function annotationMarkdown(annotation: string): Promise<string> {
  if (!annotation.length) throw("MISSING ATTRIBUTE DOC!!");

  const processor = await createMarkdownProcessor();
  return (await processor.render(
    annotation.trim().replaceAll('<', '`<').replaceAll('>', '>`')
  )).code
  .replace(/([\uE000-\uFFFF])/g, match => `<span class="smufl">${match}</span>`)
  .replaceAll(/^(?:<p>)+|(?:<\/p>)+$/g, '');
}

/**
 * Make a site URL including config.base.
 */
export const url = (path: string) => `${siteInfo.base}/${path}`;
