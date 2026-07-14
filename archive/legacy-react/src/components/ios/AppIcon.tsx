/** Icônes iOS 17 — assets SVG (/public/ios/icons/) */

const ICON_SLUG: Record<string, string> = {
  Messages: "messages",
  Telephone: "phone",
  Photos: "photos",
  Safari: "safari",
  Notes: "notes",
  Contacts: "contacts",
  Mail: "mail",
  Calendrier: "calendar",
  Réglages: "settings",
  WhatsApp: "whatsapp",
  Signal: "signal",
  "Google Maps": "maps",
  Fichiers: "files",
  Rappels: "reminders",
  Instagram: "instagram",
  Uber: "uber",
  "Crédit Agricole": "credit-agricole",
  Spotify: "spotify",
  Netflix: "netflix",
};

interface AppIconProps {
  app: string;
  size?: number;
  className?: string;
  squircle?: boolean;
}

export function AppIcon({ app, size, className = "", squircle = true }: AppIconProps) {
  const slug = ICON_SLUG[app] ?? "generic";
  const dim = size ?? undefined;
  return (
    <span
      className={`ios-app-icon ${squircle ? "ios-app-icon--squircle" : ""} ${className}`}
      style={dim != null ? { width: dim, height: dim } : undefined}
      aria-hidden
    >
      <img
        className="ios-app-icon__img"
        src={`${import.meta.env.BASE_URL}ios/icons/${slug}.svg`}
        alt=""
        width={size}
        height={size}
        draggable={false}
        loading="eager"
      />
    </span>
  );
}

/** Apps système toujours présentes sur l'écran d'accueil iOS */
export const SYSTEM_HOME_APPS = ["Réglages"] as const;
