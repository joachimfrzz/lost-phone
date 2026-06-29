/** Bloque les comportements « navigateur » qui cassent l’illusion iPhone */

export function enablePhoneImmersion(): () => void {
  const html = document.documentElement;
  html.classList.add("phone-game");

  const blockContext = (e: Event) => e.preventDefault();
  const blockDrag = (e: DragEvent) => e.preventDefault();

  document.addEventListener("contextmenu", blockContext);
  document.addEventListener("dragstart", blockDrag);

  let lastTouch = 0;
  const blockDoubleTapZoom = (e: TouchEvent) => {
    const now = Date.now();
    if (now - lastTouch < 320) e.preventDefault();
    lastTouch = now;
  };
  document.addEventListener("touchend", blockDoubleTapZoom, { passive: false });

  return () => {
    html.classList.remove("phone-game");
    document.removeEventListener("contextmenu", blockContext);
    document.removeEventListener("dragstart", blockDrag);
    document.removeEventListener("touchend", blockDoubleTapZoom);
  };
}

/** Écran noir bref — comme un iPhone qui s’allume sur le verrou */
export function wakeDelayMs(): number {
  return 480;
}
