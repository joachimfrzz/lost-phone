# Uber — clone Reddit (vendored)

Source : [264Gaurav/UBER-ios](https://github.com/264Gaurav/UBER-ios) (MIT)

Intégré dans Lost Phone comme les 14 clones Apple du Showroom : le code Swift du repo est copié tel quel dans ce dossier, puis branché via `LpspUberView` / `UberRedditAppView`.

## Fichiers vendored (repo GitHub)

- `Core/Home/` — carte MapKit, recherche destination, réservation
- `Core/LocationSearch/` — autocomplétion Apple Maps
- `Core/Trips/RideRequestView.swift` — bottom sheet courses
- `Models/`, `Extensions/`, `Managers/`, `Utilities/`

## Ajouts Lost Phone

- `UberRedditApp.swift` — tab bar Uber + routing onglets
- `UberActivityTabView.swift` — historique des courses LPSP (J-3)
- `Managers/UberCloneLocationManager.swift` — position par défaut Bastille

## Assets

Images et couleurs du clone copiées dans `LostPhone/Assets.xcassets/` :
`auto`, `bike`, `car-black`, `car-white`, `white-car2`, `BackgroundColor`, etc.
