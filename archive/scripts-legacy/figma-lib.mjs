/**
 * Helpers Figma REST API — lecture specs sans MCP (quota Starter).
 * Docs: https://www.figma.com/developers/api
 */

import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
export const GAME_ROOT = path.join(__dirname, "..");

export function envFilePath(name = ".env.local") {
  return path.join(GAME_ROOT, name);
}

/** Détecte .env.local.txt (piège Notepad Windows). */
export function diagnoseEnvFiles() {
  const local = envFilePath(".env.local");
  const parentLocal = path.join(GAME_ROOT, "..", ".env.local");
  const localTxt = envFilePath(".env.local.txt");
  const env = envFilePath(".env");
  return {
    gameRoot: GAME_ROOT,
    expected: local,
    parentEnv: parentLocal,
    found:
      fs.existsSync(local) ||
      fs.existsSync(env) ||
      fs.existsSync(parentLocal) ||
      fs.existsSync(path.join(GAME_ROOT, "..", ".env")),
    wrongNameTxt: !fs.existsSync(local) && fs.existsSync(localTxt),
    wrongNameTxtPath: localTxt,
  };
}

export function loadEnv() {
  const dirs = [GAME_ROOT, path.join(GAME_ROOT, "..")];
  const seen = new Set();
  for (const dir of dirs) {
    for (const name of [".env.local", ".env"]) {
      const file = path.join(dir, name);
      if (seen.has(file) || !fs.existsSync(file)) continue;
      seen.add(file);
      for (const line of fs.readFileSync(file, "utf8").split(/\r?\n/)) {
        const trimmed = line.trim();
        if (!trimmed || trimmed.startsWith("#")) continue;
        const eq = trimmed.indexOf("=");
        if (eq <= 0) continue;
        const key = trimmed.slice(0, eq).trim();
        let val = trimmed.slice(eq + 1).trim();
        if (
          (val.startsWith('"') && val.endsWith('"')) ||
          (val.startsWith("'") && val.endsWith("'"))
        ) {
          val = val.slice(1, -1);
        }
        if (process.env[key] == null) process.env[key] = val;
      }
    }
  }
}

export function readUiKit() {
  const file = path.join(GAME_ROOT, "src", "lib", "figma", "uiKit.json");
  return JSON.parse(fs.readFileSync(file, "utf8"));
}

export async function figmaFetch(apiPath, token, attempt = 0) {
  const res = await fetch(`https://api.figma.com/v1${apiPath}`, {
    headers: { "X-Figma-Token": token },
  });
  const text = await res.text();
  if (res.status === 429 && attempt < 3) {
    const wait = 15 * (attempt + 1);
    await new Promise((r) => setTimeout(r, wait * 1000));
    return figmaFetch(apiPath, token, attempt + 1);
  }
  if (!res.ok) {
    let detail = text;
    try {
      const json = JSON.parse(text);
      detail = json.err || json.message || text;
    } catch {
      /* raw text */
    }
    throw new Error(`Figma API ${res.status}: ${detail}`);
  }
  return JSON.parse(text);
}

export function encodeNodeId(nodeId) {
  return encodeURIComponent(nodeId);
}

/** Trouve un composant par clé ou nom dans la map `components` du fichier. */
export function findComponent(components, { key, nameIncludes }) {
  if (!components) return null;
  for (const [nodeId, meta] of Object.entries(components)) {
    if (key && meta.key === key) return { nodeId, meta };
    if (nameIncludes && meta.name?.includes(nameIncludes)) return { nodeId, meta };
  }
  return null;
}

export function rgba(color, opacity = 1) {
  if (!color) return null;
  const a = color.a ?? opacity;
  const r = Math.round((color.r ?? 0) * 255);
  const g = Math.round((color.g ?? 0) * 255);
  const b = Math.round((color.b ?? 0) * 255);
  return `rgba(${r}, ${g}, ${b}, ${Number(a.toFixed(3))})`;
}

