# Périmètre apps — fidélité totale, profondeur limitée

## Principe Lost Phone

> **Chaque écran présent = quasi identique à l’app iOS réelle.**  
> **Chaque écran absent = volontairement hors scope** (pas une version cheap).

Ce n’est **pas** une app simplifiée. C’est la **vraie surface iOS**, tronquée au minimum utile pour le jeu.

```
Fidélité UI/UX  ████████████████████  100 % sur ce qui existe
Profondeur      ██████░░░░░░░░░░░░░░  ~20–30 % des écrans iOS
Contenu         ████████████████████  100 % LPSP dynamique
```

---

## Comment lire ce document

| Colonne | Signification |
|---------|---------------|
| **Écrans IN** | À reproduire pixel par pixel vs capture |
| **Comportements IN** | Gestes, animations, navigation — comme iOS |
| **Hors scope** | N’existe pas dans Lost Phone — pas de stub, pas de menu grisé |
| **Données LPSP** | Ce que l’auteur modifie sans toucher au code |
| **Captures** | Références dans `public/captures-ios/` |

---

## Noyau iOS (obligatoire)

| Écrans IN | Comportements IN | Hors scope |
|-----------|------------------|------------|
| Verrou (vide / notifs) | Swipe unlock, torche, caméra (UI seulement) | Widgets lock screen, Focus |
| PIN | Clavier, shake erreur, annuler | Face ID (v2 si capture) |
| Accueil | Grille, dock, pager, Spotlight pill | App Library, édition icônes |
| NC, CC | Swipe, blur, tuiles | Vraie connectivité, HomeKit |
| Transitions | Open/close app depuis icône | Multitâche app switcher |

**Données LPSP :** `envelope`, `system.dock`, `manifest.apps_presentes`, scénario notifs

---

## 1. Messages

| Écrans IN | Comportements IN | Hors scope |
|-----------|------------------|------------|
| Liste conversations | Scroll, avatars, preview, heure, badges non lus | Filtres, pin, recherche avancée |
| Conversation | Bulles iMessage, timestamps, scroll, composer visuel | Envoi réel, pièces jointes interactives, audio |
| *(option)* Nouveau message | Sheet contact picker si scénario | Groupes, Memoji |

**Données LPSP :** `threads[]` → contact, messages[], lu/non lu  
**Captures :** `app.messages.liste`, `app.messages.conversation`

---

## 2. WhatsApp

| Écrans IN | Comportements IN | Hors scope |
|-----------|------------------|------------|
| Liste discussions | Filtres chips (Toutes / Non lues) si capture | Archivées, communautés, appels |
| Conversation | Bulles WA, double check, composer | Appels, statuts, diffusion |

**Données LPSP :** `conversations[]`  
**Captures :** `app.whatsapp.liste`, `app.whatsapp.conversation`

---

## 3. Signal

| Écrans IN | Comportements IN | Hors scope |
|-----------|------------------|------------|
| Liste | Style Signal (dark, minimal) | Stories, appels |
| Conversation | Bulles Signal, cadenas si chiffré dans LPSP | Enregistrement vocal |

**Données LPSP :** `conversations[]`  
**Captures :** `app.signal.liste`, `app.signal.conversation`

---

## 4. Photos

| Écrans IN | Comportements IN | Hors scope |
|-----------|------------------|------------|
| Bibliothèque (grille) | Grille 3 col, sections par date | Carte, For You, Search |
| Albums | Liste albums | Personnes, Partages |
| Détail photo | Fullscreen, swipe, pinch zoom visuel | Édition, retouche, partage sheet complet |

**Données LPSP :** `photos[]`, `albums[]`, URLs/chemins images  
**Captures :** `app.photos.bibliotheque`, `app.photos.albums`, `app.photos.detail`

---

## 5. Instagram

| Écrans IN | Comportements IN | Hors scope |
|-----------|------------------|------------|
| Feed | Stories bar, posts, like/comment UI | Reels, création, shop |
| DM | Liste + conversation | Appels, vidéo, notes |

**Données LPSP :** `feed[]`, `stories[]`, `dms[]`  
**Captures :** `app.instagram.feed`, `app.instagram.dm`

---

## 6. Notes

| Écrans IN | Comportements IN | Hors scope |
|-----------|------------------|------------|
| Liste (sections) | Épinglées, dates, dossiers | Collaboration, scan |
| Note | Éditeur lecture (texte riche affiché) | Édition joueur, dessin |

**Données LPSP :** `notes[]` → titre, corps, dossier, épinglé  
**Captures :** `app.notes.liste`, `app.notes.detail`

---

## 7. Contacts

| Écrans IN | Comportements IN | Hors scope |
|-----------|------------------|------------|
| Liste A–Z | Index alphabétique, fiches compactes | Groupes, partage |
| Fiche contact | Photo, numéros, email, actions (UI) | Appel réel, FaceTime |

**Données LPSP :** `fiches[]`  
**Captures :** `app.contacts.liste` + fiche *(capture à ajouter)*

---

## 8. Mail

| Écrans IN | Comportements IN | Hors scope |
|-----------|------------------|------------|
| Inbox | Liste, non lu, preview | Comptes multiples, VIP |
| Message | HTML/texte, pièces jointes listées | Rédaction, réponse |

**Données LPSP :** `messages[]`  
**Captures :** `app.mail.inbox`, `app.mail.detail`

---

## 9. Calendrier

| Écrans IN | Comportements IN | Hors scope |
|-----------|------------------|------------|
| Vue mois | Grille, points événements | Semaine, année |
| Vue jour / détail | Liste événements du jour | Création, invitation |

**Données LPSP :** `events[]` → titre, date, lieu, notes  
**Captures :** `app.calendrier.mois` + jour *(capture à ajouter)*

