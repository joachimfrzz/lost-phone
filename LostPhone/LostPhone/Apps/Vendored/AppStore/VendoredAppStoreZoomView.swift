//
//  VendoredAppStoreZoomView.swift
//  Youtube_Appstore
//
//  Created by Sopheamen VAN on 18/9/24.
//

import SwiftUI

struct VendoredAppStoreZoomView: View {
    @Environment(\.dismiss) var dismis
    
    var article:VendoredAppStoreArticle
    var body: some View {
        NavigationStack {
            ZStack (alignment: .topTrailing){
                // content scroll
                ScrollView {
                    VStack {
                        Image(article.imageUrl)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 450)
                            .clipped()
                        VStack (alignment: .leading){
                            Text(article.title)
                                .font(.title)
                            Text(article.description)
                                .font(.headline)
                                .fontWeight(.regular)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        
                    }
                }
                
                // close button
                Button {
                    dismis()
                }label: {
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 40, height: 40)
                        Image(systemName: "xmark")
                            .foregroundStyle(.black)
                    }
                }
                .padding(.all, 20)
                
                
            }
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea(.all)
           
        }
    }
}

#Preview {
    VendoredAppStoreZoomView(article: articleDatas[0])
}
