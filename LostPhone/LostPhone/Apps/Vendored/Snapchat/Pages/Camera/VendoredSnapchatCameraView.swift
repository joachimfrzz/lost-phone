//
//  VendoredSnapchatCameraView.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 18/5/24.
//

import SwiftUI
import Kingfisher
import AVFoundation

struct VendoredSnapchatCameraView: View {
    @State private var isCameraActive = true
    @State private var permissionDenied = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if isCameraActive && !permissionDenied {
                    CameraPreview()
                        .edgesIgnoringSafeArea(.all)
                } else if permissionDenied {
                    Text("Camera permission denied. Please enable it in settings.")
                        .padding()
                        .multilineTextAlignment(.center)
                } else {
                    Color.black.edgesIgnoringSafeArea(.all)
                }
            
                
                // load content icons
                VStack {
                    VendoredSnapchatProfileAndOptionIconsView()
                    Spacer()
                    VendoredSnapchatBrowsePhotoView()
                        
                }
                .padding(.horizontal)
                .padding(.bottom,10)
                
                
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
                    checkCameraPermission()
        }
        

    }
    // trigger when no permission
    private func checkCameraPermission() {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                isCameraActive = true
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    DispatchQueue.main.async {
                        isCameraActive = granted
                        permissionDenied = !granted
                    }
                }
            default:
                permissionDenied = true
            }
        }
}

#Preview {
    VendoredSnapchatCameraView()
}


struct VendoredSnapchatProfileAndOptionIconsView: View {
    var body: some View {
        HStack (alignment: .top){
            HStack {
                VendoredSnapchatProfileImageView(profileImage: vendoredSnapchatUserDataCurrent.profileImage, size: 35)
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                VendoredSnapchatIconButtonOpacity(iconName: "magnifyingglass")
            }
            Spacer()
             
            HStack (alignment: .top){
                VendoredSnapchatIconButtonOpacity(iconName: "person.fill")
                // icons option
                VStack (spacing:24){
                    Image(systemName: "arrow.triangle.capsulepath")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(.white)
                        .frame(width: 16, height:16)
                        .fontWeight(.bold)
                    Image(systemName: "bolt.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(.white)
                        .frame(width: 16, height:16)
                        .fontWeight(.bold)
                    Image(systemName: "play.rectangle")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(.white)
                        .frame(width: 16, height:16)
                        .fontWeight(.bold)
                    Image(systemName: "music.note")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(.white)
                        .frame(width: 14, height:14)
                        .fontWeight(.bold)
                    VendoredSnapchatIconButtonOpacity(iconName: "plus")
                    
                }
                .padding(.top, 16)
                .padding(.bottom,10)
                .padding(.horizontal,6)
                .background(Color.black.opacity(0.08))
                .padding(.top, 1)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                
            }
            
        }
    }
}

struct VendoredSnapchatBrowsePhotoView:View {
    var body: some View {
        HStack (spacing:30){
            Image(systemName: "photo.on.rectangle.angled")
                .resizable()
                .scaledToFill()
                .foregroundStyle(.white)
                .frame(width: 25, height:25)
                .fontWeight(.bold)
            Circle()
                .fill(.clear)
                .frame(width:75, height:75)
                .overlay(Circle().stroke(.white, lineWidth: 8))
            Image(systemName: "ev.plug.dc.chademo.fill")
                .resizable()
                .scaledToFill()
                .foregroundStyle(.white)
                .frame(width: 28, height:28)
                .fontWeight(.bold)
            
        }
        .padding(.vertical)
    }
}



