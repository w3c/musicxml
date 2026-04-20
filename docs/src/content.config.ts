import { defineCollection } from 'astro:content';
import { file } from 'astro/loaders';

const containerElements = defineCollection({
  loader: file("src/data/elements-container.json"),
});
const musicxmlElements = defineCollection({
  loader: file("src/data/elements-musicxml.json"),
});
const opusElements = defineCollection({
  loader: file("src/data/elements-opus.json"),
});
const soundsElements = defineCollection({
  loader: file("src/data/elements-sounds.json"),
});

const containerDatatypes = defineCollection({
  loader: file("src/data/datatypes-container.json"),
});
const musicxmlDatatypes = defineCollection({
  loader: file("src/data/datatypes-musicxml.json"),
});
const opusDatatypes = defineCollection({
  loader: file("src/data/datatypes-opus.json"),
});
const soundsDatatypes = defineCollection({
  loader: file("src/data/datatypes-sounds.json"),
});

export const collections = {
  containerElements, musicxmlElements, opusElements, soundsElements,
  containerDatatypes, musicxmlDatatypes, opusDatatypes, soundsDatatypes,
};
