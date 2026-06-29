/**
 * Export + reprocess + apply en une commande.
 * Usage: npm run figma:sync -- lock-screen
 */

import { spawnSync } from "node:child_process";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.join(__dirname, "..");
const screen = process.argv[2] ?? "lock-screen";

function run(cmd, args) {
  const r = spawnSync(cmd, args, { cwd: ROOT, stdio: "inherit", shell: true });
  if (r.status !== 0) process.exit(r.status ?? 1);
}

run("node", ["scripts/figma-export-screen.mjs", screen]);
run("node", ["scripts/figma-reprocess.mjs", screen]);
run("node", ["scripts/figma-apply-tokens.mjs", screen]);
