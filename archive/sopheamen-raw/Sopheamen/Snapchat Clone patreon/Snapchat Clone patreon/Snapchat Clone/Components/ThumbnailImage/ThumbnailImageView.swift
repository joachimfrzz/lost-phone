//
//  ThumbnailImageView.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 20/5/24.
//

import SwiftUI

struct ThumbnailImageView: View {
    let videoURL: URL
    let width, height: CGFloat?
    @State private var thumbnailImage: UIImage?
    
    var body: some View {
        Group {
            if let thumbnailImage = thumbnailImage {
                Image(uiImage: thumbnailImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
                    
            } else {
                Rectangle()
                    .fill(Color.primaryColor)
                    .frame(width: width, height: height)
                    .onAppear {
                        generateThumbnail(from: videoURL) { image in
                            self.thumbnailImage = image
                        }
                    }
            }
        }
    }
}

#Preview {
    ThumbnailImageView(videoURL: URL(string: "https://private-user-images.githubusercontent.com/16510597/331929742-0dff9a4a-3881-4a6a-bcae-c9a5c768264d.mp4?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MTYxNzQzMzEsIm5iZiI6MTcxNjE3NDAzMSwicGF0aCI6Ii8xNjUxMDU5Ny8zMzE5Mjk3NDItMGRmZjlhNGEtMzg4MS00YTZhLWJjYWUtYzlhNWM3NjgyNjRkLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDA1MjAlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQwNTIwVDAzMDAzMVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTEzYzU2MmZjZjNjZTE4N2NlYTIwNTAzYjQyODE1YWQxZDdiNmE4MWExMDIxOTFmMmI1ZDU0ZDdmYThmMTUzMDQmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.H41rChLx27ZPgzLvGFutmDKbEC8qUyhFfyl0mML1VKg")!,width: 140, height: 140)
}
