import type { ProgressStatus, ProgressStore, StoryProgress } from "../types/catalog";

const STORAGE_KEY = "lost-phone-progress";

export function loadProgress(): ProgressStore {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (!raw) return {};
    return JSON.parse(raw) as ProgressStore;
  } catch {
    return {};
  }
}

export function saveProgress(store: ProgressStore): void {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(store));
}

export function getStoryProgress(
  store: ProgressStore,
  storyId: string,
): StoryProgress {
  return store[storyId] ?? { statut: "not_started" };
}

export function setStoryProgress(
  storyId: string,
  statut: ProgressStatus,
): ProgressStore {
  const store = loadProgress();
  store[storyId] = {
    statut,
    last_played_at: new Date().toISOString(),
  };
  saveProgress(store);
  return store;
}

export function progressLabel(statut: ProgressStatus): string {
  switch (statut) {
    case "not_started":
      return "Non ouvert";
    case "in_progress":
      return "En cours";
    case "completed":
      return "Terminé";
  }
}

export function ctaLabel(statut: ProgressStatus): string {
  switch (statut) {
    case "not_started":
      return "Ouvrir";
    case "in_progress":
      return "Reprendre";
    case "completed":
      return "Rejouer";
  }
}
