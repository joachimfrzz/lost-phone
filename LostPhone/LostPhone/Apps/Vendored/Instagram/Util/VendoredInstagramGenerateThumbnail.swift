//
//  generateThumbnail.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 1/4/24.
//
import AVFoundation
import UIKit

func generateThumbnail(from videoURL: URL, at time: TimeInterval = 1.0, completion: @escaping (UIImage?) -> Void) {
    DispatchQueue.global().async {
        let asset = AVAsset(url: videoURL)
        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
        
        assetImageGenerator.appliesPreferredTrackTransform = true
        assetImageGenerator.requestedTimeToleranceAfter = .zero
        assetImageGenerator.requestedTimeToleranceBefore = .zero
        
        let cmTime = CMTime(seconds: time, preferredTimescale: 60)
        
        do {
            let thumbnailCGImage = try assetImageGenerator.copyCGImage(at: cmTime, actualTime: nil)
            let uiImage = UIImage(cgImage: thumbnailCGImage)
            DispatchQueue.main.async {
                completion(uiImage)
            }
        } catch {
            print("Error generating thumbnail: \(error)")
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
}
