//
//  ArticleData.swift
//  Youtube_Appstore
//
//  Created by Sopheamen VAN on 19/9/24.
//

import Foundation

let articleData = [
    // Featured
    VendoredAppStoreArticleResponse(
        header: "Get Started with iOS 18",
        title: "Explore iOS 18 Features",
        description: "iOS 18 introduces a host of new features designed to give users even more control over their devices, improving both functionality and customization. From upgraded privacy controls that keep your data more secure, to an entirely reimagined Focus Mode, iOS 18 ensures that you can tailor your experience to suit your lifestyle. You can now organize your home screen with widgets, set personalized notification preferences, and enjoy seamless multitasking on a more responsive and efficient platform. Explore the all-new notification system, offering less clutter and more meaningful alerts, as well as improvements in app performance and battery life.",
        image: "img_1",
        type: 1,
        appInfo: appData.dropFirst(12).prefix(6).map { $0 }
    ),
    
    // Type 2: List App Icons
    VendoredAppStoreArticleResponse(
        header: "The Best Apps for iOS 18",
        title: "Top 10 Must-Have Apps",
        description: "With iOS 18, app developers have taken full advantage of the system's new capabilities, offering a range of apps that enhance productivity, entertainment, and social connection. From apps that improve your workflow to the latest entertainment offerings, iOS 18 has something for everyone. Our curated list includes top picks like video streaming services, productivity tools, and social media apps, all optimized for the new iOS. Whether you're a casual user or a tech enthusiast, discover the must-have apps that will help you make the most of your iPhone or iPad in 2024 and beyond.",
        image: "",
        type: 2,
        appInfo: appData.prefix(6).map { $0 }
    ),
    
    VendoredAppStoreArticleResponse(
        header: "Editor's Pick",
        title: "Top Entertainment Apps",
        description: "iOS 18 is the perfect platform for entertainment lovers, with apps that provide the best video and music streaming experiences available. From personalized content recommendations to high-definition streaming and offline access, these entertainment apps are designed to keep you engaged whether you're at home or on the go. Stay updated on the latest releases, create personalized playlists, and download content for offline viewing or listening. With powerful integrations into iOS 18, these apps provide faster load times, higher-quality streaming, and better battery efficiency, ensuring an immersive and seamless entertainment experience.",
        image: "img_2",
        type: 3,
        appInfo: [appData[12]]
    ),
    
    VendoredAppStoreArticleResponse(
        header: nil,
        title: "Top Social Media Apps",
        description: "In today's fast-paced world, staying connected with friends, family, and communities is more important than ever. With iOS 18, social media apps have been enhanced to offer better privacy controls, smoother interfaces, and new features that improve how you communicate and share content. Whether you're posting photos, sharing videos, or just keeping up with the latest trends, these apps will help you stay in touch and stay informed. Discover the most popular social platforms like Instagram, Facebook, Twitter, and TikTok, all optimized for the new features and performance improvements in iOS 18.",
        image: "",
        type: 2,
        appInfo: appData.filter { $0.name == "Instagram" || $0.name == "Facebook" || $0.name == "Twitter" || $0.name == "Snapchat" || $0.name == "TikTok" || $0.name == "WhatsApp" }
    ),
    
    // Type 3: Highlights
    VendoredAppStoreArticleResponse(
        header: "Today's Highlights",
        title: "App of the Day: Instagram",
        description: "TikTok is more than just a social media app; it's a global phenomenon that has transformed the way we consume and create content. With its short-form video format, TikTok allows users to express themselves creatively and connect with a worldwide audience. On iOS 18, TikTok benefits from new features such as smoother playback, enhanced video editing tools, and better integration with iPhone cameras. Whether you're a seasoned content creator or just enjoy watching the latest viral trends, TikTok continues to lead the way in providing fast, fun, and engaging video content.",
        image: "img_3",
        type: 3,
        appInfo: [appData[29]]
    )
]

