#!/usr/bin/env node
/** Affiche les URLs à ouvrir sur iPhone (preview contenu LPSP) */
import { networkInterfaces } from "node:os";

const port = process.env.PORT ?? "5174";
const ips = Object.values(networkInterfaces())
  .flat()
  .filter((n) => n && n.family === "IPv4" && !n.internal)
  .map((n) => n.address);

console.log("\nLost Phone — URLs iPhone (Safari, même réseau Wi‑Fi)\n");
for (const ip of ips) {
  console.log(`  http://${ip}:${port}/simulator`);
}
console.log("\nLance d'abord: npm run dev\n");
console.log("Contenu éditable: public/stories/j3-louvre/lpsp.json");
console.log("App native SwiftUI: push GitHub → Codemagic → voir CURSOR-IPHONE.md\n");
