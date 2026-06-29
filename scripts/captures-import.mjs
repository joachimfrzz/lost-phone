/**
 * Import paresseux — dépose TOUTES tes captures dans inbox/ (dans l'ordre de la liste),
 * ce script les range automatiquement dans les bons dossiers.
 *
 * Usage:
 *   1. Capture les écrans DANS L'ORDRE (voir ORDER ci-dessous)
 *   2. AirDrop toutes les images → public/captures-ios/inbox/
 *   3. npm run captures:import
 */

import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.join(__dirname, "..", "public", "captures-ios");
const INBOX = path.join(ROOT, "inbox");

/** Ordre strict = ordre des captures à faire sur l'iPhone */
const ORDER = [
  { folder: "system/lock-notifs", label: "1. Verrou avec notifs" },
  { folder: "system/lock-vide", label: "2. Verrou sans notif" },
  { folder: "system/pin", label: "3. Code PIN" },
  { folder: "system/home-p1", label: "4. Accueil page 1" },
  { folder: "system/home-p2", label: "5. Accueil page 2" },
  { folder: "system/notification-center", label: "6. Centre notifications" },
  { folder: "system/control-center", label: "7. Centre de contrôle" },
  { folder: "apps/messages/liste", label: "8. Messages liste" },
  { folder: "apps/messages/conversation", label: "9. Messages conversation" },
  { folder: "apps/whatsapp/liste", label: "10. WhatsApp liste" },
  { folder: "apps/whatsapp/conversation", label: "11. WhatsApp conversation" },
  { folder: "apps/signal/liste", label: "12. Signal liste" },
  { folder: "apps/signal/conversation", label: "13. Signal conversation" },
  { folder: "apps/photos/bibliotheque", label: "14. Photos bibliothèque" },
  { folder: "apps/photos/albums", label: "15. Photos albums" },
  { folder: "apps/photos/detail", label: "16. Photos détail" },
  { folder: "apps/mail/inbox", label: "17. Mail boîte" },
  { folder: "apps/mail/detail", label: "18. Mail message" },
  { folder: "apps/notes/liste", label: "19. Notes liste" },
  { folder: "apps/notes/detail", label: "20. Notes détail" },
  { folder: "apps/telephone/recents", label: "21. Téléphone récents" },
  { folder: "apps/contacts/liste", label: "22. Contacts liste" },
  { folder: "apps/safari/accueil", label: "23. Safari accueil" },
  { folder: "apps/calendrier/mois", label: "24. Calendrier mois" },
  { folder: "apps/reglages/main", label: "25. Réglages" },
  { folder: "apps/fichiers/browser", label: "26. Fichiers" },
  { folder: "apps/rappels/liste", label: "27. Rappels" },
  { folder: "apps/maps/carte", label: "28. Plans / Maps" },
  { folder: "apps/instagram/feed", label: "29. Instagram fil" },
  { folder: "apps/instagram/dm", label: "30. Instagram DM" },
  { folder: "apps/uber/accueil", label: "31. Uber accueil" },
  { folder: "apps/credit-agricole/compte", label: "32. Crédit Agricole compte" },
  { folder: "apps/spotify/accueil", label: "33. Spotify" },
  { folder: "apps/netflix/profils", label: "34. Netflix profils" },
  { folder: "apps/netflix/accueil", label: "35. Netflix accueil" },
];

/** 6 captures suffisantes pour tester J-3 — npm run captures:import:min */
const ORDER_MIN = [
  { folder: "system/lock-notifs", label: "1. Verrou avec notifs" },
  { folder: "system/pin", label: "2. Code PIN" },
  { folder: "system/home-p1", label: "3. Accueil" },
  { folder: "apps/messages/liste", label: "4. Messages liste" },
  { folder: "apps/messages/conversation", label: "5. Messages conversation" },
  { folder: "apps/photos/bibliotheque", label: "6. Photos bibliothèque" },
];

function extractNumber(name) {
  const m = name.match(/(\d+)/);
  return m ? parseInt(m[1], 10) : 0;
}

function sortFiles(files) {
  return [...files].sort((a, b) => {
    const na = extractNumber(a);
    const nb = extractNumber(b);
    if (na !== nb) return na - nb;
    return a.localeCompare(b, undefined, { numeric: true });
  });
}

const dryRun = process.argv.includes("--dry-run");
const useMin = process.argv.includes("--min");
const order = useMin ? ORDER_MIN : ORDER;

fs.mkdirSync(INBOX, { recursive: true });

const files = fs
  .readdirSync(INBOX)
  .filter((f) => /\.png$/i.test(f) && f !== ".gitkeep");

if (files.length === 0) {
  console.log("\n📭 inbox/ est vide.\n");
  console.log("→ AirDrop tes captures dans :");
  console.log(`  ${INBOX}\n`);
  console.log("Capture-les DANS L'ORDRE (1=verrou notifs, 2=verrou vide, …).");
  console.log("Puis : npm run captures:import\n");
  process.exit(0);
}

const sorted = sortFiles(files);
const limit = Math.min(sorted.length, order.length);

if (sorted.length > order.length) {
  console.warn(`\n⚠️  ${sorted.length} fichiers mais seulement ${order.length} slots — les extras seront ignorés.\n`);
}

if (sorted.length < order.length) {
  console.log(`\nℹ️  ${sorted.length}/${order.length} captures — import partiel.\n`);
}

if (useMin) console.log("📋 Mode minimum J-3 (6 captures)\n");

console.log(dryRun ? "\n🔍 Dry-run (rien n'est déplacé)\n" : "\n📦 Import captures\n");

let moved = 0;
for (let i = 0; i < limit; i++) {
  const src = path.join(INBOX, sorted[i]);
  const destDir = path.join(ROOT, order[i].folder);
  const dest = path.join(destDir, "screen.png");

  fs.mkdirSync(destDir, { recursive: true });

  console.log(`${order[i].label}`);
  console.log(`   ${sorted[i]} → ${order[i].folder}/screen.png`);

  if (!dryRun) {
    if (fs.existsSync(dest)) fs.unlinkSync(dest);
    fs.renameSync(src, dest);
    moved++;
  }
}

const remaining = fs.readdirSync(INBOX).filter((f) => /\.png$/i.test(f));
if (!dryRun && remaining.length > 0) {
  console.log(`\n📭 ${remaining.length} fichier(s) restant(s) dans inbox/ (non assignés)`);
}

console.log(dryRun ? "\n→ Relance sans --dry-run pour appliquer.\n" : `\n✅ ${moved} capture(s) importée(s).\n→ npm run captures:status\n`);
