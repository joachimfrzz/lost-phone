import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { figmaReferenceUrl, type FigmaScreenId } from "../lib/figma/specs";
import { enablePhoneImmersion } from "../lib/immersion";
import { EMPTY_DEVICE, SIMULATOR_PIN } from "../platform/emptyDevice";
import { PhoneProvider } from "../runtime/PhoneProvider";
import { PhoneRuntime } from "../runtime/PhoneRuntime";

type OverlayScreen = "lock-screen" | "home-screen";

/**
 * iPhone vide — développement du mini-iOS sans histoire.
 * PIN : 0000
 */
export function SimulatorPage() {
  const [figmaOverlay, setFigmaOverlay] = useState(false);
  const [overlayScreen, setOverlayScreen] = useState<OverlayScreen>("lock-screen");
  const [overlayOpacity, setOverlayOpacity] = useState(0.5);
  const figmaRef = figmaReferenceUrl(overlayScreen as FigmaScreenId);

  useEffect(() => enablePhoneImmersion(), []);

  return (
    <div className="phone-page phone-page--simulator">
      <div className="phone-page__frame phone-page__frame--figma-compare">
        <PhoneProvider lpsp={EMPTY_DEVICE} platformMode="simulator">
          <PhoneRuntime />
        </PhoneProvider>

        {figmaOverlay && figmaRef && (
          <img
            src={figmaRef}
            alt={`Référence Figma — ${overlayScreen}`}
            className="simulator-figma-overlay"
            style={{ opacity: overlayOpacity }}
          />
        )}
      </div>

      <aside className="simulator-hud" aria-label="Informations simulateur">
        <p className="simulator-hud__title">Simulateur iOS</p>
        <p className="simulator-hud__hint">
          Verrou validé ✓ — PIN : <code>{SIMULATOR_PIN}</code> → accueil
        </p>

        <div className="simulator-hud__figma">
          <label className="simulator-hud__toggle">
            <input
              type="checkbox"
              checked={figmaOverlay}
              onChange={(e) => setFigmaOverlay(e.target.checked)}
            />
            Overlay Figma
          </label>
          {figmaOverlay && (
            <>
              <label className="simulator-hud__opacity">
                Écran
                <select
                  value={overlayScreen}
                  onChange={(e) => setOverlayScreen(e.target.value as OverlayScreen)}
                >
                  <option value="lock-screen">Verrou</option>
                  <option value="home-screen">Accueil</option>
                </select>
              </label>
              <label className="simulator-hud__opacity">
                Opacité
                <input
                  type="range"
                  min={0}
                  max={100}
                  value={overlayOpacity * 100}
                  onChange={(e) => setOverlayOpacity(Number(e.target.value) / 100)}
                />
              </label>
            </>
          )}
        </div>

        <nav className="simulator-hud__links">
          <Link to="/ui-reference">Calibration / comparaison</Link>
          <Link to="/phone/j3-louvre">Mode histoire (j3-louvre)</Link>
          <Link to="/hub">Hub</Link>
        </nav>
      </aside>
    </div>
  );
}
