import { StatusIcons } from "../components/ios/StatusIcons";
import { DynamicIsland } from "./DynamicIsland";

export type StatusBarMode = "lock" | "home" | "app-light" | "app-dark";

interface StatusBarProps {
  mode: StatusBarMode;
  battery?: string;
  time?: string;
  carrier?: string;
  /** Mode silencieux — icône cloche barrée à côté de l'opérateur (verrou). */
  silent?: boolean;
}

/** Barre d'état iOS 17 */
export function StatusBar({
  mode,
  battery = "34%",
  time = "14:30",
  carrier = "Free",
  silent = true,
}: StatusBarProps) {
  const whiteIcons = mode === "lock" || mode === "home" || mode === "app-dark";
  const showCarrier = mode === "lock";
  const showTime = mode === "home" || mode === "app-light" || mode === "app-dark";

  return (
    <header className={`ios-status ${whiteIcons ? "ios-status--light" : "ios-status--dark"}`}>
      <div className="ios-status__left">
        {showCarrier && (
          <span className="ios-status__carrier-row">
            <span className="ios-status__carrier">{carrier}</span>
            {silent && (
              <svg className="ios-status__silent" width="16" height="16" viewBox="0 0 24 24" aria-hidden>
                <path
                  d="M5 9v6h3l5 4V5L8 9H5Z"
                  fill="currentColor"
                  opacity="0.9"
                />
                <path
                  d="M16 8l6 8M22 8l-6 8"
                  stroke="currentColor"
                  strokeWidth="1.8"
                  strokeLinecap="round"
                />
              </svg>
            )}
          </span>
        )}
        {showTime && <time className="ios-status__time">{time.slice(0, 5)}</time>}
      </div>
      <div className="ios-status__center">
        <DynamicIsland />
      </div>
      <div className="ios-status__right">
        <StatusIcons battery={battery} light={whiteIcons} />
      </div>
    </header>
  );
}
