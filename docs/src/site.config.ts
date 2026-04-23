interface SiteInfo {
  [key: string]: string | boolean
}

export const siteInfo: SiteInfo = {
	title: 'MusicXML',
	specVersion: '4.1',
	isDraft: true,
  isDev: import.meta.env.MODE === 'development' || !import.meta.env.SITE.includes('w3c-cg.github.io')
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
