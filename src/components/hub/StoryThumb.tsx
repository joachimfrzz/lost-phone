import type { CatalogStory, ProgressStore } from "../../types/catalog";
import { ctaLabel, getStoryProgress } from "../../lib/progress";
import { StoryCover } from "./StoryCover";

interface StoryThumbProps {
  story: CatalogStory;
  progress: ProgressStore;
  onOpen: (id: string) => void;
}

export function StoryThumb({ story, progress, onOpen }: StoryThumbProps) {
  const playerProgress = getStoryProgress(progress, story.id);

  return (
    <button type="button" className="story-thumb" onClick={() => onOpen(story.id)}>
      <StoryCover story={story} variant="thumb" />
      <div className="story-thumb__overlay">
        <span className="story-thumb__genre">{story.genre_tag}</span>
        <span className="story-thumb__title">{story.title}</span>
        <span className="story-thumb__cta">{ctaLabel(playerProgress.statut)}</span>
      </div>
    </button>
  );
}
