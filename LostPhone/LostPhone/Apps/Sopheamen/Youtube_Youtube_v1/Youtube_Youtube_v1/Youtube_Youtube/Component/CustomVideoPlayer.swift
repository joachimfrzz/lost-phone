//
//  CustomVideoPlayer.swift
//  Youtube_Youtube
//
//  Created by Sopheamen VAN on 16/10/24.
//

import SwiftUI
import AVKit

struct CustomVideoPlayer: UIViewControllerRepresentable {
    var videoFileName: String // Full path of the video file, including the folder

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = AVPlayerViewController()

        if let url = Bundle.main.url(forResource: videoFileName, withExtension: "mp4") {
            let player = AVPlayer(url: url)
            controller.player = player
        }

        controller.showsPlaybackControls = false
        controller.exitsFullScreenWhenPlaybackEnds = true
        controller.allowsPictureInPicturePlayback = true
        controller.videoGravity = .resizeAspectFill

        // Add observer to replay when video ends
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: controller.player?.currentItem,
            queue: .main
        ) { [weak controller] _ in
            controller?.player?.seek(to: .zero, completionHandler: { _ in
                controller?.player?.play()
            })
        }

        // Start playing the video
        controller.player?.play()

        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // No need to update the player
    }
}
