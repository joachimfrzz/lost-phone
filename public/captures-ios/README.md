# Captures iPhone — référence UX/UI

Les PNG **ne sont pas affichés dans le jeu**. Ils servent à calibrer l’UI React sur `/ui-reference`.

---

## Envoi depuis iPhone (recommandé)

1. Sur le PC : `npm run dev`
2. Trouve l’IP du PC : `ipconfig` → ex. `192.168.1.42`
3. **Sur ton iPhone** (même Wi-Fi) : ouvre Safari  
   **`http://192.168.1.42:5174/captures-upload`**
4. Étape 1 → tape **+** → choisis la capture d’écran dans Photos
5. Pas besoin de RDP, inbox, ni renommage

> iPad en RDP : tu peux aussi ouvrir cette URL dans Safari iPad si le réseau le permet.

---

## Page d’envoi

| URL | Rôle |
|-----|------|
| `/captures-upload` | Envoi mobile, étape par étape |
| `/ui-reference` | Comparaison React vs capture |
| `npm run captures:status` | Statut en terminal |

---

## Organisation

```
public/captures-ios/
  system/     verrou, PIN, accueil…
  apps/       une capture par écran de référence
```

Chaque slot = `…/screen.png` (automatique via la page d’envoi).

---

## Ancien workflow (optionnel)

`inbox/` + `npm run captures:sort` — plus nécessaire si tu utilises `/captures-upload`.
