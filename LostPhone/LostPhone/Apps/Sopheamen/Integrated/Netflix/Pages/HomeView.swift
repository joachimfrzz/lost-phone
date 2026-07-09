//
//  HomeView.swift
//  Youtube_Netflix
//
//  Created by Sopheamen VAN on 2/9/24.
//

import SwiftUI

struct NetflixHome: View {
    @State private var showProfile = false

    var body: some View {
        NavigationStack {
            ScrollView {
                // content here
                VStack (spacing: 20){
                    FeaturedView()
                    MadeInKoreanView()
                    SciFiView()
                    ComedyView()
                    OnlyinNetflixView()
                    AnimationView()
                    ActionMovieView()
                }
            }
            // set to dark theme
            .preferredColorScheme(.dark)
            // set name and icons trailing
            .toolbar {
                ToolbarItem (placement: .topBarLeading){
                    Text("For Alex")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                }
                // trailing icons
                ToolbarItem (placement: .topBarTrailing){
                    HStack (spacing: 14){
                        Button { showProfile = true }label: {
                            Image(systemName: "person.crop.circle")
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        Button {
                            
                        }label: {
                            Image(systemName: "magnifyingglass")
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                    }
                    
                }
            }
        }
        .sheet(isPresented: $showProfile) {
            NavigationStack {
                List {
                    Text("Alex — profil principal")
                    Text("Historique de visionnage")
                    Text("Ma liste")
                }
                .navigationTitle("Profil")
            }
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    NetflixHome()
}

struct FeaturedView:View {
    var body: some View {
        ZStack {
            // image
            Image("featured")
                .resizable()
                .scaledToFill()
                .frame(height: 480)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            // overlay black
            Rectangle()
                .fill(.black.opacity(0.2))
                .frame(height: 480)
            // info
            VStack {
                Spacer()
                Text("SUITS")
                    .font(.system(size: 60))
                    .fontWeight(.semibold)
                Text("Slick - Witly - Dramedy")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                // buttons
                HStack (spacing: 14){
                    Button {
                        
                    }label: {
                        HStack(spacing: 12){
                            Image(systemName: "play.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 18, height: 18)
                                .foregroundStyle(.black)
                            Text("Play")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                        }
                        .frame(width: 150, height: 45)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                    
                    Button {
                        
                    }label: {
                        HStack(spacing: 12){
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 16, height: 16)
                                .foregroundStyle(.white)
                            Text("My List")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                        }
                        .frame(width: 150, height: 45)
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                }
            }
            .padding(.bottom)
        }
        .padding(.vertical)
        .padding(.horizontal, 25)
    }
}

struct MadeInKoreanView:View {
    // movies and korean
    var movies:[MovieResponse] = koreanMovieData
    var body: some View {
        VStack (alignment: .leading, spacing: 6){
            Text("Made in Korean")
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            // list and scrollable
            ScrollView (.horizontal, showsIndicators: false){
                LazyHStack() {
                    ForEach(movies) { movie in
                        NavigationLink(destination: DetailView(movie: movie)) {
                            MovieRowView(movie: movie)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct SciFiView:View {
    // movies and korean
    var movies:[MovieResponse] = sciFiFantasyMovieData
    var body: some View {
        VStack (alignment: .leading, spacing: 6){
            Text("Sci-Fi & Fantasy")
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            // list and scrollable
            ScrollView (.horizontal, showsIndicators: false){
                LazyHStack() {
                    ForEach(movies) { movie in
                        NavigationLink(destination: DetailView(movie: movie)) {
                            MovieRowView(movie: movie)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ComedyView:View {
    // movies and korean
    var movies:[MovieResponse] = comedyMovieData
    var body: some View {
        VStack (alignment: .leading, spacing: 6){
            Text("Comedy Movies")
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            // list and scrollable
            ScrollView (.horizontal, showsIndicators: false){
                LazyHStack() {
                    ForEach(movies) { movie in
                        NavigationLink(destination: DetailView(movie: movie)) {
                            MovieRowView(movie: movie)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct OnlyinNetflixView:View {
    // movies and korean
    var movies:[MovieResponse] = netflixOriginalData
    var body: some View {
        VStack (alignment: .leading, spacing: 6){
            Text("Only in Netflix")
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            // list and scrollable
            ScrollView (.horizontal, showsIndicators: false){
                LazyHStack() {
                    ForEach(movies) { movie in
                       
                        NavigationLink(destination: DetailView(movie: movie)) {
                            MovieRowView(movie: movie, width: 180, height: 260)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct AnimationView:View {
    // movies and korean
    var movies:[MovieResponse] = animatedMovieData
    var body: some View {
        VStack (alignment: .leading, spacing: 6){
            Text("Animation")
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            // list and scrollable
            ScrollView (.horizontal, showsIndicators: false){
                LazyHStack() {
                    ForEach(movies) { movie in
                        NavigationLink(destination: DetailView(movie: movie)) {
                            MovieRowView(movie: movie)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ActionMovieView:View {
    // movies and korean
    var movies:[MovieResponse] = actionMovieData
    var body: some View {
        VStack (alignment: .leading, spacing: 6){
            Text("Action Thriller")
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            // list and scrollable
            ScrollView (.horizontal, showsIndicators: false){
                LazyHStack() {
                    ForEach(movies) { movie in
                        NavigationLink(destination: DetailView(movie: movie)) {
                            MovieRowView(movie: movie)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

