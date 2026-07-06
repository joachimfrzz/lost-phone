## Branche artisanale (61 apps Awesome — refonte showroom)

- Tag **`appetize-preview`** : build depuis `cursor/awesome-artisanal-a052` (validation sans merge dans `main`)
- Tag **`appetize-latest`** : build stable depuis `main`

Le CI se déclenche sur push vers `cursor/awesome-artisanal-a052` (ou `cursor/**`) et publie le zip sur la Release **`appetize-preview`**.

### Déclencher manuellement

GitHub → **Actions** → **iOS Preview (Simulator)** → **Run workflow** → branche `cursor/awesome-artisanal-a052`.

### Refonte showroom (4 sources)

1. `DESIGN-swiftui.md` — composants / tokens (déjà dans `LpspAwesome*View.swift`)
2. **`DESIGN.md` §9** — Agent Prompt Guide (checklist + prompts composants)
3. Spectr — layout home + pixel ref (`scripts/spectr_previews/`)
4. Lost Phone — `LpspXxxStore` + données scénario

Avant chaque app refaite à la main :

```bash
cd LostPhone/scripts
python3 awesome_design_agent_guide.py Deliveroo          # §9 complète
python3 awesome_design_agent_guide.py deliveroo --checklist   # quality gate
python3 awesome_design_agent_guide.py whatsapp --prompts      # composants critiques
python3 awesome_design_agent_guide.py --list
```

Clone Meliwat si absent : `git clone https://github.com/Meliwat/awesome-ios-design-md.git` à la racine du repo.

## Voir l'app sans Appetize (recommandé)

1. Télécharge **`preview-demo.mov`** — vidéo du simulateur iOS
2. Ou **`01-menu-accueil.png`** — capture écran

## Appetize (PC/Mac)

- **Showroom** : menu → « **Showroom — clones Apple + tier Awesome** » (sans PIN)
- **J-3** : PIN **1503**
- OS : **iOS 17.2**, Device : iPhone 14 Pro
- Zip : Release **`appetize-preview`** (branche artisanale) ou **`appetize-latest`** (`main`)
- Upload **`LostPhone-simulator.app.zip`** sans dézipper
- Ouvre **appetize.io sur PC/Mac** (Chrome), pas sur iPhone — voir `docs/PREVIEW-SANS-MAC.md`

## Texte App Store (brouillon)

**Sous-titre :** Un téléphone trouvé. Une enquête à mener.

**Description (extrait) :** Lost Phone est un jeu d'investigation narratif. Explorez un smartphone entièrement fictif : messages, photos, apps. Recoupez les indices. **100 % fictif** — personnages et situations imaginaires. Non affilié à Apple ni aux applications citées.

**Plan B marques :** si rejet Guideline 5.2, activer `AppBranding.useFictionalDisplayNames = true` dans `AppBranding.swift` et resoumettre (gratuit).
