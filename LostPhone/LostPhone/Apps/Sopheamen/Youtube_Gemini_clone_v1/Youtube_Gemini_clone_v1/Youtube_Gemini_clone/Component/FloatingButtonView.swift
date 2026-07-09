//
//  FloatingButtonView.swift
//  Youtube_Gemini_clone
//
//  Created by Sopheamen VAN on 4/2/25.
//

import SwiftUI

struct FloatingButtonView:View {
    @Binding var promptText:String
    var body: some View {
        HStack {
            // textfield
            HStack {
                TextField("Ask Gemini", text: $promptText)
                    .padding(.leading)
                // icons
                HStack (spacing:24){
                    Button {
                        
                    }label: {
                        Image(systemName: "mic")
                    }
                    Button {
                        
                    }label: {
                        Image(systemName: "camera")
                    }
                }
                .foregroundStyle(.black)
                .frame(width: 110, height: 48)
                .background(Color.hightLightColor)
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
                        .fill(Color.hightLightColor)
                        .frame(width: 50, height: 50)
                    Image(systemName: "waveform")
                        .foregroundStyle(.black)
                }
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .frame(height: 90)
        .background(Color.white)
        .shadow(color: .gray.opacity(0.15),radius: 10)
    }
}


#Preview {
    FloatingButtonView(promptText: .constant("Hello, World"))
}
