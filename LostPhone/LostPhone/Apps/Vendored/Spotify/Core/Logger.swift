//
//  LogUtils.swift
//  SwiftUIClones
//
//  Created by ladans on 17/08/25.
//

import Foundation
import SwiftUI

struct VendoredSpotifyLoggerKey: EnvironmentKey {
    static let defaultValue: (String) -> Void = { _ in }
}

extension EnvironmentValues {
    var log: (String) -> Void {
        get { self[VendoredSpotifyLoggerKey.self] }
        set { self[VendoredSpotifyLoggerKey.self] = newValue }
    }
}

extension View {
    func injectLogger() -> some View {
        environment(\.log, logger)
    }
}

private func logger(_ value: String) {
    print("Log:\n**********\n\(value)\n**********")
}
