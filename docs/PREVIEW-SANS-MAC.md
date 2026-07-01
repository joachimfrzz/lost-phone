# Aperçus SwiftUI sans Mac ni Apple Developer

## ✅ Méthode qui marche (0 €)

L’app **fonctionne** — le CI le prouve à chaque push. Pas besoin d’Appetize pour la voir.

1. Va sur **https://github.com/joachimfrzz/lost-phone/releases/tag/preview-latest**
2. Télécharge **`preview-demo.mov`** (vidéo ~15 s du simulateur iOS)
3. Ou **`01-menu-accueil.png`** (capture du menu avec J-3)

C’est tout. Tu vois le rendu réel de l’app.

---

## ⚠️ Appetize — souvent écran noir

On a testé de nombreux builds. L’app s’installe, mais **Appetize affiche du noir** dans ces cas :

| Situation | Résultat |
|-----------|----------|
| Tu ouvres Appetize **sur ton iPhone** (Safari) | ❌ Écran noir fréquent |
| Tu configures sur mobile | ❌ Stream vidéo capricieux |
| iOS 18.2 sur Appetize | ❌ Souvent noir |
| PC/Mac + Chrome + iOS 17.2 | ⚠️ Parfois OK |

**Si tu veux quand même essayer Appetize :**

- Ouvre **appetize.io sur un PC ou Mac** (Chrome), pas sur iPhone
- OS : **iOS 17.2** · Device : iPhone 14 Pro
- Zip : **https://github.com/joachimfrzz/lost-phone/releases/download/appetize-latest/LostPhone-simulator.app.zip**
- PIN dans l’app : **1503**

Les logs `AuthKit` / `PPT` sont du bruit Apple — pas des erreurs Lost Phone.

---

## Mac cloud (~10 € / 1 h)

Pour **toucher** l’app sur ton vrai iPhone : loue un Mac cloud 1 h, build Xcode, install via Apple ID gratuit.

---

## Résumé

| Besoin | Solution |
|--------|----------|
| Voir le rendu | **Releases → preview-latest → .mov** |
| Naviguer dans l’app | Appetize sur **PC** (pas iPhone) ou Mac cloud |
| Prod / TestFlight | Apple Developer (plus tard) |
