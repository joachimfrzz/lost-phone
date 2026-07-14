import { AppIcon } from "./AppIcon";
import type { RuntimeNotification } from "../../types/lpsp";

interface Props {
  notification: RuntimeNotification;
  variant?: "lock" | "banner";
}

export function NotificationCard({ notification: n, variant = "lock" }: Props) {
  return (
    <article className={`ios-notif ios-notif--${variant} ${n.lu ? "ios-notif--read" : ""}`}>
      <AppIcon app={n.app} size={38} squircle className="ios-notif__icon" />
      <div className="ios-notif__content">
        <header className="ios-notif__header">
          <span className="ios-notif__app">{n.app}</span>
          <time className="ios-notif__time">{n.heure}</time>
        </header>
        <p className="ios-notif__title">{n.titre}</p>
        <p className="ios-notif__body">{n.texte}</p>
      </div>
    </article>
  );
}
