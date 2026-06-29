/** LPSP v1 — types consommés par le Phone Runtime */

export interface LpspNotification {
  app: string;
  titre: string;
  texte: string;
  heure: string;
  lu?: boolean;
}

export interface LpspEnvelope {
  heure_verrou?: string;
  date_verrou?: string;
  notifications_initiales?: LpspNotification[];
  fond_ecran?: { description?: string; source?: string };
  verrouillage?: string | LockConfig;
}

export interface LockConfig {
  type?: string;
  code?: string;
  indice_deductible?: string;
}

export interface ProfilTemporel {
  type?: string;
  moment_decouverte?: string;
  j_day?: string;
  description?: string;
  fenêtre_critique?: string;
  profondeur_historique?: string;
}

export interface LpspManifest {
  project_id: string;
  title: string;
  exported_at?: string;
  profil_temporel?: string | ProfilTemporel;
  apps_presentes: string[];
  coeur_narratif?: string | null;
}

export interface SpectreActions {
  definition?: string;
  actions_possibles?: string[];
  actions_impossibles?: string[];
}

export interface LpspPlayerConfig {
  verrouillage?: string | LockConfig;
  spectre_actions?: string | SpectreActions;
  apps_accessibles?: string[];
}

export interface LpspSystem {
  dock?: string[];
  wifi_enregistres?: Array<{ nom: string; lieu: string }>;
  focus_actif?: string;
  batterie?: string;
}

export interface ScenarioEvent {
  id: string;
  type: string;
  app: string;
  condition: string;
  contenu?: Record<string, unknown>;
}

export interface LpspScenario {
  profil?: string;
  evenements?: ScenarioEvent[];
}

export interface LpspPackage {
  lpsp_version: string;
  manifest: LpspManifest;
  player_config: LpspPlayerConfig;
  content: {
    envelope: LpspEnvelope;
    system: LpspSystem;
    apps: Record<string, unknown>;
  };
  scenario?: LpspScenario;
  progression_engine?: Record<string, unknown>;
  canon_engine?: Record<string, unknown>;
  qa_metadata?: { pret?: boolean; synthese?: string };
}

/** État runtime normalisé pour les plugins */
export type PhonePhase = "lock" | "pin" | "home" | "app";

export interface RuntimeNotification extends LpspNotification {
  id: string;
  lu: boolean;
}
