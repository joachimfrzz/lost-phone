//
//  VendoredGeminiHomeView.swift
//  Youtube_Gemini_clone
//
//  Created by Sopheamen VAN on 4/2/25.
//

import SwiftUI

struct VendoredGeminiHomeView: View {
    // state textifeld
    @State private var promptText: String = ""
    @State private var navigationDetail:Bool = false
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottom){
                // content
                VStack {
                    Text("Hello, ") +
                    Text("Alex")
                }
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(
                    LinearGradient(gradient: Gradient(colors: [Color.vendoredGeminiPrimary1, Color.vendoredGeminiPrimary2, Color.vendoredGeminiPrimary3]), startPoint: .leading, endPoint: .trailing)
                )
                .frame(maxHeight: .infinity)
                // floating button
                VendoredGeminiFloatingButtonView(promptText: $promptText)
                    .onSubmit {
                        if !promptText.isEmpty {
                            navigationDetail = true
                        }
                    }
            }
            .navigationDestination(isPresented: $navigationDetail) {
                VendoredGeminiDetailView(text: promptText)
            }
            // title
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // leading
                ToolbarItem (placement: .topBarLeading){
                    Button {
                        
                    }label: {
                        Image(systemName: "bubble")
                            .foregroundStyle(.black)
                    }
                }
                // trailing
                ToolbarItem (placement: .topBarTrailing){
                    Button {
                        
                    }label: {
                        ZStack {
                            Circle()
                                .fill(.blue)
                                .frame(width: 34, height: 34)
                            Text("A")
                                .font(.title3)
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    VendoredGeminiHomeView()
}

