import type { CSSProperties, ReactNode } from "react";

interface IphoneShellProps {
  wallpaper: string;
  children: ReactNode;
  className?: string;
}

/** Écran iPhone plein viewport — pas de coque ni Dynamic Island simulée */
export function IphoneShell({ wallpaper, children, className = "" }: IphoneShellProps) {
  const isPhoto = wallpaper.includes("url(");
  return (
    <div className={`iphone ${className}`}>
      <div className="iphone__screen">
        <div
          className={`iphone__wallpaper${isPhoto ? " iphone__wallpaper--photo" : ""}`}
          style={{ background: wallpaper } as CSSProperties}
        />
        <div className="iphone__wallpaper-dim" aria-hidden />
        <div className="iphone__content">{children}</div>
      </div>
    </div>
  );
}

export function HomeIndicator({ onClick, hidden }: { onClick?: () => void; hidden?: boolean }) {
  if (hidden) return null;
  return (
    <button
      type="button"
      className="iphone__home-indicator"
      onClick={onClick}
      aria-label="Accueil"
    />
  );
}
