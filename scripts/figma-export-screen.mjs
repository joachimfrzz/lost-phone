/**
 * Exporte un écran depuis le UI Kit Apple Figma → JSON + PNG de référence.
 *
 * Prérequis (game/.env.local) :
 *   FIGMA_ACCESS_TOKEN=...
 *   FIGMA_FILE_KEY=...   (fichier dupliqué iOS 26 dans vos brouillons)
 *
 * Usage:
 *   node scripts/figma-export-screen.mjs lock-screen
 *   npm run figma:export -- lock-screen
 */

import fs from "node:fs";
import path from "node:path";
import {
  GAME_ROOT,
  loadEnv,
  diagnoseEnvFiles,
  readUiKit,
  parseNodeTree,
  flattenByRole,
  deriveTokens,
  deriveHomeTokens,
  derivePinTokens,
  resolveComponentNode,
  exportPng,
  findParsedNodes,
} from "./figma-lib.mjs";

const SCREENS = {
  "lock-screen": {
    componentKeyField: "lockScreenIphone",
    nameIncludes: "Lock Screen - iPhone",
    outJson: "src/lib/figma/screens/lock-screen.json",
    outPng: "public/figma/reference/lock-screen.png",
    publicPath: "/figma/reference/lock-screen.png",
    exportWallpaper: true,
  },
  "home-screen": {
    componentKeyField: "homeScreenIphone",
    nameIncludes: "Home Screen - iPhone",
    outJson: "src/lib/figma/screens/home-screen.json",
    outPng: "public/figma/reference/home-screen.png",
    publicPath: "/figma/reference/home-screen.png",
  },
  "pin-screen": {
    nameIncludes: "Enter Passcode - iPhone",
    nameAlternatives: ["Passcode - iPhone", "Enter Passcode", "Numeric Passcode - iPhone"],
    searchPages: ["System", "Face ID", "Examples"],
    outJson: "src/lib/figma/screens/pin-screen.json",
    outPng: "public/figma/reference/pin-screen.png",
    publicPath: "/figma/reference/pin-screen.png",
  },
  "control-center": {
    nameIncludes: "Control Center - iPhone",
    outJson: "src/lib/figma/screens/control-center.json",
    outPng: "public/figma/reference/control-center.png",
    publicPath: "/figma/reference/control-center.png",
  },
  "notification-center": {
    nameIncludes: "Notification Center - iPhone",
    outJson: "src/lib/figma/screens/notification-center.json",
    outPng: "public/figma/reference/notification-center.png",
    publicPath: "/figma/reference/notification-center.png",
  },
};

function usage() {
  console.log(`
Export Figma → specs Lost Phone

  npm run figma:export -- lock-screen

Écrans: ${Object.keys(SCREENS).join(", ")}

Configurez game/.env.local :
  FIGMA_ACCESS_TOKEN=...
  FIGMA_FILE_KEY=clé_du_fichier_dupliqué

Dupliquez le kit officiel :
  https://www.figma.com/community/file/1527721578857867021/ios-and-ipados-26
`);
}

