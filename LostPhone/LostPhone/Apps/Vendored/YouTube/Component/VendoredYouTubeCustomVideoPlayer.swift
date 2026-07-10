//
//  VendoredYouTubeCustomVideoPlayer.swift
//  Youtube_Youtube
//
//  Created by Sopheamen VAN on 16/10/24.
//

import SwiftUI
import AVKit

private let sampleVideoURLs: [String: String] = [
    "video_1": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "video_2": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "video_3": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    "video_4": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
    "video_5": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
]

struct VendoredYouTubeCustomVideoPlayer: UIViewControllerRepresentable {
    var videoFileName: String

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = AVPlayerViewController()
        let url: URL? = {
            if let remote = sampleVideoURLs[videoFileName], let u = URL(string: remote) { return u }
            if videoFileName.hasPrefix("http"), let u = URL(string: videoFileName) { return u }
            return Bundle.main.url(forResource: videoFileName, withExtension: "mp4")
        }()

        if let url {
            let player = AVPlayer(url: url)
            controller.player = player
            player.play()
        }

        controller.showsPlaybackControls = true
        controller.exitsFullScreenWhenPlaybackEnds = true
        controller.allowsPictureInPicturePlayback = true
        controller.videoGravity = .resizeAspectFill

        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: controller.player?.currentItem,
            queue: .main
        ) { [weak controller] _ in
            controller?.player?.seek(to: .zero, completionHandler: { _ in
                controller?.player?.play()
            })
        }

        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
