import { useEffect, useRef, useState } from "react";
import { AppIcon, SYSTEM_HOME_APPS } from "../components/ios/AppIcon";
import { usePhone } from "../runtime/PhoneProvider";
import { HomeIndicator } from "./IphoneShell";

export function HomeScreen() {
  const { appNames, dock, openApp, referenceHomePage } = usePhone();
  const gridApps = [
    ...SYSTEM_HOME_APPS,
    ...appNames.filter((a) => !dock.includes(a) && a !== "Réglages"),
  ];
  const pages = chunk(gridApps, 16);
  const [page, setPage] = useState(referenceHomePage ?? 0);

  useEffect(() => {
    if (referenceHomePage != null) setPage(referenceHomePage);
  }, [referenceHomePage]);
  const [dragX, setDragX] = useState(0);
  const [isDragging, setIsDragging] = useState(false);
  const startX = useRef(0);
  const screenRef = useRef<HTMLDivElement>(null);

  function openFromIcon(name: string, e: React.MouseEvent<HTMLButtonElement>) {
    const screen = screenRef.current?.getBoundingClientRect();
    const icon = e.currentTarget.getBoundingClientRect();
    if (screen) {
      const x = ((icon.left + icon.width / 2 - screen.left) / screen.width) * 100;
      const y = ((icon.top + icon.height / 2 - screen.top) / screen.height) * 100;
      openApp(name, { x, y });
    } else {
      openApp(name);
    }
  }

  function onPointerDown(e: React.PointerEvent) {
    setIsDragging(true);
    startX.current = e.clientX;
    setDragX(0);
    (e.currentTarget as HTMLElement).setPointerCapture(e.pointerId);
  }

  function onPointerMove(e: React.PointerEvent) {
    if (!isDragging) return;
    setDragX(e.clientX - startX.current);
  }

  function onPointerUp(e: React.PointerEvent) {
    if (!isDragging) return;
    setIsDragging(false);
    const dx = e.clientX - startX.current;
    setDragX(0);
    if (dx < -56 && page < pages.length - 1) setPage((p) => p + 1);
    if (dx > 56 && page > 0) setPage((p) => p - 1);
  }

  const trackOffset = -page * 100 + (dragX / (screenRef.current?.clientWidth ?? 393)) * 100;
  const resistance = pages.length <= 1 ? 0 : dragX * 0.35;

  return (
    <div className="ios-home ios-home--enter" ref={screenRef}>
      <div
        className="ios-home__pages"
        onPointerDown={onPointerDown}
        onPointerMove={onPointerMove}
        onPointerUp={onPointerUp}
        onPointerCancel={() => {
          setIsDragging(false);
          setDragX(0);
        }}
      >
        <div
          className="ios-home__track"
          style={{
            transform: `translateX(calc(${trackOffset}% + ${resistance}px))`,
            transition: isDragging ? "none" : "transform 0.38s cubic-bezier(0.32, 0.72, 0, 1)",
          }}
        >
          {pages.map((pageApps, pi) => (
            <div key={pi} className="ios-home__page">
              <div className="ios-home__grid">
                {pageApps.map((name) => (
                  <button
                    key={name}
                    type="button"
                    className="ios-icon-btn"
                    onClick={(e) => openFromIcon(name, e)}
                  >
                    <AppIcon app={name} squircle />
                    <span className="ios-icon-btn__label">{name}</span>
                  </button>
                ))}
              </div>
            </div>
          ))}
        </div>
      </div>

      {pages.length > 1 && (
        <div className="ios-home__pager" aria-hidden>
          {pages.map((_, i) => (
            <span key={i} className={`ios-home__dot ${i === page ? "ios-home__dot--active" : ""}`} />
          ))}
        </div>
      )}

      <button type="button" className="ios-home__search" aria-label="Rechercher">
        <span className="ios-home__search-icon" aria-hidden>
          􀊫
        </span>
        <span>Rechercher</span>
      </button>

      <div className="ios-dock">
        <div className="ios-dock__glass">
          {dock.map((name) => (
            <button
              key={name}
              type="button"
              className="ios-icon-btn ios-icon-btn--dock"
              onClick={(e) => openFromIcon(name, e)}
            >
              <AppIcon app={name} squircle />
            </button>
          ))}
        </div>
      </div>
      <HomeIndicator />
    </div>
  );
}

function chunk<T>(arr: T[], size: number): T[][] {
  const out: T[][] = [];
  for (let i = 0; i < arr.length; i += size) out.push(arr.slice(i, i + size));
  return out.length ? out : [[]];
}
