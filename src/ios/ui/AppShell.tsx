import type { ReactNode } from "react";

export type AppTheme =
  | "light"
  | "dark"
  | "messages"
  | "whatsapp"
  | "signal"
  | "mail"
  | "notes"
  | "photos"
  | "safari"
  | "maps"
  | "instagram"
  | "uber"
  | "bank"
  | "spotify"
  | "disney"
  | "files"
  | "reminders"
  | "calendar"
  | "phone";

interface AppShellProps {
  theme?: AppTheme;
  children: ReactNode;
  className?: string;
}

/** Conteneur racine d'une app iOS — fond, safe area, scroll */
export function AppShell({ theme = "light", children, className = "" }: AppShellProps) {
  return (
    <div className={`ui-app ui-app--${theme} ${className}`}>
      <div className="ui-app__body">{children}</div>
    </div>
  );
}
