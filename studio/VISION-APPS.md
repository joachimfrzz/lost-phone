# Stratégie apps — Lost Phone Studio (juillet 2026)

> **Pivot méthodologique** : la philosophie du jeu ne change pas.  
> Ce qui change : **comment** on construit les apps et **où** on centralise le travail.

---

## Deux familles d'apps

### 1. Clones officiels Apple (gelés)

Apps système iOS — source **zerocode117** (`Apps/Clone/`).  
On ne réécrit pas l'UI. On branche le narratif LPSP.

| App | Statut |
|-----|--------|
| Téléphone | Clone officiel |
| Messages | Clone officiel |
| Contacts | Clone officiel (page 2) |
| Safari | Clone officiel |
| Météo | Clone officiel |
| Calendrier | Clone officiel |
| Photos | Clone officiel |
| Notes | Clone officiel |
| Calculatrice | Clone officiel |
| Réglages | Clone officiel |
| Mail | Clone officiel |
| Horloge | Clone officiel |
| Appareil photo | Clone officiel |
| App Store | Clone officiel |
| Musique (dock) | Clone officiel |
| Rappels, Dictaphone, Wallet | Clones officiels (page 2) |

**Règle :** pas de refonte UI. Corrections bugs + injection LPSP uniquement.

### 2. Apps tierces — créées par nous

WhatsApp, Messenger, Instagram, Netflix, Uber, etc.

**On n'utilise plus** les clones GitHub/Patreon vendored comme base runtime (Sopheamen → archivé).

**On construit** des apps maison avec :

1. **Awesome Design** — specs `DESIGN.md` / `DESIGN-swiftui.md` (Meliwat)
2. **Prompts Awesome Design** — section §9 Agent Prompt Guide
3. **Brief app** — fiche que tu envoies (voir [`docs/templates/APP-BRIEF.md`](docs/templates/APP-BRIEF.md))
4. **Logique UI + narrative** — cohérente pour le jeu (pas une copie fidèle d'un clone tiers)

Chaque app tierce doit avoir :

- Identité visuelle cohérente (tokens Awesome)
- Comportement pensé pour l'investigation (indices, blocages, fausses pistes)
- Données LPSP (contacts, messages, fils, médias)
- Navigation documentée écran par écran

---

## Ce qu'on abandonne (transition)

| Ancienne approche | Nouvelle approche |
|-------------------|-------------------|
| `Apps/Vendored/` (Sopheamen/GitHub) | Apps custom `Apps/Custom/` ou `Apps/Story/` |
| Génération bulk `LpspAwesome*View` | Implémentation guidée par brief + prompts |
| Matrice vendoring 61 apps | Backlog Notion → brief → implémentation |
| Corrections clone par clone sur code tiers | Design system unifié + narrative |

**Note :** `Vendored/` et `Awesome/Generated/` restent en place **temporairement** comme showroom de transition. Ils seront retirés app par app au fur et à mesure des remplacements custom.

---

## Pipeline de création d'une app tierce

```
Notion (brief app)
    ↓
studio/docs/templates/APP-BRIEF.md rempli
    ↓
Awesome Design spec + prompts §9
    ↓
Implémentation SwiftUI (Apps/Custom/<App>/)
    ↓
Branchement LPSP (adapters, données histoire)
    ↓
QA MobAI (tests .mob sur iPhone/simulateur)
    ↓
Notion → statut Validé
```

---

## Hub de travail

| Outil | Rôle |
|-------|------|
| **Notion** | Source de vérité produit (apps, bugs, briefs, statuts) |
| **iPhone / iPad** | Test terrain à tout moment |
| **Cursor + MobAI** | Dev assisté + QA sur device réel |
| **GitHub Actions** | Build compile (pas de device) |
| **Codemagic** | IPA TestFlight |

Objectif studio : **réduire les allers-retours** entre Notion, code, et test device.
