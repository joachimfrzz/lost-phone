// swift-tools-version: 5.9
// Vendored from https://github.com/debuging-life/SwiftUINavigation @ 34e67994b4ea
// Local copy: CI Xcode 16.4 (Swift 6.1) cannot resolve upstream Package.swift (Swift 6.2).

import PackageDescription

let package = Package(
    name: "SwiftUINavigation",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "SwiftUINavigation", targets: ["SwiftUINavigation"]),
    ],
    targets: [
        .target(name: "SwiftUINavigation"),
    ]
)
