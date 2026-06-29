import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.join(__dirname, "..", "public", "captures-ios");

const FOLDERS = [
  "system/lock-vide",
  "system/lock-notifs",
  "system/pin",
  "system/home-p1",
  "system/home-p2",
  "system/notification-center",
  "system/control-center",
  "apps/messages/liste",
  "apps/messages/conversation",
  "apps/whatsapp/liste",
  "apps/whatsapp/conversation",
  "apps/signal/liste",
  "apps/signal/conversation",
  "apps/photos/bibliotheque",
  "apps/photos/albums",
  "apps/photos/detail",
  "apps/mail/inbox",
  "apps/mail/detail",
  "apps/notes/liste",
  "apps/notes/detail",
  "apps/telephone/recents",
  "apps/contacts/liste",
  "apps/safari/accueil",
  "apps/calendrier/mois",
  "apps/reglages/main",
  "apps/fichiers/browser",
  "apps/rappels/liste",
  "apps/maps/carte",
  "apps/instagram/feed",
  "apps/instagram/dm",
  "apps/uber/accueil",
  "apps/credit-agricole/compte",
  "apps/spotify/accueil",
  "apps/netflix/profils",
  "apps/netflix/accueil",
];

function isPng(name: string): boolean {
  return /\.png$/i.test(name) && name !== "screen.png";
}

let renamed = 0;
let skipped = 0;

for (const folder of FOLDERS) {
  const dir = path.join(ROOT, folder);
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }

  const target = path.join(dir, "screen.png");
  if (fs.existsSync(target)) {
    skipped++;
    continue;
  }

  const pngs = fs.readdirSync(dir).filter(isPng);
  if (pngs.length === 0) continue;

  if (pngs.length > 1) {
    console.warn(`⚠️  ${folder}/ — plusieurs PNG, garde-en un seul :`);
    pngs.forEach((f) => console.warn(`      ${f}`));
    continue;
  }

  fs.renameSync(path.join(dir, pngs[0]), target);
  console.log(`✓ ${folder}/${pngs[0]} → screen.png`);
  renamed++;
}

console.log(`\n${renamed} renommé(s), ${skipped} déjà OK.\n`);