export function px(n) {
  if (n == null || Number.isNaN(n)) return null;
  return `${Math.round(n * 10) / 10}px`;
}

export function extractFill(node) {
  const fills = node.fills?.filter((f) => f.visible !== false) ?? [];
  const solid = fills.find((f) => f.type === "SOLID");
  if (solid) return { type: "solid", color: rgba(solid.color, solid.opacity ?? 1) };
  const grad = fills.find((f) => f.type?.includes("GRADIENT"));
  if (grad) return { type: grad.type, stops: grad.gradientStops, opacity: grad.opacity };
  return null;
}

export function extractTypography(node) {
  const s = node.style;
  if (!s) return null;
  return {
    fontFamily: s.fontFamily,
    fontSize: px(s.fontSize),
    fontWeight: s.fontWeight,
    letterSpacing: s.letterSpacing != null ? px(s.letterSpacing) : null,
    lineHeight: s.lineHeightPx != null ? px(s.lineHeightPx) : null,
    textAlign: s.textAlignHorizontal?.toLowerCase(),
  };
}

export function extractEffects(node) {
  return (node.effects ?? [])
    .filter((e) => e.visible !== false)
    .map((e) => ({
      type: e.type,
      radius: e.radius != null ? px(e.radius) : null,
      color: e.color ? rgba(e.color) : null,
      offset: e.offset ? { x: px(e.offset.x), y: px(e.offset.y) } : null,
    }));
}

export function relBox(node, rootBox) {
  const b = node.absoluteBoundingBox;
  if (!b || !rootBox) return null;
  return {
    x: Math.round((b.x - rootBox.x) * 10) / 10,
    y: Math.round((b.y - rootBox.y) * 10) / 10,
    width: Math.round(b.width * 10) / 10,
    height: Math.round(b.height * 10) / 10,
  };
}

const ROLE_PATTERNS = [
  { role: "time", re: /\b9:41\b|clock|horloge/i },
  { role: "date", re: /widget - inline|^\w{3}\s+\d/i },
  { role: "flashlight", re: /^leading$|flash|torch|lampe/i },
  { role: "camera", re: /^trailing$|camera|photo|appareil/i },
  { role: "homeIndicator", re: /home indicator|indicateur/i },
  { role: "statusBar", re: /status bar|barre d.?état/i },
  { role: "wallpaper", re: /^wallpaper$|fond/i },
  { role: "notification", re: /notif|notification|stack/i },
  { role: "controls", re: /^controls$/i },
  { role: "glass", re: /glass effect|clear glass/i },
];

export function inferRole(name) {
  if (!name) return "unknown";
  for (const { role, re } of ROLE_PATTERNS) {
    if (re.test(name)) return role;
  }
  return "unknown";
}

export function parseNodeTree(node, rootBox, depth = 0) {
  if (!node || node.visible === false) return null;

  const box = relBox(node, rootBox);
  const parsed = {
    id: node.id,
    name: node.name,
    type: node.type,
    role: inferRole(node.name),
    box,
    cornerRadius: node.cornerRadius != null ? px(node.cornerRadius) : null,
    layout: node.layoutMode
      ? {
          mode: node.layoutMode,
          gap: node.itemSpacing != null ? px(node.itemSpacing) : null,
          padding: {
            top: px(node.paddingTop ?? 0),
            right: px(node.paddingRight ?? 0),
            bottom: px(node.paddingBottom ?? 0),
            left: px(node.paddingLeft ?? 0),
          },
        }
      : null,
    fill: extractFill(node),
    typography: node.type === "TEXT" ? extractTypography(node) : null,
    characters: node.type === "TEXT" ? node.characters : undefined,
    effects: extractEffects(node),
    opacity: node.opacity,
    children: [],
  };

  for (const child of node.children ?? []) {
    const c = parseNodeTree(child, rootBox, depth + 1);
    if (c) parsed.children.push(c);
  }

  return parsed;
}

