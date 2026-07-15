# Apps Custom — Lost Phone

Apps tierces **créées par l'équipe** (Awesome Design + briefs Notion).  
Remplace progressivement `Vendored/` et `Awesome/Generated/`.

## Règles

- Une app = un dossier `Custom/<AppName>/`
- Tokens partagés : `LpspThirdPartyDesign.swift`, `LpspBrandedAppIcons.swift`
- Routing : enregistrer dans `LpspAppRouter.swift` **après** validation QA
- Ne pas modifier `Apps/Clone/` (apps Apple gelées)

## Structure cible par app

```
Custom/WhatsApp/
├── README.md           # Lien Notion, statut, notes dev
├── WhatsAppRootView.swift
├── WhatsAppChatListView.swift
├── WhatsAppConversationView.swift
└── …
```

## Backlog

Voir [`../../../../studio/docs/APPS-BACKLOG.md`](../../../../studio/docs/APPS-BACKLOG.md)

## Briefs

- Template : [`../../../../studio/docs/templates/APP-BRIEF.md`](../../../../studio/docs/templates/APP-BRIEF.md)
- Notion : [Applications LostPhone](https://app.notion.com/p/99478c55b3ae45adbc9f029d128c885c)
