# Lost Phone — guide iPhone (Remote Control)

## ✅ Déjà fait sur le PC

- Git initialisé dans `game/`
- Contenu LPSP sync vers `LostPhone/Resources/stories/`
- Projet SwiftUI zerocode117 + LPSP prêt
- Guides : `CURSOR-IPHONE.md`, `LostPhone/SWIFTUI-LPSP.md`

## 📱 Toi sur iPhone (2 min, une fois)

1. App Store → installe **Cursor** (Anysphere)
2. Connecte-toi avec **le même compte** que ce PC

## 💻 Toi sur PC (30 sec, à chaque session)

1. Cursor ouvert sur ce dossier `game`
2. Dans ce chat Agent, tape : **`/remote-control`**
3. Laisse le PC **allumé** (branché de préférence)

## 📱 Ensuite sur iPhone

1. App Cursor → **Inbox** → cette session
2. Écris en français ce que tu veux, ex. :
   - *Modifie le message Hugo dans lpsp.json*
   - *Ajoute une notif WhatsApp*

## 🎮 Voir le jeu sur iPhone

Sur le PC (ou demande-le à l’agent) :

```powershell
npm run dev
npm run dev:phone
```

→ Ouvre l’URL dans **Safari** sur ton iPhone.

**PIN J-3 :** `1503` (dans l’app native) / `0000` (simulateur web vide)

## ⚙️ Remote Control dans Cursor

**Prérequis : Cursor 3.9.8+** (tu es peut‑être en 3.6 → mets à jour d’abord)

1. Menu **Help** → **Check for Updates** (ou télécharge sur [cursor.com](https://cursor.com))
2. Redémarre Cursor
3. **Cursor Settings** (icône engrenage en haut à droite, pas « VS Code Settings »)
4. **Agents** → **Remote Control** → ON
5. **Keep this computer awake** → ON

### Tu ne vois pas Remote Control ?

| Cause | Solution |
|---|---|
| Version &lt; 3.9.8 | Mettre à jour Cursor |
| Plan gratuit | Remote Control = Pro / Pro+ / Ultra |
| Mauvais menu | C’est **Cursor Settings → Agents**, pas File → Preferences |

### Sans Remote Control : Cloud Agent (iPhone seul)

1. Pousse le projet sur **GitHub**
2. App Cursor iPhone → **New agent** → **Cloud**
3. Choisis le repo → écris ta consigne (PC peut être éteint)
