export type ReleaseStatus = "available" | "coming_soon" | "locked";

export type ProgressStatus = "not_started" | "in_progress" | "completed";

export interface CatalogStory {
  id: string;
  title: string;
  tagline: string;
  synopsis?: string;
  genre_tag: string;
  profil_temporel_label: string;
  duree_estimee_min: number;
  statut_sortie: ReleaseStatus;
  date_sortie?: string;
  lpsp_path: string | null;
  cover_image?: string;
  cover_mood?: string;
  ordre_affichage: number;
  featured?: boolean;
}

export interface CatalogManifest {
  version: string;
  stories: CatalogStory[];
}

export interface StoryProgress {
  statut: ProgressStatus;
  last_played_at?: string;
}

export type ProgressStore = Record<string, StoryProgress>;
