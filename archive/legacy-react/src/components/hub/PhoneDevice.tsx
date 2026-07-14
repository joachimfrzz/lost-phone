import type { CSSProperties } from "react";
import type { LpspEnvelope, LpspNotification } from "../../types/lpsp";

interface PhoneDeviceProps {
  envelope?: LpspEnvelope | null;
  blurred?: boolean;
  size?: "hero" | "card" | "full";
  showGlow?: boolean;
  className?: string;
}

export function PhoneDevice({
  envelope,
  blurred = false,
  size = "card",
  showGlow = true,
  className = "",
}: PhoneDeviceProps) {
  const time = envelope?.heure_verrou ?? "14:32";
  const date = envelope?.date_verrou ?? "Dimanche 28 juin";
  const notifications = envelope?.notifications_initiales?.slice(0, blurred ? 0 : 3) ?? [];
  const unread = notifications.filter((n) => !n.lu).length;
  const wallpaperHint = envelope?.fond_ecran?.description;
  const mood = wallpaperMood(wallpaperHint, blurred);

  return (
    <div
      className={`phone-device phone-device--${size} ${blurred ? "phone-device--blurred" : ""} ${className}`}
      style={{ "--phone-glow": mood.glow } as CSSProperties}
    >
      {showGlow && !blurred && <div className="phone-device__glow" aria-hidden="true" />}
      <div className="phone-device__shell">
        <div className="phone-device__btn phone-device__btn--silent" aria-hidden="true" />
        <div className="phone-device__btn phone-device__btn--vol-up" aria-hidden="true" />
        <div className="phone-device__btn phone-device__btn--vol-down" aria-hidden="true" />
        <div className="phone-device__bezel">
          <div className="phone-device__island" aria-hidden="true" />
          <div className="phone-device__screen">
            <div
              className="phone-device__wallpaper"
              style={{ background: mood.wallpaper }}
            />
            <div className="phone-device__wallpaper-shine" aria-hidden="true" />
            <div className="phone-device__lock">
              <div className="phone-device__status">
                <span>{time.slice(0, 5)}</span>
                <span className="phone-device__status-icons">
                  <SignalIcon />
                  <WifiIcon />
                  <BatteryIcon />
                </span>
              </div>
              <div className="phone-device__clock">{time}</div>
              <div className="phone-device__date">{date}</div>
              {unread > 0 && !blurred && (
                <div className="phone-device__badge">{unread} non lues</div>
              )}
              {notifications.length > 0 && (
                <div className="phone-device__notifs">
                  {notifications.map((n, i) => (
                    <Notif key={i} n={n} />
                  ))}
                </div>
              )}
              {blurred && (
                <div className="phone-device__locked-label">Bientôt disponible</div>
              )}
              {!blurred && (
                <div className="phone-device__footer">
                  <span className="phone-device__footer-icon" aria-hidden="true" />
                  <span className="phone-device__swipe">Glisser pour ouvrir</span>
                  <span className="phone-device__footer-icon" aria-hidden="true" />
                </div>
              )}
            </div>
          </div>
          <div className="phone-device__home-bar" aria-hidden="true" />
        </div>
      </div>
    </div>
  );
}

function Notif({ n }: { n: LpspNotification }) {
  return (
    <div className={`phone-device__notif ${n.lu ? "phone-device__notif--read" : ""}`}>
      <div className="phone-device__notif-head">
        <span className="phone-device__notif-app">{n.app}</span>
        <span className="phone-device__notif-time">{n.heure}</span>
      </div>
      <div className="phone-device__notif-title">{n.titre}</div>
      <div className="phone-device__notif-text">{n.texte}</div>
    </div>
  );
}

function SignalIcon() {
  return (
    <svg width="16" height="11" viewBox="0 0 16 11" fill="currentColor" aria-hidden="true">
      <rect x="0" y="7" width="2.5" height="4" rx="0.5" opacity="0.4" />
      <rect x="4" y="5" width="2.5" height="6" rx="0.5" opacity="0.6" />
      <rect x="8" y="3" width="2.5" height="8" rx="0.5" opacity="0.8" />
      <rect x="12" y="0" width="2.5" height="11" rx="0.5" />
    </svg>
  );
}

function WifiIcon() {
  return (
    <svg width="14" height="11" viewBox="0 0 14 11" fill="none" aria-hidden="true">
      <path
        d="M7 9.5a1.25 1.25 0 1 0 0-2.5 1.25 1.25 0 0 0 0 2.5Z"
        fill="currentColor"
      />
      <path
        d="M3.5 6.2a5.5 5.5 0 0 1 7 0"
        stroke="currentColor"
        strokeWidth="1.2"
        strokeLinecap="round"
      />
      <path
        d="M1 3.5a9 9 0 0 1 12 0"
        stroke="currentColor"
        strokeWidth="1.2"
        strokeLinecap="round"
      />
    </svg>
  );
}

function BatteryIcon() {
  return (
    <svg width="22" height="11" viewBox="0 0 22 11" fill="none" aria-hidden="true">
      <rect x="0.5" y="0.5" width="18" height="10" rx="2.5" stroke="currentColor" />
      <rect x="2" y="2" width="12" height="7" rx="1.5" fill="currentColor" />
      <path d="M20 3.5v4a1.5 1.5 0 0 0 0-4Z" fill="currentColor" opacity="0.5" />
    </svg>
  );
}

function wallpaperMood(description?: string, muted?: boolean) {
  if (muted) {
    return {
      wallpaper:
        "radial-gradient(ellipse 80% 60% at 50% 20%, #2a2a38 0%, #12121a 45%, #060608 100%)",
      glow: "rgba(120, 120, 160, 0.25)",
    };
  }
  const lower = (description ?? "").toLowerCase();
  if (lower.includes("été") || lower.includes("photo") || lower.includes("personnes")) {
    return {
      wallpaper:
        "radial-gradient(ellipse 90% 70% at 30% 15%, #6b7f99 0%, #3d4f68 25%, #1e2838 55%, #0a0e14 100%), linear-gradient(180deg, rgba(255,200,140,0.08) 0%, transparent 40%)",
      glow: "rgba(107, 127, 153, 0.45)",
    };
  }
  if (lower.includes("nuit") || lower.includes("train")) {
    return {
      wallpaper:
        "radial-gradient(ellipse 80% 50% at 70% 10%, #1a3050 0%, #0f1828 40%, #050810 100%)",
      glow: "rgba(26, 48, 80, 0.5)",
    };
  }
  return {
    wallpaper:
      "radial-gradient(ellipse 85% 65% at 40% 12%, #4a5568 0%, #252d3a 35%, #0c1018 100%)",
    glow: "rgba(74, 85, 104, 0.4)",
  };
}
