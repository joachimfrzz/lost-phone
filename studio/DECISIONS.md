# Journal des décisions — Restructuration Studio (juillet 2026)

Décisions prises lors de la migration vers **LostPhone Studio** et préparation du nouveau compte Cursor.

---

## D-001 — LostPhone Studio comme produit principal

**Décision :** Le studio devient l'entité centrale ; Lost Phone est le projet #1.  
**Raison :** Éviter de refaire le même travail à chaque histoire/app/release.  
**Impact :** Toute amélioration doit évaluer « améliore-t-elle le Studio ? »

---

## D-002 — Archiver, ne jamais supprimer

**Décision :** Les éléments obsolètes vont dans `archive/`, pas de suppression définitive.  
**Raison :** Préserver mois de travail (code, prompts, expérimentations).  
**Impact :** `archive/README.md` documente chaque sous-dossier.

---

## D-003 — Pivot SwiftUI confirmé

**Décision :** React/Capacitor/Figma ne sont plus la cible iPhone.  
**Action :** `src/`, `ios/` (Capacitor), `ios-swiftui/` → `archive/`.  
**Runtime unique :** `LostPhone/` SwiftUI.

---

## D-004 — LPSP : une source de vérité

**Décision :** `public/stories/` est la source éditoriale.  
**Copie générée :** `LostPhone/LostPhone/Resources/stories/` via `npm run lpsp:sync`.  
**Raison :** Éviter la dérive entre 3 copies.

---

## D-005 — Sopheamen brut hors de l'app

**Décision :** `Apps/Sopheamen/` (~2100 fichiers) déplacé vers `archive/sopheamen-raw/`.  
**Raison :** Exclu du build ; doublons avec `Vendored/` ; encombre l'arborescence active.  
**Production :** `Apps/Vendored/` uniquement.

---

## D-006 — Documentation consolidée

**Décision :** Index unique `studio/docs/INDEX.md` ; docs pré-pivot dans `archive/docs-pre-pivot/`.  
**Conservé actif :** docs SwiftUI, showroom, clones, ops.  
**Archivé :** PLAN.md, FIGMA-SETUP, NATIVE.md, ARCHITECTURE.md (React).

---

## D-007 — Formats CLONE_PICKS dupliqués

**Décision :** Garder `JOACHIM_CLONE_PICKS.md` + `VENDORED_MATRIX.md` comme références.  
**Archivé :** `.csv`, `.txt`, `.html` exports redondants.

---

## D-008 — CI simplifié

**Décision :** Workflow actif = `lost-phone-swiftui` (Codemagic) + `ios-preview` (GitHub).  
**Archivé :** workflow Capacitor `lost-phone-ios`, duplicate `LostPhone/codemagic.yaml`.

---

## D-009 — package.json minimal

**Décision :** Conserver `package.json` racine uniquement pour `lpsp:sync` et tooling Node léger.  
**Scripts legacy** (figma, captures, cap) archivés avec React.

---

## D-010 — AGENTS.md pour nouveau compte Cursor

**Décision :** Créer `AGENTS.md` à la racine avec vision Studio + chemins actifs.  
**Raison :** Onboarding propre sur nouveau compte sans perdre le contexte.

---

## Non fait (intentionnellement)

| Item | Raison |
|------|--------|
| Renommer `LostPhone/LostPhone/` en `app/Sources/` | Trop de chemins CI/scripts à mettre à jour en une passe |
| Retirer `Awesome/` du runtime | Encore utilisé comme fallback showroom |
| Sync Notion automatisée | Phase suivante — développement Studio |
| Supprimer `node_modules` / `dist` | Gitignored ; régénérables |

---

## Prochaines décisions attendues

1. Structure `studio/tooling/` vs `LostPhone/scripts/` — convergence progressive
2. Repo séparé pour `archive/legacy-react/` ? (si taille git problématique)
3. Definition of Done par app (Notion ↔ code)
4. Preflight CI v2 (patterns Swift 6)
