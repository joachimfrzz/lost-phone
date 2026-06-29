# Lost Phone — build iOS natif (Capacitor)

L'app tourne dans **WKWebView sur un vrai iPhone** : SF Pro système, safe areas, blur natif, haptiques, pas de coque simulée.

## Prérequis

- **macOS** avec **Xcode 15+** (obligatoire pour compiler iOS)
- Compte Apple Developer (gratuit pour test sur ton iPhone)
- Node.js 18+

> Sur Windows, tu peux préparer le projet (`npm run cap:sync:ios`) mais l'ouverture Xcode et l'installation sur iPhone se font **sur Mac**.

## Installation (première fois)

```bash
cd game
npm install
npm run build
npx cap add ios    # une seule fois
npm run cap:sync:ios
npm run cap:open:ios
```

Dans **Xcode** :

1. Sélectionne le target **App**
2. Onglet **Signing & Capabilities** → Team = ton compte Apple
3. Bundle ID : `com.lostphone.game` (ou le tien)
4. Branche ton iPhone ou choisis un simulateur **iPhone 15 Pro**
5. **Run** (▶)

## Développement itératif

```bash
# 1. Modifier le code React
# 2. Rebuild + sync
npm run cap:sync:ios

# 3. Relancer depuis Xcode (ou)
npm run cap:run:ios
```

## Live reload (optionnel)

Dans `capacitor.config.ts`, décommente et adapte :

```ts
server: {
  url: "http://TON_IP_LOCAL:5174",
  cleartext: true,
},
```

Puis `npm run dev` sur le Mac et relance l'app — le WebView charge le dev server.

## Comportement natif iOS

| Web (navigateur) | Natif (Capacitor) |
|------------------|-------------------|
| Coque iPhone simulée | **Plein écran** — le vrai device |
| Dynamic Island fake | **Island système** réelle |
| SF Pro CDN | **-apple-system** natif |
| Pas de haptiques | Vibrations PIN / apps |
| Status bar simulée | Overlay + safe-area-inset |

## Fichiers clés

- `capacitor.config.ts` — config app iOS
- `src/lib/native.ts` — init StatusBar, Haptics, Keyboard
- `src/ios/native.css` — layout safe-area, sans coque
- `ios/` — projet Xcode (généré par Capacitor)

## Test histoire J-3

1. Lancer l'app → Hub **Lost Phone**
2. Ouvrir **J-3 — Le téléphone de Mathieu**
3. PIN : **1503**

## Dépannage

**Écran blanc** : vérifier `npm run build` puis `npx cap sync ios`.

**Signing error** : choisir une Team dans Xcode Signing.

**Assets non trouvés** : `base: "./"` dans `vite.config.ts` (déjà configuré).
