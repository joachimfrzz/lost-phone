# AGENTS.md — Instructions pour agents IA (LostPhone Studio)

Tu travailles sur **LostPhone Studio**. Lost Phone (jeu iOS) est le premier projet du studio.

## Règle #1

Avant chaque décision : **« Est-ce que cette solution améliore aussi le Studio ? »**

## Ce qui est ACTIF (modifier ici)

| Zone | Chemin |
|------|--------|
| App SwiftUI | `LostPhone/LostPhone/` |
| Build config | `LostPhone/project.yml` |
| LPSP source | `public/stories/` |
| LPSP sync | `npm run lpsp:sync` → `scripts/sync-lpsp-swift.mjs` |
| CI scripts | `LostPhone/scripts/ios-*.sh`, `validate-lpsp-json.py` |
## Apps — nouvelle stratégie (juillet 2026)

| Famille | Source | Dossier |
|---------|--------|---------|
| **Officielles** (gelées) | zerocode117 | `Apps/Clone/` |
| **Tierces** (custom) | Awesome Design + briefs Notion | `Apps/Custom/` (cible) |

**Ne plus** étendre `Apps/Vendored/` (Sopheamen archivé). Voir [`studio/VISION-APPS.md`](studio/VISION-APPS.md).

## QA device — MobAI

Quand MobAI desktop est lancé : config MCP via `.cursor/mcp.json.example` → `.cursor/mcp.json`.  
Doc : [`studio/docs/ops/MOBAI.md`](studio/docs/ops/MOBAI.md)
| Routing | `Apps/LpspAppRouter.swift`, `VendoredShowroomRouter.swift` |
| CI | `.github/workflows/ios-preview.yml`, `codemagic.yaml` |

## Ce qui est ARCHIVÉ (ne pas réintégrer sans décision)

| Zone | Chemin |
|------|--------|
| React Creator | `archive/legacy-react/` |
| Capacitor iOS | `archive/legacy-capacitor/` |
| ios-swiftui skeleton | `archive/legacy-ios-swiftui/` |
| Sopheamen brut | `archive/sopheamen-raw/` |
| Docs pré-pivot | `archive/docs-pre-pivot/` |

Voir `archive/README.md`.

## Conventions techniques

- **Swift 6 / Xcode 26** en CI — éviter `.onSubmit(methodRef)` ; utiliser `.onSubmit { method() }`
- **Pas de `WritableKeyPath`** sur `class` — mutations directes
- **Sopheamen/** ne doit **jamais** être recompilé — runtime = Vendored/
- **Ne pas supprimer** d'apps du showroom sans accord explicite
- **Build number** dans `LostPhone/project.yml` → `CURRENT_PROJECT_VERSION`

## Documentation

- Index complet : `studio/docs/INDEX.md`
- Décisions : `studio/DECISIONS.md`
- Showroom : `LostPhone/docs/SHOWROOM_STRATEGY.md`
- LPSP : `LostPhone/SWIFTUI-LPSP.md`

## Notion

Source de vérité **produit** (bugs, statuts apps). Vérifier avant de marquer un bug comme résolu.

## Interdits sans demande explicite

- Force push, hard reset
- Suppression définitive de fichiers (archiver à la place)
- Commit / push (sauf demande)
- Désactiver des apps pour faire passer le build

## Priorité

Le temps du créateur > perfection technique immédiate. Automatiser les tâches répétitives.
