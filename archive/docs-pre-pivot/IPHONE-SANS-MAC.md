# Jouer sur iPhone sans Mac

Apple exige **Xcode sur macOS** pour compiler une app Capacitor (.ipa). Sans Mac, voici les options réalistes.

---

## Option 1 — PWA (recommandée, gratuite)

Le jeu s’installe sur l’écran d’accueil comme une app, en **plein écran**, sans coque simulée.

### A. Même Wi‑Fi (test rapide)

1. Sur le PC Windows :
   ```powershell
   cd game
   npm run dev
   ```
2. Note l’adresse réseau affichée (ex. `http://192.168.1.42:5174`).
3. Sur l’iPhone (Safari) : ouvre `http://TON_IP:5174/phone/j3-louvre`
4. **Partager** (icône carré + flèche) → **Sur l’écran d’accueil**
5. Lance l’icône **Lost Phone** — immersion directe, PIN **1503**

> PC et iPhone doivent être sur le **même réseau Wi‑Fi**.

### B. Hébergement en ligne (utilisable partout)

1. Build :
   ```powershell
   cd game
   npm run build
   ```
2. Déploie le dossier `dist/` sur un hébergeur gratuit :
   - [Netlify Drop](https://app.netlify.com/drop) — glisser-déposer `dist/`
   - [Cloudflare Pages](https://pages.cloudflare.com/)
   - GitHub Pages
3. Ouvre l’URL sur l’iPhone → **Sur l’écran d’accueil**

### Ce que tu obtiens

| | Safari normal | Écran d’accueil (PWA) |
|---|---|---|
| Plein écran | Non | **Oui** |
| Coque simulée | Oui | **Non** |
| Safe areas iPhone | Partiel | **Oui** |
| Haptiques PIN | Vibration légère | Vibration légère |
| App Store | Non | Non |

C’est **95 % de l’expérience native** pour ce projet.

---

## Option 2 — Build iOS dans le cloud (vraie app .ipa)

Si tu veux absolument une app Capacitor / TestFlight :

| Service | Prix indicatif | Notes |
|---------|----------------|-------|
| [Codemagic](https://codemagic.io) | Gratuit limité | CI Mac, signing iOS |
| [Ionic Appflow](https://ionic.io/appflow) | Payant | Spécialisé Capacitor |
| [MacinCloud](https://www.macincloud.com) | ~1 $/h | Mac distant + Xcode |
| GitHub Actions | Minutes Mac incluses | Nécessite certificats Apple |

Il te faudra quand même un **compte Apple Developer** (99 $/an pour l’App Store, gratuit pour test sur ton iPhone via Xcode).

Le projet iOS est déjà prêt dans `game/ios/` — un Mac (local ou cloud) l’ouvrira dans Xcode.

---

## Option 3 — Android (sans Mac, sur Windows)

Si tu as un téléphone **Android** :

```powershell
cd game
npm run build
npx cap add android    # une fois
npx cap sync android
npx cap open android   # Android Studio sur Windows
```

Android Studio compile et installe directement depuis Windows.

---

## Résumé

| Objectif | Solution |
|----------|----------|
| Jouer sur iPhone **maintenant**, gratuit | **PWA** — Option 1 |
| App Store / TestFlight | Mac cloud + compte Apple — Option 2 |
| Téléphone Android | Capacitor Android — Option 3 |

Pour le développement quotidien sur Windows + test iPhone : **Option 1A** (Wi‑Fi + Safari + écran d’accueil) est la plus simple.
