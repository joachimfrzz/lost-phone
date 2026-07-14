/**
 * Devine le type d'écran iOS à partir des pixels (pas d'ordre de fichiers).
 * Dépose tout dans inbox/ → npm run captures:sort
 */

import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { PNG } from "pngjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.join(__dirname, "..", "public", "captures-ios");
const INBOX = path.join(ROOT, "inbox");

const TARGETS = {
  "system.lock-notifs": "system/lock-notifs",
  "system.lock-vide": "system/lock-vide",
  "system.pin": "system/pin",
  "system.home-p1": "system/home-p1",
  "system.home-p2": "system/home-p2",
  "system.notification-center": "system/notification-center",
  "system.control-center": "system/control-center",
  "app.messages.liste": "apps/messages/liste",
  "app.messages.conversation": "apps/messages/conversation",
  "app.whatsapp.liste": "apps/whatsapp/liste",
  "app.whatsapp.conversation": "apps/whatsapp/conversation",
  "app.signal.liste": "apps/signal/liste",
  "app.signal.conversation": "apps/signal/conversation",
  "app.photos.bibliotheque": "apps/photos/bibliotheque",
  "app.photos.albums": "apps/photos/albums",
  "app.photos.detail": "apps/photos/detail",
  "app.mail.inbox": "apps/mail/inbox",
  "app.mail.detail": "apps/mail/detail",
  "app.notes.liste": "apps/notes/liste",
  "app.notes.detail": "apps/notes/detail",
  "app.telephone.recents": "apps/telephone/recents",
  "app.contacts.liste": "apps/contacts/liste",
  "app.safari.accueil": "apps/safari/accueil",
  "app.calendrier.mois": "apps/calendrier/mois",
  "app.reglages.main": "apps/reglages/main",
  "app.fichiers.browser": "apps/fichiers/browser",
  "app.rappels.liste": "apps/rappels/liste",
  "app.maps.carte": "apps/maps/carte",
  "app.instagram.feed": "apps/instagram/feed",
  "app.instagram.dm": "apps/instagram/dm",
  "app.uber.accueil": "apps/uber/accueil",
  "app.credit-agricole.compte": "apps/credit-agricole/compte",
  "app.spotify.accueil": "apps/spotify/accueil",
  "app.netflix.profils": "apps/netflix/profils",
  "app.netflix.accueil": "apps/netflix/accueil",
};

const LABELS = {
  "system.lock-notifs": "Verrou + notifs",
  "system.lock-vide": "Verrou vide",
  "system.pin": "Code PIN",
  "system.home-p1": "Accueil p1",
  "system.home-p2": "Accueil p2",
  "system.notification-center": "Centre notifications",
  "system.control-center": "Centre de contrôle",
  "app.messages.liste": "Messages liste",
  "app.messages.conversation": "Messages conv.",
  "app.whatsapp.liste": "WhatsApp liste",
  "app.whatsapp.conversation": "WhatsApp conv.",
  "app.signal.liste": "Signal liste",
  "app.signal.conversation": "Signal conv.",
  "app.photos.bibliotheque": "Photos bib.",
  "app.photos.albums": "Photos albums",
  "app.photos.detail": "Photos détail",
  "app.mail.inbox": "Mail inbox",
  "app.mail.detail": "Mail message",
  "app.notes.liste": "Notes liste",
  "app.notes.detail": "Notes détail",
  "app.telephone.recents": "Téléphone",
  "app.contacts.liste": "Contacts",
  "app.safari.accueil": "Safari",
  "app.calendrier.mois": "Calendrier",
  "app.reglages.main": "Réglages",
  "app.fichiers.browser": "Fichiers",
  "app.rappels.liste": "Rappels",
  "app.maps.carte": "Plans",
  "app.instagram.feed": "Instagram fil",
  "app.instagram.dm": "Instagram DM",
  "app.uber.accueil": "Uber",
  "app.credit-agricole.compte": "Crédit Agricole",
  "app.spotify.accueil": "Spotify",
  "app.netflix.profils": "Netflix profils",
  "app.netflix.accueil": "Netflix",
};

