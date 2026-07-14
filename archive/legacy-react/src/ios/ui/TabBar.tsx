import type { ReactNode } from "react";

export interface TabItem {
  id: string;
  label: string;
  icon: ReactNode;
}

interface TabBarProps {
  tabs: TabItem[];
  active: string;
  onChange: (id: string) => void;
}

export function TabBar({ tabs, active, onChange }: TabBarProps) {
  return (
    <nav className="ui-tab-bar" aria-label="Onglets">
      {tabs.map((t) => (
        <button
          key={t.id}
          type="button"
          className={`ui-tab-bar__item ${active === t.id ? "ui-tab-bar__item--active" : ""}`}
          onClick={() => onChange(t.id)}
        >
          <span className="ui-tab-bar__icon">{t.icon}</span>
          <span className="ui-tab-bar__label">{t.label}</span>
        </button>
      ))}
    </nav>
  );
}
