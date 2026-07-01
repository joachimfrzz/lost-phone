import UIKit

@main
final class LostPhoneAppDelegate: UIResponder, UIApplicationDelegate {
    private let phone = PhoneViewModel()
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor(red: 0.04, green: 0.05, blue: 0.12, alpha: 1)
        window.rootViewController = SplashViewController(phone: phone)
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
