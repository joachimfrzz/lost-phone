import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import type { CatalogStory } from "../types/catalog";
import type { LpspPackage } from "../types/lpsp";
import { fetchCatalog, fetchLpsp } from "../lib/catalog";
import { enablePhoneImmersion, wakeDelayMs } from "../lib/immersion";
import { validateLpsp } from "../lib/lpsp/normalize";
import { useProgress } from "../hooks/useProgress";
import { PhoneProvider } from "../runtime/PhoneProvider";
import { PhoneRuntime } from "../runtime/PhoneRuntime";

/** Téléphone du personnage — fenêtre navigateur, contenu LPSP, UI iOS en React. */
export function PhonePage() {
  const { storyId } = useParams<{ storyId: string }>();
  const { mark } = useProgress();
  const [story, setStory] = useState<CatalogStory | null>(null);
  const [lpsp, setLpsp] = useState<LpspPackage | null>(null);
  const [loading, setLoading] = useState(true);
  const [awake, setAwake] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!storyId) return;
    let cancelled = false;

    async function load() {
      try {
        const catalog = await fetchCatalog();
        const entry = catalog.stories.find((s) => s.id === storyId);
        if (!entry?.lpsp_path) throw new Error("Histoire indisponible");
        if (cancelled) return;
        setStory(entry);

        const pkg = await fetchLpsp(entry.lpsp_path);
        if (!validateLpsp(pkg)) throw new Error("Package LPSP invalide");
        if (cancelled) return;
        setLpsp(pkg);
        mark(storyId!, "in_progress");
      } catch (e) {
        if (!cancelled) setError(e instanceof Error ? e.message : "Erreur");
      } finally {
        if (!cancelled) setLoading(false);
      }
    }

    load();
    return () => {
      cancelled = true;
    };
  }, [storyId, mark]);

  useEffect(() => {
    const disableImmersion = enablePhoneImmersion();
    return () => disableImmersion();
  }, []);

  useEffect(() => {
    if (loading || error || !lpsp) {
      setAwake(false);
      return;
    }
    const t = window.setTimeout(() => setAwake(true), wakeDelayMs());
    return () => window.clearTimeout(t);
  }, [loading, error, lpsp]);

  if (loading || (!awake && !error)) {
    return (
      <div className="phone-page phone-page--loading">
        <div className="phone-page__frame">
          <div className="iphone-wake iphone-wake--inline" aria-hidden />
        </div>
      </div>
    );
  }

  if (error || !lpsp) {
    return (
      <div className="phone-page phone-page--error">
        <div className="phone-page__frame phone-page__frame--error">
          <p>{error ?? "Indisponible"}</p>
        </div>
      </div>
    );
  }

  return (
    <div className="phone-page">
      <div className="phone-page__frame">
        <PhoneProvider lpsp={lpsp}>
          <PhoneRuntime />
        </PhoneProvider>
      </div>
      <span className="phone-page__title" aria-hidden>
        {story?.title}
      </span>
    </div>
  );
}
