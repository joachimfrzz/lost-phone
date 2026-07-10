//
//  VendoredNetflixHomeView.swift
//  Youtube_Netflix
//
//  Created by Sopheamen VAN on 2/9/24.
//

import SwiftUI

struct VendoredNetflixHomeView: View {
    @State private var showProfile = false
    @State private var selectedProfile = "Alex"

    private let profiles = [
        ("Alex", "A", Color.red),
        ("Kids", "K", Color.blue),
        ("Guest", "G", Color.green),
        ("Add", "+", Color.gray)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                // content here
                VStack (spacing: 20){
                    VendoredNetflixFeaturedView()
                    VendoredNetflixMadeInKoreanView()
                    VendoredNetflixSciFiView()
                    VendoredNetflixComedyView()
                    VendoredNetflixOnlyinNetflixView()
                    VendoredNetflixAnimationView()
                    VendoredNetflixActionMovieView()
                }
            }
            // set to dark theme
            .preferredColorScheme(.dark)
            // set name and icons trailing
            .toolbar {
                ToolbarItem (placement: .topBarLeading){
                    Text("For \(selectedProfile)")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                }
                // trailing icons
                ToolbarItem (placement: .topBarTrailing){
                    HStack (spacing: 14){
                        Button {
                            showProfile = true
                        }label: {
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
                VStack(spacing: 24) {
                    Text("Who's watching?")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.top, 24)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(profiles, id: \.0) { profile in
                            Button {
                                if profile.0 != "Add" {
                                    selectedProfile = profile.0
                                    showProfile = false
                                }
                            } label: {
                                VStack(spacing: 10) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(profile.2.opacity(0.85))
                                            .frame(width: 90, height: 90)
                                        Text(profile.1)
                                            .font(.largeTitle)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                    }
                                    .overlay {
                                        if selectedProfile == profile.0 {
                                            RoundedRectangle(cornerRadius: 4)
                                                .stroke(.white, lineWidth: 2)
                                                .frame(width: 90, height: 90)
                                        }
                                    }
                                    Text(profile.0)
                                        .font(.subheadline)
                                        .foregroundStyle(.white.opacity(0.85))
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 32)

                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .navigationTitle("Profiles")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") { showProfile = false }
                            .foregroundStyle(.white)
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    VendoredNetflixHomeView()
}

struct VendoredNetflixFeaturedView:View {
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

struct VendoredNetflixMadeInKoreanView:View {
    // movies and korean
    var movies:[VendoredNetflixMovieResponse] = koreanMovieData
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
                        NavigationLink(destination: VendoredNetflixDetailView(movie: movie)) {
                            VendoredNetflixMovieRowView(movie: movie)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct VendoredNetflixSciFiView:View {
    // movies and korean
    var movies:[VendoredNetflixMovieResponse] = sciFiFantasyMovieData
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
                        NavigationLink(destination: VendoredNetflixDetailView(movie: movie)) {
                            VendoredNetflixMovieRowView(movie: movie)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct VendoredNetflixComedyView:View {
    // movies and korean
    var movies:[VendoredNetflixMovieResponse] = comedyMovieData
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
                        NavigationLink(destination: VendoredNetflixDetailView(movie: movie)) {
                            VendoredNetflixMovieRowView(movie: movie)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct VendoredNetflixOnlyinNetflixView:View {
    // movies and korean
    var movies:[VendoredNetflixMovieResponse] = netflixOriginalData
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
                       
                        NavigationLink(destination: VendoredNetflixDetailView(movie: movie)) {
                            VendoredNetflixMovieRowView(movie: movie, width: 180, height: 260)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct VendoredNetflixAnimationView:View {
    // movies and korean
    var movies:[VendoredNetflixMovieResponse] = animatedMovieData
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
                        NavigationLink(destination: VendoredNetflixDetailView(movie: movie)) {
                            VendoredNetflixMovieRowView(movie: movie)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct VendoredNetflixActionMovieView:View {
    // movies and korean
    var movies:[VendoredNetflixMovieResponse] = actionMovieData
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
                        NavigationLink(destination: VendoredNetflixDetailView(movie: movie)) {
                            VendoredNetflixMovieRowView(movie: movie)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

