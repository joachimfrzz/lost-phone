import { useEffect, useMemo, useState } from "react";
import {
  CAPTURE_LABELS,
  type CaptureId,
  allCaptureIds,
  captureUrl,
} from "../lib/captures";
import { figmaReferenceUrl } from "../lib/figma/specs";
import { enablePhoneImmersion } from "../lib/immersion";
import {
  CALIBRATION_QUEUE,
  activeCalibration,
  calibrationStatusLabel,
  isCalibrationUnlocked,
} from "../lib/reference/calibrationQueue";
import { LOCK_VIDE_CHECKLIST } from "../lib/reference/lockScreenChecklist";
import { measuredFor } from "../lib/reference/specs";
import { previewForCapture } from "../lib/reference/previewMap";
import { EMPTY_DEVICE } from "../platform/emptyDevice";
import { PhoneProvider } from "../runtime/PhoneProvider";
import { PhoneRuntime } from "../runtime/PhoneRuntime";
import "./ui-reference.css";

type ViewMode = "side" | "overlay";

export function UiReferencePage() {
  const current = activeCalibration();
  const [captureId, setCaptureId] = useState<CaptureId>(current.id);
  const [viewMode, setViewMode] = useState<ViewMode>("overlay");
  const [overlayOpacity, setOverlayOpacity] = useState(0.5);
  const lpsp = EMPTY_DEVICE;

  const preview = previewForCapture(captureId);
  const measured = measuredFor(captureId);
  const figmaRef =
    captureId === "system.lock-vide" || captureId === "system.lock-notifs"
      ? figmaReferenceUrl("lock-screen")
      : captureId === "system.home-p1" || captureId === "system.home-p2"
        ? figmaReferenceUrl("home-screen")
        : undefined;
  const ids = useMemo(() => allCaptureIds(), []);

  useEffect(() => enablePhoneImmersion(), []);

  const appIds = ids.filter((id) => id.startsWith("app."));

  function selectCapture(id: CaptureId) {
    if (!isCalibrationUnlocked(id)) return;
    setCaptureId(id);
  }

  function navItemClass(id: CaptureId) {
    const entry = CALIBRATION_QUEUE.find((e) => e.id === id);
    const locked = !isCalibrationUnlocked(id);
    return [
      "ui-ref__nav-item",
      id === captureId ? "ui-ref__nav-item--active" : "",
      locked ? "ui-ref__nav-item--locked" : "",
      entry?.status === "validated" ? "ui-ref__nav-item--done" : "",
    ]
      .filter(Boolean)
      .join(" ");
  }

  return (
    <div className="ui-ref">
      <aside className="ui-ref__sidebar">
        <header className="ui-ref__sidebar-head">
          <h1>Calibration pixel-perfect</h1>
          <p>Un écran validé à la fois — overlay 50 % jusqu'à quasi-identique.</p>
        </header>

        <div className="ui-ref__active">
          <span className="ui-ref__active-label">En cours</span>
          <strong>{current.label}</strong>
          <span className="ui-ref__active-status">{calibrationStatusLabel(current.status)}</span>
        </div>

        <nav className="ui-ref__nav">
          <p className="ui-ref__nav-title">Noyau (file d'attente)</p>
          {CALIBRATION_QUEUE.map((entry) => (
            <button
              key={entry.id}
              type="button"
              className={navItemClass(entry.id)}
              onClick={() => selectCapture(entry.id)}
              disabled={!isCalibrationUnlocked(entry.id)}
              title={
                !isCalibrationUnlocked(entry.id)
                  ? "Bloqué — valider l'écran précédent d'abord"
                  : undefined
              }
            >
              <span>{entry.label}</span>
              <span className="ui-ref__nav-badge">{calibrationStatusLabel(entry.status)}</span>
            </button>
          ))}

          <p className="ui-ref__nav-title ui-ref__nav-title--muted">Apps (après noyau)</p>
          {appIds.map((id) => (
            <button key={id} type="button" className="ui-ref__nav-item ui-ref__nav-item--locked" disabled>
              {CAPTURE_LABELS[id]}
            </button>
          ))}
        </nav>
      </aside>

      <main className="ui-ref__main">
        <div className="ui-ref__banner">
          <strong>Méthode :</strong> comparer avec la référence Figma Apple (prioritaire) ou capture iPhone.
          Overlay 50 % jusqu'à quasi-identique. Dites « OK {current.label} » pour débloquer le suivant.
        </div>

        <div className="ui-ref__toolbar">
          <h2>{CAPTURE_LABELS[captureId]}</h2>
          <div className="ui-ref__modes">
            <button
              type="button"
              className={viewMode === "side" ? "ui-ref__mode--active" : ""}
              onClick={() => setViewMode("side")}
            >
              Côte à côte
            </button>
            <button
              type="button"
              className={viewMode === "overlay" ? "ui-ref__mode--active" : ""}
              onClick={() => setViewMode("overlay")}
            >
              Overlay
            </button>
          </div>
          {viewMode === "overlay" && (
            <label className="ui-ref__opacity">
              Opacité capture
              <input
                type="range"
                min={0}
                max={100}
                value={overlayOpacity * 100}
                onChange={(e) => setOverlayOpacity(Number(e.target.value) / 100)}
              />
            </label>
          )}
        </div>

        {!preview ? (
          <p className="ui-ref__error">Aucun aperçu React mappé pour cette capture.</p>
        ) : (
          <div className={`ui-ref__compare ui-ref__compare--${viewMode}`}>
            <div className="ui-ref__panel">
              <span className="ui-ref__label">Implémentation React</span>
              <div className="ui-ref__phone">
                <PhoneProvider lpsp={lpsp} referencePreview={preview} platformMode="reference">
                  <PhoneRuntime />
                </PhoneProvider>
              </div>
            </div>

            <div
              className={`ui-ref__panel ui-ref__panel--capture${viewMode === "overlay" ? " ui-ref__panel--overlay" : ""}`}
            >
              <span className="ui-ref__label">
                {figmaRef ? "Référence Figma Apple" : "Capture iOS (référence)"}
              </span>
              <div className="ui-ref__phone ui-ref__phone--capture">
                <img
                  src={figmaRef ?? captureUrl(captureId)}
                  alt={`Référence ${CAPTURE_LABELS[captureId]}`}
                  className="ui-ref__capture-img"
                  style={viewMode === "overlay" ? { opacity: overlayOpacity } : undefined}
                />
              </div>
            </div>
          </div>
        )}

        {captureId === "system.lock-vide" && (
          <section className="ui-ref__checklist">
            <h3>Checklist — verrou vide</h3>
            <p className="ui-ref__warn">
              Fond d'écran : exporté depuis le kit Apple Figma (
              <code>/figma/assets/wallpaper-lock.png</code>).
            </p>
            {LOCK_VIDE_CHECKLIST.map((section) => (
              <div key={section.group} className="ui-ref__checklist-group">
                <h4>{section.group}</h4>
                <ul>
                  {section.items.map((item) => (
                    <li key={item}>{item}</li>
                  ))}
                </ul>
              </div>
            ))}
          </section>
        )}

        <section className="ui-ref__specs">
          <h3>Métriques mesurées</h3>
          {measured?.error ? (
            <p className="ui-ref__warn">
              Mesure indisponible ({measured.error}). Relancer <code>npm run reference:measure</code>.
            </p>
          ) : measured?.regions ? (
            <dl className="ui-ref__dl">
              <div>
                <dt>Status bar</dt>
                <dd>{measured.regions.statusBar?.heightLogical ?? "—"} px</dd>
              </div>
              <div>
                <dt>Horloge verrou (top)</dt>
                <dd>{measured.regions.lockClock?.topLogical ?? "—"} px</dd>
              </div>
              <div>
                <dt>Dock (top)</dt>
                <dd>{measured.regions.dock?.topLogical ?? "—"} px</dd>
              </div>
            </dl>
          ) : (
            <p className="ui-ref__warn">Pas encore mesuré pour cet écran.</p>
          )}
          <p className="ui-ref__hint">
            Voir <code>CALIBRATION.md</code> pour la file complète et les critères de validation.
          </p>
        </section>
      </main>
    </div>
  );
}