function luma(r, g, b) {
  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
}

function sat(r, g, b) {
  const max = Math.max(r, g, b);
  const min = Math.min(r, g, b);
  return max === 0 ? 0 : (max - min) / max;
}

function regionStats(data, w, h, rx0, ry0, rx1, ry1) {
  const x0 = Math.floor(rx0 * w);
  const x1 = Math.floor(rx1 * w);
  const y0 = Math.floor(ry0 * h);
  const y1 = Math.floor(ry1 * h);
  let n = 0;
  let lSum = 0;
  let lMax = 0;
  let white = 0;
  let dark = 0;
  let color = 0;
  let blue = 0;
  let green = 0;
  let redPix = 0;

  for (let y = y0; y < y1; y++) {
    for (let x = x0; x < x1; x++) {
      const i = (w * y + x) * 4;
      const r = data[i];
      const g = data[i + 1];
      const b = data[i + 2];
      const l = luma(r, g, b);
      const s = sat(r, g, b);
      lSum += l;
      lMax = Math.max(lMax, l);
      if (l > 235) white++;
      if (l < 45) dark++;
      if (s > 0.25 && l > 40 && l < 230) color++;
      if (b > r + 25 && b > g + 10) blue++;
      if (g > r + 20 && g > b + 5) green++;
      if (r > g + 35 && r > b + 35 && l > 30 && l < 220) redPix++;
      n++;
    }
  }

  return {
    avgLuma: lSum / n,
    maxLuma: lMax,
    whiteRatio: white / n,
    darkRatio: dark / n,
    colorRatio: color / n,
    blueRatio: blue / n,
    greenRatio: green / n,
    redRatio: redPix / n,
  };
}

