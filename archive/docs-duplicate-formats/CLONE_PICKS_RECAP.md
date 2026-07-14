# Lost Phone — Récap sélection clones (catalogue priorisé)

> Fichier de travail — à modifier librement.  
> Dernière mise à jour : 2026-07-08  
> Branche cible : `cursor/vendored-clones-a052`  
> Qualité cible : showroom zerocode117 · SwiftUI · iOS 17+ · données demo LPSP

**Légende statut**
| Statut | Signification |
|--------|---------------|
| `choisi` | Lien retenu par Joachim |
| `patreon` | Code Sopheamen — achat Patreon requis |
| `hybride` | Combiner 2 sources |
| `à décider` | Pas encore choisi |
| `à vérifier` | Repo à valider avant vendoring |
| `attention` | Intégration difficile (officiel, UIKit, Flutter…) |

---

## Déjà fait — ne pas refaire

| App | Où | Statut |
|-----|-----|--------|
| Musique (Apple Music) | Dock zerocode117 | ✓ fait |
| Rappels | `Apps/Clone/RappelsSwifty/` | ✓ fait |
| Contacts, Wallet, Dictaphone | Page 2 clone | ✓ fait |
| Météo, Calendrier, Photos, Notes, Mail, Téléphone, Safari… | Page 1 zerocode117 | ✓ fait |

---

## Messagerie

| App | Lien(s) | Statut | Notes |
|-----|---------|--------|-------|
| **WhatsApp** | https://github.com/efxlve/whatsapp-clone | `choisi` | MIT · Firebase · iOS 18+ dans le repo — à adapter iOS 17 |
| **Telegram** | https://github.com/Swiftgram/Telegram-iOS | `attention` | App officielle UIKit — build lourd, pas un clone léger |
| | *Alternative :* https://github.com/levochkaa/BetterTG | `à décider` | SwiftUI + TDLib |
| | *Alternative :* https://github.com/dopebase/messenger-iOS-chat-swift-firestore | `à décider` | ~789★ MIT · chat générique |
| **Microsoft Teams** | *(vide)* | `à décider` | Suggestion : https://github.com/techschneiderrr/Ms-Teams-Clone |
| **Messenger** | https://github.com/sopheamen007/app.mobile.facebook-messenger-app-ui | `attention` | **Flutter** — pas SwiftUI natif |
| | *Alternative :* https://github.com/23122K/Messenger-Clone | `à décider` | SwiftUI |
| **Signal** | https://github.com/signalapp/Signal-iOS | `attention` | App officielle UIKit — pas intégrable comme clone showroom |

---

## Réseaux sociaux

| App | Lien(s) | Statut | Notes |
|-----|---------|--------|-------|
| **Instagram** | https://github.com/dmakarau/InstagramClone | `choisi` | Swift 6 · 2025–2026 · Firebase |
| **Snapchat** | https://www.patreon.com/sopheamenvan/posts/swiftui-snapchat-106774973 | `patreon` | SwiftUI Sopheamen — acheter / récupérer code |
| **Facebook** | https://github.com/omarthamri/FacebookClone | `choisi` | ~25★ · Firebase |
| | https://github.com/jmmanoza/Facebook | `choisi` | Backup |
| **LinkedIn** | https://www.patreon.com/sopheamenvan/posts/swiftui-linkedin-106774147 | `patreon` | SwiftUI Sopheamen |
| **Twitter / X** | https://github.com/boardguy1024/TwitterSwiftUI | `hybride` | **Base UI** — écrans principaux |
| | https://github.com/jurmadani/TwitterClone | `hybride` | **Dock onglets** accueil uniquement |
| | *Spec :* UI `boardguy1024` + bottom bar home de `jurmadani` | | |

---

## Rencontres

