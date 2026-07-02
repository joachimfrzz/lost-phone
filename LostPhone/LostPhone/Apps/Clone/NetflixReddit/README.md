# Netflix — clone debuging-life (vendored)

Source : [debuging-life/netflix-clone](https://github.com/debuging-life/netflix-clone)

Intégré dans Lost Phone comme Uber / Instagram : **UI du clone copiée**, branchée sur LPSP J-3.

## Fichiers vendored (UI du repo)

Adaptés sans dépendances externes (pas de Supabase, Kingfisher, TMDB, ToastUI) :

- `NetflixRedditLogoView.swift` — logo NETFLIX courbé
- `NetflixRedditButton.swift` — boutons Lecture / Ma liste
- `NetflixRedditTopBar.swift` — barre « Pour {profil} »
- `NetflixRedditHeroCard.swift` — carte hero + gradient
- `NetflixRedditPosterCard.swift` — rangées horizontales (style VideoCollectionView)
- `NetflixRedditTheme.swift` — couleurs asset

## Ajouts Lost Phone

- `NetflixRedditApp.swift` — écran principal
- `NetflixRedditLPSPViews.swift` — profils, Reprendre, compte (données J-3)

## Assets

Couleurs copiées dans `Assets.xcassets/` : `netflixRed`, `bgLightGray`, `buttonGrayDark`, `profileBG`, `customDarkGray`

## Note technique

Le repo original charge les films via TMDB + Supabase auth. Lost Phone utilise les données `content.apps.Netflix` du LPSP (profils Hugo/Mathieu, Reprendre, abonnement).
