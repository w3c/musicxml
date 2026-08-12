interface SiteInfo {
  [key: string]: any
}

export const siteInfo: SiteInfo = {
	title: 'MusicXML',
	specVersion: '4.1',
	isDraft: true,
  isDev: import.meta.env.MODE === 'development' || !import.meta.env.SITE.includes('w3c-cg.github.io'),
  sites: {
    draft: 'w3c-cg.github.io',
    stable: 'www.w3.org/2021/06'
  },

  // FIXME!! The following are copies of entries in astro.config.mjs
  // because `astro build` chokes when we import astro.config.mjs
  redirects: {
    '/sounds-reference/elements/any-sounds/': `${import.meta.env.BASE_URL}sounds-reference/elements/any/`,
    '/sounds-reference/elements/ensemble-sounds/': `${import.meta.env.BASE_URL}sounds-reference/elements/ensemble/`,
    '/sounds-reference/elements/solo-sounds/': `${import.meta.env.BASE_URL}sounds-reference/elements/solo/`,
    '/sounds-reference/elements/sound-sounds/': `${import.meta.env.BASE_URL}sounds-reference/elements/sound/`,
    '/musicxml-reference/elements/opus-reference/': `${import.meta.env.BASE_URL}musicxml-reference/elements/opus/`,
    '/opus-reference/data-types/yes-no-opus/': `${import.meta.env.BASE_URL}opus-reference/data-types/yes-no/`,
    '/sounds-reference/data-types/yes-no-sounds/': `${import.meta.env.BASE_URL}sounds-reference/data-types/yes-no/`,
  }
}

/**
 * SPECIAL CASE!! \<measure\> and \<part\> are treated differently in partwise and timewise scores.
 * To differentiate between them, the elements-musicxml.json listing calls them
 * \<measure-partwise\> and \<measure-timewise\>, respectively, and same for \<part-partwise\> and \<part-timewise\>.
 *
 * The large majority of examples apply to partwise scores, so the default mapping is made here.
 * For timewise examples, the example frontmatter can override this map with an `elements_map` entry, such as in
 * docs/src/data/examples/musicxml-reference/score-timewise-element.md
 */
interface DefaultElementMap {
  [key: string]: string
}

export const defaultElementsMap: DefaultElementMap = {
  measure: 'measure-partwise',
  part: 'part-partwise',
}
