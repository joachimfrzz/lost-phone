export function initials(name?: string): string {
  if (!name) return "?";
  return name
    .split(/\s+/)
    .map((w) => w[0])
    .join("")
    .slice(0, 2)
    .toUpperCase();
}

export function isOutgoing(sender?: string): boolean {
  if (!sender) return false;
  const s = sender.toLowerCase();
  return s === "moi" || s === "me" || s === "mathieu" || s === "m";
}

export function formatTime(iso?: string): string {
  if (!iso) return "";
  try {
    return new Date(iso).toLocaleTimeString("fr-FR", { hour: "2-digit", minute: "2-digit" });
  } catch {
    return iso;
  }
}

export function formatDate(iso?: string): string {
  if (!iso) return "";
  try {
    return new Date(iso).toLocaleString("fr-FR", {
      day: "numeric",
      month: "short",
      hour: "2-digit",
      minute: "2-digit",
    });
  } catch {
    return iso;
  }
}

export function formatShortDate(iso?: string): string {
  if (!iso) return "";
  try {
    return new Date(iso).toLocaleDateString("fr-FR", { day: "numeric", month: "short" });
  } catch {
    return iso;
  }
}

export function formatMoney(v?: number | string): string {
  if (v == null) return "—";
  if (typeof v === "string" && v.includes("€")) return v;
  const n = typeof v === "string" ? parseFloat(v.replace(",", ".").replace(/[^\d.-]/g, "")) : v;
  if (Number.isNaN(n)) return String(v);
  return n.toLocaleString("fr-FR", { style: "currency", currency: "EUR" });
}
