//
//  CameraPreview.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 27/5/24.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    class Coordinator: NSObject {
        var parent: CameraPreview

        init(parent: CameraPreview) {
            self.parent = parent
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        let session = AVCaptureSession()
        session.sessionPreset = .photo

        guard let camera = AVCaptureDevice.default(for: .video) else {
            print("Failed to get the camera device")
            return view
        }

        do {
            let input = try AVCaptureDeviceInput(device: camera)
            if session.canAddInput(input) {
                session.addInput(input)
            } else {
                print("Failed to add camera input to session")
            }

            let previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer.frame = view.layer.bounds
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer)

            session.startRunning()
        } catch {
            print("Error setting up camera input: \(error)")
        }

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
