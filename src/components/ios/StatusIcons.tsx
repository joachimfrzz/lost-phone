interface StatusIconsProps {
  battery?: string;
  light?: boolean;
  /** iOS 17 — pourcentage visible dans l’icône batterie */
  showBatteryPct?: boolean;
}

export function StatusIcons({ battery = "100%", light = true, showBatteryPct = true }: StatusIconsProps) {
  const pct = Math.min(100, Math.max(0, parseInt(battery, 10) || 34));
  const low = pct <= 20;
  const color = light ? "#fff" : "#000";

  return (
    <div className="ios-status-icons" style={{ color }}>
      {/* Cellulaire iOS */}
      <svg width="19" height="13" viewBox="0 0 19 13" aria-hidden>
        <rect x="1" y="9" width="3" height="3" rx="0.6" fill="currentColor" opacity="0.35" />
        <rect x="5.5" y="6.5" width="3" height="5.5" rx="0.6" fill="currentColor" opacity="0.55" />
        <rect x="10" y="4" width="3" height="8" rx="0.6" fill="currentColor" opacity="0.75" />
        <rect x="14.5" y="1" width="3" height="11" rx="0.6" fill="currentColor" />
      </svg>
      {/* Wi‑Fi iOS */}
      <svg width="17" height="12" viewBox="0 0 17 12" fill="none" aria-hidden>
        <path
          d="M8.5 10.5a1.1 1.1 0 1 0 0-2.2 1.1 1.1 0 0 0 0 2.2Z"
          fill="currentColor"
        />
        <path
          d="M4.2 7.1a5.2 5.2 0 0 1 8.6 0"
          stroke="currentColor"
          strokeWidth="1.35"
          strokeLinecap="round"
        />
        <path
          d="M1.2 3.8a9.2 9.2 0 0 1 14.6 0"
          stroke="currentColor"
          strokeWidth="1.35"
          strokeLinecap="round"
        />
      </svg>
      {/* Batterie iOS */}
      <div className={`ios-battery ${low ? "ios-battery--low" : ""}`}>
        <svg width="27" height="13" viewBox="0 0 27 13" aria-hidden>
          <rect
            x="0.5"
            y="0.5"
            width="22"
            height="12"
            rx="3.5"
            stroke="currentColor"
            fill="none"
            strokeWidth="1"
            opacity="0.45"
          />
          <rect
            x="2"
            y="2"
            width={Math.max(3, (18 * pct) / 100)}
            height="9"
            rx="2"
            fill={low ? "#ff3b30" : "currentColor"}
          />
          <path
            d="M24 4.2a1.8 1.8 0 0 1 0 4.6"
            stroke="currentColor"
            strokeWidth="1"
            fill="none"
            opacity="0.45"
          />
        </svg>
        {showBatteryPct && (
          <span className={`ios-battery__pct${low ? " ios-battery__pct--low" : ""}`}>{pct}</span>
        )}
      </div>
    </div>
  );
}

function BackspaceIcon() {
  return (
    <svg width="28" height="22" viewBox="0 0 28 22" fill="none" aria-hidden>
      <path
        d="M8 2H24a3 3 0 0 1 3 3v12a3 3 0 0 1-3 3H8L2 11l6-9Z"
        stroke="currentColor"
        strokeWidth="1.5"
        fill="none"
      />
      <path d="M17 8l-4 4 4 4M13 12h6" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" />
    </svg>
  );
}

export { BackspaceIcon };
