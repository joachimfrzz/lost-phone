# Roadmap — finir Lost Phone iOS

## C’est quoi « fini » ?

**Fini pour le jeu** = un joueur sur j3-louvre a l’impression d’un vrai iPhone, et **tout le contenu vient du LPSP** (tu changes le JSON, pas le code).

Deux niveaux :

| Niveau | Scope | Critère |
|--------|-------|---------|
| **A — Jeu (priorité)** | Noyau + 18 apps j3-louvre | Histoire jouable, UI calibrée |
| **B — Plateforme** | `/simulator` complet, apps génériques | Réutilisable pour d’autres histoires |

On vise **A d’abord**, B vient naturellement si l’architecture est respectée.

---

## Architecture (ne pas dévier)

```
LPSP JSON
   ↓ adapters (src/content/lpsp/adapters/)
View models typés
   ↓ props
Apps templates (src/platform/apps/)
   ↓ composants uniquement
Design system (src/platform/design-system/)
   ↓
Noyau iOS (src/platform/kernel/)
```

**Interdit :** écran par histoire, PNG en runtime, styles ad hoc dans une app.

---

## Phase 0 — Débloquer (1 session)

- [ ] **Reclasser les captures système** — plusieurs dossiers sont faux aujourd’hui :
  - `system/lock-vide` → contient WhatsApp ❌
  - `system/lock-notifs` → contient Instagram ❌
  - `system/pin` → contient Notes ❌
  - `system/home-p1` et `notification-center` → vrais écrans verrou ✅
- [ ] Captures manquantes : verrou **sans** notif, PIN réel, accueil home réel
- [ ] Contrat TypeScript : `src/content/lpsp/view-models/` (types par app)

---

## Phase 1 — Noyau iOS (le joueur voit ça en premier)

Calibrer vs captures sur `/ui-reference`, valider sur `/simulator`.

| # | Élément | Capture | Dynamique via LPSP |
|---|---------|---------|-------------------|
| 1.1 | Status bar + Dynamic Island | system.* | `envelope.heure`, `system.batterie` |
| 1.2 | Verrou vide | `system.lock-vide` | heure, date, fond |
| 1.3 | Verrou + notifs | `system.lock-notifs` | `notifications_initiales` + scénario |
| 1.4 | PIN | `system.pin` | `player_config.verrouillage` |
| 1.5 | Accueil + dock + pager | `system.home-p1/p2` | `apps_presentes`, `dock` |
| 1.6 | Centre notifications | `system.notification-center` | overlay + notifs |
| 1.7 | Centre de contrôle | `system.control-center` | overlay (mock OK) |
| 1.8 | Gestes + transitions app | — | runtime fixe |

**Gate :** parcours simulateur verrou → PIN `0000` → accueil → NC → CC → ouvrir app → retour.

---

## Phase 2 — Design system (fondation unique)

Construire **une fois**, toutes les apps s’en servent.

### P0 (bloquant apps)
- [ ] `InsetGroupedList` + `Cell` (Réglages-quality)
- [ ] `NavBar` + `LargeTitle`
- [ ] `SearchField`
- [ ] `ChatBubble` + `ChatThread` + `ChatComposer`
- [ ] `PhotoGrid` + viewer
- [ ] `Switch`, `SegmentedControl`
- [ ] `NotificationCard`
- [ ] `Avatar`

### P1 (polish)
- [ ] `Alert`, `ActionSheet`, `Sheet`
- [ ] `SystemKeyboard` / clavier numérique
- [ ] `SwipeActions`, `TabBar`

**Gate :** page `/design-system` (vitrine) — chaque composant validé overlay.

**Modèle de référence :** extraire Messages en premier app 100 % DS.

---

## Phase 3 — Apps j3-louvre (18 apps)

Chaque app = **template fixe** + **adapter** + **view model**.