| App | Lien(s) | Statut | Notes |
|-----|---------|--------|-------|
| **Tinder** | https://github.com/FranckNdame/swiftui.builds | `à vérifier` | Repo générique ~588★ — **pas un clone Tinder dédié** |
| | https://github.com/enesozmus/SwiftUI-Tinder-Clone | `choisi` | iOS 17 · 2024 |
| | *Alternative :* https://github.com/alejandro-piguave/TinderCloneSwiftUI | `à décider` | ~113★ MIT · swipe + match + chat |
| **Happn / Bumble / Hinge** | *(vide)* | `à décider` | Suggestion Bumble : https://github.com/zabloncharles/Fumble |

---

## Musique

| App | Lien(s) | Statut | Notes |
|-----|---------|--------|-------|
| **Spotify** | https://github.com/denoni/SpotifyClone | `choisi` | ~291★ · API Spotify (30s previews) |
| | https://github.com/adriancysvillegast/Spotify-SwiftUI | `choisi` | Zéro dépendance · AVFoundation · MAJ 2026 |
| | https://github.com/SwiftlyCoded/Spotify-Clone-SwiftUI | `choisi` | ~3★ · backup |
| | *Déjà vendored :* https://github.com/7adans/SpotifySwiftUI | `écarté` | Qualité Appetize insuffisante |

---

## Vidéo

| App | Lien(s) | Statut | Notes |
|-----|---------|--------|-------|
| **Netflix** | https://github.com/qeude/Notflix | `choisi` | ~95★ MIT · TMDB → remplacer par demo LPSP |
| **YouTube** | https://github.com/milika/SmartTubeIOS | `choisi` | ~122★ · client natif multi-plateforme |
| **YouTube Music** | https://github.com/barisozgenn/YoutubeMusicClone-SwiftUI-UIKit | `choisi` | SwiftUI + UIKit |
| **Prime Video** | https://github.com/yagizdo/PrimeVideoDesignWithSwift | `choisi` | UI design seulement |
| **Disney+** | *(non listé)* | `à décider` | https://github.com/GouthamShiv/iOS_DisneyPlus |

---

## Intelligence artificielle

| App | Lien(s) | Statut | Notes |
|-----|---------|--------|-------|
| **ChatGPT** | https://github.com/acalderon20/chatGPT_clone | `choisi` | Léger · réponses demo LPSP |
| **2e IA** (Gemini, Claude…) | *(vide)* | `à décider` | Suggestion : https://github.com/CherryHQ/hanlin-ai (~230★, 20+ providers) |

---

## Finance

| App | Lien(s) | Statut | Notes |
|-----|---------|--------|-------|
| **Banque générique LPSP** | https://github.com/Pankajrana01/SuperWallet-SwiftUI | `choisi` | Template fintech · reskin nom/couleurs |
| | https://github.com/govardhansbhati/pocketpulse | `choisi` | Finance tracker · backup |
| **PayPal** | https://github.com/pikkukurkku/PayPalClone | `choisi` | Déjà testé vendored |
| **Revolut** | *(vide)* | `à décider` | Pas de clone UI — reskin banque générique |
| **Coinbase / Binance / Crypto** | https://github.com/RedDragonJ/Swift-Learning/tree/main/SwiftUIAndCoinbase | `à vérifier` | Tutoriel — pas wallet complet |
| | https://www.patreon.com/sopheamenvan/posts/build-phantom-on-124537380 | `patreon` | Phantom wallet · Sopheamen |

---

## Shopping / livraison / mobilité

| App | Lien(s) | Statut | Notes |
|-----|---------|--------|-------|
| **Amazon** | https://github.com/Djallil14/Amazing.ca-Amazon-SwiftUI-Clone | `choisi` | UI only · 2021 |
| | https://github.com/404ibra/AmazonClone | `choisi` | Homepage · 2023 |
| **Uber** | https://github.com/Huss3n/UberSwiftUI | `choisi` | ~6★ · Firebase |
| | https://github.com/WorkWithAfridi/SwiftUI-iUber_A-Uber-Clone | `choisi` | Backup |
| **Uber Eats** | https://www.patreon.com/sopheamenvan/posts/build-uber-clone-116211445 | `patreon` | Sopheamen |
| **Discord** | https://github.com/piwien/Discord-Clone | `choisi` | ~1★ · hors liste initiale |
| **Waze** | *(vide)* | `à décider` | Suggestion : https://github.com/GGCIRILLO/Waze-Clone-NC1 · ou ignorer si Plans suffit |

