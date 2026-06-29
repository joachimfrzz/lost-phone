#!/usr/bin/env node
/** Copie public/stories → LostPhone bundle (Windows / CI local) */
import { cpSync, mkdirSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const root = join(dirname(fileURLToPath(import.meta.url)), "..");
const src = join(root, "public", "stories");
const dst = join(root, "LostPhone", "LostPhone", "Resources", "stories");

mkdirSync(dst, { recursive: true });
cpSync(src, dst, { recursive: true });
console.log("LPSP sync OK:", dst);