/** Aplatit l'arbre pour recherche rapide par rôle. */
export function flattenByRole(node, acc = {}) {
  if (!node) return acc;
  if (node.role && node.role !== "unknown") {
    acc[node.role] ??= [];
    acc[node.role].push(node);
  }
  for (const c of node.children ?? []) flattenByRole(c, acc);
  return acc;
}

/** Parcourt l'arbre parsé (export JSON). */
export function walkParsedTree(node, fn) {
  if (!node) return;
  fn(node);
  for (const child of node.children ?? []) walkParsedTree(child, fn);
}

export function findParsedNodes(node, predicate) {
  const out = [];
  walkParsedTree(node, (n) => {
    if (predicate(n)) out.push(n);
  });
  return out;
}

function scaledPx(value, scale) {
  if (value == null || Number.isNaN(value)) return null;
  return px(value * scale);
}

/** Dérive des tokens CSS depuis l'arbre Figma → base logique 393×852. */
export function deriveTokens(tree, byRole, logicalW = 393) {
  const frameW = tree.box?.width ?? logicalW;
  const frameH = tree.box?.height ?? 852;
  const scale = logicalW / frameW;
  const tokens = {};

  const status = byRole.statusBar?.[0];
  const statusH = status?.box?.height ?? 62;

  const dateTexts = findParsedNodes(
    tree,
    (n) =>
      n.type === "TEXT" &&
      (n.name?.includes("Widget - Inline") ||
        n.typography?.fontSize === "22px" ||
        /^(Mon|Tue|Wed|Thu|Fri|Sat|Sun|Apr|Jan|Feb|Mar|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)/i.test(
          n.characters ?? "",
        )),
  );
  const date = dateTexts[0];

  const timeBlocks = findParsedNodes(tree, (n) => /^9:41/i.test(n.name ?? ""));
  const time = timeBlocks.sort((a, b) => (b.box?.height ?? 0) - (a.box?.height ?? 0))[0];

  const leading = findParsedNodes(tree, (n) => n.name === "Leading")[0];
  const trailing = findParsedNodes(tree, (n) => n.name === "Trailing")[0];
  const glass = findParsedNodes(
    tree,
    (n) => n.name === "Glass Effect" && n.parentName === "Leading",
  )[0];

  const homeBar = (byRole.homeIndicator ?? []).find((n) => n.box?.height <= 8);

  if (date?.box) {
    tokens["--ios-lock-date-size"] = date.typography?.fontSize ?? scaledPx(22, scale);
    tokens["--ios-lock-date-weight"] = String(date.typography?.fontWeight ?? 590);
    tokens["--ios-lock-date-tracking"] = date.typography?.letterSpacing ?? "-0.2px";
    tokens["--ios-lock-clock-top"] = scaledPx(Math.max(0, date.box.y - statusH), scale);
  }

  if (time?.box) {
    const timeSize = time.box.height ?? 87;
    tokens["--ios-lock-time-size"] = scaledPx(timeSize, scale);
    tokens["--ios-lock-time-weight"] = "200";
    tokens["--ios-lock-time-lh"] = "0.9";
    tokens["--ios-lock-time-tracking"] = "-0.04em";
    if (!date) {
      tokens["--ios-lock-clock-top"] = scaledPx(Math.max(0, time.box.y - statusH), scale);
    }
  }

  if (date?.box && time?.box) {
    tokens["--ios-lock-clock-gap"] = scaledPx(
      time.box.y - (date.box.y + date.box.height),
      scale,
    );
  }

  const shortcut = leading ?? trailing;
  if (shortcut?.box) {
    tokens["--ios-lock-shortcut-size"] = scaledPx(
      Math.max(shortcut.box.width, shortcut.box.height),
      scale,
    );
    tokens["--ios-lock-shortcut-inset"] = scaledPx(shortcut.box.x, scale);
  }

  const glassNode =
    glass ??
    findParsedNodes(
      tree,
      (n) => n.name === "Glass Effect" && (n.box?.width ?? 0) >= 50,
    )[0];
  if (glassNode?.effects?.length) {
    const shadow = glassNode.effects.find((e) => e.type === "DROP_SHADOW");
    if (shadow) {
      tokens["--ios-glass-shadow"] = `${shadow.offset?.x ?? "0px"} ${shadow.offset?.y ?? "8px"} ${shadow.radius ?? "40px"} ${shadow.color ?? "rgba(0,0,0,0.2)"}`;
    }
    if (glassNode.effects.some((e) => e.type === "GLASS")) {
      tokens["--ios-glass-blur"] = "saturate(180%) blur(24px)";
      tokens["--ios-glass-fill"] = "rgba(255, 255, 255, 0.12)";
      tokens["--ios-glass-border"] = "rgba(255, 255, 255, 0.28)";
    }
  }

  if (homeBar?.box) {
    tokens["--ios-home-indicator-w"] = scaledPx(homeBar.box.width, scale);
    tokens["--ios-home-indicator-h"] = scaledPx(homeBar.box.height, scale);
    tokens["--ios-home-indicator-bottom"] = scaledPx(
      frameH - homeBar.box.y - homeBar.box.height,
      scale,
    );
  }

  if (status?.box) {
    tokens["--ios-status-h"] = scaledPx(statusH, scale);
  }

  tokens["--ios-screen-w"] = px(logicalW);
  tokens["--ios-screen-h"] = px(Math.round(frameH * scale));
  tokens["--ios-frame-width"] = px(frameW);
  tokens["--ios-frame-height"] = px(frameH);
  tokens["--ios-figma-scale"] = String(Math.round(scale * 1000) / 1000);

  return tokens;
}

