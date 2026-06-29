# Calibration pixel-perfect — Lost Phone

> **Source de vérité :** [APPLE-RESOURCES.md](./APPLE-RESOURCES.md) — UI Kit Figma Apple + SF Pro + SF Symbols.  
> Les captures iPhone servent à **valider** (overlay), pas à inventer les specs.

> **Règle absolue :** on ne construit pas « du iOS-like ». On implémente depuis le **UI Kit officiel Apple**, puis on valide contre la capture.

---

## Diagnostic (pourquoi ~5/10 aujourd'hui)

| Problème | Cause |
|----------|--------|
| Accueil, CC, NC, PIN « génériques » | Composants inventés à partir de mémoire, pas découpés depuis la capture |
| Verrou « presque » | Seul écran partiellement mesuré ; fond d'écran = dégradé CSS, pas la photo réelle |
| Tokens « calibrés » inefficaces | 3 métriques grossières (status, horloge, dock) — pas assez pour reproduire iOS |
| Trop d'écrans ouverts en parallèle | 7 captures → 7 implémentations brouillonnes au lieu d'1 parfaite |

**Ce qu'on arrête :** avancer sur le noyau entier, calibrer « globalement », ou passer à l'étape 2 (Messages) tant qu'un écran système n'est pas validé.

---

## Nouvelle méthode — un écran, une porte

```
UI Kit Figma (Lock Screen, etc.)  ← spec officielle Apple
    ↓
Export assets + mesures Figma → tokens CSS (--ios-*)
    ↓
Implémentation React (uniquement cet écran)
    ↓
Capture iPhone → /ui-reference overlay 50 %  ← QA seulement
    ↓
Validation utilisateur « OK »
    ↓
Écran suivant
```

### Critère de validation (gate)

Un écran est **validé** uniquement si :

1. Overlay à **50 %** : impossible de repérer décalage sur typographie, espacements, icônes, matériaux
2. Overlay à **100 %** puis **0 %** : le comportement (gestes, animations) correspond à iOS
3. L'utilisateur dit explicitement **« OK »** pour cet écran

Tant que ce n'est pas OK → **on reste sur cet écran**. Pas de capture suivante, pas d'app, pas de LPSP.

---

## File d'attente noyau (ordre strict)

| # | Capture | Statut |
|---|---------|--------|
| 1 | `system.lock-vide` | **En cours** |
| 2 | `system.lock-notifs` | Bloqué (#1) |
| 3 | `system.pin` | Bloqué (#1) |
| 4 | `system.home-p1` | Bloqué (#1) |
| 5 | `system.home-p2` | Bloqué (#1) |
| 6 | `system.notification-center` | Bloqué (#1) |
| 7 | `system.control-center` | Bloqué (#1) |

Statuts : `bloqué` → `en cours` → `review` → `validé`

---

## Checklist — Verrou vide (`system.lock-vide`)

Chaque ligne = une passe de correction. Tant qu'une ligne n'est pas OK, l'écran n'est pas validé.

### Assets requis (prérequis)

- [ ] **Fond d'écran exact** (PNG/JPG, pas un dégradé CSS) — même wallpaper que l'iPhone de référence
- [ ] **Grain / texture** du wallpaper si visible sur capture
- [ ] **Effet de profondeur** horloge (couche avant/arrière si activé sur l'iPhone)

### Status bar

- [ ] Opérateur « Free » — typo, position
- [ ] Icône **mode silencieux** (cloche barrée) à droite de Free
- [ ] Barres cellulaires (3/4 remplies)
- [ ] Wi‑Fi
- [ ] Batterie **40 %** visible dans l'icône
- [ ] Hauteur barre : **55 px** (@393×852)
- [ ] Indicateur CC (petite barre sous les icônes droite)

### Horloge

- [ ] Date « Lun. 29 juin » — **au-dessus** de l'heure
- [ ] Police SF Pro Rounded / system-ui
- [ ] Heure « 18:04 » — ~98 px, weight 200, letter-spacing −4px
- [ ] Position top mesurée : **~68 px** depuis le haut logique
- [ ] Couleur / opacité / vibrancy (pas blanc pur opaque)
- [ ] Ombre portée légère sur fond sombre

### Bas d'écran

- [ ] Bouton torche — cercle verre (blur + bordure 0.5px + fond rgba)
- [ ] Bouton appareil photo — identique, symétrique
- [ ] Position exacte (coins, marges depuis bords)
- [ ] Icônes SF exactes (pas SVG génériques)
- [ ] Home indicator — barre blanche arrondie, position bas

### Comportement

- [ ] Swipe vers le haut — rubber band + transition
- [ ] Hint « Glisser vers le haut pour ouvrir » — opacité / fade au drag

---

## Outils

| Outil | Usage |
|-------|-------|
| `/ui-reference` | Overlay capture vs React — **un seul écran actif à la fois** |
| `npm run reference:measure` | Mesures automatiques (complété par mesures manuelles) |
| `CALIBRATION.md` | Checklist + statut de la file |
| `src/lib/reference/calibrationQueue.ts` | Source de vérité programmatique |

---

## Règles de développement

1. **Pas de nouveau écran** tant que le courant n'est pas `validé`
2. **Pas de dégradé CSS** quand la capture montre une photo — utiliser `fond_ecran.source` (URL asset)
3. **Pas de SVG inventés** — exporter SF Symbols ou tracer depuis capture
4. **Chaque valeur CSS** doit venir d'une mesure ou d'une spec Apple documentée
5. **Contenu LPSP** ne change jamais la structure UI — seulement textes, images, données

---

## Prochaine action immédiate

**Écran 1 — Verrou vide**

1. Fournir le **fond d'écran exact** (export depuis l'iPhone de référence, ou fichier PNG déjà sur le téléphone)
2. Corriger la checklist ci-dessus, élément par élément
3. Vous validez sur `/ui-reference` → « OK verrou vide »
4. Seulement alors → verrou avec notifs