### Tier 1 — Cœur narratif (à finir en premier)
| App | Écrans template | Adapter |
|-----|-----------------|---------|
| Messages | liste → conversation | `adaptMessages` ✅ existe |
| WhatsApp | liste → conversation | `adaptWhatsApp` |
| Signal | liste → conversation | `adaptSignal` |
| Photos | grille → album → détail | `adaptPhotos` |
| Notes | liste → note | `adaptNotes` |
| Instagram | feed → DM | `adaptInstagram` |

### Tier 2 — Investigation
| App | Écrans | Adapter |
|-----|--------|---------|
| Contacts | liste → fiche | `adaptContacts` |
| Mail | inbox → message | `adaptMail` |
| Calendrier | mois → jour | `adaptCalendrier` |
| Telephone | récents → clavier | `adaptTelephone` |
| Safari | accueil → onglet | `adaptSafari` |

### Tier 3 — Ambiance / contexte
| App | Écrans | Adapter |
|-----|--------|---------|
| Google Maps | carte + pin | `adaptMaps` |
| Uber | accueil | `adaptUber` |
| Spotify | accueil | `adaptSpotify` |
| Netflix | profils → accueil | `adaptNetflix` |
| Crédit Agricole | compte | `adaptBanking` |
| Fichiers | browser | `adaptFiles` |
| Rappels | liste | `adaptReminders` |

### Par app — checklist identique
1. Types view model dans `view-models/`
2. Adapter LPSP → view model
3. Refactor app = compose DS only (supprimer CSS ad hoc)
4. États vides iOS sur `/simulator`
5. Calibrer vs capture sur `/ui-reference`
6. Tester avec j3-louvre LPSP

---

## Phase 4 — Contenu dynamique (zéro code pour les histoires)

Quand phases 1–3 sont OK :

- [ ] Documenter le **schéma LPSP par app** (ce que l’auteur peut modifier)
- [ ] Scénario : notifs live, nouveaux messages → même UI
- [ ] Images : URLs/chemins dans LPSP → `<img src={…}>` dans templates
- [ ] Validation LPSP au load (erreurs claires si champ manquant)

**Exemple concret :** changer un post Instagram = éditer `lpsp.json` → `content.apps.Instagram.feed[n]` — pas de redeploy UI.

---

## Phase 5 — Finition jeu

- [ ] j3-louvre : parcours complet sans glitch visuel
- [ ] Capacitor iOS : safe areas, haptics
- [ ] Perf scroll / transitions
- [ ] Supprimer code mort (`src/os/`, `GenericApp` dump, `CaptureScreen` runtime)

---

## Ordre d’exécution (résumé)

```
0. Fix captures système
1. Noyau (verrou → accueil)
2. DS P0 (listes + chat + photos)
3. Messages (app modèle) → WhatsApp → Signal
4. Photos → Notes → Instagram
5. Tier 2 apps
6. Tier 3 apps
7. Polish + doc LPSP
```

**Ne pas sauter d’étape** : le noyau vend l’illusion ; Messages vend le pattern ; le reste duplique.

---

## Comment on sait que c’est fini

### Test joueur (j3-louvre)
1. Verrou crédible → PIN 1503 → accueil Mathieu
2. Ouvrir chaque app du manifest — navigation OK
3. Contenu cohérent LPSP (pas Joachim des captures)
4. Scénario : nouvelle notif → même rendu iOS
5. « On dirait mon iPhone » — toi en validateur overlay

### Test auteur (dynamique)
1. Modifier un message dans `lpsp.json`
2. Recharger → message changé, UI identique
3. Ajouter une conversation → apparaît dans la liste
4. Changer photo Instagram → image mise à jour

---

## Prochaine action immédiate

1. **Toi :** remettre les bonnes captures dans les bons dossiers système (verrou vide, PIN, accueil home)
2. **Moi :** Phase 1.1–1.3 — calibrer status bar + verrou vs vraies captures
3. **Ensuite :** refactor Messages en app modèle (template + DS)

Dis **« captures corrigées »** ou **« continue avec ce qu’on a »** pour lancer.
