// @ts-check
import { defineConfig, fontProviders } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';
import ViteRestart from 'vite-plugin-restart';

const setLayout = () => {
  return function (_, file) {
    file.data.astro.frontmatter.layout = file.data.astro.frontmatter.layout || "@layouts/Base.astro";
  };
};

export default defineConfig({
  fonts: [
    {
      name: "Noto Sans",
      cssVariable: "--font-noto-sans",
      provider: fontProviders.fontsource(),
      weights: [400, 700],
      styles: ["normal"]
    },
    {
      name: "Noto Serif",
      cssVariable: "--font-noto-serif",
      provider: fontProviders.fontsource(),
      weights: [400],
      styles: ["normal"]
    },
    {
      name: "SMuFL",
      cssVariable: "--font-smufl",
      provider: fontProviders.local(),
      options: {
        variants: [{
          src: ['./src/assets/fonts/BravuraText.woff2'],
          weight: 'normal',
          style: 'normal',
          unicodeRange: ['U+E???'],
        }]
      }
    }
  ],
  markdown: {
    remarkPlugins: [setLayout],
  },
  vite: {
    plugins: [
      tailwindcss(),
      ViteRestart({
        restart: ['src/data/**', '!src/xsl/**']
      })
    ]
  },
  site: 'https://davidmatthew-ie.github.io',
  base: '/musicxml',
  redirects: {
    '/sounds-reference/elements/any-sounds/': '/musicxml/sounds-reference/elements/any/',
    '/sounds-reference/elements/ensemble-sounds/': '/musicxml/sounds-reference/elements/ensemble/',
    '/sounds-reference/elements/solo-sounds/': '/musicxml/sounds-reference/elements/solo/',
    '/sounds-reference/elements/sound-sounds/': '/musicxml/sounds-reference/elements/sound/',
    '/musicxml-reference/elements/opus-reference/': '/musicxml/musicxml-reference/elements/opus/',
    '/opus-reference/data-types/yes-no-opus/': '/musicxml/opus-reference/data-types/yes-no/',
    '/sounds-reference/data-types/yes-no-sounds/': '/musicxml/sounds-reference/data-types/yes-no/',
  }
});