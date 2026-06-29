import { useEffect, useState, type ReactNode } from "react";
import { captureUrl, type CaptureId } from "../lib/captures";

interface CaptureScreenProps {
  id: CaptureId;
  /** UI actuelle si pas de capture */
  fallback: ReactNode;
  /** Contenu interactif par-dessus la capture */
  children?: ReactNode;
  className?: string;
}

/**
 * Affiche screen.png du dossier capture si présent,
 * sinon le fallback React existant.
 */
export function CaptureScreen({ id, fallback, children, className = "" }: CaptureScreenProps) {
  const [mode, setMode] = useState<"loading" | "capture" | "fallback">("loading");
  const src = captureUrl(id);

  useEffect(() => {
    let cancelled = false;
    const img = new Image();
    img.onload = () => {
      if (!cancelled) setMode("capture");
    };
    img.onerror = () => {
      if (!cancelled) setMode("fallback");
    };
    img.src = src;
    return () => {
      cancelled = true;
    };
  }, [src]);

  if (mode === "loading") {
    return <div className="capture-screen capture-screen--loading" aria-hidden />;
  }

  if (mode === "fallback") {
    return <>{fallback}</>;
  }

  return (
    <div className={`capture-screen ${className}`.trim()}>
      <img className="capture-screen__img" src={src} alt="" draggable={false} />
      {children && <div className="capture-screen__overlay">{children}</div>}
    </div>
  );
}
