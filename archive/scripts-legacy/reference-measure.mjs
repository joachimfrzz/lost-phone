/**
 * Mesure les captures iOS de référence → specs logiques (@1x, base 393×852)
 * Usage: node scripts/reference-measure.mjs
 */

import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { PNG } from "pngjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.join(__dirname, "..", "public", "captures-ios");
const OUT = path.join(__dirname, "..", "src", "lib", "reference", "measured.json");

const LOGICAL_W = 393;
const LOGICAL_H = 852;

const SCREENS = [
  { id: "system.lock-vide", path: "system/lock-vide/screen.png" },
  { id: "system.lock-notifs", path: "system/lock-notifs/screen.png" },
  { id: "system.pin", path: "system/pin/screen.png" },
  { id: "system.home-p1", path: "system/home-p1/screen.png" },
  { id: "system.home-p2", path: "system/home-p2/screen.png" },
  { id: "system.control-center", path: "system/control-center/screen.png" },
  { id: "system.notification-center", path: "system/notification-center/screen.png" },
  { id: "app.messages.liste", path: "apps/messages/liste/screen.png" },
];

function luma(r, g, b) {
  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
}

/** Certaines captures iOS ont des octets après IEND — on tronque au PNG valide. */
function trimPngBuffer(buf) {
  const iend = Buffer.from("IEND");
  let idx = buf.indexOf(iend);
  while (idx !== -1) {
    const end = idx + 8;
    if (end <= buf.length) {
      try {
        PNG.sync.read(buf.subarray(0, end));
        return buf.subarray(0, end);
      } catch {
        /* chercher un autre IEND */
      }
    }
    idx = buf.indexOf(iend, idx + 1);
  }
  return buf;
}

function analyze(filePath) {
  if (!fs.existsSync(filePath)) return null;
  try {
    const buf = trimPngBuffer(fs.readFileSync(filePath));
    const { width, height, data } = PNG.sync.read(buf);
  const scaleX = width / LOGICAL_W;
  const scaleY = height / LOGICAL_H;

  // Zone horloge verrou (~8–28% hauteur, centre)
  const clockY0 = Math.floor(0.08 * height);
  const clockY1 = Math.floor(0.28 * height);
  const clockX0 = Math.floor(0.15 * width);
  const clockX1 = Math.floor(0.85 * width);
  let clockBright = 0;
  let clockN = 0;
  for (let y = clockY0; y < clockY1; y++) {
    for (let x = clockX0; x < clockX1; x++) {
      const i = (width * y + x) * 4;
      clockBright += luma(data[i], data[i + 1], data[i + 2]);
      clockN++;
    }
  }

  // Barre d'état (~0–6% hauteur)
  const statusY1 = Math.floor(0.065 * height);
  let statusAvg = 0;
  let statusN = 0;
  for (let y = 0; y < statusY1; y++) {
    for (let x = 0; x < width; x++) {
      const i = (width * y + x) * 4;
      statusAvg += luma(data[i], data[i + 1], data[i + 2]);
      statusN++;
    }
  }

  // Dock (~88–98% hauteur)
  const dockY0 = Math.floor(0.86 * height);
  let dockBlur = 0;
  let dockN = 0;
  for (let y = dockY0; y < height; y++) {
    for (let x = Math.floor(0.05 * width); x < Math.floor(0.95 * width); x++) {
      const i = (width * y + x) * 4;
      dockBlur += luma(data[i], data[i + 1], data[i + 2]);
      dockN++;
    }
  }

  return {
    pixelSize: { width, height },
    scale: { x: +scaleX.toFixed(3), y: +scaleY.toFixed(3) },
    logicalBase: { width: LOGICAL_W, height: LOGICAL_H },
    regions: {
      statusBar: { topPx: 0, heightLogical: +(statusY1 / scaleY).toFixed(1) },
      lockClock: {
        topLogical: +(clockY0 / scaleY).toFixed(1),
        heightLogical: +((clockY1 - clockY0) / scaleY).toFixed(1),
        avgLuma: +(clockBright / clockN).toFixed(1),
      },
      dock: {
        topLogical: +(dockY0 / scaleY).toFixed(1),
        avgLuma: +(dockBlur / dockN).toFixed(1),
      },
    },
  };
  } catch (e) {
    return { error: String(e.message ?? e), path: filePath };
  }
}

const result = {
  generatedAt: new Date().toISOString(),
  logicalBase: { width: LOGICAL_W, height: LOGICAL_H },
  screens: {},
};

for (const s of SCREENS) {
  const full = path.join(ROOT, s.path);
  const m = analyze(full);
  if (m) result.screens[s.id] = m;
  else result.screens[s.id] = { missing: true, path: s.path };
}

fs.mkdirSync(path.dirname(OUT), { recursive: true });
fs.writeFileSync(OUT, JSON.stringify(result, null, 2));
console.log(`\n✓ Specs → ${OUT}`);
console.log(`  ${Object.values(result.screens).filter((s) => !s.missing).length}/${SCREENS.length} captures mesurées\n`);
