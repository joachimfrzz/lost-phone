//
//  VendoredGeminiDetailView.swift
//  Youtube_Gemini_clone
//
//  Created by Sopheamen VAN on 4/2/25.
//

import SwiftUI

struct VendoredGeminiDetailView: View {
    // state and param from home view
    var text:String
    @State private var promptText: String = ""
    
    init(text: String) {
        self.text = text
        _promptText = State(initialValue: text)
    }
    
    // loading
    @State private var isLoading: Bool = false
    // animation and text
    @State private var extractedText:String = ""
    @State private var displayedText:String = ""
    @State private var typingIndex:Int = 0
    
    // back button trigger
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottom){
                // scrollable content
                ScrollView (showsIndicators: false){
                    VStack (spacing:14){
                        // text prompt badge
                        Text(promptText)
                            .font(.headline)
                            .fontWeight(.regular)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 20)
                            .background(Color.vendoredGeminiHightLightColor)
                            .clipShape(Capsule())
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        // loading view
                        if isLoading {
                            VendoredGeminiLoadingView()
                        }else {
                            Text(displayedText)
                                .font(.subheadline)
                                .foregroundStyle(.black)
                                .multilineTextAlignment(.leading)
                        }
                        // content response from api service using gemini
                    }
                    .padding(.top)
                    .padding(.horizontal)
                    .padding(.bottom, 140)
                }
                // floating button
                VendoredGeminiFloatingButtonView(promptText: $promptText)
            }
            // title
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                // title center
                ToolbarItem (placement: .principal){
                    Text(promptText)
                        .font(.headline)
                }
                // leading
                ToolbarItem (placement: .topBarLeading){
                    Button {
                        dismiss()
                    }label: {
                        Image(systemName: "chevron.left")
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
        .onAppear {
            fetchAIContent(with: promptText)
        }
    }
    
    // func to get from api service
    func fetchAIContent(with prompt:String){
        isLoading = true
        VendoredGeminiAIService.fetchAIContent(prompt: prompt) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let text):
                    self.extractedText = text
                    typingAnimation()
                    //
                case .failure(let error):
                    self.extractedText = "Error: \(error)"
                }
            }
        }
    }
    // func for animation typing smooth
    func typingAnimation(){
        typingIndex = 0
        displayedText = ""
        
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
            if typingIndex < extractedText.count {
                displayedText.append(extractedText[extractedText.index(extractedText.startIndex, offsetBy: typingIndex)])
                typingIndex += 1
            }else {
                timer.invalidate()
            }
        }
    }
}

#Preview {
    VendoredGeminiDetailView(text: "flutter code basic?")
}

struct VendoredGeminiLoadingView:View {
    var body: some View {
        VStack (spacing:20){
            Image("loading-icon")
                .resizable()
                .scaledToFill()
                .frame(width: 28, height: 28)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.vendoredGeminiHightLightColor)
                    .frame(maxWidth: .infinity)
                    .frame(height: 18)
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.vendoredGeminiHightLightColor)
                    .frame(width: 200)
                    .frame(height: 18)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
