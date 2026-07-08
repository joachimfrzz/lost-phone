//
//  VendoredInstagramPlayerView.swift
//  Instagram-SwiftUI
//
//  Created by Pankaj Gaikar on 24/05/21.
//

import SwiftUI
import AVKit

protocol ViewLifecycleDelegate {
    func onAppear()
    func onDisappear()
}

struct VendoredInstagramPlayer : UIViewControllerRepresentable {
    
    var player : AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController{
        let view = AVPlayerViewController()
        view.player = player
        view.showsPlaybackControls = false
        view.videoGravity = .resizeAspectFill
        return view
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
}

struct VendoredInstagramPlayerView : View {
    @Binding var videos : [VendoredInstagramVideo]
    let lifecycleDelegate: ViewLifecycleDelegate?
    
    var body: some View{
        VStack(spacing: 0){
            ForEach(0..<self.videos.count){i in
                ZStack{
                    VendoredInstagramPlayer(player: self.videos[i].player)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .offset(y: -5)
                    VendoredInstagramReelInfoView(video: self.videos[i])
                }
            }
        }
        .onAppear {
            self.lifecycleDelegate?.onAppear()
        }
        .onDisappear {
            self.lifecycleDelegate?.onDisappear()
        }
    }
}

struct VendoredInstagramPlayerPageView : UIViewRepresentable {

    func makeCoordinator() -> VendoredInstagramCoordinator {
        return VendoredInstagramPlayerPageView.VendoredInstagramCoordinator(parent1: self)
    }
    
    @Binding var videos : [VendoredInstagramVideo]
    
    func makeUIView(context: Context) -> UIScrollView{
        
        let view = UIScrollView()
        
        let childView = UIHostingController(rootView: VendoredInstagramPlayerView(videos: self.$videos, lifecycleDelegate: context.coordinator))
        childView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((videos.count)))
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((videos.count)))
        
        view.addSubview(childView.view)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        view.isPagingEnabled = true
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        uiView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((videos.count)))
        
        for i in 0..<uiView.subviews.count{
            uiView.subviews[i].frame = CGRect(x: 0, y: 0,width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((videos.count)))
        }
    }
    
    class VendoredInstagramCoordinator : NSObject, UIScrollViewDelegate, ViewLifecycleDelegate{
        
        var parent : VendoredInstagramPlayerPageView
        var index = 0
        init(parent1 : VendoredInstagramPlayerPageView) {
            parent = parent1
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let currentindex = Int(scrollView.contentOffset.y / UIScreen.main.bounds.height)
            
            if index != currentindex{
                parent.videos[index].player.seek(to: .zero)
                parent.videos[index].player.pause()
                index = currentindex
                parent.videos[index].player.play()
                parent.videos[index].player.actionAtItemEnd = .none
                NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: parent.videos[index].player.currentItem, queue: .main) { (_) in
                    self.parent.videos[self.index].player.seek(to: .zero)
                    self.parent.videos[self.index].player.play()
                }
            }
        }
        
        func onAppear() {
            parent.videos[self.index].player.seek(to: .zero)
            parent.videos[self.index].player.play()
        }
        
        func onDisappear() {
            parent.videos[self.index].player.seek(to: .zero)
            parent.videos[self.index].player.pause()
        }

    }
}
