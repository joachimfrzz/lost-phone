# Apps vendored (GitHub → Lost Phone)

Même recette que [zerocode117/iOS-26-clone](https://github.com/zerocode117/iOS-26-clone) et `Apps/Clone/` :

1. **Copier** les fichiers Swift (+ assets) du repo tel quel.
2. **Renommer** uniquement les conflits de types / fichiers.
3. **Ne pas réécrire** l’UI — pas de version « inspirée ».
4. Ajouter l’app dans `VendoredShowroomCatalog.tierApps` + `VendoredShowroomRouter`.
5. Documenter dans `<App>/SOURCE.md` (URL, commit, licence, adaptations).
6. `SOURCE.md` est exclu du bundle (`project.yml`).

## Routage showroom

```
CloneAppCatalog (Apple) → VendoredShowroomCatalog → AwesomeShowroomCatalog → fallback
```

Fichiers :
- `VendoredShowroomCatalog.swift` — liste des apps vendored actives
- `VendoredShowroomRouter.swift` — entrées par app
- `LpspAppRouter.showroomAppView` — priorité vendored avant Awesome

## Matrice complète

Voir [docs/VENDORED_MATRIX.md](../../docs/VENDORED_MATRIX.md) — 61 apps, candidats GitHub, effort, statut.

## Apps intégrées

| App | Dossier | SOURCE |
|-----|---------|--------|
| TikTok | `TikTok/` | [SOURCE.md](TikTok/SOURCE.md) |
