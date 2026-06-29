import measured from "./measured.json";
import type { CaptureId } from "../captures";

export type MeasuredScreen = {
  pixelSize?: { width: number; height: number };
  scale?: { x: number; y: number };
  regions?: {
    statusBar?: { heightLogical: number };
    lockClock?: { topLogical: number; heightLogical: number; avgLuma: number };
    dock?: { topLogical: number; avgLuma: number };
  };
  error?: string;
};

export type ReferenceSpecs = typeof measured;

export const REFERENCE_SPECS = measured as ReferenceSpecs;

export function measuredFor(id: CaptureId): MeasuredScreen | null {
  const entry = REFERENCE_SPECS.screens[id as keyof typeof REFERENCE_SPECS.screens];
  if (!entry) return null;
  if ("error" in entry && entry.error) return { error: String(entry.error) };
  return entry as MeasuredScreen;
}

/** Tokens dérivés des mesures @393×852 (iPhone 15 Pro, captures de référence). */
export const CALIBRATED_TOKENS = {
  statusHeight: REFERENCE_SPECS.screens["system.lock-vide"]?.regions?.statusBar?.heightLogical ?? 55.2,
  lockClockTop: REFERENCE_SPECS.screens["system.lock-vide"]?.regions?.lockClock?.topLogical ?? 67.9,
  lockClockHeight: REFERENCE_SPECS.screens["system.lock-vide"]?.regions?.lockClock?.heightLogical ?? 170.6,
  dockTop: REFERENCE_SPECS.screens["system.home-p1"]?.regions?.dock?.topLogical ?? 732.4,
  logicalWidth: REFERENCE_SPECS.logicalBase.width,
  logicalHeight: REFERENCE_SPECS.logicalBase.height,
} as const;

export const LOCK_CLOCK_GAP =
  CALIBRATED_TOKENS.lockClockTop - CALIBRATED_TOKENS.statusHeight;

export const DOCK_ZONE_HEIGHT =
  CALIBRATED_TOKENS.logicalHeight - CALIBRATED_TOKENS.dockTop;
