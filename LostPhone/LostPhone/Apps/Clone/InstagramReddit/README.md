# Instagram — clone NDCSwift (vendored)

Source : [NDCSwift/InstagramRecreation2](https://github.com/NDCSwift/InstagramRecreation2)

Intégré dans Lost Phone comme Uber : code Swift copié dans ce dossier, branché via `LpspInstagramView`.

## Fichiers vendored (repo GitHub)

- `InstagramRedditTopAppBar.swift` — barre « Instagram » + icônes
- `InstagramRedditStoriesBar.swift` — stories horizontales
- `InstagramRedditFeedPost.swift` / `InstagramRedditFeedList.swift` — fil d'actualité
- `InstagramRedditBottomTabBar.swift` — tab bar 5 icônes

## Ajouts Lost Phone

- `InstagramRedditApp.swift` — routing onglets (feed / profil / placeholders)
- `InstagramProfileTabView.swift` — profil + grille LPSP J-3

## Assets

- `post.imageset` copié dans `LostPhone/Assets.xcassets/`

## Onglets

| Index | Écran |
|-------|--------|
| 0 Accueil | Clone feed + posts LPSP |
| 4 Profil | Pseudo, bio, grille publications |
| 1–3 | Placeholder read-only |
