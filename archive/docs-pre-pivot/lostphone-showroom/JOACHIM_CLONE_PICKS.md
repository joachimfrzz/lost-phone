# Joachim — sélection finale clones

> Validé par Joachim · 2026-07-08 (soir)  
> Branche : `cursor/vendored-clones-a052`  
> Zips locaux : voir `LostPhone/vendor-incoming/`

---

## Liste officielle (ta sélection)

| App | Source retenue | Type |
|-----|----------------|------|
| WhatsApp | https://github.com/efxlve/whatsapp-clone | GitHub |
| Telegram | https://github.com/Swiftgram/Telegram-iOS | GitHub ⚠️ |
| Microsoft Teams | *(vide)* | — |
| Messenger | https://github.com/sopheamen007/app.mobile.facebook-messenger-app-ui | Flutter ⚠️ |
| Signal | https://github.com/signalapp/Signal-iOS | Officiel ⚠️ |
| Instagram | https://github.com/dmakarau/InstagramClone | GitHub |
| Snapchat | https://www.patreon.com/sopheamenvan/posts/swiftui-snapchat-106774973 | Patreon |
| Facebook | https://github.com/omarthamri/FacebookClone **ou** https://github.com/jmmanoza/Facebook | GitHub (2) |
| LinkedIn | https://www.patreon.com/sopheamenvan/posts/swiftui-linkedin-106774147 | Patreon |
| Twitter / X | https://github.com/boardguy1024/TwitterSwiftUI + https://github.com/jurmadani/TwitterClone | Hybride |
| Tinder | https://github.com/FranckNdame/swiftui.builds + https://github.com/enesozmus/SwiftUI-Tinder-Clone | GitHub (2) |
| Happn / Bumble / Hinge | *(vide)* | — |
| Spotify | https://github.com/denoni/SpotifyClone + alts ci-dessous | GitHub (3) |
| Netflix | https://github.com/qeude/Notflix | GitHub |
| YouTube Music | https://github.com/barisozgenn/YoutubeMusicClone-SwiftUI-UIKit | GitHub |
| YouTube | https://github.com/milika/SmartTubeIOS | GitHub |
| Prime Video | https://github.com/yagizdo/PrimeVideoDesignWithSwift | GitHub |
| ChatGPT | https://github.com/acalderon20/chatGPT_clone | GitHub |
| Grok | `grok_clone_v1.zip` | **Zip local** |
| Banque LPSP | https://github.com/Pankajrana01/SuperWallet-SwiftUI + https://github.com/govardhansbhati/pocketpulse | GitHub (2) |
| PayPal | https://github.com/pikkukurkku/PayPalClone | GitHub |
| Crypto | https://github.com/RedDragonJ/Swift-Learning/tree/main/SwiftUIAndCoinbase + Patreon Phantom | À vérifier + Patreon |
| Amazon | https://github.com/Djallil14/Amazing.ca-Amazon-SwiftUI-Clone + https://github.com/404ibra/AmazonClone | GitHub (2) |
| Discord | https://github.com/piwien/Discord-Clone | GitHub |
| Airbnb | https://github.com/piwien/Airbnb-Clone | GitHub |
| Uber | https://github.com/Huss3n/UberSwiftUI + https://github.com/WorkWithAfridi/SwiftUI-iUber_A-Uber-Clone | GitHub (2) |
| Uber Eats | *(vide)* | — |
| Hôtel | *(vide)* | — |
| Flighty | https://github.com/chrisfree/flightySwiftUI | GitHub |
| Trains | *(vide)* | — |
| Fichiers | *(vide)* | — |
| Plans | https://github.com/karanb03/iOS-map-clone | GitHub |
| Waze | https://github.com/GGCIRILLO/Waze-Clone-NC1 | GitHub |

---

## Comparaison — clones en double ou triple

### Facebook (2 choix)

| Repo | Stars | Backend | Verdict |
|------|------:|---------|---------|
| **omarthamri/FacebookClone** | ~25 | Firebase | **Principal** — feed + profil plus complet, même auteur que WhatsApp |
| jmmanoza/Facebook | ~2 | ? | Backup — plus léger, bon si omarthamri trop lourd à strip |

→ **Recommandation :** vendorer **omarthamri** en premier ; garder jmmanoza si build échoue.

---

### Twitter / X (hybride — pas vraiment doublon)

| Repo | Rôle |
|------|------|
| **boardguy1024/TwitterSwiftUI** | Timeline, profil, écrans principaux |
| **jurmadani/TwitterClone** | Dock / onglets bas écran d’accueil uniquement |

→ Pas un choix A ou B : **assembler** les deux.

---

### Tinder (2 choix)

| Repo | Stars | Contenu | Verdict |
|------|------:|---------|---------|
| FranckNdame/swiftui.builds | ~588 | Repo **générique** SwiftUI (plusieurs apps), pas Tinder dédié | ⚠️ Risqué — chercher sous-dossier Tinder ou écarter |
| **enesozmus/SwiftUI-Tinder-Clone** | ~1 | Clone Tinder dédié · iOS 17 · 2024 | **Principal** pour showroom |

→ **Recommandation :** **enesozmus** pour l’intégration ; FranckNdame seulement si tu confirmes qu’il contient un module Tinder isolé de qualité.

