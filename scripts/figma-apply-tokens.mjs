/**
 * Applique les tokens exportés depuis Figma dans tokens.css + reference-calibration.css
 *
 * Usage: npm run figma:apply -- lock-screen
 */

import fs from "node:fs";
import path from "node:path";
import { GAME_ROOT } from "./figma-lib.mjs";

const MAP = {
  "lock-screen": {
    json: "src/lib/figma/screens/lock-screen.json",
    targets: ["src/ios/tokens.css", "src/ios/reference-calibration.css", "src/ios/hig.css"],
  },
  "home-screen": {
    json: "src/lib/figma/screens/home-screen.json",
    targets: ["src/ios/tokens.css", "src/ios/hig.css"],
  },
  "pin-screen": {
    json: "src/lib/figma/screens/pin-screen.json",
    targets: ["src/ios/tokens.css", "src/ios/hig.css"],
  },
};

function upsertVars(css, tokens, marker) {
  const block = Object.entries(tokens)
    .map(([k, v]) => `  ${k}: ${v};`)
    .join("\n");

  const start = `/* ${marker} — auto Figma */`;
  const end = `/* /${marker} */`;
  const inner = `${start}\n${block}\n${end}`;

  if (css.includes(start)) {
    const re = new RegExp(`${escapeRe(start)}[\\s\\S]*?${escapeRe(end)}`, "m");
    return css.replace(re, inner);
  }

  const rootIdx = css.indexOf(":root");
  if (rootIdx === -1) return `${css}\n\n:root {\n${inner}\n}\n`;

  const brace = css.indexOf("{", rootIdx);
  return `${css.slice(0, brace + 1)}\n${inner}\n${css.slice(brace + 1)}`;
}

function escapeRe(s) {
  return s.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}

function main() {
  const screenId = process.argv[2] ?? "lock-screen";
  const cfg = MAP[screenId];
  if (!cfg) {
    console.error(`Écran inconnu: ${screenId}`);
    process.exit(1);
  }

  const jsonPath = path.join(GAME_ROOT, cfg.json);
  if (!fs.existsSync(jsonPath)) {
    console.error(`❌ ${cfg.json} introuvable — lancez d'abord npm run figma:export -- ${screenId}`);
    process.exit(1);
  }

  const { tokens, source } = JSON.parse(fs.readFileSync(jsonPath, "utf8"));
  if (!tokens || !Object.keys(tokens).length) {
    console.error("❌ Aucun token dans le JSON exporté");
    process.exit(1);
  }

  const marker = `figma-${screenId}`;
  for (const rel of cfg.targets) {
    const file = path.join(GAME_ROOT, rel);
    if (!fs.existsSync(file)) continue;
    const next = upsertVars(fs.readFileSync(file, "utf8"), tokens, marker);
    fs.writeFileSync(file, next);
    console.log(`  ✓ ${rel}`);
  }

  console.log(`\n✓ ${Object.keys(tokens).length} tokens appliqués depuis ${source.name}`);
}

main();
