import { createMarkdownProcessor } from '@astrojs/markdown-remark';
import { transformerCopyButton } from '@selemondev/shiki-transformer-copy-button';
import { siteInfo } from '@/site.config';

const { default: iconCodeCopy } = await import(`/src/assets/icons/code-copy.svg?raw`);
const { default: iconCodeCopied } = await import(`/src/assets/icons/code-copied.svg?raw`);

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

/**
 * Convert SVG to Data URL
 * @see https://github.com/F1LT3R/svg-to-dataurl
 */
const svgToDataURL = (svgStr: string) => `data:image/svg+xml,${encodeURIComponent(svgStr).replace(/'/g, '%27').replace(/"/g, '%22')}`;

/**
 * Make a code copy Shiki transformer.
 */
export const copyTransformer = () => transformerCopyButton({
  enableDarkMode: true,
  duration: 2000,
  display: 'ready',
  successIcon: svgToDataURL(iconCodeCopied),
  copyIcon: svgToDataURL(iconCodeCopy),
  cssVariables: `
:root {
  --button-border-color: #2e2e32;
  --button-bg: transparent;
  --button-bg-hover: #1b1b1f;

  --button-border-color-dark: #2e2e32;
  --button-bg-dark: transparent;
  --button-bg-hover-dark: #1b1b1f;

  --button-top: 1px;
  --button-right: 1px;
  --button-z-index: 20;
  --button-radius: 4px;
  --button-size: 30px;
  --icon-size: 20px;
}
  `
});