/** Tokens accueil — icônes, dock, recherche. */
export function deriveHomeTokens(tree, baseTokens = {}, logicalW = 393) {
  const frameW = tree.box?.width ?? logicalW;
  const scale = logicalW / frameW;
  const tokens = { ...baseTokens };

  const icon = findParsedNodes(
    tree,
    (n) => n.name === "Icon" && (n.box?.width ?? 0) >= 56 && (n.box?.width ?? 0) <= 72,
  )[0];
  const appIcons = findParsedNodes(tree, (n) => n.name === "App Icons")[0];
  const dock = findParsedNodes(
    tree,
    (n) => n.name === "Dock" && (n.box?.height ?? 0) >= 80,
  )[0];
  const search = findParsedNodes(
    tree,
    (n) => n.name === "Search" && n.type === "INSTANCE",
  )[0];

  if (icon?.box) {
    tokens["--ios-icon-size"] = scaledPx(icon.box.width, scale);
  }
  if (appIcons?.layout?.padding?.left) {
    tokens["--ios-grid-pad-x"] = appIcons.layout.padding.left;
  }
  if (appIcons?.layout?.gap) {
    tokens["--ios-grid-gap-x"] = appIcons.layout.gap;
  }
  if (appIcons?.box) {
    const statusH = parseFloat(tokens["--ios-status-h"] ?? "60") || 60;
    tokens["--ios-home-grid-top"] = scaledPx(Math.max(0, appIcons.box.y - statusH), scale);
  }
  if (dock?.box) {
    tokens["--ios-dock-height"] = scaledPx(dock.box.height, scale);
    tokens["--ios-dock-radius"] = dock.cornerRadius ?? "32px";
  }
  const dockGlass = findParsedNodes(
    tree,
    (n) => n.name === "Blur" && (n.box?.width ?? 0) > 300,
  )[0];
  const dockFrame = findParsedNodes(
    tree,
    (n) => n.name === "Dock" && n.type === "FRAME" && (n.box?.width ?? 0) > 300,
  )[0];
  if (dockFrame?.layout?.gap) tokens["--ios-dock-gap"] = dockFrame.layout.gap;
  if (dockGlass?.box) {
    tokens["--ios-dock-glass-h"] = scaledPx(dockGlass.box.height, scale);
    tokens["--ios-dock-radius"] = "38px";
  }
  const appIconRows = findParsedNodes(tree, (n) => n.name === "App Icon")
    .map((n) => n.box?.y ?? 0)
    .filter((y) => y > 0);
  const uniqRows = [...new Set(appIconRows.map((y) => Math.round(y)))].sort((a, b) => a - b);
  if (uniqRows.length >= 2) {
    tokens["--ios-grid-gap-y"] = scaledPx(uniqRows[1] - uniqRows[0] - 83, scale);
  }
  if (search?.box) {
    tokens["--ios-home-search-bottom"] = scaledPx(
      (tree.box?.height ?? 874) - search.box.y - search.box.height,
      scale,
    );
  }
  const searchPill = findParsedNodes(
    tree,
    (n) =>
      n.role === "glass" &&
      (n.box?.width ?? 0) >= 60 &&
      (n.box?.width ?? 0) <= 120 &&
      (n.box?.y ?? 0) > 650,
  )[0];
  if (searchPill?.box) {
    tokens["--ios-home-search-h"] = scaledPx(searchPill.box.height, scale);
    tokens["--ios-home-search-radius"] = searchPill.cornerRadius ?? "38px";
    tokens["--ios-home-search-min-w"] = scaledPx(searchPill.box.width, scale);
  }
  const searchIcon = findParsedNodes(
    tree,
    (n) => n.type === "TEXT" && n.characters?.includes("􀊫"),
  )[0];
  if (searchIcon?.typography?.fontSize) {
    tokens["--ios-home-search-font-size"] = searchIcon.typography.fontSize;
  }

  return tokens;
}