async function main() {
  loadEnv();
  const screenId = process.argv[2] ?? "lock-screen";
  const cfg = SCREENS[screenId];
  if (!cfg) {
    usage();
    process.exit(1);
  }

  const token = process.env.FIGMA_ACCESS_TOKEN;
  if (!token) {
    const diag = diagnoseEnvFiles();
    console.error(`
❌ FIGMA_ACCESS_TOKEN manquant.

Le script cherche le fichier ici (dossier game, pas LOST PHONE parent) :
  ${diag.expected}

Contenu attendu (2 lignes, sans guillemets) :
  FIGMA_ACCESS_TOKEN=figd_...
  FIGMA_FILE_KEY=clé_copiée_depuis_l_url_figma

${diag.wrongNameTxt ? `⚠ Fichier détecté avec mauvais nom Windows :\n  ${diag.wrongNameTxtPath}\n  Renommez-le en .env.local (sans .txt)\n` : ""}Commandes de test (PowerShell, depuis le dossier game) :
  cd "${GAME_ROOT}"
  npm run figma:export -- ${screenId}

  — ou —
  node scripts/figma-export-screen.mjs ${screenId}
`);
    process.exit(1);
  }

  const uiKit = readUiKit();
  const fileKeys = process.env.FIGMA_TRY_ALL_FILES === "1"
    ? [
        process.env.FIGMA_FILE_KEY,
        uiKit.fileKey,
        uiKit.libraryFileKeys?.ios26,
        uiKit.libraryFileKeys?.ios27,
      ].filter(Boolean)
    : [process.env.FIGMA_FILE_KEY].filter(Boolean);

  const nameCandidates = cfg.nameIncludes
    ? [cfg.nameIncludes, ...(cfg.nameAlternatives ?? [])]
    : [];

  const componentKey = cfg.componentKeyField
    ? uiKit.components?.[cfg.componentKeyField]
    : undefined;
  console.log(`→ Export ${screenId} (${cfg.nameIncludes})`);
  console.log(`  Fichiers testés : ${fileKeys.join(", ")}`);

  const resolved = await resolveComponentNode(token, [...new Set(fileKeys)], {
    componentKey,
    nameIncludes: cfg.nameIncludes,
    nameCandidates,
    searchPages: cfg.searchPages,
  });

  console.log(`  ✓ Trouvé dans ${resolved.fileKey} — ${resolved.meta.name} (${resolved.nodeId})`);

  const rootBox = resolved.document.absoluteBoundingBox;
  const tree = parseNodeTree(resolved.document, rootBox);
  const byRole = flattenByRole(tree);
  let tokens = deriveTokens(tree, byRole);
  if (screenId === "home-screen") tokens = deriveHomeTokens(tree, tokens);
  if (screenId === "pin-screen") tokens = derivePinTokens(tree, tokens);

  const pngAbs = path.join(GAME_ROOT, cfg.outPng);
  await exportPng(token, resolved.fileKey, resolved.nodeId, pngAbs, 2);
  console.log(`  ✓ PNG → ${cfg.outPng}`);

  let assets = {};
  if (cfg.exportWallpaper) {
    const wp = findParsedNodes(tree, (n) => n.name === "Wallpaper" && n.id)[0];
    if (wp?.id) {
      const wpOut = path.join(GAME_ROOT, "public/figma/assets/wallpaper-lock.png");
      await exportPng(token, resolved.fileKey, wp.id, wpOut, 2);
      assets.wallpaper = "/figma/assets/wallpaper-lock.png";
      assets.wallpaperNodeId = wp.id;
      console.log(`  ✓ Wallpaper → public/figma/assets/wallpaper-lock.png`);
    }
  }

  const leading = findParsedNodes(tree, (n) => n.name === "Leading")[0];
  const trailing = findParsedNodes(tree, (n) => n.name === "Trailing")[0];
  const sym = (root) =>
    root
      ? findParsedNodes(root, (n) => n.name === "Symbol" && n.characters)[0]?.characters
      : undefined;
  const symbols =
    screenId === "lock-screen"
      ? { flashlight: sym(leading), camera: sym(trailing) }
      : undefined;

  const payload = {
    screen: screenId,
    source: {
      fileKey: resolved.fileKey,
      nodeId: resolved.nodeId,
      componentKey: resolved.meta.key ?? null,
      name: resolved.meta.name,
      exportedAt: new Date().toISOString(),
      searchPath: resolved.searchPath,
    },
    frame: {
      width: rootBox?.width,
      height: rootBox?.height,
    },
    referenceImage: cfg.publicPath,
    tokens,
    symbols,
    assets: Object.keys(assets).length ? assets : undefined,
    roles: Object.fromEntries(
      Object.entries(byRole).map(([role, nodes]) => [
        role,
        nodes.map((n) => ({
          name: n.name,
          box: n.box,
          typography: n.typography,
          fill: n.fill,
          cornerRadius: n.cornerRadius,
          effects: n.effects,
        })),
      ]),
    ),
    tree,
  };

  const jsonAbs = path.join(GAME_ROOT, cfg.outJson);
  fs.mkdirSync(path.dirname(jsonAbs), { recursive: true });
  fs.writeFileSync(jsonAbs, JSON.stringify(payload, null, 2));
  console.log(`  ✓ Specs → ${cfg.outJson}`);
  console.log(`  Tokens : ${Object.keys(tokens).join(", ")}`);
  console.log(`
Prochaine étape : npm run figma:apply -- ${screenId}
Puis validez sur /simulator
`);
}

main().catch((err) => {
  console.error(`\n❌ ${err.message}`);
  if (String(err.message).includes("403") || String(err.message).includes("404")) {
    console.error(`
→ Vérifiez que le kit iOS 26 est dupliqué dans VOS brouillons Figma
  (pas seulement la page Cover iOS 27).
→ Le token doit appartenir au même compte que la copie.
`);
  }
  process.exit(1);
});
