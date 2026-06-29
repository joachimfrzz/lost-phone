/**
 * Copie une image existante vers le fond d'écran de calibration.
 * Usage: node scripts/bootstrap-wallpaper.mjs [source.png]
 * Défaut: public/captures-ios/system/lock-vide/screen.png
 */

import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.join(__dirname, "..");
const OUT_DIR = path.join(ROOT, "public", "assets", "wallpapers");
const DEFAULT_SRC = path.join(ROOT, "public", "captures-ios", "system", "lock-vide", "screen.png");

const src = process.argv[2] ? path.resolve(process.argv[2]) : DEFAULT_SRC;
if (!fs.existsSync(src)) {
  console.error(`Source introuvable: ${src}`);
  process.exit(1);
}

const ext = path.extname(src).toLowerCase().replace(".", "") || "png";
const outName = `calibration-lock.${ext === "jpeg" ? "jpg" : ext}`;
const dest = path.join(OUT_DIR, outName);
const rel = `/assets/wallpapers/${outName}`;

fs.mkdirSync(OUT_DIR, { recursive: true });
fs.copyFileSync(src, dest);
fs.writeFileSync(path.join(OUT_DIR, "active.source"), rel);

console.log(`\n✓ Fond d'écran → ${dest}`);
console.log(`  ${fs.statSync(dest).size} octets`);
console.log(`  active.source → ${rel}\n`);
