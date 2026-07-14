# LostPhone Studio

LostPhone Studio n'est pas un dépôt de documentation. C'est l'**environnement** dans lequel le jeu, les histoires, les apps, les assets, la QA et les releases sont produits et maintenus.

Lost Phone est le **premier projet** du studio — pas le studio lui-même.

## Mission

1. Construire et faire évoluer **Lost Phone** (jeu d'investigation iOS).
2. Construire **LostPhone Studio** : réduire les manipulations manuelles, centraliser la connaissance, automatiser les workflows répétitifs.

## Règle fondamentale

Avant chaque décision :

> **Est-ce que cette solution améliore aussi le Studio ?**

## Domaines

| Domaine | Rôle | Emplacement actuel |
|---------|------|-------------------|
| **Vision** | Produit, périmètre, pivot, roadmap | `studio/VISION.md`, `APP-SCOPE.md` |
| **Applications** | Clones officiels + apps custom (Awesome Design) | [`VISION-APPS.md`](VISION-APPS.md) |
| **Histoires** | LPSP JSON, scénarios, showroom | `public/stories/` |
| **Design** | Spectr, pixel QA, assets | `LostPhone/scripts/spectr_*`, `public/` |
| **Développement** | SwiftUI, XcodeGen, adapters | `LostPhone/` |
| **QA** | Notion bugs, preflight, pixel diff | Notion + `LostPhone/scripts/` |
| **Analytics** | *(à structurer)* | — |
| **Marketing** | *(à structurer)* | — |
| **Business** | *(à structurer)* | — |

## Structure du dépôt

```
game/
├── studio/          ← Ce hub (vision, docs, décisions)
├── LostPhone/       ← App iOS SwiftUI (projet #1)
├── public/          ← Assets + LPSP source de vérité
├── scripts/         ← Outils racine (LPSP sync)
├── archive/         ← Legacy conservé, hors runtime
├── .github/         ← CI GitHub Actions
└── codemagic.yaml   ← CI TestFlight
```

Structure cible détaillée : [`STRUCTURE.md`](STRUCTURE.md).

## Documents clés

- [`VISION.md`](VISION.md) — philosophie et priorités
- [`VISION-APPS.md`](VISION-APPS.md) — stratégie apps (officielles vs custom)
- [`docs/WORKFLOW.md`](docs/WORKFLOW.md) — Notion, iPhone, Cursor
- [`DECISIONS.md`](DECISIONS.md) — journal des décisions d'architecture
- [`docs/INDEX.md`](docs/INDEX.md) — index de toute la documentation
- [`../AGENTS.md`](../AGENTS.md) — instructions pour agents Cursor

## Prochaine étape

Une fois la base propre validée : développer les **workflows Studio** (Notion ↔ LPSP ↔ QA ↔ CI) comme produit à part entière.
