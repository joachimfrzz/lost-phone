# Cursor sur iPhone — Lost Phone

Guide pour utiliser **l’app Cursor iOS** (beta) sur ton iPhone avec ce projet.  
Doc officielle : [cursor.com/docs/cloud-agent/mobile](https://cursor.com/docs/cloud-agent/mobile)

---

## C’est quoi l’app Cursor iPhone ?

Ce **n’est pas** Xcode ni un éditeur Swift complet sur le téléphone.

C’est une app pour **lancer et piloter des agents IA** :

| Mode | Usage |
|---|---|
| **Cloud Agent** | Agent dans une VM Cursor → édite ton repo GitHub, commit, PR |
| **Remote Control** | Ton PC Windows reste allumé → tu diriges l’agent Cursor du bureau **depuis l’iPhone** |

Tu vois les diffs, tu envoies des instructions (texte ou voix), tu merges des PR.  
Tu **ne compiles pas** SwiftUI directement dans l’app Cursor.

---

## Prérequis

- iPhone **iOS 26+**
- Plan **Pro / Pro+ / Ultra / Teams / Enterprise** (cloud agents inclus)
- Repo **GitHub** avec le projet (`game/` ou racine)
- App Store : [Cursor](https://apps.apple.com/app/cursor/id6767085653)

---

## Setup recommandé pour Lost Phone

### 1. Pousser le projet sur GitHub

L’app mobile travaille sur un **repo Git**, pas sur des fichiers locaux Windows seuls.

```
LOST PHONE/
└── game/          ← contient LostPhone/ (SwiftUI) + public/stories/ (LPSP)
```

### 2. Ouvrir l’app Cursor sur iPhone

1. Se connecter (même compte que Cursor desktop)
2. Choisir le repo + branche
3. Lancer un agent avec une consigne claire, par ex. :

> « Modifie `public/stories/j3-louvre/lpsp.json` : change le message Hugo sur le verrou. Sync vers LostPhone avec le script lpsp:sync. Ne touche pas à React. »

### 3. Deux façons de travailler

**A — Cloud Agent (PC éteint OK)**  
L’agent tourne dans le cloud, édite le repo, pousse un commit.  
Idéal pour modifier **contenu LPSP** (messages, notifs, PIN) depuis le canapé.

**B — Remote Control (PC allumé)**  
Sur Cursor desktop (Windows) : `/remote-control` dans le chat agent.  
Puis continue sur l’iPhone — les commandes s’exécutent sur **ton PC**.

Réglages PC : Cursor ≥ 3.9.8, Settings → Agents → Remote Control ON, « Keep computer awake » si branché.

---

## Tester le jeu sur le même iPhone

L’app **Cursor** et l’app **Lost Phone** sont deux apps différentes :

| App | Rôle |
|---|---|
| **Cursor iOS** | Coder / diriger l’agent |
| **Lost Phone** (SwiftUI) | Jouer l’histoire |

Pour installer Lost Phone après les modifs de l’agent :

1. Agent push sur GitHub  
2. **Codemagic** build le `.ipa` (workflow `lost-phone-swiftui`)  
3. Tu installes Lost Phone sur ton iPhone  

Preview **contenu** plus rapide (sans rebuild) : Safari → `http://<IP-PC>:5174/simulator` (voir ci‑dessous).

---

## Contenu modifiable (LPSP)

Fichier principal :

```
game/public/stories/j3-louvre/lpsp.json
```

Exemples de prompts depuis l’iPhone :

- « Ajoute une notif WhatsApp de Vincent à 14:30 dans notifications_initiales »
- « Change le PIN en 1503 et mets à jour 3 messages dans Messages.threads »
- « Branche WhatsApp sur LPSP comme Messages en SwiftUI »

Détails JSON : [`LostPhone/SWIFTUI-LPSP.md`](LostPhone/SWIFTUI-LPSP.md)

---

## Preview web depuis iPhone (optionnel)

Sur le **PC** (ou via Remote Control) :

```powershell
cd game
npm run dev
npm run dev:phone
```

Ouvre l’URL affichée dans **Safari** sur iPhone — utile pour valider le contenu avant rebuild SwiftUI.

---

## Résumé

```
iPhone (app Cursor)  →  agent édite lpsp.json / SwiftUI sur GitHub
                    →  Codemagic build  →  app Lost Phone sur iPhone
                    →  Safari :5174/simulator pour preview contenu rapide
```

**Tu peux tout piloter depuis ton iPhone avec Cursor** — le build natif reste dans le cloud (Codemagic), pas dans l’app Cursor.

---

## Ancienne section — Cursor desktop + iPhone sans Mac

Tu codes dans **Cursor sur PC**, tu testes sur **ton iPhone**. Pas besoin de Xcode chez toi.

---

## Deux boucles de travail

### Boucle A — Contenu (messages, notifs, PIN…) — la plus rapide

**Fichier à éditer dans Cursor :**

```
game/public/stories/j3-louvre/lpsp.json
```

**Sync vers l’app SwiftUI :**

```powershell
cd game
npm run lpsp:sync
```

**Prévisualisation immédiate sur iPhone (Safari, même Wi‑Fi ou IP publique) :**

```powershell
cd game
npm run dev
```

Sur l’iPhone, ouvre dans Safari :

- `http://<IP-de-ton-PC>:5174/simulator` — simulateur vide (PIN `0000` en mode demo)
- ou l’IP publique si tu l’as déjà configurée

> La preview web reste utile pour **valider le contenu LPSP** en quelques secondes.  
> Le rendu visuel final = app SwiftUI (boucle B).

---

### Boucle B — App native SwiftUI sur iPhone (zerocode117)

**Code Swift :** `game/LostPhone/`

**Une fois configuré (GitHub + Codemagic) :**

```
1. Tu modifies dans Cursor (Swift ou lpsp.json)
2. npm run lpsp:sync   (si JSON modifié)
3. git push
4. Codemagic compile sur Mac cloud (~10–15 min)
5. Tu installes le .ipa sur ton iPhone (lien email Codemagic)
```

Workflow Codemagic : **`lost-phone-swiftui`** (voir `game/codemagic.yaml`).

---

## Setup Codemagic (une fois)

1. Crée un repo **GitHub** avec le dossier `game/` (ou tout le projet).
2. Compte gratuit : [codemagic.io](https://codemagic.io) → connecte le repo.
3. **Team settings → Code signing** : ajoute ton Apple ID (gratuit suffit pour **ton** iPhone).
4. Codemagic détecte `game/codemagic.yaml`.
5. Lance le workflow **`Lost Phone SwiftUI`** manuellement la première fois.

Tu recevras un mail avec le lien pour installer l’app.

---

## Compte Apple

| Option | Prix | Usage |
|---|---|---|
| Apple ID gratuit | 0 € | Installer sur **ton** iPhone via Codemagic |
| Apple Developer | 99 €/an | TestFlight, certificats longue durée |

Commence gratuit.

---

## Fichiers importants dans Cursor

| Fichier | Rôle |
|---|---|
| `public/stories/j3-louvre/lpsp.json` | **Tout le contenu modifiable** |
| `LostPhone/LostPhone/System/` | Verrou, PIN, accueil |
| `LostPhone/LostPhone/Apps/` | Apps (Messages LPSP, clone zerocode117) |
| `LostPhone/SWIFTUI-LPSP.md` | Exemples JSON (messages, notifs…) |

**PIN histoire J-3 :** `1503`

---

## Commandes utiles (PowerShell)

```powershell
cd "C:\Users\Administrateur\Downloads\LOST PHONE\game"

# Sync contenu → bundle SwiftUI
npm run lpsp:sync

# Preview web sur iPhone (contenu)
npm run dev

# Trouver ton IP locale
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -notmatch 'Loopback' }).IPAddress
```

---

## Résumé

| Tu veux… | Fais… |
|---|---|
| Changer textes / messages / notifs | Édite `lpsp.json` → `npm run lpsp:sync` → push → rebuild Codemagic |
| Tester contenu tout de suite | `npm run dev` → Safari iPhone `:5174/simulator` |
| Voir le vrai rendu iOS natif | Push → Codemagic SwiftUI → install sur iPhone |
| Coder l’UI Swift | Cursor → `LostPhone/` → push → Codemagic |

**Cursor reste ton IDE.** Le Mac n’existe que dans le cloud au moment du build.
