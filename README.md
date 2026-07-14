# LostPhone Studio

**LostPhone Studio** est l'environnement de développement assisté par IA du projet.  
**Lost Phone** (le jeu iOS) est le premier produit construit avec ce studio.

## Point d'entrée

| Besoin | Où aller |
|--------|----------|
| Vision, organisation, décisions | [`studio/README.md`](studio/README.md) |
| Index de toute la documentation | [`studio/docs/INDEX.md`](studio/docs/INDEX.md) |
| Instructions pour les agents IA | [`AGENTS.md`](AGENTS.md) |
| App SwiftUI (runtime) | [`LostPhone/README.md`](LostPhone/README.md) |
| Histoires LPSP (source de vérité) | [`public/stories/`](public/stories/) |
| Archives (legacy, non supprimé) | [`archive/README.md`](archive/README.md) |

## État actuel (juillet 2026)

- **Runtime actif :** SwiftUI natif dans `LostPhone/`
- **Contenu :** LPSP JSON dans `public/stories/`
- **CI :** GitHub Actions (`ios-preview`) + Codemagic (`lost-phone-swiftui`)
- **Legacy archivé :** React/Capacitor, ios-swiftui, docs pré-pivot → `archive/`

## Commandes essentielles

```bash
# Synchroniser les histoires vers l'app SwiftUI
npm run lpsp:sync

# Générer le projet Xcode (Mac / CI)
cd LostPhone && xcodegen generate
```

Voir [`studio/docs/ops/`](studio/docs/ops/) pour CI, preview et déploiement iPhone.
