//
//  HideTabBar.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 1/4/24.
//

import SwiftUI

struct VendoredInstagramHideTabBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(VendoredInstagramTabBarHider())
    }
}

struct VendoredInstagramTabBarHider: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return VendoredInstagramHideTabBarViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

class VendoredInstagramHideTabBarViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabBarController = self.parent?.tabBarController {
            tabBarController.tabBar.isHidden = true
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let tabBarController = self.parent?.tabBarController {
            tabBarController.tabBar.isHidden = false
        }
    }
}

extension View {
    func hideTabBar() -> some View {
        self.modifier(VendoredInstagramHideTabBarModifier())
    }
}
