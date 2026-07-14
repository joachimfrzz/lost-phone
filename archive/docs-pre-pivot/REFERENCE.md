# Copie de référence iOS

> **Méthode complète :** voir **[CALIBRATION.md](./CALIBRATION.md)** — un écran validé à la fois, pixel par pixel.

Les PNG dans `public/captures-ios/` sont des **références visuelles** pour calibrer l’UI React.  
Le **contenu** affiché en jeu reste celui du LPSP — pas celui des captures.

## Modes de développement

| Route | Usage |
|-------|-------|
| `/simulator` | iPhone **vide** — développer le noyau iOS sans histoire |
| `/ui-reference` | Comparer React vs capture iOS (overlay 50 %) — **un écran à la fois** |
| `/phone/:id` | Jeu avec contenu LPSP |

## Workflow (résumé)

1. **Un seul écran actif** — file d’attente dans `CALIBRATION.md`
2. **Assets exacts** — wallpaper PNG, icônes SF (pas de dégradés CSS ni SVG inventés)
3. **Mesurer** chaque élément depuis la capture → tokens CSS
4. **Comparer** sur `/ui-reference` — overlay 50 %, corriger jusqu’à quasi-identique
5. **Valider** — l’utilisateur dit « OK » → écran suivant débloqué

## Gate de validation

On ne passe à l’écran suivant **que** si l’overlay à 50 % ne révèle plus d’écart visible.  
Pas de Messages, pas d’apps, pas de LPSP tant qu’un écran noyau n’est pas validé.

## Règle

Ne jamais afficher les PNG en runtime jeu — uniquement sur `/ui-reference`.

## Scripts

```bash
npm run reference:measure   # métriques depuis les PNG
npm run captures:status     # captures manquantes
```
