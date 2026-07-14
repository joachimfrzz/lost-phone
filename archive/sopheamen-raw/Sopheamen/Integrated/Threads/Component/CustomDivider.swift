//
//  CustomDivider.swift
//  Youtube_Threads
//
//  Created by Sopheamen VAN on 25/9/24.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 0.2)
            .foregroundStyle(.white.opacity(0.4))
    }
}

#Preview {
    CustomDivider()
}
