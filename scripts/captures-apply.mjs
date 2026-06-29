import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

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

const selPath = path.join(INBOX, "selections.json");
if (!fs.existsSync(selPath)) {
  console.log("\n❌ inbox/selections.json introuvable.\n");
  console.log("→ Exporte depuis http://localhost:5174/captures-review\n");
  process.exit(1);
}

const { assignments } = JSON.parse(fs.readFileSync(selPath, "utf8"));
let n = 0;
for (const { file, id } of assignments) {
  const folder = TARGETS[id];
  if (!folder) continue;
  const src = path.join(INBOX, file);
  if (!fs.existsSync(src)) {
    console.warn(`⚠️  ${file} introuvable`);
    continue;
  }
  const destDir = path.join(ROOT, folder);
  const dest = path.join(destDir, "screen.png");
  fs.mkdirSync(destDir, { recursive: true });
  if (fs.existsSync(dest)) fs.unlinkSync(dest);
  fs.renameSync(src, dest);
  console.log(`✓ ${file} → ${folder}/`);
  n++;
}
console.log(`\n✅ ${n} appliquée(s)\n`);
