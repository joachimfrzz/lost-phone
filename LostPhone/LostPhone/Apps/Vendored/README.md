# Apps vendored (GitHub → Lost Phone)

Même recette que [zerocode117/iOS-26-clone](https://github.com/zerocode117/iOS-26-clone) et `Apps/Clone/` :

1. **Copier** les fichiers Swift (+ assets) du repo tel quel.
2. **Préfixer** les types (`Vendored<App>_`) pour éviter les collisions entre clones.
3. **Ne pas réécrire** l’UI — pas de version « inspirée ».
4. Ajouter l’app dans `VendoredShowroomCatalog.tierApps` + `VendoredShowroomRouter`.
5. Documenter dans `<App>/SOURCE.md` (URL, commit, licence, adaptations).
6. `SOURCE.md` est exclu du bundle (`project.yml`).

Script : `python3 LostPhone/scripts/vendor_swiftui_clone.py`

## Routage showroom

```
CloneAppCatalog (Apple) → VendoredShowroomCatalog → AwesomeShowroomCatalog → fallback
```

## Apps intégrées (lot 1 — clones quasi parfaits)

| App | Dossier | Repo | Entrée |
|-----|---------|------|--------|
| TikTok | `TikTok/` | johannpires/TikTok-Clone-App | `LpspVendoredTikTokRootView` |
| Instagram | `Instagram/` | PankajGaikar/Instagram-Clone-SwiftUI | `LpspVendoredInstagramRootView` |
| LinkedIn | `LinkedIn/` | DipakRaut/Linkedin_Clone_SwiftUI | `LpspVendoredLinkedInRootView` |
| Teams | `Teams/` | techschneiderrr/Ms-Teams-Clone | `LpspVendoredTeamsRootView` |
| Spotify | `Spotify/` | 7adans/SpotifySwiftUI | `LpspVendoredSpotifyRootView` |
| Netflix | `Netflix/` | qeude/Notflix | `LpspVendoredNetflixRootView` |
| Disney+ | `DisneyPlus/` | GouthamShiv/iOS_DisneyPlus | `LpspVendoredDisneyPlusRootView` |
| ChatGPT | `ChatGPT/` | acalderon20/chatGPT_clone | `LpspVendoredChatGPTRootView` |
| PayPal | `PayPal/` | pikkukurkku/PayPalClone | `LpspVendoredPayPalRootView` |
| Uber | `Uber/` | WorkWithAfridi/SwiftUI-iUber_A-Uber-Clone | `LpspVendoredUberRootView` |
| Airbnb / Booking | `Airbnb/` | Keerthi-Sparkout/AirbnbClone-SwiftUI | `LpspVendoredAirbnbRootView` |

## Apps Apple (Sopheamen — remplace zerocode117)

| App LPSP | Dossier | Source | Entrée |
|----------|---------|--------|--------|
| Mail | `Gmail/` | Patreon `Youtube_Gmail_v1.zip` | `LpspVendoredGmailRootView` |
| App Store | `AppStore/` | Patreon `Youtube_Appstore_v1.zip` | `LpspVendoredAppStoreRootView` |
| Musique | `AppleMusic/` | Patreon `Youtube_Apple_music_clone_v2.zip` | `LpspVendoredAppleMusicRootView` |

## Bundle Sopheamen complet (21 zip → showroom)

Voir `SopheamenShowroomCatalog.swift` — **18 apps** pages 3+ + **3 Apple** page 1/dock.

| App LPSP | Dossier | Zip |
|----------|---------|-----|
| WhatsApp | `WhatsApp/` | WhatsAppclone patreon.zip |
| Instagram | `Instagram/` | Instagram clone patreon.zip |
| Snapchat | `Snapchat/` | Snapchat Clone patreon.zip |
| LinkedIn | `LinkedIn/` | LinkedIn Clone patreon.zip |
| Facebook | `Facebook/` | Youtube_Facebook_v1.zip |
| Messenger | `Messenger/` | Youtube_FacebookMessenger_v1.zip |
| Threads | `Threads/` | Youtube_Threads_v1.zip |
| Grok | `Grok/` | grok_clone_v1.zip (**port SwiftUI** depuis Flutter) |
| Gemini | `Gemini/` | Youtube_Gemini_clone_v1.zip |
| Netflix | `Netflix/` | Youtube_Netflix_v1.zip |
| YouTube | `YouTube/` | Youtube_Youtube_v1.zip |
| YouTube Music | `YouTubeMusic/` | Youtube_Music_v2_1.zip |
| Coinbase (Phantom) | `Phantom/` | Youtube_Phantom_clone_v1.zip |
| Uber | `Uber/` | Youtube_uber_clone_v1.zip |
| Uber Eats | `UberEats/` | food-delivery-ui-kit-cart-checkout.zip |
| Airbnb | `Airbnb/` | youtube_airbnb_clone_v1.zip |
| Tinder | `Tinder/` | tinder_clone_ui_kit.zip (**port SwiftUI** depuis Flutter) |
| TikTok | `TikTok/` | Youtube_Tiktok_v1.zip |

Scripts : `vendor_sopheamen_batch.py`, `fix_vendored_colors.py`

Sauvegarde zerocode117 : `Apps/Clone/_backup/zerocode117/`.

## Lot 2 (plus tard — Firebase / Flutter / sur mesure)

WhatsApp, Telegram, Facebook, Snapchat, Tinder, YouTube, Uber Eats, Amazon, banque générique, crypto, voyage (vols/trains), Fichiers, Plans, Cloud PC.
