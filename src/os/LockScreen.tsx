import { NotificationCard } from "../components/ios/NotificationCard";
import { usePhone } from "../runtime/PhoneProvider";
import type { LpspEnvelope } from "../types/lpsp";

interface LockScreenProps {
  envelope: LpspEnvelope;
}

export function LockScreen({ envelope }: LockScreenProps) {
  const { notifications, swipeToUnlock } = usePhone();
  const time = envelope.heure_verrou ?? "14:30";
  const date = envelope.date_verrou ?? "";
  const visible = notifications.slice(0, 4);

  return (
    <div className="os-lock">
      <div className="os-lock__top">
        <div className="os-lock__clock">{time}</div>
        <div className="os-lock__date">{date}</div>
      </div>

      <div className="os-lock__notifs-stack">
        {visible.map((n) => (
          <NotificationCard key={n.id} notification={n} />
        ))}
      </div>

      <button type="button" className="os-lock__swipe-bar" onClick={swipeToUnlock} aria-label="Déverrouiller">
        <span className="os-lock__swipe-pill" />
      </button>
    </div>
  );
}
