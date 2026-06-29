import type { IncomingMessage, ServerResponse } from "node:http";
import fs from "node:fs";
import path from "node:path";
import type { Plugin } from "vite";
import { CAPTURE_PATHS, type CaptureId } from "../src/lib/captures";
import { allSlotIds } from "../src/lib/captureSlots";

const PUBLIC_ROOT = path.resolve("public");
const WALLPAPER_DIR = path.join(PUBLIC_ROOT, "assets", "wallpapers");
const ACTIVE_WALLPAPER = path.join(WALLPAPER_DIR, "active.source");

function readActiveWallpaper(): { ok: boolean; path?: string; bytes?: number } {
  if (!fs.existsSync(ACTIVE_WALLPAPER)) return { ok: false };
  const rel = fs.readFileSync(ACTIVE_WALLPAPER, "utf8").trim();
  if (!rel.startsWith("/assets/wallpapers/")) return { ok: false };
  const abs = path.join(PUBLIC_ROOT, rel.replace(/^\//, ""));
  if (!fs.existsSync(abs)) return { ok: false };
  return { ok: true, path: rel, bytes: fs.statSync(abs).size };
}

function readJsonBody(req: IncomingMessage): Promise<unknown> {
  return new Promise((resolve, reject) => {
    const chunks: Buffer[] = [];
    req.on("data", (c) => chunks.push(c));
    req.on("end", () => {
      try {
        resolve(JSON.parse(Buffer.concat(chunks).toString("utf8")));
      } catch (e) {
        reject(e);
      }
    });
    req.on("error", reject);
  });
}

function sendJson(res: ServerResponse, status: number, data: unknown) {
  res.statusCode = status;
  res.setHeader("Content-Type", "application/json");
  res.end(JSON.stringify(data));
}

function screenPath(id: CaptureId): string {
  const rel = CAPTURE_PATHS[id];
  if (!rel) throw new Error(`Unknown capture id: ${id}`);
  return path.join(PUBLIC_ROOT, rel);
}

function slotStatus(): Record<string, boolean> {
  const out: Record<string, boolean> = {};
  for (const id of allSlotIds()) {
    out[id] = fs.existsSync(screenPath(id as CaptureId));
  }
  return out;
}

/** API dev : upload captures depuis iPhone (même Wi-Fi) → public/captures-ios/ */
export function captureUploadPlugin(): Plugin {
  return {
    name: "capture-upload",
    configureServer(server) {
      server.middlewares.use(async (req, res, next) => {
        const url = req.url?.split("?")[0] ?? "";

        if (url === "/api/captures/status" && req.method === "GET") {
          const status = slotStatus();
          const total = allSlotIds().length;
          const done = Object.values(status).filter(Boolean).length;
          const wallpaper = readActiveWallpaper();
          sendJson(res, 200, { status, done, total, wallpaper });
          return;
        }

        if (url === "/api/assets/wallpaper/status" && req.method === "GET") {
          sendJson(res, 200, readActiveWallpaper());
          return;
        }

        if (url === "/api/assets/wallpaper/upload" && req.method === "POST") {
          try {
            const body = (await readJsonBody(req)) as { data?: string; ext?: string };
            if (!body.data || typeof body.data !== "string") {
              sendJson(res, 400, { error: "data base64 manquante" });
              return;
            }
            const ext = (body.ext ?? "png").replace(/^\./, "").toLowerCase();
            if (!["png", "jpg", "jpeg", "webp", "heic", "heif"].includes(ext)) {
              sendJson(res, 400, { error: "format non supporté (utilisez PNG ou JPEG)" });
              return;
            }
            const buf = Buffer.from(body.data, "base64");
            if (buf.length < 1000) {
              sendJson(res, 400, { error: "fichier trop petit" });
              return;
            }
            if (buf.length > 12 * 1024 * 1024) {
              sendJson(res, 413, { error: "fichier trop volumineux (max 12 Mo)" });
              return;
            }
            fs.mkdirSync(WALLPAPER_DIR, { recursive: true });
            const filename =
              ext === "jpeg" ? "calibration-lock.jpg" : ext === "heic" || ext === "heif" ? "calibration-lock.heic" : `calibration-lock.${ext}`;
            const rel = `/assets/wallpapers/${filename}`;
            fs.writeFileSync(path.join(WALLPAPER_DIR, filename), buf);
            fs.writeFileSync(ACTIVE_WALLPAPER, rel);
            sendJson(res, 200, { ok: true, path: rel, bytes: buf.length });
          } catch (e) {
            sendJson(res, 500, { error: String(e) });
          }
          return;
        }

        if (url === "/api/captures/upload" && req.method === "POST") {
          try {
            const body = (await readJsonBody(req)) as {
              id?: string;
              data?: string;
              ext?: string;
            };
            const id = body.id as CaptureId;
            if (!id || !CAPTURE_PATHS[id]) {
              sendJson(res, 400, { error: "id capture invalide" });
              return;
            }
            if (!body.data || typeof body.data !== "string") {
              sendJson(res, 400, { error: "data base64 manquante" });
              return;
            }
            const ext = (body.ext ?? "png").replace(/^\./, "").toLowerCase();
            if (!["png", "jpg", "jpeg", "webp", "heic", "heif"].includes(ext)) {
              sendJson(res, 400, { error: "format non supporté (utilisez PNG ou JPEG)" });
              return;
            }
            const buf = Buffer.from(body.data, "base64");
            if (buf.length < 1000) {
              sendJson(res, 400, { error: "fichier trop petit" });
              return;
            }
            if (buf.length > 12 * 1024 * 1024) {
              sendJson(res, 413, { error: "fichier trop volumineux (max 12 Mo)" });
              return;
            }

            const dest = screenPath(id);
            fs.mkdirSync(path.dirname(dest), { recursive: true });
            fs.writeFileSync(dest, buf);
            sendJson(res, 200, { ok: true, id, bytes: buf.length });
          } catch (e) {
            sendJson(res, 500, { error: String(e) });
          }
          return;
        }

        if (url === "/api/captures/clear" && req.method === "POST") {
          try {
            let removed = 0;
            for (const id of allSlotIds()) {
              const p = screenPath(id as CaptureId);
              if (fs.existsSync(p)) {
                fs.unlinkSync(p);
                removed++;
              }
            }
            sendJson(res, 200, { ok: true, removed });
          } catch (e) {
            sendJson(res, 500, { error: String(e) });
          }
          return;
        }

        next();
      });
    },
  };
}
