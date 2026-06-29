# Figma → Lost Phone (source de vérité)

Le rendu iOS **doit** venir du [UI Kit Apple iOS 26](https://www.figma.com/community/file/1527721578857867021/ios-and-ipados-26), pas de CSS deviné.

---

## Blocage connu — MCP Cursor Starter

| Plan Figma | Siège | Limite MCP |
|------------|-------|------------|
| Starter | **View** | ~6 appels/mois → **quota épuisé** |

Tant que le quota MCP n’est pas levé (upgrade **Dev/Full** sur Pro) ou reset mensuel, **`get_design_context` ne fonctionne pas**.

**Solution recommandée : API REST Figma** (même compte, pas la limite MCP).

---

## Setup en 5 minutes

### 1. Dupliquer le kit iOS 26 (pas seulement la Cover iOS 27)

1. Ouvrir : https://www.figma.com/community/file/1527721578857867021/ios-and-ipados-26  
2. **Ouvrir dans Figma** → **Dupliquer**  
3. Le fichier apparaît dans **Vos brouillons**

> La copie iOS 27 (`JhyGhOxtWAdEAivM0XriuC`) ne contient que la page Cover + bibliothèques liées.  
> Pour l’API, il faut le kit **iOS 26 complet** dans vos brouillons (ou une instance du composant sur le canvas).

### 2. Token API

1. Figma → **Settings** → **Security** → **Generate new token**  
2. Scope : `file_content:read`  
3. Créer `game/.env.local` :

```env
FIGMA_ACCESS_TOKEN=votre_token
FIGMA_FILE_KEY=clé_dans_l_url_apres_design
```

Exemple d’URL : `https://www.figma.com/design/XXXXXXXX/ios-and-ipados-26` → `FIGMA_FILE_KEY=XXXXXXXX`

### 3. Export + application (verrou)

```powershell
cd game
npm run figma:export -- lock-screen
npm run figma:apply -- lock-screen
npm run dev
```

Puis valider sur **`/simulator`** à côté du vrai iPhone.

---

## Workflow écran par écran

| Étape | Commande / action |
|-------|-------------------|
| Export specs + PNG | `npm run figma:export -- lock-screen` |
| Tokens → CSS | `npm run figma:apply -- lock-screen` |
| Implémentation React | Agent (depuis `src/lib/figma/screens/*.json`) |
| Validation | Vous sur `/simulator` → « OK verrou » ou corrections |
| Écran suivant | `pin`, `home-screen`, etc. |

Cache local : `src/lib/figma/screens/lock-screen.json` + `public/figma/reference/lock-screen.png`  
→ pas besoin de rappeler Figma à chaque session.

---

## Option B — MCP Figma (si quota disponible)

1. Cursor → `/add-plugin figma` → Connect  
2. Compte : `joachim.fourez@gmail.com`  
3. Siège **Dev ou Full** (Pro) pour lever la limite Starter  

Ensuite l’agent peut appeler `get_design_context` sur **Lock Screen - iPhone** (`c16ce8eb…`).

---

## Quand c’est prêt

Envoyez dans le chat : **`token ok`**

L’agent exporte le verrou, applique les tokens, refait `LockScreen.tsx` / CSS depuis les specs Figma, et vous validez sur `/simulator`.
