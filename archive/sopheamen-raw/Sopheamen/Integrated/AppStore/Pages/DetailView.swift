//
//  DetailView.swift
//  Youtube_Appstore
//
//  Created by Sopheamen VAN on 25/9/24.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    var article: ArticleResponse
    // trigger back button
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            ZStack (alignment: .topTrailing){
                // content as scrollable
                switch article.type {
                case 1:
                    FeaturedAndHightLightView(article: article)
                case 2:
                    ListIconsDetailView(article: article)
                case 3:
                    FeaturedAndHightLightView(article: article)
                default:
                    EmptyView()
                }
                // close button
                Button {
                    dismiss()
                }label: {
                    ZStack {
                        Circle()
                            .fill(.black.opacity(0.7))
                            .frame(width: 35, height: 35)
                        Image(systemName: "xmark")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.horizontal)
                .offset(x: 0, y: -25)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    DetailView(article: articleData[1])
}

struct FeaturedAndHightLightView:View {
    var article: ArticleResponse
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    // image
                    Image(article.image)
                        .resizable()
                        .scaledToFill()
                    // title and icons
                    VStack {
                        Spacer()
                        Text(article.title)
                            .font(.title)
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        // icon
                        // icons list
                        HStack (spacing:10){
                            if let app = article.appInfo.first {
                                KFImage(URL(string: app.image))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                VStack (alignment: .leading, spacing: 0){
                                    Text(app.name)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(app.category)
                                        .font(.subheadline)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                                Spacer()
                                Button {
                                    
                                }label: {
                                    Text(app.label)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 24)
                                        .foregroundStyle(Color.primaryColor)
                                        .background(Color.buttonGrayColor)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                                
                            }
                            }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        .background(.black.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                // description
                Text(article.description)
                    .font(.headline)
                    .fontWeight(.regular)
                    .padding(.horizontal)
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct ListIconsDetailView:View {
    var article: ArticleResponse
    var body: some View {
        ScrollView {
            VStack (spacing: 20){
                Text(article.header ?? "")
                    .font(.title)
                    .foregroundStyle(.black)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                // icons
                VStack {
                    ForEach(article.appInfo) { app in
                        // icons list
                        HStack (spacing:12){
                            
                                KFImage(URL(string: app.image))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                VStack (alignment: .leading, spacing: 0){
                                    Text(app.name)
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                    Text(app.category)
                                        .font(.subheadline)
                                        .foregroundStyle(.black.opacity(0.5))
                                }
                                Spacer()
                                Button {
                                    
                                }label: {
                                    Text(app.label)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 24)
                                        .foregroundStyle(Color.primaryColor)
                                        .background(Color.buttonGrayColor)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                                
                            
                        }
                       
                    }
                }
                // description
                Text(article.description)
                    .font(.headline)
                    .fontWeight(.regular)
                
            }
            .padding(.vertical, 20)
            .padding(.horizontal)
        }
        
    }
}
