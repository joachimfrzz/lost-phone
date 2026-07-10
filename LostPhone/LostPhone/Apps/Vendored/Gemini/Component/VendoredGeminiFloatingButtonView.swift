//
//  VendoredGeminiFloatingButtonView.swift
//  Youtube_Gemini_clone
//
//  Created by Sopheamen VAN on 4/2/25.
//

import SwiftUI

struct VendoredGeminiFloatingButtonView:View {
    @Binding var promptText:String
    var onSend: () -> Void = {}

    var body: some View {
        HStack {
            // textfield
            HStack {
                TextField("Ask Gemini", text: $promptText)
                    .padding(.leading)
                    .onSubmit(onSend)
                // icons
                HStack (spacing:16){
                    Button {
                        onSend()
                    } label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.title2)
                            .foregroundStyle(
                                promptText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                                    ? .secondary
                                    : Color.vendoredGeminiPrimaryColor1
                            )
                    }
                    .disabled(promptText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    Button {
                        
                    }label: {
                        Image(systemName: "mic")
                    }
                    Button {
                        
                    }label: {
                        Image(systemName: "camera")
                    }
                }
                .foregroundStyle(.primary)
                .frame(width: 130, height: 48)
                .background(Color.vendoredGeminiHightLightColor)
                .clipShape(Capsule())
            }
            .padding(.trailing, 4)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .overlay(
                Capsule().stroke(.gray.opacity(0.2))
            )
            // icon voice
            Button {
                
            }label: {
                ZStack {
                    Circle()
                        .fill(Color.vendoredGeminiHightLightColor)
                        .frame(width: 50, height: 50)
                    Image(systemName: "waveform")
                        .foregroundStyle(.primary)
                }
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .frame(height: 90)
        .background(Color(uiColor: .systemBackground))
        .shadow(color: .gray.opacity(0.15),radius: 10)
    }
}


#Preview {
    VendoredGeminiFloatingButtonView(promptText: .constant("Hello, World"))
}
