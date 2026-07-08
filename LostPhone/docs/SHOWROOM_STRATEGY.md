# Stratégie showroom — pivot juillet 2026

> Décision Joachim · 2026-07-08  
> **Awesome dégage** · **zerocode117 gelé** · **Vendored + Sopheamen + GitHub**

---

## 1. Ce qu’on ne touche pas (apps parfaites)

Apps **zerocode117** — qualité showroom, gelées :

### Page 1 (grille)
Météo · Calendrier · Photos · Appareil photo · Notes · Calculatrice · Réglages · Mail · Horloge · App Store

### Page 2 (grille)
Contacts · Rappels · Dictaphone · Wallet

### Dock
Téléphone · Safari · Messages · Musique

**Total gelé : 18 icônes** (10 + 4 + 4). En pratique = tout le shell Apple zerocode117.

> Rappels page 2 = `RappelsSwifty` (déjà au niveau cible). Musique dock = Apple Music zerocode117.

---

## 2. Ce qu’on supprime

### 61 apps **Awesome** (`Apps/Awesome/Generated/LpspAwesome*.swift`)

- Générées Meliwat / Spectr — qualité insuffisante pour vitrine
- Routées via `AwesomeShowroomCatalog` + `AwesomeShowroomRouter`
- **Objectif :** retirer du showroom et du routage ; ne garder Awesome qu’en fallback temporaire le temps du remplacement

Fichiers concernés :
- `LostPhone/Core/Services/AwesomeShowroomCatalog.swift`
- `LostPhone/Apps/Awesome/AwesomeShowroomRouter.swift`
- `LostPhone/Apps/Awesome/Generated/` (~61 vues)
- `CloneShowroomLayout.gridAppsTier` → plus `AwesomeShowroomCatalog.tierApps`

---

## 3. Par quoi on remplace

### A. Clones GitHub (liste Joachim)

Voir `JOACHIM_CLONE_PICKS.md` — WhatsApp, Instagram, Netflix, Spotify, Uber, etc.

### B. Bundle Patreon Sopheamen Van (21 zip)

