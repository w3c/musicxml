import { defineCollection } from 'astro:content';
import { file } from 'astro/loaders';
import { glob } from 'astro/loaders';
import { z } from 'astro/zod';

const ElementValueType = z.discriminatedUnion('type', [
  z.object({ type: z.literal('type'),
    value: z.string()
  }),
  z.object({ type: z.literal('element'),
    value: z.string(),
    min: z.string(),
    max: z.string()
  }),
  z.object({ type: z.literal('sequence'),
    get value(): z.ZodArray<typeof ElementValueType> { return z.array(ElementValueType); },
    min: z.string(),
    max: z.string()
  }),
  z.object({ type: z.literal('choice'),
    get value(): z.ZodArray<typeof ElementValueType> { return z.array(ElementValueType); },
    min: z.string(),
    max: z.string()
  }),
]);

const ElementType = z.object({
  parents: z.array(z.string()),
  name: z.string(),
  documentation: z.string(),
  children: z.nullable(ElementValueType),
  attributes: z.optional(z.array(z.object({
    required: z.boolean(),
    name: z.string(),
    type: z.string(),
    default: z.optional(z.string()),
    documentation: z.string(),
  })))
});

const containerElements = defineCollection({
  loader: file("src/data/elements-container.json"),
  schema: ElementType,
});
const musicxmlElements = defineCollection({
  loader: file("src/data/elements-musicxml.json"),
  schema: ElementType,
});
const opusElements = defineCollection({
  loader: file("src/data/elements-opus.json"),
  schema: ElementType,
});
const soundsElements = defineCollection({
  loader: file("src/data/elements-sounds.json"),
  schema: ElementType,
});

const containerElementsTree = defineCollection({
  loader: file("src/data/elements-tree-container.json"),
});
const musicxmlElementsTree = defineCollection({
  loader: file("src/data/elements-tree-musicxml.json"),
});
const opusElementsTree = defineCollection({
  loader: file("src/data/elements-tree-opus.json"),
});
const soundsElementsTree = defineCollection({
  loader: file("src/data/elements-tree-sounds.json"),
});

const DataTypeType = z.discriminatedUnion('type', [
  z.object({ type: z.literal('none'),
    name: z.string(),
    base: z.optional(z.array(z.string())),
    documentation: z.nullable(z.string()),
    value: z.optional(z.literal(null)),
  }),
  z.object({ type: z.literal('values'),
    name: z.string(),
    base: z.optional(z.array(z.string())),
    documentation: z.nullable(z.string()),
    value: z.array(z.object({
      value: z.string(),
      documentation: z.nullable(z.string())
    }))
  }),
  z.object({ type: z.literal('range'),
    name: z.string(),
    base: z.optional(z.array(z.string())),
    documentation: z.nullable(z.string()),
    value: z.object({
      minInclusive: z.optional(z.string()),
      minExclusive: z.optional(z.string()),
      maxInclusive: z.optional(z.string()),
      maxExclusive: z.optional(z.string()),
    })
  }),
  z.object({ type: z.literal('regex'),
    name: z.string(),
    base: z.optional(z.array(z.string())),
    documentation: z.nullable(z.string()),
    value: z.string()
  })
]);

const containerDatatypes = defineCollection({
  loader: file("src/data/datatypes-container.json"),
  schema: DataTypeType,
});
const musicxmlDatatypes = defineCollection({
  loader: file("src/data/datatypes-musicxml.json"),
  schema: DataTypeType,
});
const opusDatatypes = defineCollection({
  loader: file("src/data/datatypes-opus.json"),
  schema: DataTypeType,
});
const soundsDatatypes = defineCollection({
  loader: file("src/data/datatypes-sounds.json"),
  schema: DataTypeType,
});

const containerExamples = defineCollection({
  loader: glob({
    pattern: '**/*.md',
    base: './src/data/examples/container',
    generateId: ({ entry }) => entry.replace(/\.md$/, ''),
  }),
});
const musicxmlExamples = defineCollection({
  loader: glob({
    pattern: '**/*.md',
    base: './src/data/examples/musicxml',
    generateId: ({ entry }) => entry.replace(/\.md$/, ''),
  }),
});
const opusExamples = defineCollection({
  loader: glob({
    pattern: '**/*.md',
    base: './src/data/examples/opus',
    generateId: ({ entry }) => entry.replace(/\.md$/, ''),
  }),
});
const soundsExamples = defineCollection({
  loader: glob({
    pattern: '**/*.md',
    base: './src/data/examples/sounds',
    generateId: ({ entry }) => entry.replace(/\.md$/, ''),
  }),
});

const notes = defineCollection({
  loader: glob({
    pattern: '**/*.md',
    base: './src/data/notes',
    generateId: ({ entry }) => entry.replace(/\.md$/, ''),
  }),
});

export const collections = {
  containerElements, musicxmlElements, opusElements, soundsElements,
  containerElementsTree, musicxmlElementsTree, opusElementsTree, soundsElementsTree,
  containerDatatypes, musicxmlDatatypes, opusDatatypes, soundsDatatypes,
  containerExamples, musicxmlExamples, opusExamples, soundsExamples,
  notes,
};
