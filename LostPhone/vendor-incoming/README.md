# Vendor incoming — zips clones

Dépose ici les archives `.zip` avant vendoring (Patreon Sopheamen, Grok, etc.).

## Fichiers attendus (liste Joachim)

| Fichier | App | Statut |
|---------|-----|--------|
| `grok_clone_v1.zip` | Grok | mentionné |
| *(20 autres — à nommer par Joachim)* | | en attente |

## Comment envoyer les 21 zip à l’agent

### Option A — Cursor (recommandé si < ~50 Mo par fichier)

1. Glisse-dépose chaque `.zip` **dans le chat** Cursor (pièce jointe)
2. Ou copie les fichiers dans ce dossier sur ta machine :  
   `LostPhone/vendor-incoming/`
3. Commit + push sur `cursor/vendored-clones-a052` si tu utilises le cloud agent

### Option B — Plusieurs fichiers / gros volume

1. **Google Drive** ou **Dropbox** — dossier partagé avec lien public
2. Envoie le **lien du dossier** dans le chat (pas besoin des 21 en une fois)
3. L’agent télécharge et extrait dans `vendor-incoming/`

### Option C — GitHub (petits zip < 25 Mo chacun)

```bash
cp *.zip LostPhone/vendor-incoming/
git add LostPhone/vendor-incoming/
git commit -m "vendor: ajout zips clones Patreon/Sopheamen"
git push
```

Pour zip > 100 Mo : utiliser **Git LFS** ou Drive (éviter de gonfler le repo).

### Option D — Par lots

Tu n’es pas obligé d’envoyer les 21 d’un coup. Envoie par priorité :

1. Lot Patreon (Snapchat, LinkedIn, Uber Eats, Phantom…)
2. Lot Grok + IA
3. Le reste

## Après réception

L’agent pour chaque zip :

1. Vérifie structure Xcode / SwiftUI  
2. Copie vers `Apps/Vendored/<App>/`  
3. Rédige `SOURCE.md`  
4. Branche dans `VendoredShowroomCatalog`  
5. Lance CI Appetize  

## Git

Les `.zip` sont ignorés par git par défaut (voir `.gitignore` à la racine `vendor-incoming/`).
