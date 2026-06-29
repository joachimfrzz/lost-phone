import type { LpspPackage, RuntimeNotification, ScenarioEvent } from "../types/lpsp";

export function parseDelayMs(condition: string): number {
  if (condition === "immediate") return 0;
  const m = condition.match(/^delay_(\d+)min$/);
  if (m) return parseInt(m[1], 10) * 60_000;
  return 30_000;
}

export function eventToNotification(ev: ScenarioEvent): RuntimeNotification | null {
  const c = ev.contenu ?? {};
  if (ev.type === "notification") {
    return {
      id: ev.id,
      app: ev.app,
      titre: String(c.titre ?? c.title ?? ev.app),
      texte: String(c.texte ?? c.body ?? c.message ?? ""),
      heure: String(c.heure ?? "maintenant"),
      lu: false,
    };
  }
  if (ev.type === "message_entrant") {
    return {
      id: ev.id,
      app: ev.app,
      titre: String(c.expediteur ?? c.contact ?? c.de ?? "Message"),
      texte: String(c.texte ?? c.message ?? c.body ?? ""),
      heure: String(c.heure ?? "maintenant"),
      lu: false,
    };
  }
  if (ev.type === "appel_manque") {
    return {
      id: ev.id,
      app: "Telephone",
      titre: String(c.appelant ?? c.contact ?? "Appel manqué"),
      texte: String(c.texte ?? "Appel manqué"),
      heure: String(c.heure ?? "maintenant"),
      lu: false,
    };
  }
  return null;
}

export interface ScheduledEvent {
  event: ScenarioEvent;
  fireAt: number;
}

export function scheduleScenario(lpsp: LpspPackage, startAt = Date.now()): ScheduledEvent[] {
  const events = lpsp.scenario?.evenements ?? [];
  let cursor = startAt;
  const scheduled: ScheduledEvent[] = [];

  for (const ev of events) {
    const delay = parseDelayMs(ev.condition);
    if (ev.condition === "immediate") {
      scheduled.push({ event: ev, fireAt: startAt });
    } else if (delay > 0) {
      cursor += delay;
      scheduled.push({ event: ev, fireAt: cursor });
    } else {
      cursor += 30_000;
      scheduled.push({ event: ev, fireAt: cursor });
    }
  }

  return scheduled.sort((a, b) => a.fireAt - b.fireAt);
}

export function envelopeNotifications(lpsp: LpspPackage): RuntimeNotification[] {
  return (lpsp.content.envelope.notifications_initiales ?? []).map((n, i) => ({
    ...n,
    id: `init-${i}`,
    lu: n.lu ?? false,
  }));
}