/** Tokens clavier PIN — depuis l'arbre Figma. */
export function derivePinTokens(tree, baseTokens = {}, logicalW = 393) {
  const frameW = tree.box?.width ?? logicalW;
  const scale = logicalW / frameW;
  const tokens = { ...baseTokens };

  const title = findParsedNodes(
    tree,
    (n) =>
      n.type === "TEXT" &&
      (/entrez|enter passcode|enter code/i.test(n.characters ?? "") ||
        /title|heading/i.test(n.name ?? "")),
  )[0];
  const key = findParsedNodes(
    tree,
    (n) =>
      (n.name === "Key" || n.name === "Button") &&
      (n.box?.width ?? 0) >= 60 &&
      (n.box?.width ?? 0) <= 90,
  )[0];
  const dots = findParsedNodes(tree, (n) => /dot|indicator|passcode field/i.test(n.name ?? ""))[0];
  const num = findParsedNodes(
    tree,
    (n) => n.type === "TEXT" && /^[0-9]$/.test(n.characters ?? "") && n.typography?.fontSize,
  )[0];

  if (title?.typography) {
    tokens["--ios-pin-title-size"] = title.typography.fontSize ?? scaledPx(22, scale);
    tokens["--ios-pin-title-weight"] = String(title.typography.fontWeight ?? 400);
  }
  if (key?.box) {
    tokens["--ios-pin-key-size"] = scaledPx(Math.max(key.box.width, key.box.height), scale);
  }
  if (num?.typography?.fontSize) {
    tokens["--ios-pin-num-size"] = num.typography.fontSize;
  }
  if (dots?.box) {
    tokens["--ios-pin-dot-size"] = scaledPx(Math.max(dots.box.width, dots.box.height), scale);
  }

  tokens["--ios-glass-blur"] = tokens["--ios-glass-blur"] ?? "saturate(180%) blur(24px)";
  tokens["--ios-glass-fill"] = tokens["--ios-glass-fill"] ?? "rgba(255, 255, 255, 0.12)";

  return tokens;
}

function collectNodesByName(node, nameIncludes, pathParts = [], out = []) {
  if (!node) return out;
  const parts = [...pathParts, node.name ?? ""];
  if (node.name?.includes(nameIncludes)) {
    out.push({ node, path: parts.join(" > ") });
  }
  for (const child of node.children ?? []) {
    collectNodesByName(child, nameIncludes, parts, out);
  }
  return out;
}

