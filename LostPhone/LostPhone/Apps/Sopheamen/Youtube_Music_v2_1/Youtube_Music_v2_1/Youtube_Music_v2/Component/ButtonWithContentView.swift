//
//  ButtonWithContentView.swift
//  Youtube_Music_v2
//
//  Created by Sopheamen VAN on 4/9/24.
//

import SwiftUI

struct ButtonWithContentView<Content: View>: View {
    let content:Content
    var body: some View {
        HStack (spacing: 8){
            content
        }
        .padding(.vertical,8)
        .padding(.horizontal, 14)
        .background(Color.buttonColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ButtonWithContentView(content: Text("Hello, World").foregroundStyle(.white))
}
