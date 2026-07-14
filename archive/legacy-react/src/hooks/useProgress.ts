import { useCallback, useEffect, useState } from "react";
import type { ProgressStore } from "../types/catalog";
import { loadProgress, setStoryProgress } from "../lib/progress";
import type { ProgressStatus } from "../types/catalog";

export function useProgress() {
  const [progress, setProgress] = useState<ProgressStore>(() => loadProgress());

  useEffect(() => {
    const onStorage = () => setProgress(loadProgress());
    window.addEventListener("storage", onStorage);
    return () => window.removeEventListener("storage", onStorage);
  }, []);

  const mark = useCallback((storyId: string, statut: ProgressStatus) => {
    setProgress(setStoryProgress(storyId, statut));
  }, []);

  return { progress, mark };
}
