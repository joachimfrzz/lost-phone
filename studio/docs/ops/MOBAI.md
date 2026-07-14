# MobAI — QA device pour LostPhone Studio

[MobAI](https://mobai.run) donne à Cursor (et autres agents MCP) la capacité de **voir et piloter** un iPhone, iPad ou simulateur iOS — tap, scroll, saisie, screenshots, tests.

C'est l'outil recommandé pour valider les apps **sur device réel** pendant le développement, en complément du CI (qui compile sans téléphone).

---

## Pourquoi c'est utile pour Lost Phone

| Besoin Studio | MobAI |
|---------------|-------|
| Tester WhatsApp/Messenger sur iPhone sans manip manuelle | Agent tape, scroll, envoie messages |
| Vérifier contrastes / navigation après un fix | Screenshots + exploration guidée |
| Régressions après changement UI | Scripts `.mob` rejouables |
| Moins d'allers-retours créateur ↔ Cursor | L'agent teste pendant qu'il code |

**Limite :** MobAI tourne **en local** (app desktop + device). Il ne remplace pas GitHub Actions pour le build compile.

---

## Prérequis

1. Télécharger [MobAI desktop](https://mobai.run/download) (macOS, Windows, Linux)
2. Node.js 18+
3. iPhone/iPad branché **ou** simulateur iOS ouvert
4. App Lost Phone installée (Codemagic TestFlight ou build local)

---

## Installation MCP (Cursor)

1. Lancer l'app **MobAI desktop** (API sur `http://127.0.0.1:8686`)
2. Copier la config exemple :

```bash
cp .cursor/mcp.json.example .cursor/mcp.json
```

3. Redémarrer Cursor ou recharger les MCP servers
4. Vérifier : l'agent doit voir les outils `mobai` (execute_dsl, test_run, etc.)

Config minimale :

```json
{
  "mcpServers": {
    "mobai": {
      "command": "npx",
      "args": ["-y", "mobai-mcp"]
    }
  }
}
```

---

## Tests Lost Phone

Scripts `.mob` dans `studio/tooling/mobai/tests/` :

| Dossier | Couverture |
|---------|------------|
| `smoke/` | Ouvrir app, déverrouiller PIN, atteindre home |
| `apps/` | Un sous-dossier par app tierce (à créer avec chaque brief) |

Exemple smoke :

```text
# studio/tooling/mobai/tests/smoke/open-home.mob
tap "LostPhone"
wait_for "Showroom"
# … adapter aux libellés réels de ton build
```

Lancer via MCP : `test_run` avec `project_dir` = `studio/tooling/mobai/tests`

---

## Workflow recommandé

1. Tu envoies un **brief app** (template Notion)
2. Cursor implémente l'app custom
3. **MobAI** : agent explore l'app sur ton iPhone et rapporte bugs
4. Fix → re-test `.mob`
5. Notion → statut Validé

---

## Coût

| Plan | Prix | Suffisant pour nous ? |
|------|------|----------------------|
| Free | $0 | 1 device, 100 pts/jour — **démarrage OK** |
| Plus | $4.99/mo | Usage illimité, 1 device |
| Pro | $9.99/mo | Multi-devices, tests parallèles |

Commencer en **Free** pour valider l'intégration.

---

## Ce que MobAI ne fait pas

- Ne compile pas le projet (→ GitHub Actions / Codemagic)
- Ne remplace pas Notion (→ hub produit)
- Ne génère pas les designs Awesome (→ specs Meliwat + tes briefs)
- Ne tourne pas dans CI cloud sans machine locale MobAI

---

## Liens

- Site : https://mobai.run
- MCP : https://github.com/MobAI-App/mobai-mcp
- npm : `mobai-mcp` (v2.3.0)
