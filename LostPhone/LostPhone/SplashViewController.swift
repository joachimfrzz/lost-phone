import UIKit
import SwiftUI

/// UIKit splash shown before SwiftUI — Appetize often streams black until the first UIKit frame.
final class SplashViewController: UIViewController {
    private let phone: PhoneViewModel

    init(phone: PhoneViewModel) {
        self.phone = phone
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.04, green: 0.05, blue: 0.12, alpha: 1)

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        let icon = UIImageView(image: UIImage(systemName: "iphone.gen3"))
        icon.tintColor = UIColor.white.withAlphaComponent(0.9)
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.widthAnchor.constraint(equalToConstant: 56).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 56).isActive = true

        let title = UILabel()
        title.text = "Lost Phone"
        title.textColor = .white
        title.font = .systemFont(ofSize: 34, weight: .bold)

        let subtitle = UILabel()
        subtitle.text = "Chargement…"
        subtitle.textColor = UIColor.white.withAlphaComponent(0.65)
        subtitle.font = .systemFont(ofSize: 15, weight: .regular)

        stack.addArrangedSubview(icon)
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(subtitle)
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            self?.presentMainInterface()
        }
    }

    private func presentMainInterface() {
        guard let window = view.window else { return }

        let host = UIHostingController(
            rootView: PhoneRootView()
                .environmentObject(phone)
                .environment(\.locale, Locale(identifier: "fr_FR"))
                .preferredColorScheme(.dark)
        )
        host.view.backgroundColor = UIColor(red: 0.04, green: 0.05, blue: 0.12, alpha: 1)
        host.view.isOpaque = true

        UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve) {
            window.rootViewController = host
        }
    }
}
