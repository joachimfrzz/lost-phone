# Recherche clones — catalogue curé Lost Phone

Objectif : pour chaque app retenue dans la note vocale (juillet 2026), identifier si un **clone SwiftUI** existe, si un **clone Flutter** peut servir de référence, ou quelle **solution** permet d’atteindre la qualité zerocode117.

**Légende statut**
| Symbole | Signification |
|---------|---------------|
| ✅ | Clone SwiftUI trouvé — vendorable |
| ⚠️ | SwiftUI partiel / vieux / UI seulement |
| 🔄 | Flutter seulement — réécriture SwiftUI possible |
| 🛠️ | Pas de clone — construction sur mesure |
| ✓ | Déjà en qualité zerocode117 dans Lost Phone |

**Légende effort** : S (&lt; 1 j) · M (1–3 j) · L (3–7 j) · XL (7+ j)

**Qualité cible** : comparée aux apps `Apps/Clone/` (zerocode117) — ★★★★★ = indistinguable en showroom

---

## Déjà parfait — ne pas refaire

| App | Où | Qualité |
|-----|-----|---------|
| Musique (Apple Music) | Dock zerocode117 | ★★★★★ |
| Rappels | `RappelsSwifty/` page 2 | ★★★★★ |
| Contacts, Wallet, Dictaphone | Page 2 | ★★★★★ |
| Météo, Calendrier, Photos, Notes, Mail, etc. | Page 1 + dock | ★★★★★ |

---

## Messagerie