function analyzeImage(filePath) {
  const buf = fs.readFileSync(filePath);
  const { width, height, data } = PNG.sync.read(buf);

  const full = regionStats(data, width, height, 0, 0, 1, 1);
  const top = regionStats(data, width, height, 0, 0, 1, 0.12);
  const clock = regionStats(data, width, height, 0.1, 0.1, 0.9, 0.28);
  const mid = regionStats(data, width, height, 0.05, 0.35, 0.95, 0.72);
  const notifZone = regionStats(data, width, height, 0.08, 0.42, 0.92, 0.72);
  const bottom = regionStats(data, width, height, 0, 0.82, 1, 1);
  const dock = regionStats(data, width, height, 0.05, 0.78, 0.95, 0.92);
  const keypad = regionStats(data, width, height, 0.08, 0.52, 0.92, 0.88);
  const ccTop = regionStats(data, width, height, 0.05, 0.08, 0.95, 0.52);
  const chat = regionStats(data, width, height, 0.05, 0.45, 0.95, 0.88);
  const grid = regionStats(data, width, height, 0.05, 0.18, 0.95, 0.72);

  const scores = {};

  // Verrou vide — horloge lumineuse, pas blanc, peu de cartes milieu
  scores["system.lock-vide"] =
    (clock.maxLuma > 200 ? 0.35 : 0) +
    (clock.avgLuma > 140 ? 0.2 : 0) +
    (full.whiteRatio < 0.35 ? 0.2 : 0) +
    (notifZone.whiteRatio < 0.25 ? 0.15 : 0) +
    (full.colorRatio > 0.08 ? 0.1 : 0);

  // Verrou + notifs
  scores["system.lock-notifs"] =
    scores["system.lock-vide"] * 0.6 +
    (notifZone.avgLuma > 90 && notifZone.avgLuma < 220 ? 0.25 : 0) +
    (notifZone.whiteRatio > 0.08 && notifZone.whiteRatio < 0.45 ? 0.2 : 0);

  // PIN — fond sombre/flou, clavier bas
  scores["system.pin"] =
    (keypad.avgLuma > 50 && keypad.avgLuma < 160 ? 0.25 : 0) +
    (keypad.colorRatio < 0.15 ? 0.15 : 0) +
    (full.avgLuma < 120 ? 0.2 : 0) +
    (clock.maxLuma < 220 ? 0.15 : 0) +
    (keypad.whiteRatio > 0.02 && keypad.whiteRatio < 0.2 ? 0.25 : 0);

  // Accueil — dock coloré, grille d'icônes
  scores["system.home-p1"] =
    (dock.colorRatio > 0.12 ? 0.3 : 0) +
    (grid.colorRatio > 0.15 ? 0.35 : 0) +
    (full.whiteRatio < 0.5 ? 0.15 : 0) +
    (bottom.colorRatio > 0.1 ? 0.2 : 0);

  scores["system.home-p2"] = scores["system.home-p1"] * 0.92;

  // Centre de contrôle — bandeau sombre riche en modules en haut
  scores["system.control-center"] =
    (ccTop.avgLuma > 35 && ccTop.avgLuma < 120 ? 0.35 : 0) +
    (ccTop.colorRatio > 0.06 ? 0.25 : 0) +
    (full.avgLuma < 140 ? 0.15 : 0) +
    (ccTop.darkRatio > 0.2 ? 0.25 : 0);

  // Centre notifications — cartes sous barre de statut, pas horloge géante
  scores["system.notification-center"] =
    (top.whiteRatio > 0.05 ? 0.1 : 0) +
    (mid.whiteRatio > 0.1 && mid.whiteRatio < 0.5 ? 0.3 : 0) +
    (clock.maxLuma < 220 ? 0.2 : 0) +
    (full.colorRatio > 0.05 ? 0.15 : 0) +
    (ccTop.avgLuma > 60 ? 0.1 : 0);

  // Messages liste — très blanc
  scores["app.messages.liste"] =
    (full.whiteRatio > 0.55 ? 0.45 : 0) +
    (mid.whiteRatio > 0.6 ? 0.35 : 0) +
    (chat.blueRatio < 0.08 ? 0.1 : 0) +
    (grid.colorRatio < 0.12 ? 0.1 : 0);

  // Messages conversation — blanc + bulles bleues
  scores["app.messages.conversation"] =
    (full.whiteRatio > 0.45 ? 0.25 : 0) +
    (chat.blueRatio > 0.04 ? 0.4 : 0) +
    (chat.avgLuma > 180 ? 0.15 : 0) +
    (mid.whiteRatio > 0.4 ? 0.2 : 0);

  // WhatsApp — vert en header
  scores["app.whatsapp.liste"] =
    (full.whiteRatio > 0.5 ? 0.35 : 0) +
    (top.greenRatio > 0.08 ? 0.35 : 0) +
    (chat.blueRatio < 0.05 ? 0.1 : 0);

  scores["app.whatsapp.conversation"] =
    scores["app.whatsapp.liste"] * 0.4 +
    (chat.greenRatio > 0.03 || top.greenRatio > 0.05 ? 0.25 : 0) +
    (full.whiteRatio > 0.4 ? 0.2 : 0) +
    (chat.avgLuma > 150 ? 0.15 : 0);

  // Signal — sombre (pas confondre avec listes blanches)
  const signalScore =
    (full.avgLuma < 55 ? 0.45 : full.avgLuma < 75 ? 0.2 : 0) +
    (full.darkRatio > 0.45 ? 0.35 : full.darkRatio > 0.3 ? 0.15 : 0) +
    (full.whiteRatio < 0.12 ? 0.2 : 0);
  scores["app.signal.liste"] = signalScore;
  scores["app.signal.conversation"] = signalScore * 0.85 + (chat.avgLuma < 90 && chat.avgLuma > 40 ? 0.15 : 0);

  scores["app.spotify.accueil"] =
    (full.avgLuma < 70 ? 0.4 : 0) +
    (full.darkRatio > 0.4 ? 0.35 : 0) +
    (grid.colorRatio > 0.08 ? 0.15 : 0);

  // Photos bibliothèque — grille très colorée
  scores["app.photos.bibliotheque"] =
    (grid.colorRatio > 0.2 ? 0.45 : 0) +
    (full.avgLuma < 100 ? 0.15 : 0) +
    (full.whiteRatio < 0.4 ? 0.2 : 0);

  scores["app.photos.albums"] = scores["app.photos.bibliotheque"] * 0.85;

  // Photo plein écran — souvent sombre ou une image dominante
  scores["app.photos.detail"] =
    (full.darkRatio > 0.25 ? 0.25 : 0) +
    (grid.colorRatio > 0.12 && grid.colorRatio < 0.35 ? 0.25 : 0) +
    (bottom.avgLuma < 60 ? 0.2 : 0) +
    (full.whiteRatio < 0.35 ? 0.15 : 0);

  // Mail, Notes, Réglages — listes claires
  const listApp =
    (full.whiteRatio > 0.5 ? 0.4 : 0) + (mid.whiteRatio > 0.55 ? 0.35 : 0) + (grid.colorRatio < 0.1 ? 0.1 : 0);
  scores["app.mail.inbox"] = listApp;
  scores["app.notes.liste"] = listApp * 0.95;
  scores["app.contacts.liste"] = listApp * 0.9;
  scores["app.telephone.recents"] = listApp * 0.88;
  scores["app.rappels.liste"] = listApp * 0.85;
  scores["app.reglages.main"] = listApp * 0.8 + (top.whiteRatio > 0.5 ? 0.1 : 0);

  scores["app.mail.detail"] = listApp * 0.5 + (mid.whiteRatio > 0.65 ? 0.25 : 0);
  scores["app.notes.detail"] = scores["app.mail.detail"] * 0.9;

  scores["app.safari.accueil"] = listApp * 0.7 + (bottom.avgLuma > 200 ? 0.15 : 0);
  scores["app.calendrier.mois"] = listApp * 0.6 + (grid.colorRatio > 0.05 ? 0.2 : 0);
  scores["app.fichiers.browser"] = listApp * 0.75;
  scores["app.maps.carte"] = (grid.colorRatio > 0.12 ? 0.35 : 0) + (full.whiteRatio < 0.45 ? 0.2 : 0);
  scores["app.instagram.feed"] = listApp * 0.65 + (grid.colorRatio > 0.08 ? 0.15 : 0);
  scores["app.instagram.dm"] = listApp * 0.55 + (chat.blueRatio > 0.02 ? 0.15 : 0);
  scores["app.uber.accueil"] = listApp * 0.7;
  scores["app.credit-agricole.compte"] = listApp * 0.65 + (full.greenRatio > 0.08 ? 0.2 : 0);
  scores["app.netflix.profils"] =
    (full.darkRatio > 0.35 ? 0.35 : 0) + (full.redRatio > 0.04 ? 0.25 : 0);
  scores["app.netflix.accueil"] = scores["app.netflix.profils"] * 0.9 + (grid.colorRatio > 0.12 ? 0.1 : 0);

  const ranked = Object.entries(scores)
    .sort((a, b) => b[1] - a[1])
    .map(([id, score]) => ({ id, score: Math.min(1, score) }));

  return { width, height, ranked, top: ranked[0] };
}

