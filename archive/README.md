# Archive — LostPhone Studio

Ce dossier conserve tout le travail **obsolète ou hors runtime** — **rien n'a été supprimé définitivement**.

Les éléments ici ne sont **pas compilés** et ne doivent **pas** être réintégrés sans décision documentée dans [`studio/DECISIONS.md`](../studio/DECISIONS.md).

---

## Contenu

| Dossier | Description | Date archivage |
|---------|-------------|----------------|
| `legacy-react/` | App React/Vite Creator (`src/`), vite config, plugins | Juil. 2026 |
| `legacy-capacitor/` | Shell iOS Capacitor (`ios/`) | Juil. 2026 |
| `legacy-ios-swiftui/` | Premier squelette SwiftUI (superseded par `LostPhone/`) | Juil. 2026 |
| `sopheamen-raw/` | Extracts Patreon bruts (~2100 fichiers) | Juil. 2026 |
| `zerocode117-backup/` | Backup Mail/AppStore/Music avant clones Sopheamen | Juil. 2026 |
| `docs-pre-pivot/` | Documentation ère React/Figma/Capacitor | Juil. 2026 |
| `docs-duplicate-formats/` | Exports CLONE_PICKS redondants (csv, txt, html) | Juil. 2026 |
| `legacy-public/` | Assets calibration React (`figma/`, `captures-ios/`) | Juil. 2026 |
| `scripts-legacy/` | Scripts figma, captures, integrate-sopheamen | Juil. 2026 |
| `config-duplicates/` | Configs dupliquées (ex. `LostPhone/codemagic.yaml`) | Juil. 2026 |

---

## Pourquoi Sopheamen est ici

Les sources Patreon brutes ont servi à produire `LostPhone/LostPhone/Apps/Vendored/`.  
Le runtime compile **Vendored/** uniquement. Garder 2100+ fichiers dans `Apps/` encombrait l'arborescence et confondait les agents IA.

**Scripts vendoring :** `LostPhone/scripts/vendor_sopheamen_batch.py` lit depuis `/tmp/sopheamen-scan` ou `vendor-incoming/`, pas depuis cette archive.

---

## Restaurer un élément

```bash
# Exemple : consulter l'ancien Creator React
ls archive/legacy-react/src/

# Ne pas déplacer vers la racine sans mettre à jour CI et DECISIONS.md
```

---

## Taille git

Cette archive augmente la taille du dépôt. Option future : sous-module git ou repo `lost-phone-archive` séparé (décision non prise).
