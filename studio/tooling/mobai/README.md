# MobAI — tests device Lost Phone

Prérequis : [MobAI desktop](https://mobai.run/download) lancé + MCP configuré (voir [`../../docs/ops/MOBAI.md`](../../docs/ops/MOBAI.md)).

## Structure

```
tests/
├── smoke/          # Ouvrir l'app, home, showroom
└── apps/           # Un dossier par app tierce (whatsapp/, messenger/, …)
```

## Ajouter un test pour une nouvelle app

1. Créer `tests/apps/<slug>/`
2. Ajouter `*.mob` (syntaxe MobAI : tap, type, wait_for, assert)
3. Documenter le scénario dans le brief app Notion
4. Lancer via Cursor + MCP `test_run`

## Exemple minimal

Voir `tests/smoke/README.mob` — à adapter après premier run sur ton iPhone.
