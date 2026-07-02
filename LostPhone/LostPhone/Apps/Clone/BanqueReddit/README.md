# BanqueReddit

Clone [GeraudLuku/YT-BankingApp](https://github.com/GeraudLuku/YT-BankingApp) intégré dans Lost Phone.

## Source

- Repo : https://github.com/GeraudLuku/YT-BankingApp
- Design : Dribbble Banking App (Piqo Design)
- UI : carte bancaire lime, bandeau « Envoyer de l'argent », carrousel transactions

## Adaptations Lost Phone

- **SwiftUI pur** — pas d'assets PNG (visa, avatars) : SF Symbols + cercles initiales
- Couleurs vendored : `green` #E0FE0E, `dark`, `purple`
- Données LPSP via `LpspAdapters.banque` (comptes LCL J-3, opérations narrative)
- Liste complète des opérations conservée sous le carrousel (contenu enquête J-3)
- Read-only : virement et recherche contacts désactivés

## Fichiers

- `BanqueRedditApp.swift` — écran principal + `LpspBanqueView`
- `BanqueRedditBankCardView.swift` — carte solde
- `BanqueRedditShareCardView.swift` — bandeau contacts
- `BanqueRedditTransactionItemView.swift` — tuile carrousel
- `BanqueRedditOperationViews.swift` — liste + détail opération
- `BanqueRedditTheme.swift` — couleurs + icônes catégories