| App | Statut | Meilleur candidat SwiftUI | Qualité estimée | Effort | Si rien / fallback |
|-----|--------|---------------------------|-----------------|--------|-------------------|
| **WhatsApp** | ✅ | [omarthamri/WhatsAPPClone-Swiftui](https://github.com/omarthamri/WhatsAPPClone-Swiftui) | ★★★★ | L | Virer Firebase → données LPSP demo |
| **Telegram** | ✅ | [dopebase/messenger-iOS-chat-swift-firestore](https://github.com/dopebase/messenger-iOS-chat-swift-firestore) (MIT, 789★) | ★★★★ | L | Même recette — strip Firestore |
| **Teams** | ✅ | [techschneiderrr/Ms-Teams-Clone](https://github.com/techschneiderrr/Ms-Teams-Clone) | ★★★ | M | Polish manuel onglets / réunions |
| Messenger (optionnel) | ✅ | [23122K/Messenger-Clone](https://github.com/23122K/Messenger-Clone) | ★★★ | M | — |
| Signal (optionnel) | ❌ | Aucun SwiftUI crédible | — | XL | Shell messagerie générique (style Signal) + LPSP |

---

## Réseaux sociaux

| App | Statut | Meilleur candidat SwiftUI | Qualité estimée | Effort | Si rien / fallback |
|-----|--------|---------------------------|-----------------|--------|-------------------|
| **Instagram** | ✅ | [dmakarau/InstagramClone](https://github.com/dmakarau/InstagramClone) (2025–2026, Swift 6) · fallback UI : [PankajGaikar/Instagram-Clone-SwiftUI](https://github.com/PankajGaikar/Instagram-Clone-SwiftUI) (MIT, 167★, UI only) | ★★★★ / ★★★★★ | L | Combiner UI Pankaj + logique dmakarau, ou strip Firebase |
| **Snapchat** | ⚠️ | [SwiftLogic/SnapchatDetailsTransition](https://github.com/SwiftLogic/SnapchatDetailsTransition) (transitions) + [pierreveron/SwiftUICam](https://github.com/pierreveron/SwiftUICam) (caméra) · vieux : [Gilbert097/Snapchat-Clone-IOS](https://github.com/Gilbert097/Snapchat-Clone-IOS) (UIKit storyboard) | ★★★ | XL | **Assembler** : caméra SwiftUICam + feed stories + gestures ; pas de clone complet récent |
| **Facebook** | ✅ | [omarthamri/FacebookClone](https://github.com/omarthamri/FacebookClone) | ★★★ | M | — |
| **LinkedIn** | ✅ | [DipakRaut/Linkedin_Clone_SwiftUI](https://github.com/DipakRaut/Linkedin_Clone_SwiftUI) | ★★★ | M | — |
| X (optionnel) | ✅ | [boardguy1024/TwitterSwiftUI](https://github.com/boardguy1024/TwitterSwiftUI) | ★★★ | M | — |

**Flutter (référence seulement, pas intégrable tel quel)**

| App | Repo Flutter | Conversion SwiftUI ? |
|-----|--------------|-------------------|
| Instagram | [sopheamen007/app.mobile.flutter-instagram-app-ui](https://github.com/sopheamen007/app.mobile.flutter-instagram-app-ui) | Oui — **réécriture** écran par écran (60–70 % du temps d’un build from scratch). Utiliser comme maquette + Cursor, pas comme code source. |
| Snapchat | [sopheamen007/app.mobile.snapchat-clone-app-ui](https://github.com/sopheamen007/app.mobile.snapchat-clone-app-ui) | Idem — bonne ref visuelle Patreon/Sopheamen |

---

## Rencontres (2 apps)

| App | Statut | Meilleur candidat SwiftUI | Qualité estimée | Effort | Si rien / fallback |
|-----|--------|---------------------------|-----------------|--------|-------------------|
| **Tinder** | ✅ | [alejandro-piguave/TinderCloneSwiftUI](https://github.com/alejandro-piguave/TinderCloneSwiftUI) (MIT, 113★) | ★★★★ | L | Strip Firebase ; swipe + match + chat |
| **Bumble / Hinge / Happn** (1 seul) | ⚠️ | [ritesh-15/flare](https://github.com/ritesh-15/flare) (dating SwiftUI, 2025) · [zabloncharles/Fumble](https://github.com/zabloncharles/Fumble) (style Bumble) · Hinge = [javelwill/hinge-clone](https://github.com/javelwill/hinge-clone) (**React Native**, pas SwiftUI) | ★★★ | L | **Reskin Tinder** : même moteur swipe, palette + copy Bumble/Hinge via LPSP |
| — | 🔄 | [sopheamen007/app.mobile.tinder-clone-app-ui](https://github.com/sopheamen007/app.mobile.tinder-clone-app-ui) (Flutter) | — | — | Référence visuelle pour 2e app dating |

---

## Musique (Spotify — Apple Music déjà dans le dock)

| App | Statut | Meilleur candidat SwiftUI | Qualité estimée | Effort | Si rien / fallback |
|-----|--------|---------------------------|-----------------|--------|-------------------|
| **Spotify** | ✅ | [adriancysvillegast/Spotify-SwiftUI](https://github.com/adriancysvillegast/Spotify-SwiftUI) (MAJ 2026) · [7adans/SpotifySwiftUI](https://github.com/7adans/SpotifySwiftUI) (animations avancées) · [TnasuH/Spotify-SwiftUI](https://github.com/TnasuH/Spotify-SwiftUI) (15★) | ★★★★ | M | Données demo + AVFoundation, pas d’API Spotify réelle |

---

## Vidéo (3 apps)

| App | Statut | Meilleur candidat SwiftUI | Qualité estimée | Effort | Si rien / fallback |
|-----|--------|---------------------------|-----------------|--------|-------------------|
| **Netflix** | ✅ | [qeude/Notflix](https://github.com/qeude/Notflix) (MIT, 95★) | ★★★★ | M | Remplacer API TMDB par assets demo LPSP |
| **YouTube** | ✅ | [heysonder/atlas](https://github.com/heysonder/atlas) (SwiftUI, iOS 26) · [fabirt/iOS-youtube-app](https://github.com/fabirt/iOS-youtube-app) (simple) · [leokossdev/vidacity](https://github.com/leokossdev/vidacity) (complet, lourd) | ★★★★ | M–L | Atlas = bon compromis UI moderne |
| **Disney+ / Prime / Apple TV** (1) | ✅ / ❌ | **Disney+** : [GouthamShiv/iOS_DisneyPlus](https://github.com/GouthamShiv/iOS_DisneyPlus) (MIT) · Prime Video / Apple TV : aucun | ★★★ / — | M / XL | Prioriser **Disney+** ; sinon shell catalogue vidéo (même moteur que Netflix) |

**Flutter** : YouTube [sopheamen007/app.mobile.youtube-clone-app-ui](https://github.com/sopheamen007/app.mobile.youtube-clone-app-ui) → réécriture SwiftUI avec Atlas ou fabirt.

---

## Intelligence artificielle (2 apps)

| App | Statut | Meilleur candidat SwiftUI | Qualité estimée | Effort | Si rien / fallback |
|-----|--------|---------------------------|-----------------|--------|-------------------|
| **ChatGPT** | ✅ | [acalderon20/chatGPT_clone](https://github.com/acalderon20/chatGPT_clone) | ★★★ | M | UI chat + réponses demo LPSP (pas d’API réelle en jeu) |
| **2e IA** (Gemini, Claude, etc.) | ✅ | [CherryHQ/hanlin-ai](https://github.com/CherryHQ/hanlin-ai) (20+ providers, SwiftUI, iOS 18) · [roryford/ManifoldKit](https://github.com/roryford/ManifoldKit) (framework chat multi-backend) | ★★★★ | M | **Un seul repo** : hanlin-ai ou ManifoldKit — choisir provider par histoire LPSP |

Pas de clone « Gemini seul » ou « Claude seul » crédible → **shell chat IA unique** avec icône/nom variable.

---

## Finance (3 apps)

| App | Statut | Meilleur candidat SwiftUI | Qualité estimée | Effort | Si rien / fallback |
|-----|--------|---------------------------|-----------------|--------|-------------------|
| **Banque générique** (nom/couleurs LPSP) | 🛠️ | [Pankajrana01/SuperWallet-SwiftUI](https://github.com/Pankajrana01/SuperWallet-SwiftUI) (wallet fintech) · [SugarHashira/Escudo](https://github.com/SugarHashira/Escudo) (dashboard multi-banques) | ★★★★ | M | **Template LPSP** : solde, virements, historique — `manifest` change nom + couleurs |
| **Revolut ou PayPal** | ⚠️ / ✅ | PayPal : [pikkukurkku/PayPalClone](https://github.com/pikkukurkku/PayPalClone) · Revolut : aucun clone · [marvin753/Noon](https://github.com/marvin753/Noon) (multibanking, 2026) | ★★★ | M | Reskin banque générique en « Revolut » ou vendorer PayPal |
| **Crypto** (Binance / Coinbase) | ⚠️ | [gemwalletcom/gem-ios](https://github.com/gemwalletcom/gem-ios) (GPL-3, archivé → [gemwalletcom/wallet](https://github.com/gemwalletcom/wallet)) · [mohitsharmadl/anvil-wallet](https://github.com/mohitsharmadl/anvil-wallet) (Rust+SwiftUI, lourd) | ★★★ | L | **Écran portefeuille simplifié** : 3–4 vues (solde, graph, send) — pas un vrai wallet on-chain |

**Flutter** : [sopheamen007/app.mobile.banking-clone-app-ui](https://github.com/sopheamen007/app.mobile.banking-clone-app-ui) → bonne ref pour banque générique, réécriture SwiftUI.

---

## Shopping / livraison / mobilité

| App | Statut | Meilleur candidat SwiftUI | Qualité estimée | Effort | Si rien / fallback |
|-----|--------|---------------------------|-----------------|--------|-------------------|
| **Amazon** | ⚠️ | [Djallil14/Amazing.ca-Amazon-SwiftUI-Clone](https://github.com/Djallil14/Amazing.ca-Amazon-SwiftUI-Clone) (UI only, 2021) · [deepanshubajaj/GlamCartShoppingApp-SwiftUI](https://github.com/deepanshubajaj/GlamCartShoppingApp-SwiftUI) (e-commerce complet) | ★★★ | M–L | GlamCart = moteur e-commerce ; reskin Amazon (couleurs + catégories LPSP) |
| **Uber** | ✅ | [WorkWithAfridi/SwiftUI-iUber_A-Uber-Clone](https://github.com/WorkWithAfridi/SwiftUI-iUber_A-Uber-Clone) | ★★★ | M | Carte MapKit + course demo |
| **Uber Eats** | 🔄 | Pas de SwiftUI crédible · Flutter : [sopheamen007/app.mobile.ubereats-clone-app-ui](https://github.com/sopheamen007/app.mobile.ubereats-clone-app-ui) (228★) | — | L | **Réécriture SwiftUI** depuis Flutter OU shell food-delivery : [islamIbrahim89/UberEats-MobileSytstemDesign](https://github.com/islamIbrahim89/UberEats-MobileSytstemDesign) (patterns) + [SierikovaTetiana/RestaurantAppSwiftUI](https://github.com/SierikovaTetiana/RestaurantAppSwiftUI) |
| Waze (conditionnel) | ❌ | Aucun | — | XL | **Ignorer** si Plans présent — même MapKit ; sinon réutiliser moteur Plans |

---

## Voyage (3 types : hôtels, vols, trains)

| Besoin | Statut | Meilleur candidat SwiftUI | Qualité estimée | Effort | Solution |
|--------|--------|---------------------------|-----------------|--------|----------|
| **Hôtels** | ✅ | [Keerthi-Sparkout/AirbnbClone-SwiftUI](https://github.com/Keerthi-Sparkout/AirbnbClone-SwiftUI) · [williamsouef/Travel-Booking-App-SwiftUI](https://github.com/williamsouef/Travel-Booking-App-SwiftUI) (15★) · [manuellugodev/HotelClientIos](https://github.com/manuellugodev/HotelClientIos) | ★★★★ | M | Airbnb = meilleur look ; reskin « Booking » via LPSP |
| **Vols avion** | ✅ | [chrisfree/flightySwiftUI](https://github.com/chrisfree/flightySwiftUI) (55★, recréation Flighty) · [JosiasPerJac/Lift](https://github.com/JosiasPerJac/Lift) (tracker complet) · [malczan/FlightTracker-SwiftUI](https://github.com/malczan/FlightTracker-SwiftUI) | ★★★★ | M | flightySwiftUI = meilleur polish UI ; données demo sans API |
| **Trains** | ⚠️ | [alfredang/sgmrtapp](https://github.com/alfredang/sgmrtapp) (MRT Singapore, SwiftUI, 2025) · [AlessandroVacca/dima-polimi-trenord](https://github.com/AlessandroVacca/dima-polimi-trenord) (Trenord, Firebase) | ★★★ | L | **Reskin sgmrtapp** en « SNCF / Trainline » : même UX planner + carte ; données statiques LPSP |

Pas de clone Trainline/SNCF natif récent → shell voyage trains basé sur sgmrtapp.

---

## Utilitaires

| App | Statut | Meilleur candidat SwiftUI | Qualité estimée | Effort | Solution |
|-----|--------|---------------------------|-----------------|--------|----------|
| **Fichiers** | ⚠️ | [noppefoxwolf/FileManagerUI](https://github.com/noppefoxwolf/FileManagerUI) (SPM, 2025) · [AzozzALFiras/Secure-File-Manager-Pro](https://github.com/AzozzALFiras/Secure-File-Manager-Pro) | ★★★★ | M | FileManagerUI = base ; brancher dossiers LPSP + assets histoire |
| **Plans** (Maps) | ⚠️ | [karanb03/iOS-map-clone](https://github.com/karanb03/iOS-map-clone) (MapKit + directions) | ★★★ | M | MapKit natif + recherche + itinéraire demo LPSP |
| **Cloud PC** (fichiers du PC joueur) | 🛠️ | Aucun | — | XL | **Feature Lost Phone** : WebDAV / lien magique / sync dossier — UI = Fichiers avec source « Mon PC » |
| **Strava** (optionnel) | ⚠️ | Pas de clone UI Strava · apps avec API : [renzoventura/stride](https://github.com/renzoventura/stride) (feed runs) | ★★★ | L | UI fitness (carte + stats) + données demo ; pas besoin vraie API Strava |

---

## Flutter → SwiftUI : est-ce possible ?

**Oui, mais ce n’est pas une conversion automatique.** C’est une **réécriture** en prenant le Flutter comme **maquette fonctionnelle**.

| Aspect | Réalité |
|--------|---------|
| Intégrer Flutter dans Lost Phone | ❌ Non — app SwiftUI native, pas de moteur Flutter embarqué |
| Traduire Dart → Swift ligne par ligne | ❌ Impossible — frameworks différents |
| Réécrire écran par écran avec Cursor + clone Flutter ouvert à côté | ✅ **Méthode recommandée** pour Snapchat, Uber Eats, YouTube (Sopheamen) |
| Temps estimé vs build from scratch | ~60–70 % du temps d’une création from scratch |
| Qualité zerocode117 atteignable ? | Oui, **si** polish manuel + données demo LPSP (comme zerocode117) |

**Repos Flutter utiles comme référence visuelle (Sopheamen Van)**

| App | Repo | Stars |
|-----|------|------:|
| Uber Eats | app.mobile.ubereats-clone-app-ui | 228 |
| Instagram | app.mobile.flutter-instagram-app-ui | 118 |
| TikTok | app.mobile.tiktok-app-ui | 90 |
| Tinder | app.mobile.tinder-clone-app-ui | 89 |
| YouTube | app.mobile.youtube-clone-app-ui | 75 |
| Snapchat | app.mobile.snapchat-clone-app-ui | 56 |
| Banking | app.mobile.banking-clone-app-ui | 21 |

---

## Synthèse chiffrée

| Catégorie | Apps | ✅ SwiftUI prêt | ⚠️ Partiel | 🔄 Flutter | 🛠️ Sur mesure |
|-----------|-----:|---------------:|-----------:|-----------:|-------------:|
| Messagerie | 5 | 4 | 0 | 0 | 1 (Signal) |
| Social | 5 | 4 | 1 (Snapchat) | 2 ref | 0 |
| Dating | 2 | 1 | 1 | 1 ref | 0 |
| Musique | 1 | 1 | 0 | 0 | 0 |
| Vidéo | 3 | 3 | 0 | 1 ref | 0 |
| IA | 2 | 2 | 0 | 0 | 0 |
| Finance | 3 | 1 | 2 | 1 ref | 0 |
| Shopping | 4 | 2 | 1 | 1 | 1 (Waze) |
| Voyage | 3 | 3 | 0 | 0 | 0 |
| Utilitaires | 4 | 0 | 3 | 0 | 1 (Cloud PC) |
| **Total curé** | **32** | **21** | **8** | **6 ref** | **3** |

---

## Stratégie qualité zerocode117 (quand pas de clone parfait)

Ordre de préférence :

1. **Vendorer** clone SwiftUI MIT (copier fichiers, strip backend)
2. **Reskin shell** existant (Tinder → Bumble, Netflix → Prime, Banque template → Revolut)
3. **Assembler** briques SwiftUI (Snapchat = SwiftUICam + transitions + feed)
4. **Réécrire depuis Flutter** (Uber Eats, Snapchat UI Sopheamen) avec Cursor — écran par écran
5. **Craft manuel** guidé Spectr/Meliwat — **une app à la fois**, jamais en bulk generate
6. **Awesome** = fallback temporaire seulement, pas vitrine

**Règle d’or** : même recette que zerocode117 — **code UI réel qui tourne**, données demo LPSP, zéro génération massique depuis markdown.

---

## Plan de vendoring recommandé (par impact / facilité)

### Lot 1 — SwiftUI prêt, impact maximal (2–3 semaines agent)
1. WhatsApp · Telegram · Instagram (dmakarau ou PankajGaikar)
2. Spotify · Netflix · YouTube (Atlas)
3. Tinder · Facebook · LinkedIn · Teams

### Lot 2 — Polish moyen
4. Uber · ChatGPT · hanlin-ai (2e IA)
5. Disney+ · PayPal ou banque template
6. Airbnb (hôtels) · flightySwiftUI (vols)

### Lot 3 — Plus difficile
7. Snapchat (assemblage) · Uber Eats (réécriture Flutter)
8. Amazon (reskin GlamCart) · 2e dating (reskin Tinder)
9. Fichiers · Plans · Trains (reskin sgmrtapp)

### Lot 4 — Sur mesure
10. Banque générique LPSP · Crypto simplifié · Cloud PC · Strava optionnel

---

## Catalogue Swift final (référence)

```
Messagerie    : WhatsApp, Telegram, Teams [, Messenger, Signal]
Social        : Instagram, Snapchat, Facebook, LinkedIn [, X]
Dating        : Tinder, + (Bumble|Hinge|Happn)
Musique       : Spotify  (+ Musique zerocode117)
Vidéo         : Netflix, YouTube, + (Disney+|Prime|Apple TV)
IA            : ChatGPT, + (Gemini|Claude|Perplexity|Grok)
Finance       : Banque générique, Revolut|PayPal, Crypto
Shopping      : Amazon, Uber, Uber Eats [, Waze]
Voyage        : Hôtels, Vols, Trains
Utilitaires   : Fichiers, Plans, Cloud PC [, Strava]
Déjà fait     : Rappels, Musique, apps Apple page 1–2
```

---

Dernière mise à jour : 2026-07-08
