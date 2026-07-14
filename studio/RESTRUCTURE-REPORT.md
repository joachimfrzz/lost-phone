# Rapport de restructuration — LostPhone Studio

**Date :** juillet 2026  
**Objectif :** Préparer une base propre pour le nouveau compte Cursor, sans perdre le travail existant.

---

## 1. Ce que j'ai compris du projet

### Lost Phone (le jeu)

Jeu d'investigation sur **iPhone simulé** : le joueur explore le téléphone d'un personnage via des apps iOS clones (WhatsApp, Instagram, Mail, etc.) alimentées par des données **LPSP JSON** (histoires dans `public/stories/`).

**Architecture runtime (SwiftUI) :**
- `Game/` — menu, choix d'histoire, progression
- `Phone/` — verrou, PIN, écran d'accueil
- `Apps/` — Clone (Apple), Vendored (tiers), Awesome (fallback généré)
- `Core/` — loader LPSP, adapters, routing (`LpspAppRouter`)

### LostPhone Studio (l'environnement)

Le dépôt contient déjà les briques d'un studio, mais dispersées :
- **61 apps** showroom (matrice vendoring)
- **3 histoires** LPSP
- **CI** GitHub Actions (preview simulateur) + Codemagic (TestFlight)
- **QA** Spectr pixel diff, preflight Swift, bugs Notion
- **Tooling** vendoring Python, génération Awesome v3, sync LPSP

### Historique technique

| Ère | Stack | Statut |
|-----|-------|--------|
| 2025–début 2026 | React + Figma + Capacitor | Archivé |
| Mi-2026 | Pivot SwiftUI natif | **Actif** |
| Juil. 2026 | Showroom : zerocode117 + Vendored Sopheamen | **Actif** |

### État CI (au moment de la restructuration)

- GitHub Actions run **#207** vert (build 25, commit `9811b40`)
- Runtime compile : `Clone/`, `Vendored/`, `Awesome/` uniquement

---

## 2. Améliorations réalisées

### Hub LostPhone Studio créé

| Fichier | Rôle |
|---------|------|
| `README.md` (racine) | Point d'entrée unique |
| `AGENTS.md` | Instructions pour agents Cursor (nouveau compte) |
| `studio/README.md` | Hub Studio |
| `studio/VISION.md` | Philosophie et domaines |
| `studio/DECISIONS.md` | Journal des 10 décisions d'architecture |
| `studio/STRUCTURE.md` | Arborescence actuelle et cible |
| `studio/docs/INDEX.md` | Index de toute la documentation |
| `studio/docs/ops/PREVIEW-CI.md` | Synthèse CI |

### Archivage (rien supprimé)

~**2300 fichiers** déplacés vers `archive/` — voir `archive/README.md`.

### Simplifications

- `package.json` réduit à `lpsp:sync` uniquement
- `codemagic.yaml` : workflow Capacitor retiré (archivé)
- Docs pré-pivot regroupées dans `archive/docs-pre-pivot/`
- Formats CLONE_PICKS dupliqués archivés (canonique : `JOACHIM_CLONE_PICKS.md`)

### Harmonisation

- `LostPhone/README.md` pointe vers Studio
- `.gitignore` mis à jour pour chemins Capacitor archivés
- `project.yml` commenté (Sopheamen archivé)

---

## 3. Éléments archivés

| Dossier | Contenu approximatif |
|---------|---------------------|
| `archive/legacy-react/` | `src/`, vite, tsconfig (~102 fichiers app) |
| `archive/legacy-capacitor/` | `ios/` Capacitor (~47 fichiers) |
| `archive/legacy-ios-swiftui/` | Squelette SwiftUI early |
| `archive/sopheamen-raw/` | **2136 fichiers** Patreon bruts |
| `archive/zerocode117-backup/` | Backup Mail/AppStore/Music |
| `archive/docs-pre-pivot/` | PLAN, FIGMA, NATIVE, ARCHITECTURE React… |
| `archive/docs-duplicate-formats/` | CLONE_PICKS csv/txt/html |
| `archive/legacy-public/` | figma/, captures-ios/ |
| `archive/scripts-legacy/` | 15 scripts figma/captures |
| `archive/config-duplicates/` | codemagic dupliqués + legacy Capacitor |

---

## 4. Problèmes détectés

| Problème | Gravité | Note |
|----------|---------|------|
| Git rename collision (IDEWorkspaceChecks.plist) | Faible | 1 plist identique Sopheamen ↔ ios ; archive intacte |
| `Awesome/` encore en runtime fallback | Moyen | Stratégie = retirer quand Vendored complet |
| Notion ↔ code non synchronisé | Moyen | Statuts Notion pas auto-mis à jour |
| Triple copie LPSP (public → Resources → bundle) | Faible | Sync script en place ; une source éditoriale |
| Pas de `.cursor/rules` | Faible | `AGENTS.md` compense pour nouveau compte |
| Taille git (~2100 fichiers archivés) | Info | Option future : repo archive séparé |
| `node_modules` / dépendances React orphelines | Faible | `package.json` minimal ; supprimer `node_modules` localement |

### Non modifié (volontairement)

- Arborescence `LostPhone/LostPhone/` (évite de casser CI)
- Apps runtime (Clone, Vendored, Awesome)
- Scripts actifs dans `LostPhone/scripts/`
- Build number 25

---

## 5. Recommandations pour la suite

### Phase 1 — Valider la base (immédiat)

1. **Push** ce commit sur `main` depuis le nouveau compte Cursor
2. Vérifier **GitHub Actions #208** (build vert après restructuration)
3. Lancer **Codemagic** TestFlight build 25+
4. Tester sur iPhone les apps critiques

### Phase 2 — Studio v0 (prochain développement)

1. **Preflight CI v2** — scanner MainActor, keypaths, doublons de types
2. **Notion sync** — workflow bugs : Notion → checklist → statut auto
3. **Definition of Done par app** — contrat (contraste, navigation, envoi message)
4. **Convergence scripts** — `studio/tooling/` ← migration progressive depuis `LostPhone/scripts/`

### Phase 3 — Architecture long terme

1. Renommer `public/stories/` → `content/stories/`
2. Retirer `Awesome/` quand matrice Vendored complète
3. Repo `archive/` séparé si taille git problématique
4. Domaines Analytics / Marketing / Business dans `studio/domains/`

---

## 6. Démarrage nouveau compte Cursor

1. Cloner `joachimfrzz/lost-phone`
2. Lire `AGENTS.md` puis `studio/README.md`
3. Index docs : `studio/docs/INDEX.md`
4. Ne pas toucher `archive/` sauf restauration documentée

**Commande essentielle :**
```bash
npm run lpsp:sync
cd LostPhone && xcodegen generate
```

---

*Rapport généré lors de la phase d'analyse et restructuration LostPhone Studio.*
