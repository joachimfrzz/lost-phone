import { useEffect, useMemo, useState } from "react";
import { useNavigate } from "react-router-dom";
import type { CatalogManifest, CatalogStory } from "../types/catalog";
import { fetchCatalog } from "../lib/catalog";
import { useProgress } from "../hooks/useProgress";
import { SpotlightStory } from "../components/hub/SpotlightStory";
import { QueueStory } from "../components/hub/QueueStory";
import { StoryThumb } from "../components/hub/StoryThumb";
import { SettingsPanel } from "../components/hub/SettingsPanel";

export function HubPage() {
  const navigate = useNavigate();
  const { progress } = useProgress();
  const [catalog, setCatalog] = useState<CatalogManifest | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [settingsOpen, setSettingsOpen] = useState(false);
  const [soundEnabled, setSoundEnabled] = useState(
    () => localStorage.getItem("lost-phone-sound") !== "false",
  );

  useEffect(() => {
    fetchCatalog()
      .then(setCatalog)
      .catch((e) => setError(e instanceof Error ? e.message : "Erreur"))
      .finally(() => setLoading(false));
  }, []);

  const stories = useMemo(
    () => [...(catalog?.stories ?? [])].sort((a, b) => a.ordre_affichage - b.ordre_affichage),
    [catalog],
  );

  const featured =
    stories.find((s) => s.featured && s.statut_sortie === "available") ??
    stories.find((s) => s.statut_sortie === "available");

  const comingSoon = stories.filter((s) => s.statut_sortie === "coming_soon");
  const others = stories.filter(
    (s) => s.statut_sortie === "available" && s.id !== featured?.id,
  );

  const handleOpen = (storyId: string) => navigate(`/phone/${storyId}`);

  const handleSoundChange = (v: boolean) => {
    setSoundEnabled(v);
    localStorage.setItem("lost-phone-sound", v ? "true" : "false");
  };

  return (
    <div className="hub">
      <div className="hub__inner">
        <header className="hub__header">
          <div className="hub__brand">
            <span className="hub__brand-top">Lost</span>
            <span className="hub__brand-bottom">Phone</span>
          </div>
          <button
            type="button"
            className="hub__settings"
            onClick={() => setSettingsOpen(true)}
            aria-label="Paramètres"
          >
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" aria-hidden="true">
              <path
                d="M12 15a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z"
                stroke="currentColor"
                strokeWidth="1.5"
              />
              <path
                d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 1 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 1 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 1 1-2.83-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 1 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 1 1 2.83-2.83l.06.06A1.65 1.65 0 0 0 9 4.68a1.65 1.65 0 0 0 1-1.51V3a2 2 0 1 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 1 1 2.83 2.83l-.06.06A1.65 1.65 0 0 0 19.4 9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 1 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1Z"
                stroke="currentColor"
                strokeWidth="1.5"
              />
            </svg>
          </button>
        </header>

        <p className="hub__tagline">
          Chaque histoire commence par un objet oublié.
        </p>

        {loading && <p className="hub__status">Chargement…</p>}
        {error && <p className="hub__status hub__status--error">{error}</p>}

        {!loading && !error && (
          <>
            {featured && (
              <SpotlightStory story={featured} progress={progress} onOpen={handleOpen} />
            )}

            {comingSoon.length > 0 && (
              <section className="hub__section">
                <div className="hub__section-head">
                  <h2 className="hub__section-title">À venir</h2>
                  <span className="hub__section-rule" aria-hidden="true" />
                </div>
                <div className="hub__queue">
                  {comingSoon.map((story: CatalogStory) => (
                    <QueueStory key={story.id} story={story} />
                  ))}
                </div>
              </section>
            )}

            {others.length > 0 && (
              <section className="hub__section">
                <div className="hub__section-head">
                  <h2 className="hub__section-title">Catalogue</h2>
                  <span className="hub__section-rule" aria-hidden="true" />
                </div>
                <div className="hub__scroll">
                  {others.map((story: CatalogStory) => (
                    <StoryThumb
                      key={story.id}
                      story={story}
                      progress={progress}
                      onOpen={handleOpen}
                    />
                  ))}
                </div>
              </section>
            )}
          </>
        )}
      </div>

      <SettingsPanel
        open={settingsOpen}
        onClose={() => setSettingsOpen(false)}
        soundEnabled={soundEnabled}
        onSoundChange={handleSoundChange}
      />
    </div>
  );
}
