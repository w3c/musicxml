import type { ShikiTransformer } from 'shiki';
import { h } from 'hastscript';
import { svgToDataURL } from '@/utils';
import { transformerCopyButton } from '@selemondev/shiki-transformer-copy-button';

const { default: iconCodeCopy } = await import(`/src/assets/icons/code-copy.svg?raw`);
const { default: iconCodeCopied } = await import(`/src/assets/icons/code-copied.svg?raw`);
const { default: iconDownload } = await import(`/src/assets/icons/code-download.svg?raw`);

/**
 * Make a code copy Shiki transformer.
 */
export const copyTransformer = () => transformerCopyButton({
  enableDarkMode: true,
  duration: 2000,
  display: 'ready',
  successIcon: svgToDataURL(iconCodeCopied),
  copyIcon: svgToDataURL(iconCodeCopy)
});

export interface DownloadButtonOptions {
  filename?: string
  downloadIcon?: string
  enableDarkMode?: boolean
  display?: 'hover' | 'ready'
  cssVariables?: string
}

/**
 * File download Shiki transformer.
 *
 * @see https://github.com/selemondev/shiki-transformer-download-button
 */
export const downloadTransformer = (options: DownloadButtonOptions): ShikiTransformer => {

  function buttonStyles({
    downloadIcon = svgToDataURL(iconDownload)
  }: {
    downloadIcon?: string
    display?: 'hover' | 'ready'
    enableDarkMode?: boolean
    cssVariables?: string
  }) {
    return `.shiki-transformer-button-download .ready { background-image: url("${downloadIcon}") }`;
  }

  return {
    name: 'shiki-transformer-download-button',
    code(node) {
      const button = h(
        'button',
        {
          'class': 'shiki-transformer-button-download',
          'role': 'button',
          'aria-label': 'Download as file',
          'aria-live': 'polite',
          'onclick': `
            const a = this.querySelector("a");
            if (!a.href) {
              a.href = window.URL.createObjectURL(new Blob([
                this.parentElement.querySelector(".shiki-transformer-button-copy").dataset.code
              ], { type: 'text/xml' }));
            }
            return true;
          `
        },
        [h('a', {
          class: 'ready',
          download: options.filename
        })],
      )
      node.children.push(button)
      node.children.push({
        type: 'element',
        tagName: 'style',
        properties: {},
        children: [
          {
            type: 'text',
            value: buttonStyles({
              downloadIcon: options.downloadIcon,
              display: options.display,
              enableDarkMode: options.enableDarkMode,
              cssVariables: options.cssVariables,
            }),
          },
        ],
      })
    },
  }
}
