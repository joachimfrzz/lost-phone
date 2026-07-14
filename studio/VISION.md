# Vision — LostPhone Studio

## Ce que nous construisons

**LostPhone Studio** est un environnement de développement assisté par IA, conçu pour durer plusieurs années.

**Lost Phone** est le premier jeu produit dans ce studio — pas un projet isolé.

## Philosophie

- **Simplicité** — pas de couches inutiles
- **Modularité** — apps, histoires, tooling séparés
- **Automatisation** — chaque tâche répétée doit tendre vers un workflow
- **Maintenabilité** — une source de vérité par concept
- **Réutilisation** — adapters, générateurs, templates
- **Scalabilité** — plusieurs histoires, dizaines d'apps, plusieurs releases

## Priorité absolue

La ressource la plus importante est le **temps du créateur**.

Avant chaque tâche :

- Peut-elle être automatisée ?
- Peut-on supprimer un copier-coller ?
- Peut-on supprimer une manipulation ?
- Peut-on transformer cette tâche en workflow réutilisable ?
- Existe-t-il une meilleure architecture ?

## Esprit critique

Ne jamais valider une idée sans analyse. Toujours présenter avantages et inconvénients des alternatives.

## Notion

Quand Notion est utilisé, il constitue la **source de vérité produit** (bugs, apps, statuts).  
Le code et le CI constituent la **source de vérité technique**.

Objectif studio : synchroniser les deux avec un minimum de travail manuel.

## Pivot technique (juin 2026)

| Avant | Après |
|-------|-------|
| React + Figma + Capacitor | SwiftUI natif + LPSP JSON |
| Creator web comme cible iPhone | Creator web **archivé** (`archive/legacy-react/`) |
| Multiples couches d'apps non consolidées | Clone → Vendored → Awesome (fallback) |

Référence : [`../PIVOT-SWIFTUI.md`](../PIVOT-SWIFTUI.md)

## Showroom (juillet 2026)

- **Clone/** — apps Apple zerocode117 (gelées, qualité showroom)
- **Vendored/** — clones tiers en production (Sopheamen/GitHub vendored)
- **Awesome/** — vues générées Spectr (fallback temporaire, à retirer)
- **Sopheamen brut** — archivé hors compile path (`archive/sopheamen-raw/`)

Référence : [`../LostPhone/docs/SHOWROOM_STRATEGY.md`](../LostPhone/docs/SHOWROOM_STRATEGY.md)
