import { useEffect, useState } from "react";
import type { CatalogStory } from "../../types/catalog";
import { formatCountdown, formatReleaseDate } from "../../lib/catalog";
import { StoryCover } from "./StoryCover";

interface QueueStoryProps {
  story: CatalogStory;
}

export function QueueStory({ story }: QueueStoryProps) {
  const [countdown, setCountdown] = useState("");
  const [notifySet, setNotifySet] = useState(
    () => localStorage.getItem(`lost-phone-notify-${story.id}`) === "true",
  );

  useEffect(() => {
    if (!story.date_sortie) return;
    const tick = () => setCountdown(formatCountdown(story.date_sortie!));
    tick();
    const id = window.setInterval(tick, 1000);
    return () => window.clearInterval(id);
  }, [story.date_sortie]);

  const handleNotify = () => {
    setNotifySet(true);
    localStorage.setItem(`lost-phone-notify-${story.id}`, "true");
  };

  const releaseLabel = story.date_sortie ? formatReleaseDate(story.date_sortie) : "";

  return (
    <article className="queue-item">
      <div className="queue-item__thumb">
        <StoryCover story={story} variant="thumb" />
      </div>

      <div className="queue-item__body">
        <div className="queue-item__head">
          <span className="queue-item__genre">{story.genre_tag}</span>
          {countdown && (
            <span className="queue-item__countdown">{countdown}</span>
          )}
        </div>

        <h3 className="queue-item__title">{story.title}</h3>

        {releaseLabel && (
          <p className="queue-item__date">{releaseLabel}</p>
        )}

        <p className="queue-item__teaser">{story.tagline}</p>

        <button
          type="button"
          className={`queue-item__notify ${notifySet ? "queue-item__notify--done" : ""}`}
          onClick={handleNotify}
          disabled={notifySet}
        >
          {notifySet ? "Alerte enregistrée" : "M'avertir à la sortie"}
        </button>
      </div>
    </article>
  );
}
