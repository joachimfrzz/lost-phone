import type { LockConfig, LpspPackage, LpspPlayerConfig } from "../../types/lpsp";

export function parseLock(config: LpspPlayerConfig["verrouillage"]): LockConfig | null {
  if (!config) return null;
  if (typeof config === "string") {
    if (config.toLowerCase().includes("déverrouill") || config.toLowerCase().includes("deverrouill")) {
      return { type: "none" };
    }
    return { type: config };
  }
  return config;
}

export function lockRequiresPin(lock: LockConfig | null): boolean {
  if (!lock || lock.type === "none") return false;
  return Boolean(lock.code && lock.code.length > 0);
}

export function getAppPayload(apps: Record<string, unknown>, appName: string): unknown {
  const raw = apps[appName];
  if (!raw || typeof raw !== "object") return raw;
  const obj = raw as Record<string, unknown>;
  if ("contenu" in obj && ("app" in obj || "profondeur" in obj)) {
    return obj.contenu;
  }
  return obj;
}

export function profilTemporelLabel(manifest: LpspPackage["manifest"]): string {
  const p = manifest.profil_temporel;
  if (!p) return "—";
  if (typeof p === "string") return p;
  return p.type ?? "—";
}

export function validateLpsp(pkg: unknown): pkg is LpspPackage {
  if (!pkg || typeof pkg !== "object") return false;
  const p = pkg as LpspPackage;
  return (
    p.lpsp_version != null &&
    p.manifest?.title != null &&
    p.content?.envelope != null &&
    p.content?.apps != null
  );
}
