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
    "video_6": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
    "video_7": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
    "video_8": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
    "video_9": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
    "video_10": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
    "video_11": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
    "video_12": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
    "video_13": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4",
    "video_14": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "video_15": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "video_16": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    "video_17": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
    "video_18": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
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