function filledTargets() {
  const used = new Set();
  for (const [id, folder] of Object.entries(TARGETS)) {
    if (fs.existsSync(path.join(ROOT, folder, "screen.png"))) used.add(id);
  }
  return used;
}

function assignGreedy(classifications, usedTargets) {
  const assigned = new Map();
  const pairs = [];

  for (const [file, data] of classifications) {
    for (const r of data.ranked) {
      if (r.score < 0.15) break;
      pairs.push({ file, id: r.id, score: r.score });
    }
  }

  pairs.sort((a, b) => b.score - a.score);

  const assignedFiles = new Set();
  for (const p of pairs) {
    if (assignedFiles.has(p.file)) continue;
    if (usedTargets.has(p.id)) continue;
    if (p.score < 0.22) continue;
    assigned.set(p.file, { id: p.id, score: p.score });
    usedTargets.add(p.id);
    assignedFiles.add(p.file);
  }

  // 2e passe : une capture par slot restant, meilleur candidat disponible
  const openSlots = new Set(Object.keys(TARGETS).filter((id) => !usedTargets.has(id)));
  for (const file of classifications.keys()) {
    if (assignedFiles.has(file)) continue;
    const ranked = classifications.get(file).ranked;
    for (const r of ranked) {
      if (!openSlots.has(r.id) || r.score < 0.12) continue;
      assigned.set(file, { id: r.id, score: r.score });
      openSlots.delete(r.id);
      assignedFiles.add(file);
      break;
    }
  }

  const unassigned = [...classifications.keys()].filter((f) => !assignedFiles.has(f));
  return { assigned, unassigned };
}

