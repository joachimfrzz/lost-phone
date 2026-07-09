//
//  NewPostView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 2/4/24.
//

import SwiftUI
import Photos

struct VendoredInstagramBrowseGalleryView: View {
    @Environment(\.dismiss)  var dismiss
    @State private var selectedImages: [UIImage] = []
    @State private var displayImage: UIImage?
    
    
    
    let height = ((UIScreen.main.bounds.height - 140) / 2)
    
      let columns:[GridItem] = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]
    let size = (UIScreen.main.bounds.width / 3) - 2
    
    let tabsPosts = ["POST", "STORY", "REEL", "LIVE"]
    
    var body: some View {
        NavigationStack {
            VStack {
                if selectedImages.isEmpty {
                    Text("No images selected")
                        .onAppear(perform: loadImages)
                } else {
                    VStack {
                        // display main photo view
                        Image(uiImage: displayImage ?? selectedImages[0])
                            .resizable()
                            .scaledToFit()
                            .frame(height: height)
                        
                        
                        HStack {
                            HStack (spacing: 7){
                                Text("Recents")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                
                                Image(systemName: "chevron.down")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:13, height: 13)
                                    .padding(.top, 2)
                            }
                            Spacer()
                            HStack (spacing: 10){
                                HStack {
                                    Image("photo_collection_icon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:15, height: 15)
                                        
                                    Text("Select multiple")
                                        .font(.subheadline)
                                        .foregroundStyle(.white)
                                }
                                .padding(.vertical, 6)
                                .padding(.horizontal, 12)
                                .background(.white.opacity(0.15))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                
                                Image(systemName: "camera")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:20, height: 20)
                                    .padding(.all, 8)
                                    .background(.white.opacity(0.15))
                                    .clipShape(Circle())
                                    
                            }
                        }
                        .frame(height: 36)
                        .padding(.horizontal)
                       
                        Spacer()
                        // grid photos view
                        ZStack (alignment: .bottomTrailing){
                            ScrollView (showsIndicators: false){
                                LazyVGrid(columns: columns, spacing: 2){
                                    ForEach(selectedImages, id: \.self) { image in
                                        Button {
                                            displayImage = image
                                        }label: {
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: size, height: size)
                                                .clipped()
                                        }
                                    
                                        
                                    }
                                }
                            }
                            // post tab
                            HStack (spacing: 12){
                                ForEach(tabsPosts, id: \.self) { item in
                                    Text(item)
                                        .font(.subheadline)
                                        .foregroundStyle(.white)
                                    
                                }
                            }
                            .padding(.vertical,10)
                            .padding(.horizontal,20)
                            .background(.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .padding()
                        }
                    }

                }
            }
            .navigationBarTitle("New post", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.white)
                          
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    NavigationLink(destination: VendoredInstagramUploadView(displayImage: displayImage)) {
                        Text("Next")
                            .font(.headline)
                            .foregroundStyle(Color.vendoredInstagramVendoredInstagramPrimary)
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .colorScheme(.dark)
        
    }
    private func loadImages() {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .notDetermined {
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized {
                    self.fetchImages()
                }
            }
        } else if status == .authorized {
            self.fetchImages()
        }
    }
        
    
    private func fetchImages() {
            // Fetch the images from the photo library
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            fetchOptions.fetchLimit = 24

            let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)

            let imageManager = PHCachingImageManager()

            fetchResult.enumerateObjects { asset, _, _ in
                let targetSize = CGSize(width: 300, height: 300)
                let options = PHImageRequestOptions()
                options.isSynchronous = false
                options.deliveryMode = .highQualityFormat

                imageManager.requestImage(for: asset,
                                          targetSize: targetSize,
                                          contentMode: .aspectFit,
                                          options: options) { image, _ in
                    if let image = image {
                        DispatchQueue.main.async {
                            self.selectedImages.append(image)
                        }
                    }
                }
            }
        }
}



#Preview {
    VendoredInstagramBrowseGalleryView()
}