---

## 10. Telephone

| Écrans IN | Comportements IN | Hors scope |
|-----------|------------------|------------|
| Récents | Entrants/sortants/manqués | Répondeur |
| Clavier | Pavé numérique (UI) | Appel réel |
| *(option)* Fiche depuis récent | Tap → contact | FaceTime |

**Données LPSP :** `recents[]`  
**Captures :** `app.telephone.recents` + clavier *(à ajouter)*

---

## 11. Safari

| Écrans IN | Comportements IN | Hors scope |
|-----------|------------------|------------|
| Accueil | Favoris, onglets visuels | Navigation web réelle |
| Page statique | Contenu LPSP (HTML/texte/image) | JS externe, formulaires |

**Données LPSP :** `favoris[]`, `historique[]`, `pages{}` contenu statique  
**Captures :** `app.safari.accueil` + onglet *(à ajouter)*

---

## 12. Google Maps

| Écrans IN | Comportements IN | Hors scope |
|-----------|------------------|------------|
| Carte | Pin(s), zoom/pan | Itinéraire temps réel, trafic live |
| Fiche lieu | Nom, adresse, note | Navigation turn-by-turn |

**Données LPSP :** `places[]`, coordonnées, image carte statique ou tiles mock  
**Captures :** `app.maps.carte`

---

## 13. Uber

| Écrans IN | Comportements IN | Hors scope |
|-----------|------------------|------------|
| Accueil / historique | Carte statique, courses passées | Commander, paiement, chauffeur live |
| Détail course | Trajet, prix, date, chauffeur | Annulation, notation |

**Données LPSP :** `courses[]`, `compte`  
**Captures :** `app.uber.accueil` *(manquante)* + détail *(à ajouter)*

---

## 14. Spotify

| Écrans IN | Comportements IN | Hors scope |
|-----------|------------------|------------|
| Accueil | Playlists récentes, albums | Radio, podcasts, Discover, classements |
| Playlist / album | Liste morceaux | Téléchargement, partage |
| Lecteur mini + full | Play/pause UI, barre progression | Streaming réel, lyrics |

**Données LPSP :** `playlists[]`, `albums[]`, `tracks[]`, `now_playing`  
**Captures :** `app.spotify.accueil` + lecteur *(à ajouter)*

---

## 15. Netflix

| Écrans IN | Comportements IN | Hors scope |
|-----------|------------------|------------|
| Choix profil | Grille profils | Gestion compte |
| Accueil | Rangées, vignettes | Lecture vidéo réelle, recherche |
| Détail titre | Synopsis, épisodes si série | Player |

**Données LPSP :** `profils[]`, `catalogue[]`  
**Captures :** `app.netflix.profils`, `app.netflix.accueil`

---

## 16. Crédit Agricole

| Écrans IN | Comportements IN | Hors scope |
|-----------|------------------|------------|
| Compte principal | Solde, dernières opérations | Virement, RIB, assurances, tous les menus |
| Détail opération | Montant, date, libellé | Contester, catégories |

**Données LPSP :** `comptes[]`, `operations[]`  
**Captures :** `app.credit-agricole.compte`

---

## 17. Fichiers

| Écrans IN | Comportements IN | Hors scope |
|-----------|------------------|------------|
| Navigateur | Dossiers, fichiers, icônes types | iCloud sync, partage, édition |

**Données LPSP :** arborescence `items[]`  
**Captures :** `app.fichiers.browser`

---

## 18. Rappels

| Écrans IN | Comportements IN | Hors scope |
|-----------|------------------|------------|
| Liste | Cases, dates, listes | Création, Siri, tags |

**Données LPSP :** `lists[]`, `items[]`  
**Captures :** `app.rappels.liste`

---

## Synthèse — écrans totaux

| App | Écrans parfaits | Hors scope volontaire |
|-----|-----------------|------------------------|
| Messages | 2 | ~70 % |
| WhatsApp | 2 | ~75 % |
| Signal | 2 | ~80 % |
| Photos | 3 | ~60 % |
| Instagram | 2 | ~70 % |
| Notes | 2 | ~65 % |
| Contacts | 2 | ~70 % |
| Mail | 2 | ~75 % |
| Calendrier | 2 | ~70 % |
| Telephone | 2 | ~75 % |
| Safari | 2 | ~80 % |
| Maps | 2 | ~75 % |
| Uber | 2 | ~85 % |
| Spotify | 3 | ~70 % |
| Netflix | 2–3 | ~75 % |
| Crédit Agricole | 2 | ~90 % |
| Fichiers | 1 | ~80 % |
| Rappels | 1 | ~85 % |
| **Noyau** | **8** | ~50 % |
| **Total** | **~45 écrans** | — |

**45 écrans parfaits**, pas 200. C’est le vrai scope.

---

## Architecture (inchangée)

```
LPSP  →  adapter  →  view model  →  template app (écrans IN only)  →  design system
```

Changer un message Instagram = JSON.  
L’écran feed reste le template Instagram calibré une fois.

---

## Estimation révisée (45 écrans parfaits)

| Bloc | Temps |
|------|-------|
| Noyau (8 écrans) | ~2 semaines |
| Design system | ~2–3 semaines |
| 18 apps × ~2,5 écrans | ~8–12 semaines |
| Finition j3-louvre | ~1 semaine |
| **Total** | **~3–4 mois** travail régulier |

Plus rapide que « 18 apps complètes », plus long que « 18 apps simplifiées » — c’est le bon curseur.

---

## Prochaine étape

1. **Valider ce périmètre** — dis-moi si un écran manque pour j3-louvre
2. **Fix captures** (système mal classé + captures manquantes listées ci-dessus)
3. **Commencer** : noyau → Messages (modèle) → reste dans l’ordre tier 1/2/3
