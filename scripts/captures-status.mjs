import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import os from "node:os";
import { CAPTURE_FOLDERS } from "./capture-slots.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.join(__dirname, "..", "public", "captures-ios");

for (const folder of CAPTURE_FOLDERS) {
  fs.mkdirSync(path.join(ROOT, folder), { recursive: true });
}

const present = [];
const missing = [];

for (const folder of CAPTURE_FOLDERS) {
  const screen = path.join(ROOT, folder, "screen.png");
  if (fs.existsSync(screen)) present.push(folder);
  else missing.push(folder);
}

function localIps() {
  const nets = os.networkInterfaces();
  const ips = [];
  for (const list of Object.values(nets)) {
    for (const net of list ?? []) {
      if (net.family === "IPv4" && !net.internal) ips.push(net.address);
    }
  }
  return ips;
}

console.log("\n📱 Captures iPhone — statut\n");
console.log(`✅ Présentes : ${present.length}/${CAPTURE_FOLDERS.length}`);
for (const f of present) console.log(`   ✓ ${f}/screen.png`);

console.log(`\n⏳ Manquantes : ${missing.length}`);
for (const f of missing) console.log(`   · ${f}/screen.png`);

const ips = localIps();
console.log("\n📤 Envoi iPhone → Safari :");
if (ips.length) {
  for (const ip of ips) console.log(`   http://${ip}:5174/captures-upload`);
} else {
  console.log("   http://<IP-du-PC>:5174/captures-upload");
}
console.log("");
