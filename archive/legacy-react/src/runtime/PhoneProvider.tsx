import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useRef,
  useState,
  type ReactNode,
} from "react";
import { getAppPayload, lockRequiresPin, parseLock } from "../lib/lpsp/normalize";
import { hapticError, hapticLight, hapticSuccess } from "../lib/native";
import {
  envelopeNotifications,
  eventToNotification,
  scheduleScenario,
  type ScheduledEvent,
} from "../scenario/engine";
import type { LpspPackage, PhonePhase, RuntimeNotification } from "../types/lpsp";

import type { ReferencePreviewConfig } from "../lib/reference/previewMap";
import { getMockAppData } from "../platform/mock/appData";
import type { PlatformMode } from "../platform/types";

export type SystemOverlay = "none" | "notifications" | "control-center";

export type LaunchOrigin = { x: number; y: number };

interface PhoneContextValue {
  lpsp: LpspPackage;
  phase: PhonePhase;
  activeApp: string | null;
  launchOrigin: LaunchOrigin | null;
  notifications: RuntimeNotification[];
  unreadCount: number;
  pinRequired: boolean;
  pinError: boolean;
  dock: string[];
  appNames: string[];
  overlay: SystemOverlay;
  platformMode: PlatformMode;
  referenceHomePage?: number;
  referenceMode: boolean;
  getAppData: (name: string) => unknown;
  swipeToUnlock: () => void;
  submitPin: (digits: string) => void;
  openApp: (name: string, origin?: LaunchOrigin) => void;
  closeApp: () => void;
  cancelPin: () => void;
  markNotificationRead: (id: string) => void;
  openNotificationCenter: () => void;
  openControlCenter: () => void;
  closeOverlay: () => void;
}

const PhoneContext = createContext<PhoneContextValue | null>(null);

export function usePhone() {
  const ctx = useContext(PhoneContext);
  if (!ctx) throw new Error("usePhone outside PhoneProvider");
  return ctx;
}

interface PhoneProviderProps {
  lpsp: LpspPackage;
  children: ReactNode;
  /** simulator = iPhone vide ; story = jeu ; reference = comparaison captures */
  platformMode?: PlatformMode;
  /** Mode /ui-reference : fige phase, overlay et app pour comparaison visuelle */
  referencePreview?: ReferencePreviewConfig | null;
}

