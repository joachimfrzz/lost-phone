# Lost Phone — Architecture plateforme iOS

> **Plan détaillé :** voir [PLAN.md](./PLAN.md) — feuille de route complète jusqu’à un iOS fonctionnel (~16 semaines).

## Principe

Lost Phone n’est pas une collection d’écrans d’histoire. C’est un **mini-iOS** dans lequel on injecte ensuite des histoires.

```
┌─────────────────────────────────────────┐
│  Couche 5 — Contenu (LPSP / scénario)   │  ← remplit les apps existantes
├─────────────────────────────────────────┤
│  Couche 4 — Apps tierces (Instagram…)   │
├─────────────────────────────────────────┤
│  Couche 3 — Apps natives (Messages…)    │
├─────────────────────────────────────────┤
│  Couche 2 — Design system iOS           │
├─────────────────────────────────────────┤
│  Couche 1 — Noyau système iOS           │  ← verrou, accueil, CC, NC, gestes…
└─────────────────────────────────────────┘
```

**Règle absolue :** aucun écran n’est développé de mémoire. Chaque écran est calibré contre une capture iOS de référence (`public/captures-ios/`) jusqu’à quasi-identique. Les captures définissent le **design**, jamais le **contenu** affiché en jeu.

---

## Phases de développement

### Phase 1 — Noyau système (iPhone vide)

Objectif : un iPhone sans histoire doit déjà ressembler à un vrai iPhone.

| Composant | État | Capture de référence |
|-----------|------|----------------------|
| Verrou (vide / notifs) | En cours | `system.lock-vide`, `system.lock-notifs` |
| Code PIN | En cours | `system.pin` |
| Face ID | À faire | *(capture à ajouter)* |
| Accueil + dock + pager | En cours | `system.home-p1`, `system.home-p2` |
| Centre de notifications | En cours | `system.notification-center` |
| Centre de contrôle | En cours | `system.control-center` |
| Status bar + Dynamic Island | En cours | toutes captures système |
| Gestes (swipe unlock, NC, CC) | Partiel | — |
| Transitions app open/close | Partiel | — |
| Clavier système | À faire | *(capture à ajouter)* |
| Alertes / sheets / menus | À faire | *(captures à ajouter)* |

**Dev :** [`/simulator`](/simulator) — iPhone vide, aucune LPSP.

### Phase 2 — Design system

Bibliothèque unique `src/platform/design-system/` (migration depuis `src/ios/ui/`).

Toutes les apps **doivent** composer leurs écrans à partir de ces composants — jamais de styles ad hoc par écran.

| Composant | Fichier actuel | Statut |
|-----------|----------------|--------|
| NavBar / LargeTitle | `ui/NavBar.tsx` | Basique |
| List Group / Cell | `ui/List.tsx` | Basique |
| TabBar | `ui/TabBar.tsx` | Basique |
| AppShell | `ui/AppShell.tsx` | Basique |
| ChatThread / Composer | `ui/Chat*.tsx` | Messages only |
| SearchField | — | **Manquant** |
| Switch / Toggle | — | **Manquant** |
| SegmentedControl | — | **Manquant** |
| ActionSheet / Alert | — | **Manquant** |
| Sheet / Modal | — | **Manquant** |
| Keyboard | — | **Manquant** |
| ContextMenu | — | **Manquant** |
| Toolbar / Edit mode | — | **Manquant** |

Inventaire détaillé : [`src/platform/design-system/CATALOG.md`](src/platform/design-system/CATALOG.md).

### Phase 3 — Apps natives iOS

Une par une, calibrées contre captures, avec données mock vides en simulateur.

Ordre suggéré : Réglages → Messages → Photos → Téléphone → Contacts → Mail → Notes → Calendrier → Safari → Fichiers → Rappels → Plans.

Emplacement cible : `src/platform/apps/native/`.

### Phase 4 — Apps tierces

Instagram, WhatsApp, Signal, Uber, Spotify, Netflix, X, Discord, Google…

Emplacement cible : `src/platform/apps/third-party/`.

Chaque app tierce a son propre thème mais **réutilise** le design system (listes, navbars, sheets…).

### Phase 5 — Injection LPSP (histoires)

Seulement quand les phases 1–4 sont solides.

```
LPSP JSON  →  adapters  →  props des apps  →  rendu identique au simulateur, contenu différent
```

- `PhonePage` charge une LPSP et passe en mode `story`.
- Le noyau et les apps **ne connaissent pas** l’histoire — ils reçoivent des données.
- Le scénario (`scenario/engine.ts`) ajoute des événements temporels par-dessus.

---

## Structure de dossiers (cible)

```
src/
  platform/                 # Mini-iOS — aucune dépendance histoire
    emptyDevice.ts          # État iPhone vide par défaut
    mock/                   # Données vides par app (simulateur)
    design-system/          # Composants UI réutilisables
    apps/
      native/               # Messages, Photos, Réglages…
      third-party/          # Instagram, Uber…
    kernel/                 # (migration) shell, lock, home, overlays…

  content/                  # (migration) couche LPSP
    lpsp/                   # adapters, normalize, types
    scenario/               # moteur d’événements

  runtime/                  # Compose platform + content
  pages/
    SimulatorPage.tsx       # /simulator — dev plateforme
    PhonePage.tsx           # /phone/:id — jeu avec histoire
    UiReferencePage.tsx     # /ui-reference — comparaison captures
```

**Migration progressive :** le code actuel (`src/ios/`, `src/apps/`) reste fonctionnel ; on déplace fichier par fichier vers `platform/` au fil des phases.

---

## Workflow « copie de référence »

Pour **chaque** écran ou composant :

1. Placer ou vérifier la capture dans `public/captures-ios/…/screen.png`
2. Ouvrir `/ui-reference` → sélectionner l’écran → mode **Overlay**
3. Comparer : position, typo, blur, ombres, couleurs, icônes, animations, toucher
4. Ajuster `tokens.css` / `reference-calibration.css` / design system
5. Valider en `/simulator` (contenu vide) puis en `/phone/j3-louvre` (contenu LPSP)
6. Ne pas passer à l’écran suivant tant que l’écart visuel est visible

```bash
npm run reference:measure   # métriques automatiques depuis les PNG
npm run captures:status     # captures manquantes
```

---

## Modes de la plateforme

| Mode | Route | LPSP | Scénario | Usage |
|------|-------|------|----------|-------|
| `simulator` | `/simulator` | Vide (mock) | Non | Développer le mini-iOS |
| `reference` | `/ui-reference` | j3-louvre | Non | Calibrer vs captures |
| `story` | `/phone/:id` | Histoire | Oui | Jeu |

---

## Critère de succès

> Quelqu’un qui ouvre Lost Phone doit avoir l’impression d’utiliser un **vrai iPhone**, pas une interface inspirée d’iOS.

Test : `/simulator` avec iPhone vide → verrou → PIN → accueil → ouvrir Messages vide → doit être indiscernable d’un iPhone réel au niveau structurel et rendu.