**Source :** [Dropbox — Clones-Sopheamen-Van-Patreon.zip](https://www.dropbox.com/scl/fi/dt4mn6n6vddpw8kug9vkd/Clones-Sopheamen-Van-Patreon.zip?rlkey=kb5s24s4dpandt3lz4emojpz8&dl=1)

**Téléchargé localement :** `vendor-incoming/Clones-Sopheamen-Van-Patreon.zip` (381 Mo, non commité git)

| # | Archive | App Lost Phone | Priorité Joachim |
|---|---------|----------------|------------------|
| 1 | `WhatsAppclone patreon.zip` | WhatsApp | ✅ remplace Awesome |
| 2 | `Instagram clone patreon.zip` | Instagram | ✅ (vs dmakarau GitHub) |
| 3 | `Snapchat Clone patreon.zip` | Snapchat | ✅ |
| 4 | `LinkedIn Clone patreon.zip` | LinkedIn | ✅ |
| 5 | `Youtube_Facebook_v1.zip` | Facebook | ✅ |
| 6 | `Youtube_FacebookMessenger_v1.zip` | Messenger | ✅ |
| 7 | `Youtube_Threads_v1.zip` | Threads | bonus |
| 8 | `grok_clone_v1.zip` | Grok | ✅ |
| 9 | `Youtube_Gemini_clone_v1.zip` | Gemini (2e IA) | ✅ |
| 10 | `Youtube_Netflix_v1.zip` | Netflix | ✅ (vs Notflix) |
| 11 | `Youtube_Youtube_v1.zip` | YouTube | ✅ (~228 Mo) |
| 12 | `Youtube_Music_v2_1.zip` | YouTube Music | ✅ |
| 13 | `Youtube_Apple_music_clone_v2.zip` | — | ⚠️ doublon dock Musique |
| 14 | `Youtube_Phantom_clone_v1.zip` | Crypto | ✅ |
| 15 | `Youtube_uber_clone_v1.zip` | Uber | ✅ |
| 16 | `food-delivery-ui-kit-cart-checkout.zip` | Uber Eats | ✅ |
| 17 | `youtube_airbnb_clone_v1.zip` | Airbnb | ✅ |
| 18 | `tinder_clone_ui_kit.zip` | Tinder | ✅ (~156 Mo) |
| 19 | `Youtube_Tiktok_v1.zip` | TikTok | ✅ (vs GitHub johannpires) |
| 20 | `Youtube_Gmail_v1.zip` | Mail tier? | ⚠️ Mail déjà zerocode117 |
| 21 | `Youtube_Appstore _v1.zip` | App Store tier? | ⚠️ App Store déjà page 1 |

### C. Routage cible

```
LpspAppRouter
  → Clone (Apple gelé)
  → VendoredShowroomRouter (GitHub + Sopheamen vendored)
  → (plus Awesome en prod)
```

---

## 4. État actuel code

| Couche | Statut |
|--------|--------|
| Clone zerocode117 | ✅ live showroom |
| Vendored (11 apps GitHub) | ✅ intégrées, qualité variable |
| Awesome (61) | ⚠️ encore dans `gridAppsTier` + fallback router |
| Sopheamen zip | ✅ téléchargé, **pas encore vendored** |

---

## 5. Plan d’exécution

### Phase 1 — Inventaire & priorité Sopheamen
1. Extraire chaque zip → vérifier SwiftUI / iOS 17 / compile
2. Mapper zip → `Apps/Vendored/<App>/`
3. **Préférer Sopheamen** quand doublon avec GitHub (Snapchat, LinkedIn, WhatsApp, Messenger, Uber Eats)

### Phase 2 — Remplacer Awesome dans le showroom
1. Construire `VendoredShowroomCatalog.tierApps` = catalogue curé Joachim (~30 apps)
2. Changer `CloneShowroomLayout.gridAppsTier` → `VendoredShowroomCatalog` (plus Awesome)
3. Retirer fallback Awesome dans `LpspAppRouter` / `VendoredShowroomRouter`

### Phase 3 — Nettoyage
1. Archiver ou supprimer `Apps/Awesome/Generated/` (ou dossier `_deprecated`)
2. Désactiver pipeline Spectr/Awesome generate si plus utilisé
3. CI Appetize sur showroom curé

### Phase 4 — Trous restants
Teams · Signal · Dating 2 · Hôtel · Trains · Fichiers · Waze · Revolut → GitHub picks Joachim ou report v2

---

## 6. Doublons Sopheamen vs GitHub vs vendored actuel

| App | Vendored actuel | GitHub Joachim | Sopheamen zip | **Gagnant** |
|-----|-----------------|----------------|---------------|-------------|
| WhatsApp | — | efxlve | WhatsAppclone patreon | **Sopheamen** |
| Instagram | dmakarau (live) | dmakarau | Instagram patreon | **Sopheamen** (à comparer) |
| LinkedIn | DipakRaut (live) | Patreon lien | LinkedIn patreon | **Sopheamen** |
| Snapchat | — | Patreon lien | Snapchat patreon | **Sopheamen** |
| Netflix | Notflix (live) | Notflix | Youtube_Netflix_v1 | **Comparer** build |
| Spotify | 7adans (live) | denoni / adrian | — | **GitHub** (pas dans zip) |
| TikTok | johannpires (live) | — | Youtube_Tiktok_v1 | **Sopheamen** |
| Uber | WorkWithAfridi (live) | Huss3n | Youtube_uber_clone_v1 | **Sopheamen** |
| Airbnb | Keerthi (live) | piwien | youtube_airbnb_clone_v1 | **Sopheamen** |
| Tinder | — | enesozmus | tinder_clone_ui_kit | **Sopheamen** (156 Mo) |
| Grok | — | grok_clone_v1 | grok_clone_v1 | **Zip** |
| Messenger | — | Flutter sopheamen | FacebookMessenger_v1 | **Sopheamen SwiftUI** |
| Uber Eats | — | (vide) | food-delivery-ui-kit | **Sopheamen** |
| Crypto | — | Phantom Patreon | Phantom_clone_v1 | **Sopheamen** |

---

## 7. Fichiers de référence

- `JOACHIM_CLONE_PICKS.md` — sélection + comparaisons
- `CLONE_PICKS_COPIER_COLLER.txt` — liste brute
- `vendor-incoming/SOPHEAMEN_MANIFEST.md` — inventaire zip
- `vendor-incoming/README.md` — procédure dépôt archives

---

*Lost Phone · branche `cursor/vendored-clones-a052`*
