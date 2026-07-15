# Ressources Apple — source de vérité Lost Phone

> **Page officielle :** [developer.apple.com/design/resources](https://developer.apple.com/design/resources/)

## Pourquoi l’approche actuelle échoue

| Ce qu’on faisait | Problème |
|------------------|----------|
| CSS « inspiré iOS » | Valeurs inventées — jamais identiques |
| Captures iPhone comme spec | Utile pour **valider**, pas pour **construire** |
| Fond d’écran = capture verrou | Image avec horloge/UI incluses → double rendu, incohérent |
| SVG maison | Pas les vrais SF Symbols, pas les bons poids |

**Conclusion :** les captures restent le **test final** (overlay). La **spec** vient d’Apple.

---

## Ce qu’il faut télécharger (par priorité)

### 1. UI Kit iOS — **indispensable**

**iOS 27 UI Kit for Figma** (officiel Apple)  
→ [Figma Community — iOS and iPadOS 27](https://www.figma.com/community/file/1651309003795292092/ios-and-ipados-27)

Contient déjà, mesurés et nommés :
- Lock Screen (vide, notifs)
- Passcode / PIN
- Home Screen (grille, dock, recherche, widgets)
- Control Center
- Notification Center
- Status bar, Dynamic Island
- Materials (Liquid Glass, blur, vibrancy)
- Text styles, color styles

**Workflow :** ouvrir le composant « Lock Screen » dans Figma → lire chaque propriété (px, font, blur, rgba) → implémenter en React → valider avec votre capture overlay.

*(Sketch aussi disponible sur la page Apple — Figma marche dans le navigateur, pratique depuis Windows/iPad.)*

### 2. SF Pro — **polices système**

Sur [Apple Design Resources → Fonts → SF Pro](https://developer.apple.com/design/resources/)

Télécharger et placer dans :
```
public/fonts/SF-Pro/
```

Puis `@font-face` dans `tokens.css` — **plus de `-apple-system` en fallback seul**.

Variantes utiles :
- SF Pro Display (grandes tailles — horloge verrou)
- SF Pro Text (UI générale)
- SF Pro Rounded (horloge iOS si activée)

### 3. SF Symbols — **icônes système**

App **macOS uniquement** : [SF Symbols 7](https://developer.apple.com/design/resources/) (ou beta 8)

Exporte en SVG : torche, appareil photo, Wi‑Fi, batterie, mode silencieux, CC, etc.

**Sans Mac :** exporter les symboles depuis le UI Kit Figma (souvent déjà inclus en composants).

### 4. Human Interface Guidelines

[developer.apple.com/design/human-interface-guidelines](https://developer.apple.com/design/human-interface-guidelines/)

Comportements : gestes, animations, états — pas seulement le visuel.

---

## Nouvelle méthode (remplace l’ancienne)

```
Apple UI Kit (Figma)     ← SPEC : tailles, couleurs, blur, composants
        ↓
Export assets (SVG, PNG wallpaper si dispo dans le kit)
        ↓
Implémentation React (un écran à la fois)
        ↓
Capture iPhone (overlay 50 %)  ← QA uniquement
        ↓
« OK » → écran suivant
```

**Les captures ne définissent plus le design.** Elles prouvent que le rendu React = votre iPhone.

---

## Fond d’écran — correction

| ❌ Ne pas faire | ✅ Faire |
|---------------|---------|
| Utiliser la capture verrou comme wallpaper | Wallpaper **nu** : export Figma, ou photo Réglages sans UI |
| Dégradé CSS | Image PNG/JPG + `fond_ecran.source` LPSP |

Le fichier `calibration-lock.png` actuel (copié depuis capture verrou) **doit être remplacé** par un vrai fond sans interface.

---

## Setup recommandé (votre config)

| Appareil | Rôle |
|----------|------|
| **iPad + RDP** | Figma (navigateur) → lire specs UI Kit |
| **PC Windows** | Dev Cursor, assets dans `public/` |
| **iPhone** | Captures QA + overlay validation |

---

## Prochaine action concrète

1. **Vous** : ouvrir le [UI Kit Figma iOS 27](https://www.figma.com/community/file/1651309003795292092/ios-and-ipados-27) (compte Figma gratuit)
2. **Vous** : télécharger **SF Pro** depuis Apple → me dire quand c’est dans le projet ou me demander de brancher les `@font-face`
3. **Moi** : refaire **Lock Screen** en lisant le composant Figma (pas en devinant) — écran par écran

Dès que le UI Kit est ouvert, dites **« UI Kit ok »** et on attaque le verrou avec les vraies valeurs Apple.
