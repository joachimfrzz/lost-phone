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

## Lot 2 (plus tard — Firebase / Flutter / sur mesure)

WhatsApp, Telegram, Facebook, Snapchat, Tinder, YouTube, Uber Eats, Amazon, banque générique, crypto, voyage (vols/trains), Fichiers, Plans, Cloud PC.
