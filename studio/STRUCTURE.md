# Structure du dépôt — actuel et cible

## Structure actuelle (post-restructuration juillet 2026)

```
game/
├── README.md                    # Entrée → studio/
├── AGENTS.md                    # Instructions agents IA
│
├── studio/                      # ★ Hub LostPhone Studio
│   ├── README.md
│   ├── VISION.md
│   ├── DECISIONS.md
│   ├── STRUCTURE.md             # Ce fichier
│   └── docs/
│       ├── INDEX.md
│       └── ops/                 # Liens ops (preview, CI)
│
├── LostPhone/                   # ★ App iOS SwiftUI
│   ├── project.yml              # XcodeGen (source build)
│   ├── README.md
│   ├── ARCHITECTURE.md
│   ├── SWIFTUI-LPSP.md
│   ├── docs/                    # Recherche clones, showroom
│   ├── scripts/                 # CI, vendoring, QA Spectr
│   ├── vendor-incoming/         # Drop zone zips Patreon
│   └── LostPhone/
│       ├── Game/
│       ├── Phone/
│       ├── Core/
│       ├── Apps/
│       │   ├── Clone/           # Apple zerocode117
│       │   ├── Vendored/        # Production third-party
│       │   ├── Awesome/         # Fallback généré (temporaire)
│       │   └── Custom/
│       └── Resources/stories/   # Généré — sync depuis public/
│
├── public/                      # ★ Assets + LPSP source
│   ├── stories/
│   ├── assets/
│   └── ios/icons/
│
├── scripts/
│   └── sync-lpsp-swift.mjs      # LPSP → Resources/stories
│
├── archive/                     # Legacy conservé
│   ├── README.md
│   ├── legacy-react/
│   ├── legacy-capacitor/
│   ├── legacy-ios-swiftui/
│   ├── sopheamen-raw/
│   ├── zerocode117-backup/
│   ├── docs-pre-pivot/
│   ├── docs-duplicate-formats/
│   ├── legacy-public/
│   ├── scripts-legacy/
│   └── config-duplicates/
│
├── .github/workflows/
│   └── ios-preview.yml
│
├── codemagic.yaml
├── package.json                 # Minimal (lpsp:sync)
│
└── [docs racine actifs]
    ├── PIVOT-SWIFTUI.md
    ├── ROADMAP.md
    ├── APP-SCOPE.md
    ├── APPS-MASTER.md
    ├── CURSOR-IPHONE.md
    └── ...
```

## Structure cible (évolution progressive)

```
game/
├── studio/
│   ├── domains/                 # Vision, Apps, Stories, QA…
│   └── tooling/                 # Scripts unifiés (migration depuis LostPhone/scripts)
├── app/                         # (futur) rename LostPhone/
├── content/stories/             # (futur) rename public/stories/
└── archive/
```

La migration vers `app/` et `content/` est **différée** pour ne pas casser CI/Codemagic lors du changement de compte Cursor.

## Flux de données

```
Notion (bugs, apps)     public/stories/ (LPSP)
        │                      │
        │                      ▼ npm run lpsp:sync
        │              Resources/stories/
        │                      │
        ▼                      ▼
   QA manuelle            LostPhone.app
        │                      │
        └──────────┬───────────┘
                   ▼
            GitHub Actions + Codemagic
```

## Apps — couches runtime

| Couche | Chemin | Statut |
|--------|--------|--------|
| Apple clones | `Apps/Clone/` | Actif, gelé |
| Third-party | `Apps/Vendored/` | Actif, priorité showroom |
| Generated fallback | `Apps/Awesome/` | Temporaire |
| Raw Patreon | `archive/sopheamen-raw/` | Archivé |
