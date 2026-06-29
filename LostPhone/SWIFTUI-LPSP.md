# Modifier le contenu du jeu (LPSP)

Le jeu SwiftUI lit **uniquement** le JSON LPSP. Le Creator (ou un éditeur de texte) produit ce fichier ; l'app l'affiche.

## Fichier principal

```
game/public/stories/j3-louvre/lpsp.json
```

Copie bundlée dans l'app :

```
game/LostPhone/LostPhone/Resources/stories/j3-louvre/lpsp.json
```

**Workflow :** édite `public/stories/.../lpsp.json`, puis resynchronise :

```powershell
Copy-Item "game/public/stories" "game/LostPhone/LostPhone/Resources/stories" -Recurse -Force
```

(En CI, les deux chemins sont bundlés.)

---

## Exemples concrets

### Changer l'heure du verrou

```json
"envelope": {
  "heure_verrou": "14:30",
  "date_verrou": "Dimanche 15 juin"
}
```

### Ajouter une notification sur le verrou

```json
"notifications_initiales": [
  {
    "app": "Messages",
    "titre": "Hugo 💙",
    "texte": "papa t'es où ?",
    "heure": "14:12",
    "lu": false
  }
]
```

### Changer le code PIN

```json
"player_config": {
  "verrouillage": {
    "type": "Code PIN à 4 chiffres",
    "code": "1503"
  }
}
```

### Modifier les messages

```json
"content": {
  "apps": {
    "Messages": {
      "threads": [
        {
          "contact": "Hugo 💙",
          "messages": [
            { "de": "contact", "texte": "Salut papa !", "date": "2025-06-15T14:12:00" },
            { "de": "moi", "texte": "Salut mon grand", "date": "2025-06-15T14:13:00" }
          ]
        }
      ]
    }
  }
}
```

- `"de": "moi"` → bulle bleue (Mathieu)
- `"de": "contact"` ou autre → bulle grise

### Notification dynamique en cours de jeu

```json
"scenario": {
  "evenements": [
    {
      "id": "notif-1",
      "type": "notification",
      "app": "WhatsApp",
      "condition": "delay_2min",
      "contenu": {
        "titre": "Vincent M.",
        "texte": "Réponds stp",
        "heure": "14:35"
      }
    }
  ]
}
```

`immediate` = dès le lancement. `delay_5min` = 5 minutes après le début.

### Liste des apps sur l'accueil

```json
"manifest": {
  "apps_presentes": ["Messages", "Photos", "WhatsApp", "..."]
},
"content": {
  "system": {
    "dock": ["Telephone", "Safari", "Messages", "Spotify"]
  }
}
```

---

## Apps et données

| Clé `content.apps` | Vue SwiftUI |
|---|---|
| `Messages` | Inbox + fil (LPSP) |
| Autres apps clone | UI zerocode117 (demo) — branchement LPSP en cours |
| WhatsApp, Signal, etc. | Vue JSON (lisible) — UI dédiée à venir |

Pour toute app, le payload LPSP doit exister sous `content.apps.NomApp`.

---

## Nouvelle histoire

1. Dupliquer `public/stories/j3-louvre/` → `public/stories/ma-histoire/`
2. Éditer `lpsp.json`
3. Dans `PhoneRootView.swift`, changer `storyId: "ma-histoire"` (ou variable d'environnement plus tard)

---

## Creator

Le Creator Lost Phone exporte déjà du LPSP compatible. Aucun changement de format requis : **même JSON**, runtime SwiftUI à la place de React.
