# Workflow Studio — Notion, iPhone, Cursor

## Hub centralisé : Notion

Notion est la **source de vérité produit** :

- Liste des apps (officielles vs custom)
- Briefs par app ([template](templates/APP-BRIEF.md))
- Bugs et statuts QA
- Notes de session (test iPhone)

Le code et le CI sont la **source de vérité technique**.

## Boucle de travail

```
┌─────────────┐     brief app      ┌──────────────┐
│   Notion    │ ─────────────────► │    Cursor    │
│  (iPhone)   │ ◄───────────────── │  + MobAI     │
└─────────────┘   statut / bugs    └──────────────┘
       │                                    │
       │ test manuel                        │ git push
       ▼                                    ▼
   iPhone/iPad                         GitHub + Codemagic
```

## Sur iPhone / iPad (à tout moment)

1. Ouvrir Notion → consulter brief / bugs de l'app en cours
2. Tester sur Lost Phone (TestFlight)
3. Noter dans Notion (ou dicter à Cursor au retour au bureau)
4. Pas besoin de Mac pour **tester** — Mac/PC pour **compiler**

## Sur Mac / PC (développement)

1. Cloner le repo, lire `AGENTS.md`
2. `npm run lpsp:sync` si histoire modifiée
3. Cursor + MobAI pour implémenter et tester sur simulateur/device branché
4. Push → CI vert → Codemagic → TestFlight

## Création d'une app tierce (résumé)

1. **Notion** — remplir brief ([APP-BRIEF.md](templates/APP-BRIEF.md))
2. **Design** — Awesome Design spec + prompts §9 (`awesome_design_agent_guide.py <App>`)
3. **Code** — `Apps/Custom/<App>/` (nouveau dossier, pas Vendored)
4. **LPSP** — adapters dans `Core/Services/`
5. **QA** — MobAI tests + validation Notion
6. **Retrait** — désactiver l'ancienne entrée Vendored/Awesome dans le router quand l'app custom est prête

## Apps officielles (clones)

Workflow plus court :

1. Bug Notion → fix ciblé dans `Apps/Clone/`
2. MobAI smoke si interaction critique
3. Pas de refonte UI
