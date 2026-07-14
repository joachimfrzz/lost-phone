import type { CatalogStory, ProgressStore } from "../../types/catalog";
import { formatDuration } from "../../lib/catalog";
import { ctaLabel, getStoryProgress } from "../../lib/progress";
import { StoryCover } from "./StoryCover";

interface SpotlightStoryProps {
  story: CatalogStory;
  progress: ProgressStore;
  onOpen: (id: string) => void;
}

export function SpotlightStory({ story, progress, onOpen }: SpotlightStoryProps) {
  const playerProgress = getStoryProgress(progress, story.id);
  const synopsis = story.synopsis ?? story.tagline;
  const action =
    ctaLabel(playerProgress.statut) === "Ouvrir"
      ? "Explorer l'histoire"
      : ctaLabel(playerProgress.statut);

  return (
    <section className="spotlight">
      <div className="spotlight__frame">
        <StoryCover story={story} variant="spotlight" />
        <div className="spotlight__veil" aria-hidden="true" />

        <div className="spotlight__content">
          <p className="spotlight__kicker">{story.genre_tag}</p>
          <h2 className="spotlight__title">{story.title}</h2>
          <p className="spotlight__synopsis">{synopsis}</p>
          <p className="spotlight__meta">
            {formatDuration(story.duree_estimee_min)} · Téléphone {story.profil_temporel_label.toLowerCase()}
          </p>
          <button type="button" className="spotlight__cta" onClick={() => onOpen(story.id)}>
            {action}
            <span className="spotlight__cta-arrow" aria-hidden="true">→</span>
          </button>
        </div>
      </div>
    </section>
  );
}