function moveCapture(file, id) {
  const folder = TARGETS[id];
  if (!folder) return false;
  const dest = path.join(ROOT, folder, "screen.png");
  if (fs.existsSync(dest)) return false;
  const src = path.join(INBOX, file);
  const destDir = path.join(ROOT, folder);
  fs.mkdirSync(destDir, { recursive: true });
  fs.renameSync(src, dest);
  return true;
}

const autoApply = !process.argv.includes("--dry-run");
const minConfidence = parseFloat(process.argv.find((a) => a.startsWith("--min="))?.split("=")[1] ?? "0.32");

fs.mkdirSync(INBOX, { recursive: true });

const files = fs.readdirSync(INBOX).filter((f) => /\.png$/i.test(f));
if (files.length === 0) {
  console.log("\n📭 inbox/ vide — AirDrop tes captures ici :\n");
  console.log(`   ${INBOX}\n`);
  console.log("Puis : npm run captures:sort\n");
  process.exit(0);
}

console.log(`\n🔍 Analyse de ${files.length} capture(s)…\n`);

const classifications = new Map();
for (const file of files) {
  classifications.set(file, analyzeImage(path.join(INBOX, file)));
}

const { assigned, unassigned } = assignGreedy(classifications, filledTargets());

const report = {
  generatedAt: new Date().toISOString(),
  files: [],
  unassigned: [],
};

let moved = 0;
for (const [file, { id, score }] of assigned) {
  const label = LABELS[id] ?? id;
  const mark = score >= minConfidence ? "✓" : "~";
  console.log(`${mark} ${file}`);
  console.log(`     → ${label} (${Math.round(score * 100)}%)`);

  report.files.push({ file, id, label, score, folder: TARGETS[id] });

  if (autoApply && score >= minConfidence) {
    moveCapture(file, id);
    moved++;
  }
}

for (const file of unassigned) {
  const top = classifications.get(file).top;
  console.log(`? ${file}`);
  console.log(`     → incertain (meilleur guess: ${LABELS[top.id]} ${Math.round(top.score * 100)}%)`);
  report.unassigned.push({
    file,
    guess: top.id,
    label: LABELS[top.id],
    score: top.score,
  });
}

fs.writeFileSync(path.join(INBOX, "report.json"), JSON.stringify(report, null, 2));

console.log("\n─────────────────────────────────────");
if (autoApply) {
  console.log(`✅ ${moved} capture(s) rangée(s) automatiquement`);
  if (unassigned.length || assigned.size > moved) {
    console.log(`⚠️  ${unassigned.length + assigned.size - moved} à valider → http://localhost:5174/captures-review`);
  }
} else {
  console.log("Dry-run — relance sans --dry-run pour appliquer");
}
console.log(`📄 Rapport : inbox/report.json`);
console.log("→ npm run captures:status\n");
