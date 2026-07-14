/** Mode d'exécution de la plateforme téléphone */
export type PlatformMode =
  /** iPhone vide — développement noyau + apps sans histoire */
  | "simulator"
  /** Comparaison visuelle vs captures iOS */
  | "reference"
  /** Jeu avec contenu LPSP et scénario */
  | "story";