---

## Voyage

| App | Lien(s) | Statut | Notes |
|-----|---------|--------|-------|
| **Airbnb / Hôtels** | https://github.com/piwien/Airbnb-Clone | `à vérifier` | 0★ · très léger |
| | *Alternative :* https://github.com/Keerthi-Sparkout/AirbnbClone-SwiftUI | `à décider` | ~11★ |
| | *Alternative :* https://github.com/sebastian-nunez/airbnb-ios | `à décider` | ~11★ · booking MapKit |
| **Hôtel** (Booking…) | *(vide)* | `à décider` | Reskin Airbnb ou https://github.com/williamsouef/Travel-Booking-App-SwiftUI |
| **Flighty / Vols** | https://github.com/chrisfree/flightySwiftUI | `choisi` | ~55★ · meilleur polish UI |
| **Trains** (SNCF / Trainline) | *(vide)* | `à décider` | Suggestion : https://github.com/alfredang/sgmrtapp (reskin SNCF) |

---

## Utilitaires

| App | Lien(s) | Statut | Notes |
|-----|---------|--------|-------|
| **Fichiers** | *(vide)* | `à décider` | Suggestion : https://github.com/noppefoxwolf/FileManagerUI |
| **Plans / Maps** | https://github.com/karanb03/iOS-map-clone | `choisi` | MapKit · directions demo |
| **Cloud PC** | *(vide)* | `à décider` | Sur mesure Lost Phone — pas de clone |
| **Strava** (optionnel) | *(vide)* | `à décider` | Suggestion : https://github.com/renzoventura/stride |

---

## Patreon Sopheamen Van — récap

| Post | App | Lien |
|------|-----|------|
| SwiftUI Snapchat | Snapchat | https://www.patreon.com/sopheamenvan/posts/swiftui-snapchat-106774973 |
| SwiftUI LinkedIn | LinkedIn | https://www.patreon.com/sopheamenvan/posts/swiftui-linkedin-106774147 |
| Uber clone | Uber Eats | https://www.patreon.com/sopheamenvan/posts/build-uber-clone-116211445 |
| Phantom | Crypto | https://www.patreon.com/sopheamenvan/posts/build-phantom-on-124537380 |
| Profil | — | https://www.patreon.com/cw/sopheamenvan |

---

## Specs spéciales

### Twitter / X (hybride)

1. **Vendorer** `boardguy1024/TwitterSwiftUI` comme base (timeline, profil, etc.)
2. **Extraire** le dock / `TabView` de l’écran d’accueil depuis `jurmadani/TwitterClone`
3. **Greffer** le bottom bar jurmadani sur le home boardguy1024
4. Données : mock LPSP (pas d’API Twitter)

---

## Compteur

| | Nombre |
|--|-------:|
| Apps avec lien `choisi` | ~28 |
| Apps `patreon` (Sopheamen) | 4 |
| Apps `à décider` / vides | ~12 |
| Apps `attention` (à remplacer ?) | 4 (Telegram, Signal, Messenger Flutter, FranckNdame Tinder) |

---

## Mes modifications (espace libre)

```
Teams :
Telegram (remplacement ?) :
Signal (garder / ignorer / shell ?) :
Messenger :
Happn / Bumble / Hinge :
Disney+ :
2e IA :
Revolut :
Hôtel :
Trains :
Fichiers :
Waze :
Strava :
Autres :
```

---

*Généré pour Lost Phone · joachimfrzz/lost-phone*
