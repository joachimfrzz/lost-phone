import { useRef, useState } from "react";
import { NotificationCard } from "../components/ios/NotificationCard";
import { getFigmaScreen } from "../lib/figma/specs";
import { usePhone } from "../runtime/PhoneProvider";
import type { LpspEnvelope } from "../types/lpsp";
import { HomeIndicator } from "./IphoneShell";

interface LockScreenProps {
  envelope: LpspEnvelope;
}

const FIGMA = getFigmaScreen("lock-screen");

export function LockScreen({ envelope }: LockScreenProps) {
  const { notifications, swipeToUnlock, referenceMode } = usePhone();
  const time = envelope.heure_verrou ?? "18:04";
  const date = envelope.date_verrou ?? "Lun. 29 juin";
  const visible = notifications.slice(0, 3);

  const [dragY, setDragY] = useState(0);
  const [unlocking, setUnlocking] = useState(false);
  const startY = useRef(0);
  const dragging = useRef(false);
  const dragDelta = useRef(0);
  const zoneRef = useRef<HTMLDivElement>(null);

  function rubberBand(delta: number, max: number): number {
    if (delta <= max) return delta;
    const extra = delta - max;
    return max + extra * 0.25;
  }

  function onPointerDown(e: React.PointerEvent) {
    if (referenceMode || unlocking) return;
    dragging.current = true;
    startY.current = e.clientY;
    dragDelta.current = 0;
    (e.currentTarget as HTMLElement).setPointerCapture(e.pointerId);
  }

  function onPointerMove(e: React.PointerEvent) {
    if (!dragging.current || unlocking) return;
    const delta = startY.current - e.clientY;
    dragDelta.current = Math.max(0, delta);
    setDragY(rubberBand(dragDelta.current, 140));
  }

  function onPointerUp() {
    if (!dragging.current || unlocking) return;
    dragging.current = false;
    if (dragDelta.current > 72) {
      setUnlocking(true);
      setDragY(window.innerHeight);
      window.setTimeout(() => swipeToUnlock(), 380);
      return;
    }
    dragDelta.current = 0;
    setDragY(0);
  }

  const progress = Math.min(1, dragY / 120);
  const torchSymbol = FIGMA?.symbols?.flashlight ?? "􀝌";
  const cameraSymbol = FIGMA?.symbols?.camera ?? "􀌟";

  return (
    <div
      className={`ios-lock ${unlocking ? "ios-lock--unlocking" : ""}${FIGMA ? " ios-lock--figma" : ""}`}
      style={
        dragY > 0
          ? {
              transform: `translateY(${-dragY}px)`,
              opacity: `${1 - progress * 0.35}`,
            }
          : undefined
      }
    >
      <div className="ios-lock__clock-block">
        <p className="ios-lock__date">{date}</p>
        <time className="ios-lock__time">{time}</time>
      </div>

      <div className="ios-lock__notifs">
        {visible.map((n) => (
          <NotificationCard key={n.id} notification={n} variant="lock" />
        ))}
      </div>

      <div className="ios-lock__bottom">
        <button type="button" className="ios-lock__shortcut" aria-label="Lampe torche">
          <span className="ios-lock__sf" aria-hidden>
            {torchSymbol}
          </span>
        </button>

        <div
          ref={zoneRef}
          className="ios-lock__unlock-zone"
          onPointerDown={onPointerDown}
          onPointerMove={onPointerMove}
          onPointerUp={onPointerUp}
          onPointerCancel={onPointerUp}
        >
          <HomeIndicator />
        </div>

        <button type="button" className="ios-lock__shortcut" aria-label="Appareil photo">
          <span className="ios-lock__sf" aria-hidden>
            {cameraSymbol}
          </span>
        </button>
      </div>
    </div>
  );
}
