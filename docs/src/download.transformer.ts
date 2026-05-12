import type { ShikiTransformer } from 'shiki';
import { h } from 'hastscript';
import { svgToDataURL } from '@/utils';

const { default: iconDownload } = await import(`/src/assets/icons/code-download.svg?raw`);

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

function buttonStyles({
  downloadIcon = svgToDataURL(iconDownload),
  display = 'ready',
  enableDarkMode = false,
  cssVariables = `
:root {
  --button-download-right: 32px;
}
`,
}: {
  downloadIcon?: string
  display?: 'hover' | 'ready'
  enableDarkMode?: boolean
  cssVariables?: string
}) {
  let styles = `
${cssVariables}

pre {
    position: relative;
    overflow: auto;
}

pre:has(code) code {
    overflow-x: auto;
    display: block;
}

pre:has(code) button.shiki-transformer-button-download {
  position: absolute;
  top: var(--button-top);
  right: var(--button-download-right);
  z-index: var(--button-z-index);

  width: var(--button-size);
  height: var(--button-size);
  border-radius: var(--button-radius);
  border: 1px solid var(--button-border-color);

  background-color: var(--button-bg);
  display: flex;
  align-items: center;
  justify-content: center;

  cursor: pointer;
  transition: background-color .2s, opacity .2s;
}

pre:has(code) button.shiki-transformer-button-download:hover {
  background-color: var(--button-bg-hover);
}

pre:has(code) button.shiki-transformer-button-download .ready {
  width: var(--icon-size);
  height: var(--icon-size);
  background-repeat: no-repeat;
  background-position: center;
  background-size: contain;
}

pre:has(code) button.shiki-transformer-button-download .ready {
  background-image: url("${downloadIcon}");
}
`

  if (display === 'hover') {
    styles += `
pre:has(code) button.shiki-transformer-button-download {
  opacity: 0;
}
pre:has(code):hover button.shiki-transformer-button-download {
  opacity: 1;
}
`
  }

  if (enableDarkMode) {
    styles += `
html.dark pre:has(code) button.shiki-transformer-button-download {
  background-color: var(--button-bg-dark);
  border-color: var(--button-border-color-dark);
}

html.dark pre:has(code) button.shiki-transformer-button-download:hover {
  background-color: var(--button-bg-hover-dark);
}
`
  }

  return styles
}

function removeCodeAnnotations(code: string) {
  const annotationRegex = /\/\/\s*\[!code\s*(?:\S.*)?\]/;

  return code
    .split('\n')
    .filter(line => !annotationRegex.test(line))
    .join('\n');
}
