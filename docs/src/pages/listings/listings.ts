import { readFileSync, readdirSync } from 'node:fs';
import { basename, resolve } from 'node:path';

export const DATA_DIR = resolve('../schema');

export function getIds(): string[] {
  return readdirSync(DATA_DIR)
    .filter(f => f.endsWith('.xsd') || f.endsWith('.xsl') || f.endsWith('.xml'))
    .map(f => basename(f));
}

export function getXML(id: string): string {
  return readFileSync(resolve(DATA_DIR, `${id}`), 'utf-8');
}
