import type { CaptureId } from "../captures";

export type CalibrationStatus = "blocked" | "in_progress" | "review" | "validated";

export type CalibrationEntry = {
  id: CaptureId;
  label: string;
  status: CalibrationStatus;
  /** Écran précédent qui doit être validé avant de débloquer celui-ci. */
  dependsOn?: CaptureId;
};

/** File d'attente strict — un seul écran actif à la fois. */
export const CALIBRATION_QUEUE: CalibrationEntry[] = [
  { id: "system.lock-vide", label: "Verrou (vide)", status: "validated" },
  {
    id: "system.lock-notifs",
    label: "Verrou (notifications)",
    status: "blocked",
    dependsOn: "system.lock-vide",
  },
  { id: "system.pin", label: "Code PIN", status: "in_progress", dependsOn: "system.lock-vide" },
  { id: "system.home-p1", label: "Accueil page 1", status: "review", dependsOn: "system.pin" },
  { id: "system.home-p2", label: "Accueil page 2", status: "blocked", dependsOn: "system.home-p1" },
  {
    id: "system.notification-center",
    label: "Centre de notifications",
    status: "blocked",
    dependsOn: "system.home-p1",
  },
  {
    id: "system.control-center",
    label: "Centre de contrôle",
    status: "blocked",
    dependsOn: "system.home-p1",
  },
];

export function activeCalibration(): CalibrationEntry {
  return CALIBRATION_QUEUE.find((e) => e.status === "in_progress") ?? CALIBRATION_QUEUE[0];
}

export function isCalibrationUnlocked(id: CaptureId): boolean {
  const entry = CALIBRATION_QUEUE.find((e) => e.id === id);
  if (!entry) return true;
  if (entry.status === "validated" || entry.status === "in_progress" || entry.status === "review") {
    return true;
  }
  if (!entry.dependsOn) return entry.status !== "blocked";
  const dep = CALIBRATION_QUEUE.find((e) => e.id === entry.dependsOn);
  return dep?.status === "validated";
}

export function calibrationStatusLabel(status: CalibrationStatus): string {
  switch (status) {
    case "blocked":
      return "Bloqué";
    case "in_progress":
      return "En cours";
    case "review":
      return "À valider";
    case "validated":
      return "Validé";
  }
}
