import { useEffect, useRef, useState } from "react";
import type { CSSProperties } from "react";
import { resolveAppComponent } from "../apps/registry";
import { statusModeForApp } from "../lib/appStatusBar";
import { setNativeStatusBar } from "../lib/native";
import { wallpaperMood } from "../lib/wallpaper";
import { HomeScreen } from "../ios/HomeScreen";
import { HomeIndicator, IphoneShell } from "../ios/IphoneShell";
import { LockScreen } from "../ios/LockScreen";
import { PinScreen } from "../ios/PinScreen";
import { StatusBar } from "../ios/StatusBar";
import { SystemGestures, SystemOverlays } from "../ios/SystemOverlays";
import { usePhone } from "./PhoneProvider";

export function PhoneRuntime() {
  const { lpsp, phase, activeApp, launchOrigin, closeApp, getAppData } = usePhone();
  const envelope = lpsp.content.envelope;
  const system = lpsp.content.system;
  const time = envelope.heure_verrou ?? "14:30";
  const [uploadedWallpaper, setUploadedWallpaper] = useState<string | undefined>();

  useEffect(() => {
    fetch("/api/assets/wallpaper/status", { cache: "no-store" })
      .then((r) => (r.ok ? r.json() : null))
      .then((d: { ok?: boolean; path?: string } | null) => {
        if (d?.ok && d.path) setUploadedWallpaper(d.path);
      })
      .catch(() => {});
  }, []);

  const mood = wallpaperMood(
    envelope.fond_ecran?.description,
    envelope.fond_ecran?.source ?? uploadedWallpaper,
  );

  const AppComponent = activeApp ? resolveAppComponent(activeApp) : null;
  const appData = activeApp ? getAppData(activeApp) : null;

  const statusMode =
    phase === "lock" || phase === "pin"
      ? "lock"
      : phase === "home"
        ? "home"
        : statusModeForApp(activeApp);

  useEffect(() => {
    const lightIcons = statusMode === "lock" || statusMode === "home" || statusMode === "app-dark";
    setNativeStatusBar(lightIcons);
  }, [statusMode]);

  const launchStyle = launchOrigin
    ? ({ "--launch-x": `${launchOrigin.x}%`, "--launch-y": `${launchOrigin.y}%` } as CSSProperties)
    : undefined;

  return (
    <IphoneShell wallpaper={mood.wallpaper} className={`iphone--phase-${phase}`}>
      <StatusBar mode={statusMode} battery={system?.batterie} time={time} carrier="Free" />

      <main className={`iphone__stage iphone__stage--${phase}`}>
        {phase === "lock" && <LockScreen envelope={envelope} />}
        {phase === "pin" && <PinScreen />}
        {phase === "home" && <HomeScreen />}
        {phase === "app" && AppComponent && (
          <AppLayer launchStyle={launchStyle} onClose={closeApp}>
            <AppComponent data={appData} />
          </AppLayer>
        )}
      </main>
      <SystemGestures />
      <SystemOverlays />
    </IphoneShell>
  );
}

function AppLayer({
  children,
  launchStyle,
  onClose,
}: {
  children: React.ReactNode;
  launchStyle?: CSSProperties;
  onClose: () => void;
}) {
  const [dragY, setDragY] = useState(0);
  const [closing, setClosing] = useState(false);
  const startY = useRef(0);
  const dragging = useRef(false);
  const delta = useRef(0);

  function onPointerDown(e: React.PointerEvent) {
    if (closing) return;
    dragging.current = true;
    startY.current = e.clientY;
    delta.current = 0;
    (e.currentTarget as HTMLElement).setPointerCapture(e.pointerId);
  }

  function onPointerMove(e: React.PointerEvent) {
    if (!dragging.current || closing) return;
    const dy = Math.max(0, e.clientY - startY.current);
    delta.current = dy;
    setDragY(dy);
  }

  function finishClose() {
    setClosing(true);
    setDragY(window.innerHeight * 0.4);
    window.setTimeout(onClose, 280);
  }

  function onPointerUp() {
    if (!dragging.current || closing) return;
    dragging.current = false;
    if (delta.current > 96) {
      finishClose();
      return;
    }
    delta.current = 0;
    setDragY(0);
  }

  const scale = Math.max(0.88, 1 - dragY / 1200);

  return (
    <div
      className={`iphone__app-layer iphone__app-layer--open ${closing ? "iphone__app-layer--closing" : ""}`}
      style={{
        ...launchStyle,
        transform: dragY > 0 ? `translateY(${dragY}px) scale(${scale})` : undefined,
        borderRadius: dragY > 0 ? `${Math.min(24, 8 + dragY / 20)}px` : undefined,
        transition: dragging.current ? "none" : "transform 0.32s cubic-bezier(0.32, 0.72, 0, 1), border-radius 0.32s",
      }}
    >
      {children}
      <div
        className="ios-app__home-zone"
        onPointerDown={onPointerDown}
        onPointerMove={onPointerMove}
        onPointerUp={onPointerUp}
        onPointerCancel={() => {
          dragging.current = false;
          setDragY(0);
        }}
      >
        <HomeIndicator onClick={onClose} />
      </div>
    </div>
  );
}