export function PhoneProvider({
  lpsp,
  children,
  platformMode: platformModeProp,
  referencePreview = null,
}: PhoneProviderProps) {
  const platformMode: PlatformMode =
    platformModeProp ?? (referencePreview != null ? "reference" : "story");
  const referenceMode = platformMode === "reference";
  const lock = parseLock(lpsp.player_config.verrouillage);
  const pinRequired = lockRequiresPin(lock);
  const pinCode = lock?.code ?? "";
  const runScenario = platformMode === "story";

  const [phase, setPhase] = useState<PhonePhase>(
    referencePreview?.phase ?? (pinRequired ? "lock" : "home"),
  );
  const [activeApp, setActiveApp] = useState<string | null>(referencePreview?.activeApp ?? null);
  const [launchOrigin, setLaunchOrigin] = useState<LaunchOrigin | null>(
    referencePreview?.activeApp ? { x: 50, y: 80 } : null,
  );
  const [pinError, setPinError] = useState(false);
  const [overlay, setOverlay] = useState<SystemOverlay>(referencePreview?.overlay ?? "none");
  const [notifications, setNotifications] = useState<RuntimeNotification[]>(() =>
    envelopeNotifications(lpsp)
  );
  const firedRef = useRef<Set<string>>(new Set());
  const scheduleRef = useRef<ScheduledEvent[]>([]);
  const startRef = useRef<number | null>(null);

  const appNames = lpsp.manifest.apps_presentes ?? Object.keys(lpsp.content.apps);
  const dock = lpsp.content.system?.dock ?? appNames.slice(0, 5);
  const referenceHomePage = referencePreview?.homePage;

  useEffect(() => {
    if (!referencePreview) return;
    setPhase(referencePreview.phase);
    setActiveApp(referencePreview.activeApp ?? null);
    setLaunchOrigin(referencePreview.activeApp ? { x: 50, y: 80 } : null);
    setOverlay(referencePreview.overlay ?? "none");
    setPinError(false);
  }, [referencePreview]);

  const getAppData = useCallback(
    (name: string) => {
      if (platformMode === "simulator") return getMockAppData(name);
      if (name === "Réglages") return {};
      const payload = getAppPayload(lpsp.content.apps, name);
      return payload ?? (platformMode === "reference" ? getMockAppData(name) : payload);
    },
    [lpsp, platformMode]
  );

  const unreadCount = notifications.filter((n) => !n.lu).length;

  const startScenario = useCallback(() => {
    if (startRef.current != null) return;
    startRef.current = Date.now();
    scheduleRef.current = scheduleScenario(lpsp, startRef.current);
  }, [lpsp]);

  useEffect(() => {
    if (!runScenario || referenceMode) return;
    if (phase === "home" || phase === "app") startScenario();
  }, [phase, startScenario, referenceMode, runScenario]);

  useEffect(() => {
    if (!runScenario || referenceMode || startRef.current == null) return;
    const tick = () => {
      const now = Date.now();
      for (const item of scheduleRef.current) {
        if (firedRef.current.has(item.event.id)) continue;
        if (now >= item.fireAt) {
          firedRef.current.add(item.event.id);
          const notif = eventToNotification(item.event);
          if (notif) {
            setNotifications((prev) => [notif, ...prev]);
          }
        }
      }
    };
    tick();
    const id = window.setInterval(tick, 2000);
    return () => window.clearInterval(id);
  }, [phase]);

  const swipeToUnlock = useCallback(() => {
    if (pinRequired) setPhase("pin");
    else setPhase("home");
  }, [pinRequired]);

  const submitPin = useCallback(
    (digits: string) => {
      if (digits === pinCode) {
        setPinError(false);
        setPhase("home");
        hapticSuccess();
      } else {
        setPinError(true);
        hapticError();
        window.setTimeout(() => setPinError(false), 520);
      }
    },
    [pinCode]
  );

  const openApp = useCallback((name: string, origin?: LaunchOrigin) => {
    setOverlay("none");
    setLaunchOrigin(origin ?? { x: 50, y: 80 });
    setActiveApp(name);
    setPhase("app");
    hapticLight();
  }, []);

  const closeApp = useCallback(() => {
    setActiveApp(null);
    setLaunchOrigin(null);
    setPhase("home");
  }, []);

  const openNotificationCenter = useCallback(() => setOverlay("notifications"), []);
  const openControlCenter = useCallback(() => setOverlay("control-center"), []);
  const closeOverlay = useCallback(() => setOverlay("none"), []);

  const cancelPin = useCallback(() => {
    setPinError(false);
    setPhase("lock");
  }, []);

  const markNotificationRead = useCallback((id: string) => {
    setNotifications((prev) => prev.map((n) => (n.id === id ? { ...n, lu: true } : n)));
  }, []);

  const value = useMemo<PhoneContextValue>(
    () => ({
      lpsp,
      phase,
      activeApp,
      launchOrigin,
      notifications,
      unreadCount,
      pinRequired,
      pinError,
      dock,
      appNames,
      overlay,
      platformMode,
      referenceHomePage,
      referenceMode,
      getAppData,
      swipeToUnlock,
      submitPin,
      openApp,
      closeApp,
      cancelPin,
      markNotificationRead,
      openNotificationCenter,
      openControlCenter,
      closeOverlay,
    }),
    [
      lpsp,
      phase,
      activeApp,
      launchOrigin,
      notifications,
      unreadCount,
      pinRequired,
      pinError,
      dock,
      appNames,
      overlay,
      platformMode,
      referenceHomePage,
      referenceMode,
      getAppData,
      swipeToUnlock,
      submitPin,
      openApp,
      closeApp,
      cancelPin,
      markNotificationRead,
      openNotificationCenter,
      openControlCenter,
      closeOverlay,
    ]
  );

  return <PhoneContext.Provider value={value}>{children}</PhoneContext.Provider>;
}
