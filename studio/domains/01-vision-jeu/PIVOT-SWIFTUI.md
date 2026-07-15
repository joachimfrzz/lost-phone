# Pivot SwiftUI — juin 2026

**Décision :** abandon React + Figma pour l’iPhone jouable.  
**Base UI :** [zerocode117/iOS-26-clone](https://github.com/zerocode117/iOS-26-clone)  
**Contenu :** LPSP JSON (modifiable, inchangé côté Creator)

## Où est le jeu ?

| Avant | Maintenant |
|---|---|
| `game/src/` React | **Deprecated** pour le shell iOS |
| Figma pipeline | **Abandonné** |
| **`game/LostPhone/`** | **App SwiftUI native** |

## Modifier textes, messages, notifs

→ Voir [`LostPhone/SWIFTUI-LPSP.md`](LostPhone/SWIFTUI-LPSP.md)

Fichier éditable : `public/stories/j3-louvre/lpsp.json`  
Sync vers l’app : `npm run lpsp:sync`

## Cursor + iPhone sans Mac

→ [`CURSOR-IPHONE.md`](CURSOR-IPHONE.md) (guide complet)

Build cloud : workflow **`lost-phone-swiftui`** dans [`codemagic.yaml`](codemagic.yaml)

## Prochaines étapes dev

1. Brancher Photos, Mail, WhatsApp, Signal sur LPSP (comme Messages)
2. Porter apps custom avec UI clone en inspiration
3. Hub / sélection d’histoire (SwiftUI)
