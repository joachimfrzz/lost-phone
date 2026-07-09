//
//  VendoredAppStoreMainView.swift
//  Youtube_Appstore
//
//  Created by Sopheamen VAN on 18/9/24.
//

import SwiftUI

struct VendoredAppStoreArticle:Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var imageUrl: String
}


var articleDatas = [
        VendoredAppStoreArticle(title: "SwiftUI Basics", description: "Learn the foundations of SwiftUI.", imageUrl: "img_1"),
        VendoredAppStoreArticle(title: "Understanding Combine", description: "Explore reactive programming with Combine.", imageUrl: "img_2"),
        VendoredAppStoreArticle(title: "iOS 17 Features", description: "Discover new updates and features in iOS 17.", imageUrl: "img_3"),
        VendoredAppStoreArticle(title: "Animations in SwiftUI", description: "Master animation techniques in SwiftUI.", imageUrl: "img_4"),
        VendoredAppStoreArticle(title: "Building Custom Views", description: "Create and design custom views in SwiftUI.", imageUrl: "img_5")
    ]

struct VendoredAppStoreMainView: View {
    var datas:[VendoredAppStoreArticle] = articleDatas
    @Namespace var heroTransition
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(datas) { article in
                        if #available(iOS 18.0, *) {
                            NavigationLink {
                                VendoredAppStoreZoomView(article: article)
                                    .navigationTransition(.zoom(sourceID: article.id, in: heroTransition))
                            }label: {
                                VendoredAppStoreItemView(article: article)
                            }
                            .matchedTransitionSource(id: article.id, in: heroTransition)
                        } else {
                            // Fallback on earlier versions
                        }
                        
                    }
                }
            }
        }
    }
}

#Preview {
    VendoredAppStoreMainView()
}

struct VendoredAppStoreItemView:View {
    var article:VendoredAppStoreArticle
    var body: some View {
        ZStack (alignment: .bottomLeading){
            Image(article.imageUrl)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 450)
                .clipped()
            VStack (alignment: .leading){
                Text(article.title)
                    .font(.title)
                    .foregroundStyle(.white)
                Text(article.description)
                    .foregroundStyle(.white)
            }
            .padding(.leading)
            .padding(.bottom)
        }
    }
}

//extension AnyTransition {
//    static func scale(scale: CGFloat) -> AnyTransition {
//        .modifier(
//            active: VendoredAppStoreScaleModifier(scale: scale),
//            identity: VendoredAppStoreScaleModifier(scale: 1.0)
//        )
//    }
//}
//
//struct VendoredAppStoreScaleModifier: ViewModifier {
//    var scale: CGFloat
//
//    func body(content: Content) -> some View {
//        content
//            .scaleEffect(scale)
//            .animation(.easeInOut, value: scale) // You can customize the animation here
//    }
//}

// Custom transition using AnyTransition
extension AnyTransition {
    static var customScale: AnyTransition {
        .modifier(
            active: VendoredAppStoreScaleModifier(scale: 0.5),
            identity: VendoredAppStoreScaleModifier(scale: 1.0)
        )
    }
}

// ViewModifier to scale the view
struct VendoredAppStoreScaleModifier: ViewModifier {
    var scale: CGFloat

    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .animation(.easeInOut, value: scale) // Customize the animation here
    }
}
