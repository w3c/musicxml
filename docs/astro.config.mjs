// @ts-check
import { defineConfig, fontProviders } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';

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
    }
  ],
  markdown: {
    remarkPlugins: [setLayout],
  },
  vite: {
    plugins: [tailwindcss()]
  }
});