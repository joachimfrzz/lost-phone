//
//  HomeView.swift
//  Youtube_Appstore
//
//  Created by Sopheamen VAN on 25/9/24.
//

import SwiftUI
// import image network cache
import Kingfisher

struct HomeView: View {
    // get dummy feed data
    var articleDatas:[ArticleResponse] = articleData
    // transition zoom
    @Namespace var transitionAnimation
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing:10){
                    // info and profile
                    InfoAndProfileView()
                    // list feed
                    LazyVStack (spacing: 20){
                        ForEach(articleDatas) { article in
                            // three type, 1 as featured, 2 list icons, 3 hightlight
                            switch article.type {
                            case 1:
                                // check if ios 18 else ios 17
                                if #available(iOS 18.0, *) {
                                    NavigationLink (destination: DetailView(article: article)
                                        .navigationTransition(.zoom(sourceID: article.id, in: transitionAnimation))
                                    ){
                                        FeaturedView(article: article)
                                    }
                                } else {
                                    NavigationLink (destination: DetailView(article: article)){
                                        FeaturedView(article: article)
                                    }
                                }
                                
                            case 2:
                                if #available(iOS 18.0, *) {
                                    NavigationLink (destination: DetailView(article: article)
                                        .navigationTransition(.zoom(sourceID: article.id, in: transitionAnimation))
                                    ){
                                        ListIconsView(article: article)
                                    }
                                } else {
                                    NavigationLink (destination: DetailView(article: article)){
                                        ListIconsView(article: article)
                                    }
                                }
                                
                            case 3:
                                if #available(iOS 18.0, *) {
                                    NavigationLink (destination: DetailView(article: article)
                                        .navigationTransition(.zoom(sourceID: article.id, in: transitionAnimation))
                                    ){
                                        HightLightView(article: article)
                                    }
                                } else {
                                    NavigationLink (destination: DetailView(article: article)){
                                        HightLightView(article: article)
                                    }
                                }
                               
                            default:
                                EmptyView()
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

struct InfoAndProfileView:View {
    var body: some View {
        HStack (alignment: .center){
            Text("Today")
                .font(.title)
                .fontWeight(.semibold)
            Text("25 September 2024")
                .font(.headline)
                .foregroundStyle(.gray)
                .padding(.top, 6)
            Spacer()
            
            KFImage(URL(string: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHByb2ZpbGV8ZW58MHx8MHx8fDA%3D"))
                .resizable()
                .scaledToFill()
                .frame(width: 35, height: 35)
                .clipShape(Circle())
        }
        .padding(.horizontal)
    }
}

struct FeaturedView:View {
    var article:ArticleResponse
    var body: some View {
        VStack (spacing:12){
            Text(article.header ?? "")
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.black)
            // image and info
            ZStack {
                // image
                Image(article.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 400)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                // info
                VStack {
                    Spacer()
                    VStack (alignment: .leading){
                        Text("Get started")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .textCase(.uppercase)
                            .foregroundStyle(.white.opacity(0.5))
                        Text(article.title)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // icons list
                    HStack (spacing:10){
                        ForEach(article.appInfo) { app in
                            KFImage(URL(string: app.image))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(.black.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
        }
    }
}

struct ListIconsView:View {
    var article:ArticleResponse
    var body: some View {
        VStack (spacing:12){
            // content title and list icons
            if !article.title.isEmpty {
                Text(article.title)
                    .font(.title2)
                    .foregroundStyle(.black)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            // list icons
            VStack (spacing: 12){
                ForEach(article.appInfo) { app in
                    HStack (spacing: 12){
                        KFImage(URL(string: app.image))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        VStack (alignment: .leading, spacing: 0){
                            Text(app.name)
                                .font(.headline)
                                .foregroundStyle(.black)
                            Text(app.category)
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        VStack (spacing:0){
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
                            // text
                            Text("In-App Purchases")
                                .font(.caption2)
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color:.gray.opacity(0.4),radius: 15)
    }
}

struct HightLightView:View {
    var article:ArticleResponse
    var body: some View {
        VStack (spacing:12){
            Text(article.header ?? "")
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.black)
            // image and info
            ZStack {
                // image
                Image(article.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 400)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                // info
                VStack {
                    Spacer()
                    VStack (alignment: .leading){
                        Text("Get started")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .textCase(.uppercase)
                            .foregroundStyle(.white.opacity(0.5))
                        Text(article.title)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // icons list
                    HStack (spacing:10){
                        ForEach(article.appInfo) { app in
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
        }
    }
}



