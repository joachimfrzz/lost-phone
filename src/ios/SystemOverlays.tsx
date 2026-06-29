import { useRef } from "react";
import { usePhone } from "../runtime/PhoneProvider";
import type { RuntimeNotification } from "../types/lpsp";
import { SFBackward, SFForward, SFPlay } from "./ui/SFSymbols";

interface ControlCenterProps {
  open: boolean;
  onClose: () => void;
}

/** Centre de contrôle iOS 17 */
export function ControlCenter({ open, onClose }: ControlCenterProps) {
  if (!open) return null;

  return (
    <div className="ios-cc ios-cc--open" onClick={onClose} role="presentation">
      <div className="ios-cc__panel" onClick={(e) => e.stopPropagation()}>
        <div className="ios-cc__grid">
          <div className="ios-cc__module ios-cc__module--connectivity">
            <button type="button" className="ios-cc__toggle ios-cc__toggle--on" aria-label="Wi-Fi">
              <WifiIcon />
            </button>
            <button type="button" className="ios-cc__toggle ios-cc__toggle--on" aria-label="Bluetooth">
              <BluetoothIcon />
            </button>
            <button type="button" className="ios-cc__toggle" aria-label="Mode avion">
              <PlaneIcon />
            </button>
            <button type="button" className="ios-cc__toggle ios-cc__toggle--on" aria-label="Données cellulaires">
              <CellIcon />
            </button>
          </div>

          <div className="ios-cc__module ios-cc__module--media">
            <div className="ios-cc__media-art" aria-hidden />
            <div className="ios-cc__media-info">
              <span className="ios-cc__media-title">Non connecté</span>
              <span className="ios-cc__media-sub">Apple Music</span>
            </div>
            <div className="ios-cc__media-controls" aria-hidden>
              <SFBackward /><SFPlay /><SFForward />
            </div>
          </div>

          <div className="ios-cc__module ios-cc__module--sliders">
            <div className="ios-cc__slider ios-cc__slider--bright">
              <SunIcon />
              <div className="ios-cc__slider-track"><div className="ios-cc__slider-fill" style={{ height: "72%" }} /></div>
            </div>
            <div className="ios-cc__slider ios-cc__slider--volume">
              <SpeakerIcon />
              <div className="ios-cc__slider-track"><div className="ios-cc__slider-fill" style={{ height: "45%" }} /></div>
            </div>
          </div>

          <div className="ios-cc__module ios-cc__module--shortcuts">
            <button type="button" className="ios-cc__shortcut" aria-label="Lampe torche"><FlashIcon /></button>
            <button type="button" className="ios-cc__shortcut" aria-label="Minuteur"><TimerIcon /></button>
            <button type="button" className="ios-cc__shortcut" aria-label="Calculatrice"><CalcIcon /></button>
            <button type="button" className="ios-cc__shortcut" aria-label="Appareil photo"><CameraIcon /></button>
          </div>
        </div>
        <div className="ios-cc__handle" aria-hidden />
      </div>
    </div>
  );
}

interface NotificationCenterProps {
  open: boolean;
  onClose: () => void;
}

export function NotificationCenter({ open, onClose }: NotificationCenterProps) {
  const { notifications, markNotificationRead } = usePhone();
  if (!open) return null;

  return (
    <div className="ios-nc ios-nc--open" onClick={onClose} role="presentation">
      <div className="ios-nc__panel" onClick={(e) => e.stopPropagation()}>
        <header className="ios-nc__header">
          <h2>Centre de notifications</h2>
        </header>
        <div className="ios-nc__list">
          {notifications.length === 0 ? (
            <p className="ios-nc__empty">Aucune notification</p>
          ) : (
            notifications.map((n: RuntimeNotification) => (
              <button
                key={n.id}
                type="button"
                className="ios-nc__item"
                onClick={() => markNotificationRead(n.id)}
              >
                <span className="ios-nc__item-app">{n.app}</span>
                <strong>{n.titre}</strong>
                <p>{n.texte}</p>
                <time>{n.heure}</time>
              </button>
            ))
          )}
        </div>
      </div>
    </div>
  );
}

