import type { ReactNode } from "react";

interface NavBarProps {
  title: string;
  backLabel?: string;
  onBack?: () => void;
  right?: ReactNode;
  transparent?: boolean;
  dark?: boolean;
}

/** Barre de navigation iOS (inline title) */
export function NavBar({ title, backLabel = "Retour", onBack, right, transparent, dark }: NavBarProps) {
  return (
    <header
      className={`ui-nav ${transparent ? "ui-nav--transparent" : ""} ${dark ? "ui-nav--dark" : ""}`}
    >
      <div className="ui-nav__side">
        {onBack && (
          <button type="button" className="ui-nav__back" onClick={onBack}>
            <ChevronLeft />
            <span>{backLabel}</span>
          </button>
        )}
      </div>
      <h1 className="ui-nav__title">{title}</h1>
      <div className="ui-nav__side ui-nav__side--right">{right}</div>
    </header>
  );
}

interface LargeTitleProps {
  title: string;
  subtitle?: string;
}

/** Grand titre iOS (écran racine d'une app) */
export function LargeTitle({ title, subtitle }: LargeTitleProps) {
  return (
    <div className="ui-large-title">
      <h1>{title}</h1>
      {subtitle && <p>{subtitle}</p>}
    </div>
  );
}

function ChevronLeft() {
  return (
    <svg width="12" height="20" viewBox="0 0 12 20" aria-hidden>
      <path
        d="M10.5 1.5L2 10l8.5 8.5"
        fill="none"
        stroke="currentColor"
        strokeWidth="2.2"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
}
