//
//  TextFieldBottomBorderLineView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 17/3/24.
//

import SwiftUI

struct TextFieldBottomBorderLineView: View {
    var placeHolder: String
    @Binding var controller: String
    var body: some View {
        HStack {
            Text(placeHolder)
                .fontWeight(.regular)
                .frame(maxWidth: 100,alignment: .leading)
           
            VStack {
                TextField(placeHolder, text: $controller)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.blackOpacity.opacity(0.15))
            }
        }
        .font(.headline)
    }
}

#Preview {
    TextFieldBottomBorderLineView(placeHolder: "Username", controller: .constant(""))
}
