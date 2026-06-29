import type { ReactNode } from "react";

interface GroupProps {
  header?: string;
  footer?: string;
  children: ReactNode;
}

export function Group({ header, footer, children }: GroupProps) {
  return (
    <section className="ui-group">
      {header && <h2 className="ui-group__header">{header}</h2>}
      <div className="ui-group__cells">{children}</div>
      {footer && <p className="ui-group__footer">{footer}</p>}
    </section>
  );
}

interface CellProps {
  label: ReactNode;
  detail?: ReactNode;
  accessory?: ReactNode;
  chevron?: boolean;
  onClick?: () => void;
  unread?: boolean;
  icon?: ReactNode;
  subtitle?: ReactNode;
}

export function Cell({ label, detail, accessory, chevron, onClick, unread, icon, subtitle }: CellProps) {
  const Tag = onClick ? "button" : "div";
  return (
    <Tag type={onClick ? "button" : undefined} className={`ui-cell ${unread ? "ui-cell--unread" : ""}`} onClick={onClick}>
      {icon && <span className="ui-cell__icon">{icon}</span>}
      <span className="ui-cell__body">
        <span className="ui-cell__label">{label}</span>
        {subtitle && <span className="ui-cell__subtitle">{subtitle}</span>}
      </span>
      {detail && <span className="ui-cell__detail">{detail}</span>}
      {accessory}
      {chevron && (
        <svg className="ui-cell__chevron" width="8" height="14" viewBox="0 0 8 14" aria-hidden>
          <path d="M1.5 1.5L6.5 7l-5 5.5" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" />
        </svg>
      )}
    </Tag>
  );
}

export function Avatar({ name, color }: { name?: string; color?: string }) {
  const letter = name?.charAt(0)?.toUpperCase() ?? "?";
  return (
    <span className="ui-avatar" style={color ? { background: color } : undefined}>
      {letter}
    </span>
  );
}
