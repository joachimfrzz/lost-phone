//
//  TimeLineView.swift
//  Instagram-SwiftUI
//
//  Created by Pankaj Gaikar on 03/04/21.
//

import SwiftUI

struct VendoredInstagramTimeLineContainerView: View {
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(VendoredInstagramMockData().stories) {
                            VendoredInstagramStoryView(story: $0)
                        }
                    }
                }
                ForEach(VendoredInstagramMockData().posts) {
                    VendoredInstagramPostView(post: $0, screenWidth: UIScreen.main.bounds.size.width)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("instagram")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .frame(width: 130)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Image(systemName: "plus.app")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.trailing, 10)
                        NavigationLink(destination: VendoredInstagramMessagesContainerView()) {
                            Image(systemName: "message")
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 25, height: 25)
                        }

                    }
                }
            })
        }
    }
}

