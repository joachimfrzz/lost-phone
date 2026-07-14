import { StatusIcons } from "../components/ios/StatusIcons";
import type { LpspSystem } from "../types/lpsp";

interface StatusBarProps {
  system?: LpspSystem;
  time?: string;
  light?: boolean;
}

export function StatusBar({ system, time = "14:30", light = true }: StatusBarProps) {
  return (
    <div className={`os-status ${light ? "os-status--light" : "os-status--dark"}`}>
      <span className="os-status__time">{time.slice(0, 5)}</span>
      <StatusIcons battery={system?.batterie ?? "34%"} light={light} />
    </div>
  );
}
