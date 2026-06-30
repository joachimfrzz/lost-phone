# Aperçus SwiftUI sans Mac ni Apple Developer

Option A (clone zerocode117 en SwiftUI) + previews gratuits ou quasi gratuits.

## 1. GitHub Actions — build iOS simulateur (0 €)

**Pas de Mac. Pas de compte Apple Developer.**

Le workflow tourne automatiquement à chaque push sur `main` (dossier `LostPhone/`).

### Tester sur Appetize (méthode simple)

1. Va sur **https://github.com/joachimfrzz/lost-phone/releases/tag/appetize-latest**
2. Télécharge **`LostPhone-simulator.app.zip`** (lien direct, pas un artifact Actions)
3. Upload **ce fichier** sur **https://appetize.io** — **sans le dézipper**
4. Ouvre le lien Appetize → **J-3** → PIN **1503**

### Si Appetize dit « No .app folder found »

Tu as uploadé le **mauvais** fichier. Causes fréquentes :

| Fichier uploadé | Résultat |
|-----------------|----------|
| `appetize-upload-9.zip` (artifact GitHub) | ❌ Il faut d'abord le **dézipper** pour obtenir `LostPhone-simulator.app.zip` |
| `ios-swiftui-preview-9.zip` | ❌ Contient PNG + vidéo, pas le bon zip |
| Dossier `LostPhone.app` re-zippé incorrectement | ❌ Le `.app` doit être **à la racine** du zip |

**Solution :** utilise le lien **Releases → appetize-latest** (téléchargement direct du bon zip).

---

## 2. Artifacts Actions (bonus)

Sur un run vert dans **Actions → iOS Preview (Simulator)** :

- **`appetize-upload-XXX`** — zip Appetize + `APPETIZE-LISEZMOI.txt`
- **`ios-swiftui-preview-XXX`** — zip + captures PNG/MOV

---

## 3. Mac cloud 1 h (~5–20 €, ponctuel)

Build Xcode + install sur ton iPhone (Apple ID gratuit, ~7 jours).

---

## 4. Apple Developer + TestFlight — plus tard

99 €/an quand tu voudras distribuer proprement.

---

## Résumé

| Besoin | Solution |
|--------|----------|
| Tester dans le navigateur | **Releases → appetize-latest** → Appetize |
| Voir captures CI | Actions → artifact `ios-swiftui-preview-XXX` |
| App sur vrai iPhone | Mac cloud 1 h |
