import type { CatalogStory } from "../../types/catalog";

interface StoryCoverProps {
  story: Pick<CatalogStory, "cover_image" | "cover_mood" | "title">;
  className?: string;
  variant?: "hero" | "spotlight" | "card" | "thumb";
}

export function StoryCover({ story, className = "", variant = "hero" }: StoryCoverProps) {
  const style = story.cover_image
    ? { backgroundImage: `url(${story.cover_image})` }
    : { background: moodFallback(story.cover_mood) };

  return (
    <div
      className={`story-cover story-cover--${variant} ${className}`}
      style={style}
      role="img"
      aria-label={story.title}
    >
      <div className="story-cover__shade" aria-hidden="true" />
    </div>
  );
}

function moodFallback(mood?: string): string {
  switch (mood) {
    case "train":
      return "linear-gradient(165deg, #1a2030 0%, #0a0e18 100%)";
    case "night":
      return "linear-gradient(165deg, #1e2838 0%, #080c14 100%)";
    default:
      return "linear-gradient(165deg, #252530 0%, #0a0a10 100%)";
  }
}