/** Gestes système : swipe bas depuis le haut (NC), swipe bas coin droit (CC) */
export function SystemGestures() {
  const { phase, openNotificationCenter, openControlCenter, referenceMode } = usePhone();
  const start = useRef<{ x: number; y: number } | null>(null);

  if (referenceMode || (phase !== "lock" && phase !== "home")) return null;

  function onPointerDown(e: React.PointerEvent) {
    if (e.clientY > 80) return;
    start.current = { x: e.clientX, y: e.clientY };
    (e.currentTarget as HTMLElement).setPointerCapture(e.pointerId);
  }

  function onPointerUp(e: React.PointerEvent) {
    if (!start.current) return;
    const dy = e.clientY - start.current.y;
    const sx = start.current.x;
    start.current = null;
    if (dy < 40) return;
    const fromRight = sx > window.innerWidth * 0.55;
    if (fromRight) openControlCenter();
    else openNotificationCenter();
  }

  return (
    <div
      className="ios-gestures"
      onPointerDown={onPointerDown}
      onPointerUp={onPointerUp}
      onPointerCancel={() => { start.current = null; }}
    />
  );
}

export function SystemOverlays() {
  const { overlay, closeOverlay, referenceMode } = usePhone();
  const onClose = referenceMode ? () => {} : closeOverlay;
  return (
    <>
      <NotificationCenter open={overlay === "notifications"} onClose={onClose} />
      <ControlCenter open={overlay === "control-center"} onClose={onClose} />
    </>
  );
}

function WifiIcon() {
  return (
    <svg width="22" height="18" viewBox="0 0 22 18" fill="currentColor" aria-hidden>
      <path d="M11 14a2 2 0 1 0 0-4 2 2 0 0 0 0 4Zm-7-3.5a8 8 0 0 1 14 0" fill="none" stroke="currentColor" strokeWidth="2" />
      <path d="M2 6.5a14 14 0 0 1 18 0" fill="none" stroke="currentColor" strokeWidth="2" />
    </svg>
  );
}

function BluetoothIcon() {
  return (
    <svg width="14" height="22" viewBox="0 0 14 22" fill="currentColor" aria-hidden>
      <path d="M7 1v20M7 1l6 6-6 4 6 4-6 6" fill="none" stroke="currentColor" strokeWidth="2" />
    </svg>
  );
}

function PlaneIcon() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="currentColor" aria-hidden>
      <path d="M2 12h20M12 2l4 10-4 10" fill="none" stroke="currentColor" strokeWidth="2" />
    </svg>
  );
}

function CellIcon() {
  return (
    <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor" aria-hidden>
      <rect x="7" y="2" width="6" height="16" rx="2" fill="none" stroke="currentColor" strokeWidth="2" />
    </svg>
  );
}

function SunIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor" aria-hidden>
      <circle cx="12" cy="12" r="4" />
    </svg>
  );
}

function SpeakerIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor" aria-hidden>
      <path d="M4 9v6h4l5 4V5L8 9H4z" />
    </svg>
  );
}

function FlashIcon() {
  return (
    <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor" aria-hidden>
      <path d="M13 2L4 14h7l-1 8 10-14h-7l0-6z" />
    </svg>
  );
}

function TimerIcon() {
  return (
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" aria-hidden>
      <circle cx="12" cy="13" r="8" /><path d="M12 9v4l3 2M9 2h6" />
    </svg>
  );
}

function CalcIcon() {
  return (
    <svg width="18" height="22" viewBox="0 0 18 22" fill="currentColor" aria-hidden>
      <rect x="1" y="1" width="16" height="20" rx="3" fill="none" stroke="currentColor" strokeWidth="1.5" />
    </svg>
  );
}

function CameraIcon() {
  return (
    <svg width="22" height="18" viewBox="0 0 24 20" fill="none" stroke="currentColor" strokeWidth="2" aria-hidden>
      <path d="M2 6h4l2-3h8l2 3h4v12H2V6z" /><circle cx="12" cy="12" r="3" />
    </svg>
  );
}
