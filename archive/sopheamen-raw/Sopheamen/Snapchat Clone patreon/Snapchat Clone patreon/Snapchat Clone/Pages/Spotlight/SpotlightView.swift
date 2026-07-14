//
//  SpotlightView.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 23/5/24.
//

import SwiftUI
import AVFoundation

struct SpotlightView: View {
    var storiesDatas:[StoriesResponse] = storiesData
    @State private var scrollPosition: String?
    @State private var player = AVPlayer()
    
    var body: some View {
        NavigationStack {
            ScrollView (showsIndicators: false){
                LazyVStack(spacing: 0){
                    ForEach (storiesDatas) { stories in
                        SpotlightVideoView(story: stories, player: player)
                            .id(stories.id)
                            .onAppear { playInitVideoIfNecessary() }
                            .onTapGesture {
                                switch player.timeControlStatus {
                                case .paused:
                                    player.play()
                                case .waitingToPlayAtSpecifiedRate:
                                    break
                                case .playing:
                                    player.pause()
                                @unknown default:
                                    break
                                }
                            }
                        
                    }
                }
                .scrollTargetLayout()
            }
            .onAppear { player.play() }
            .scrollPosition(id: $scrollPosition)
            .scrollTargetBehavior(.paging)
            .ignoresSafeArea()
            .onChange(of: scrollPosition) { oldValue, newValue in
                playVideoOnChangeOfScrollPosition(postId: newValue)
            }
            
            
        }
    }
    func playInitVideoIfNecessary() {
        guard scrollPosition == nil,
              let post = storiesDatas.first,
              player.currentItem == nil else { return }
        let item = AVPlayerItem(url: URL(string: post.videoUrl)!)
        player.replaceCurrentItem(with: item)
    }
    
    func playVideoOnChangeOfScrollPosition(postId: String?) {
        guard let currentPost = storiesDatas.first(where: { $0.id == postId }) else { return }
        
        player.replaceCurrentItem(with: nil)
        let playerItem = AVPlayerItem(url: URL(string: currentPost.videoUrl)!)
        player.replaceCurrentItem(with: playerItem)
    }
}

#Preview {
    SpotlightView()
}

struct SpotlightVideoView: View {
    var story: StoriesResponse
    var player: AVPlayer
    
    init(story: StoriesResponse, player: AVPlayer) {
        self.story = story
        self.player = player
    }
    
    var body: some View {
        ZStack {
            // video container
            CustomVideoPlayer(player: player)
                .containerRelativeFrame([.horizontal,.vertical])
//            Rectangle()
//                .containerRelativeFrame([.horizontal,.vertical])
            
            // content views
            InformationView(story: story)
                .padding(.vertical,50)
                .padding(.horizontal)
                .padding(.bottom,50)
            
        }
    }
}

struct InformationView: View {
    var story: StoriesResponse
    var body: some View {
        VStack {
            CustomHeaderView(story: story)
            Spacer()
            CustomFooterView(story: story)
            
        }
    }
}

struct CustomHeaderView:View {
    var story: StoriesResponse
    var body: some View {
        HStack {
            HStack {
                ProfileImageView(profileImage: story.user.profileImage, size: 35)
                    .overlay(Circle().stroke(Color.gray.opacity(0.1), lineWidth: 3))
                IconButton(iconName: "magnifyingglass",iconColor: .white)
            }
           
            Text("Spotlight")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .padding(.trailing, 40)
            
            IconButton(iconName: "line.diagonal.arrow",iconColor: .white)
        }
    }
}

struct CustomFooterView:View {
    var story: StoriesResponse
    var body: some View {
        HStack (alignment: .bottom){
            VStack (alignment: .leading){
                // total likes
                HStack {
                    Image(systemName: "play.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 10, height: 10)
                        .fontWeight(.bold)
                        .padding(.top,3)
                    Text("\(story.totalViews)k")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.white)
                
                // profile image and username
                HStack {
                    ProfileImageView(profileImage: story.user.profileImage, size: 30)
                    Text("@\(story.user.username)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
                
                // song and owner name
                HStack (spacing:14){
                    Image(systemName: "text.justify.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 12, height: 12)
                        .fontWeight(.bold)
                        
                    VStack (alignment: .leading){
                        Text("@\(story.music.ownerName)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text(story.music.musicName)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white.opacity(0.6))
                    }
                }
                .foregroundStyle(.white)
                .padding(.horizontal,14)
                .padding(.vertical,4)
                .background(.white.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
            
            Spacer()
            
            VStack (spacing:20){
                IconButton(iconName: "bookmark.fill",size: 12, iconColor: .white)
                IconButton(iconName: "heart.fill", iconColor: .white)
                IconButton(iconName: "location.fill", iconColor: .white)
                IconButton(iconName: "ellipsis",size: 4, iconColor: .white)
            }
        }
    }
}
