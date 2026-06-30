# Aperçus SwiftUI sans Mac ni Apple Developer

Option A (clone zerocode117 en SwiftUI) + previews gratuits ou quasi gratuits.

## 1. GitHub Actions — captures à la demande (0 €)

**Pas de Mac. Pas de compte Apple Developer.** Le build cible le **simulateur iOS** (signature non requise).

### Lancer un aperçu

1. Va sur GitHub → repo `lost-phone` → **Actions**
2. Workflow **「iOS Preview (Simulator)」**
3. **Run workflow** → laisse **Simulateur** vide (auto) → **Run workflow**
4. Attends ~15–30 min (premier run peut télécharger la plateforme iOS)
5. Télécharge l’artifact **`appetize-upload-XXX`** (un seul fichier `.zip` — c’est celui-là pour Appetize)
   - ⚠️ **Ne pas** uploader l’artifact `ios-swiftui-preview-XXX` : il contient aussi PNG/MOV et Appetize affiche « No .app folder found »
6. Va sur [appetize.io](https://appetize.io) → upload ce `.zip` **sans le décompresser**

### Coût

- Repo **public** : minutes macOS GitHub gratuites
- Repo **privé** : ~10–15 min macOS × 10 = crédit GitHub consommé ; largement suffisant pour quelques previews / mois

---

## 2. Appetize.io — preview interactive dans le navigateur (0 € limité)

Tu **pilotes** l’app comme sur un iPhone, dans Safari (PC ou iPhone).

1. Récupère `LostPhone-simulator.app.zip` depuis l’artifact GitHub
2. Compte gratuit [appetize.io](https://appetize.io) (~30 min / mois)
3. Upload le `.zip`
4. Ouvre le lien Appetize → navigue menu, verrou, apps

**Limite :** session limitée en gratuit ; suffisant pour vérifier le rendu quand tu veux.

---

## 3. Mac cloud 1 h — vrai iPhone physique (~5–20 €, ponctuel)

Quand tu veux **l’app sur ton iPhone** (pas simulateur) sans Apple Developer annuel :

- Loue un Mac cloud 1 h
- Build Xcode + Apple ID **gratuit** → install sur ton iPhone (~7 jours)

---

## 4. Apple Developer + Codemagic — plus tard

Quand tu voudras TestFlight, builds stables, testeurs : 99 €/an + Codemagic.

---

## Résumé

| Besoin | Solution | Coût |
|--------|----------|------|
| Voir le rendu SwiftUI quand je veux | GitHub Actions → PNG + vidéo | 0 € |
| Toucher / naviguer dans l’app | Appetize + .zip artifact | 0 € (limité) |
| App sur mon vrai iPhone | Mac cloud 1 h | ~5–20 € |
| Prod / testeurs | Developer + Codemagic | 99 €/an |
