//
//  DetailView.swift
//  Youtube_Threads
//
//  Created by Sopheamen VAN on 26/9/24.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    var post:PostResponse
    var body: some View {
        NavigationStack {
            VStack {
                // close and option button
                CloseAndOptionView()
                Spacer()
                // images scrollable
                ImagesScrollableView(post: post)
                Spacer()
                // button options action
                ButtonOptionsView(post: post)
                    .padding(.vertical, 20)
            }
            .navigationBarBackButtonHidden(true)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    DetailView(post: postData[0])
}

struct CloseAndOptionView:View {
    // trigger back button to close the detail view
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack {
            // close button
            Button {
                dismiss()
            }label: {
                ZStack {
                    Circle()
                        .fill(Color.grayColor)
                        .frame(width: 40, height: 40)
                    Image(systemName: "xmark")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
            }
            Spacer()
            // option button
            Button {
                
            }label: {
                Image(systemName: "ellipsis")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }
            
        }
        .padding(.horizontal)
    }
}

struct ImagesScrollableView:View {
    // get width
    var width = UIScreen.main.bounds.width
    // select index to slide
    @State private var selectedTabIndex = 0
    
    var post:PostResponse
    var body: some View {
        TabView (selection: $selectedTabIndex){
            ForEach(post.imagesUrl, id: \.self) { image in
                KFImage(URL(string: image))
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: 550)
                    .tag(image)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: 550)
    }
}