---

### Spotify (3 choix)

| Repo | Stars | API / deps | Qualité showroom | Verdict |
|------|------:|------------|------------------|---------|
| **denoni/SpotifyClone** | ~291 | API Spotify officielle · Alamofire | ★★★★★ UI la plus aboutie | **#1 si API OK** en demo |
| **adriancysvillegast/Spotify-SwiftUI** | ~1 | Aucune dep · AVFoundation · MAJ 2026 | ★★★★ propre, léger | **#1 si zéro API** (LPSP) |
| SwiftlyCoded/Spotify-Clone-SwiftUI | ~3 | ? | ★★★ | Backup |
| ~~7adans/SpotifySwiftUI~~ | — | iOS 18 APIs | ★★ écarté | Déjà testé — insuffisant |

→ **Recommandation Lost Phone :** **adriancysvillegast** (données mock LPSP, pas de clé API) ou **denoni** si tu veux le polish max + assets demo custom.

---

### Banque LPSP (2 choix)

| Repo | Focus | Verdict |
|------|-------|---------|
| **Pankajrana01/SuperWallet-SwiftUI** | Wallet fintech complet (send, receive, history) | **Principal** — meilleur template banque générique |
| govardhansbhati/pocketpulse | Finance tracker | Backup — moins « banque », plus budget |

→ **Recommandation :** **SuperWallet** pour LPSP ; pocketpulse si tu veux une 2e app finance « budget ».

---

### Crypto (2 sources)

| Source | Type | Verdict |
|--------|------|---------|
| RedDragonJ/SwiftUIAndCoinbase | Tutoriel GitHub | ⚠️ Pas un wallet complet — écran demo seulement |
| **Patreon Phantom** | Zip Sopheamen | **Meilleur** pour showroom crypto |

→ **Recommandation :** Phantom (Patreon/zip) ; ignorer RedDragonJ sauf pour un écran unique.

---

### Amazon (2 choix)

| Repo | Année | Contenu | Verdict |
|------|-------|---------|---------|
| Djallil14/Amazing.ca-Amazon-SwiftUI-Clone | 2021 | UI Amazon.ca | Vieux mais structure OK |
| **404ibra/AmazonClone** | 2023 | Homepage | **Principal** — plus récent |

→ **Recommandation :** **404ibra** ; Djallil14 en backup.

---

### Uber (2 choix)

| Repo | Stars | Verdict |
|------|------:|---------|
| **Huss3n/UberSwiftUI** | ~6 | **Principal** — Firebase, course demo |
| WorkWithAfridi/SwiftUI-iUber_A-Uber-Clone | ~4 | Backup — MapKit |

→ **Recommandation :** tester **Huss3n** en CI d’abord.

---

## Alertes sur ta liste

| App | Problème | Action suggérée |
|-----|----------|-----------------|
| **Telegram** | Swiftgram = fork app officielle (UIKit, énorme) | Remplacer par BetterTG ou dopebase messenger |
| **Signal** | App officielle ~12k★ UIKit | Shell messagerie ou ignorer |
| **Messenger** | Flutter Sopheamen | SwiftUI : 23122K/Messenger-Clone ou omarthamri |
| **FranckNdame Tinder** | Pas un clone Tinder | Privilégier enesozmus |
| **piwien/Airbnb** | 0★, minimal | Tester ; alt Keerthi-Sparkout si faible |
| **7 apps vides** | Teams, Dating 2, Uber Eats, Hôtel, Trains, Fichiers | À combler ou ignorer v1 |

---

## Zips locaux (à recevoir)

| Fichier mentionné | App | Emplacement attendu |
|-------------------|-----|---------------------|
| `grok_clone_v1.zip` | Grok | `LostPhone/vendor-incoming/grok_clone_v1.zip` |
| *(19 autres zips à lister)* | ? | `LostPhone/vendor-incoming/` |

Voir `LostPhone/vendor-incoming/README.md` pour envoyer les 21 zip.

---

## Récap situation projet

### Déjà intégré (vendored live, branche actuelle)

TikTok, Instagram, LinkedIn, Teams, Spotify, Netflix, Disney+, ChatGPT, PayPal, Uber, Airbnb — **qualité Appetize mitigée** ; Spotify/Netflix etc. ont nécessité plusieurs fix CI.

### Ta nouvelle direction

1. **Liste validée** — ~30 apps avec sources nommées + zips Patreon/Sopheamen/Grok  
2. **21 zip à fournir** — probablement Patreon + Grok + autres clones hors GitHub  
3. **8 trous** — Teams, Messenger (?), Dating 2, Uber Eats, Hôtel, Trains, Fichiers, Revolut  
4. **4 sources risquées** — Telegram, Signal, Messenger Flutter, FranckNdame Tinder  

### Prochaine étape agent (quand zips reçus)

1. Inventorier les 21 zip dans `vendor-incoming/`  
2. Vendorer par lot prioritaire : WhatsApp → Instagram → denoni/adrian Spotify → Notflix → SmartTube  
3. Intégrer zips Sopheamen (Snapchat, LinkedIn, Uber Eats, Phantom) + `grok_clone_v1.zip`  
4. Hybride Twitter  
5. CI Appetize après chaque lot  

---

*Lost Phone · joachimfrzz/lost-phone*