function pickBestFrameMatch(candidates, exactName) {
  if (!candidates.length) return null;
  let best = null;
  let bestScore = -Infinity;
  for (const { node, path } of candidates) {
    let score = 0;
    const box = node.absoluteBoundingBox;
    if (node.name === exactName) score += 100;
    if (box && box.width >= 350 && box.width <= 430 && box.height >= 700) score += 60;
    if (node.type === "COMPONENT" || node.type === "COMPONENT_SET") score += 25;
    if (/control center|widget|example/i.test(path)) score -= 35;
    if (score > bestScore) {
      bestScore = score;
      best = { node, path };
    }
  }
  return best;
}

/** Le kit Apple duplique des frames par page — pas toujours dans `components`. */
export async function searchFrameByName(
  token,
  fileKey,
  nameIncludes,
  pages = ["System", "Examples"],
  nameCandidates = [],
) {
  const file = await figmaFetch(`/files/${fileKey}?depth=1`, token);
  const targets = file.document.children.filter((p) => pages.includes(p.name));
  const names = [nameIncludes, ...nameCandidates].filter(Boolean);
  const all = [];

  for (const page of targets) {
    const nodes = await figmaFetch(
      `/files/${fileKey}/nodes?ids=${encodeNodeId(page.id)}`,
      token,
    );
    const doc = nodes.nodes?.[page.id]?.document;
    for (const name of names) {
      collectNodesByName(doc, name, [page.name], all);
    }
  }

  let best = null;
  for (const name of names) {
    best = pickBestFrameMatch(all, name);
    if (best) break;
  }
  if (!best && all.length) {
    best = pickBestFrameMatch(all, all[0].node.name);
  }
  if (!best) return null;

  return {
    fileKey,
    nodeId: best.node.id,
    meta: { key: null, name: best.node.name },
    document: best.node,
    searchPath: best.path,
  };
}

export async function resolveComponentNode(
  token,
  fileKeys,
  { componentKey, nameIncludes, nameCandidates = [], searchPages },
) {
  let lastErr;
  const uniqueKeys = [...new Set(fileKeys.filter(Boolean))];
  const pages = searchPages ?? ["System", "Examples"];

  for (const fileKey of uniqueKeys) {
    try {
      const shallow = await figmaFetch(`/files/${fileKey}?depth=1`, token);
      const hit = findComponent(shallow.components, { key: componentKey, nameIncludes });
      if (hit) {
        const nodes = await figmaFetch(
          `/files/${fileKey}/nodes?ids=${encodeNodeId(hit.nodeId)}`,
          token,
        );
        const doc = nodes.nodes?.[hit.nodeId]?.document;
        if (!doc) {
          lastErr = new Error(`Nœud ${hit.nodeId} sans document dans ${fileKey}`);
          continue;
        }
        return { fileKey, nodeId: hit.nodeId, meta: hit.meta, document: doc };
      }

      if (nameIncludes) {
        const searched = await searchFrameByName(
          token,
          fileKey,
          nameIncludes,
          pages,
          nameCandidates,
        );
        if (searched) return searched;
      }

      lastErr = new Error(`Composant introuvable dans ${fileKey}`);
    } catch (e) {
      lastErr = e;
    }
  }
  throw lastErr ?? new Error("Aucun fichier Figma accessible");
}

export async function exportPng(token, fileKey, nodeId, outPath, scale = 2) {
  const img = await figmaFetch(
    `/images/${fileKey}?ids=${encodeNodeId(nodeId)}&format=png&scale=${scale}`,
    token,
  );
  const url = img.images?.[nodeId];
  if (!url) throw new Error("Export PNG Figma sans URL");
  const res = await fetch(url);
  if (!res.ok) throw new Error(`Téléchargement PNG ${res.status}`);
  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, Buffer.from(await res.arrayBuffer()));
  return outPath;
}
