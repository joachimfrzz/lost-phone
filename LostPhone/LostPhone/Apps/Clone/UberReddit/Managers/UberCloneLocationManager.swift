import CoreLocation

/// Localisation pour le clone Uber Reddit — position par défaut Bastille (J-3).
final class UberCloneLocationManager: NSObject, ObservableObject {
    static let shared = UberCloneLocationManager()

    /// Domicile Mathieu (Bastille) — cohérent avec l'histoire J-3.
    static let storyDefault = CLLocationCoordinate2D(latitude: 48.8530, longitude: 2.3690)

    @Published var userLocation: CLLocationCoordinate2D? = storyDefault

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension UberCloneLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        userLocation = location.coordinate
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        userLocation = Self.storyDefault
    }
}
