/**
 * Re-dérive les tokens depuis un JSON Figma déjà exporté (sans rappeler l'API).
 * Usage: npm run figma:reprocess -- lock-screen
 */

import fs from "node:fs";
import path from "node:path";
import {
  GAME_ROOT,
  flattenByRole,
  deriveTokens,
  deriveHomeTokens,
  derivePinTokens,
  findParsedNodes,
} from "./figma-lib.mjs";

const MAP = {
  "lock-screen": "src/lib/figma/screens/lock-screen.json",
  "home-screen": "src/lib/figma/screens/home-screen.json",
  "pin-screen": "src/lib/figma/screens/pin-screen.json",
  "control-center": "src/lib/figma/screens/control-center.json",
  "notification-center": "src/lib/figma/screens/notification-center.json",
};

function extractSymbols(tree) {
  const leading = findParsedNodes(tree, (n) => n.name === "Leading")[0];
  const trailing = findParsedNodes(tree, (n) => n.name === "Trailing")[0];
  const sym = (root) =>
    findParsedNodes(root ?? tree, (n) => n.name === "Symbol" && n.characters)?.[0]
      ?.characters;

  return {
    flashlight: sym(leading),
    camera: sym(trailing),
  };
}

function main() {
  const screenId = process.argv[2] ?? "lock-screen";
  const rel = MAP[screenId];
  if (!rel) {
    console.error(`Écran inconnu: ${screenId}`);
    process.exit(1);
  }

  const file = path.join(GAME_ROOT, rel);
  if (!fs.existsSync(file)) {
    console.error(`❌ ${rel} introuvable`);
    process.exit(1);
  }

  const payload = JSON.parse(fs.readFileSync(file, "utf8"));
  const byRole = flattenByRole(payload.tree);
  let tokens = deriveTokens(payload.tree, byRole);
  if (screenId === "home-screen") tokens = deriveHomeTokens(payload.tree, tokens);
  if (screenId === "pin-screen") tokens = derivePinTokens(payload.tree, tokens);
  payload.tokens = tokens;

  if (screenId === "lock-screen") {
    payload.symbols = extractSymbols(payload.tree);
    const wp = findParsedNodes(payload.tree, (n) => n.name === "Wallpaper" && n.id)[0];
    if (wp?.id) payload.assets = { ...(payload.assets ?? {}), wallpaperNodeId: wp.id };
  }

  fs.writeFileSync(file, JSON.stringify(payload, null, 2));
  console.log(`✓ ${rel} — ${Object.keys(tokens).length} tokens`);
  if (payload.symbols) console.log("  Symboles:", payload.symbols);
  console.log("  ", Object.entries(tokens).map(([k, v]) => `${k}: ${v}`).join("\n   "));
}

main();
