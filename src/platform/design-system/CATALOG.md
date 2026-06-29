# Design system iOS — inventaire

Objectif : **une seule bibliothèque** pour le noyau système, les apps natives et les apps tierces.

## Existant (`src/ios/ui/` → migration vers ici)

| Composant | Export | Usage actuel | Qualité vs iOS |
|-----------|--------|--------------|----------------|
| `AppShell` | thème light/dark par app | Toutes les apps | Approximatif |
| `NavBar` | barre + back + actions | Apps | Approximatif |
| `LargeTitle` | titre grand format | Listes | Approximatif |
| `Group` / `Cell` | listes groupées | Réglages, Contacts… | Approximatif |
| `Avatar` | initiales colorées | Messages, Contacts | OK |
| `TabBar` | onglets bas | Quelques apps | Approximatif |
| `ChatThread` | bulles iMessage | Messages, WhatsApp, Signal | Partiel |
| `ChatComposer` | zone saisie | Chats | Partiel |
| `SFSymbols` | icônes SVG | Divers | Partiel |

## À créer (priorité design system)

### Système
- [ ] `SearchField` — pill blur accueil + barre recherche apps
- [ ] `PinPad` — clavier code (extraire de PinScreen)
- [ ] `FaceIdPrompt` — animation Face ID
- [ ] `SystemKeyboard` — clavier QWERTY AZERTY
- [ ] `HomeIndicator` — *(existe dans IphoneShell, formaliser)*
- [ ] `NotificationCard` — *(existe dans components/ios, migrer)*
- [ ] `ControlCenterModule` — tuiles CC
- [ ] `Sheet` — bottom sheet iOS
- [ ] `Alert` — UIAlertController style
- [ ] `ActionSheet` — menu actions bas
- [ ] `ContextMenu` — long-press menu
- [ ] `Popover` — menu compact

### Formulaires
- [ ] `Switch` — UISwitch
- [ ] `SegmentedControl` — pill selector
- [ ] `TextField` — champ avec clear button
- [ ] `Stepper` — +/- value
- [ ] `Picker` — wheel / inline
- [ ] `Slider` — continuous + discrete

### Listes & navigation
- [ ] `InsetGroupedList` — style Réglages exact
- [ ] `PlainList` — style Mail
- [ ] `SwipeActions` — actions swipe gauche/droite
- [ ] `EditMode` — reorder + delete
- [ ] `Toolbar` — barre d’outils bas/haut
- [ ] `SectionHeader` — en-têtes listes

### Média & contenu
- [ ] `PhotoGrid` — grille Photos
- [ ] `MapPin` — annotation Plans
- [ ] `MediaPlayer` — contrôles CC / Music

## Règles

1. **Aucun** composant app ne définit ses propres tokens couleur/espacement — tout passe par `tokens.css` / `hig.css`.
2. Chaque nouveau composant est calibré contre une capture avant merge.
3. Les apps ne font que **composer** des composants + brancher des données.
