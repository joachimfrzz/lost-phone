# SwiftUI natif — iPhone oui, Mac non

Tu as un **iPhone** mais pas de **Mac**. Voici la situation sans langue de bois et le plan le plus court.

---

## Ce qu’Apple impose

| Tu as | Tu peux |
|-------|---------|
| iPhone seul | Jouer à des apps, **pas** compiler SwiftUI |
| Mac + Xcode | Compiler SwiftUI, installer sur ton iPhone |
| **Mac dans le cloud** + iPhone | **Même résultat** qu’avec un Mac chez toi |

**SwiftUI = code compilé par Xcode sur macOS.** Il n’existe aucun contournement : pas d’app Store, pas d’outil tiers, pas de « mode iPhone » pour builder du natif.

Ton iPhone sert à **tester** l’app une fois compilée. Pas à la **fabriquer**.

---

## Deux chemins (du plus rapide au « PAREIL »)

### Chemin A — Capacitor (déjà prêt, ~1 jour)

Le projet `game/` est déjà configuré. Ce n’est **pas** SwiftUI, mais sur ton iPhone :

- Vrai plein écran, SF Pro système, haptiques, safe areas
- UI = le jeu React actuel dans une WebView native

**Build sans Mac** via **Codemagic** (Mac cloud gratuit limité) :

1. Crée un compte [codemagic.io](https://codemagic.io)
2. Pousse le dossier `game/` sur GitHub (repo privé OK)
3. Connecte le repo à Codemagic
4. Le fichier `codemagic.yaml` (à la racine de `game/`) lance le build iOS
5. Branche ton iPhone, configure ton **Apple ID** dans Codemagic
6. Télécharge l’`.ipa` ou installe via lien Codemagic

→ Tu as une **vraie app sur ton iPhone** sans acheter un Mac.

---

### Chemin B — SwiftUI natif (vrai iOS, ~plusieurs mois)

C’est ce que tu veux pour du **PAREIL**. Il faut :

1. **Louer un Mac cloud** (MacinCloud ~1 $/h, ou Codemagic avec session Xcode)
2. **Compte Apple Developer** — gratuit pour tester sur **ton** iPhone (certificat 7 jours, renouvelable) ; **99 $/an** pour TestFlight / distribution simple
3. **Nouveau projet Xcode** SwiftUI — réécriture du shell iPhone (verrou, accueil, apps)
4. **Garder le LPSP** — le JSON `lpsp.json` reste la source de vérité narrative ; SwiftUI le charge comme le fait React aujourd’hui

```
Lost Phone SwiftUI (à créer)
├── LostPhoneApp.swift          # Point d'entrée
├── Core/
│   ├── LpspLoader.swift        # Parse lpsp.json
│   └── ScenarioEngine.swift    # Notifications, timing
├── System/                     # Vrai UIKit/SwiftUI système
│   ├── LockScreenView.swift
│   ├── HomeScreenView.swift
│   ├── PinCodeView.swift
│   └── ControlCenterView.swift
└── Apps/                       # Une vue SwiftUI par app
    ├── MessagesView.swift
    ├── PhotosView.swift
    └── …
```

**Estimation honnête** : le shell système seul = 2–4 semaines à temps plein ; 18 apps = plusieurs mois. Le jeu React actuel représente déjà des mois de UI — SwiftUI, c’est refaire tout ça en natif.

---

## Plan recommandé pour toi

```
Étape 1 (cette semaine)     Codemagic + Capacitor → app sur TON iPhone
                            Valider gameplay J-3, PIN 1503, immersion device

Étape 2 (si OK gameplay)    Mac cloud 2–3 h → ouvrir Xcode, créer projet SwiftUI
                            Commencer par LockScreen + PinCode en SwiftUI pur

Étape 3 (itérations)        Une app native à la fois (Messages en premier)
                            LPSP inchangé côté backend/creator
```

Ne saute pas l’étape 1 : elle te prouve que le **contenu** fonctionne sur iPhone avant d’investir des mois en SwiftUI.

---

## Mac cloud — options

| Service | Prix | Usage |
|---------|------|--------|
| [Codemagic](https://codemagic.io) | Gratuit (500 min/mois) | Build automatique depuis GitHub |
| [MacinCloud](https://www.macincloud.com) | ~1 $/heure | Xcode à la main, dev SwiftUI |
| [GitHub Actions](https://github.com) | macOS runner facturé | CI si repo GitHub |

Pour **développer** SwiftUI au jour le jour → MacinCloud (session Xcode interactive).  
Pour **compiler et envoyer sur iPhone** → Codemagic suffit.

---

## Compte Apple (ton iPhone)

1. **Apple ID gratuit** — suffit pour installer sur **ton** iPhone via Xcode/Codemagic (profil de développement, renouvelé régulièrement)
2. **Apple Developer Program (99 $/an)** — TestFlight, certificats longue durée, partage à des testeurs

Commence avec le gratuit + ton iPhone branché (ou wireless debug).

---

## Ce que je peux faire ensuite dans ce repo

- [x] `codemagic.yaml` — build Capacitor sans Mac
- [ ] Squelette projet SwiftUI (`ios-swiftui/`) — prêt à ouvrir dès que tu as une session Mac cloud
- [ ] Spec de migration LPSP → SwiftUI (modèles `Codable`)

Dis-moi si tu veux qu’on enchaîne sur le **squelette SwiftUI** ou d’abord **Codemagic + GitHub** pour avoir l’app sur ton iPhone cette semaine.
