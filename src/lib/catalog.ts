import type { CatalogManifest } from "../types/catalog";
import type { LpspPackage } from "../types/lpsp";

export async function fetchCatalog(): Promise<CatalogManifest> {
  const res = await fetch("/catalog.json");
  if (!res.ok) throw new Error("Impossible de charger le catalogue");
  return res.json() as Promise<CatalogManifest>;
}

export async function fetchLpsp(path: string): Promise<LpspPackage> {
  const res = await fetch(path);
  if (!res.ok) throw new Error("Impossible de charger l'histoire");
  return res.json() as Promise<LpspPackage>;
}

export function formatDuration(minutes: number): string {
  if (minutes < 60) return `~${minutes} min`;
  const h = Math.floor(minutes / 60);
  const m = minutes % 60;
  return m > 0 ? `~${h}h${m.toString().padStart(2, "0")}` : `~${h}h`;
}

export function formatCountdown(targetIso: string): string {
  const target = new Date(targetIso).getTime();
  const now = Date.now();
  const diff = Math.max(0, target - now);

  const days = Math.floor(diff / (1000 * 60 * 60 * 24));
  const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
  const seconds = Math.floor((diff % (1000 * 60)) / 1000);

  if (days > 0) return `${days}j ${hours}h`;
  if (hours > 0) return `${hours}h ${minutes.toString().padStart(2, "0")}m`;
  return `${minutes}:${seconds.toString().padStart(2, "0")}`;
}

export function formatReleaseDate(iso: string): string {
  const d = new Date(iso);
  const day = new Intl.DateTimeFormat("fr-FR", {
    weekday: "long",
    day: "numeric",
    month: "long",
  }).format(d);
  const h = d.getHours();
  return `${day} · ${h}h`;
}
