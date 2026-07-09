//
//  PostData.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 6/3/24.
//

import Foundation


let postsData: [VendoredInstagramPostResponse] = [
    VendoredInstagramPostResponse(id: 1, user: vendoredInstagramUserData[0], caption: "A beautiful day at the beach! 🏖️", postType: 1, imageOrVideoUrl: [
        "https://images.unsplash.com/photo-1710156958953-329d3531c745?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw5fHx8ZW58MHx8fHx8",
        "https://images.unsplash.com/photo-1660486358484-975da44dc68e?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"], totalLikes: 300, totalComments: 50),
    VendoredInstagramPostResponse(id: 2, user: vendoredInstagramUserData[1], caption: "Exploring the mountains 🏔️ #adventure", postType: 1, imageOrVideoUrl: ["https://images.unsplash.com/photo-1489914169085-9b54fdd8f2a2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.M3wxMjA3fDB8MHxzZWFyY2h8M3x8RXhwbG9yaW5nJTIwdGhlJTIwbW91bnRhaW5zJTIwJUYwJTlGJThGJTk0JUVGJUI4JThGJTIwJTIzYWR2ZW50dXJlfGVufDB8fDB8fHww0.3&ixid="], totalLikes: 450, totalComments: 75),
    VendoredInstagramPostResponse(id: 3, user: vendoredInstagramUserData[0], caption: "My morning coffee ☕ #coffeelover", postType: 1, imageOrVideoUrl: ["https://images.unsplash.com/photo-1495862433577-132cf20d7902?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fE15JTIwbW9ybmluZyUyMGNvZmZlZSUyMCVFMiU5OCU5NSUyMCUyM2NvZmZlZWxvdmVyfGVufDB8fDB8fHww"], totalLikes: 200, totalComments: 30),
    VendoredInstagramPostResponse(id: 4, user: vendoredInstagramUserData[2], caption: "Sunset vibes 🌇 #photography", postType: 1, imageOrVideoUrl: ["https://images.unsplash.com/photo-1494548162494-384bba4ab999?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8U3Vuc2V0JTIwdmliZXMlMjAlRjAlOUYlOEMlODclMjAlMjNwaG90b2dyYXBoeXxlbnwwfHwwfHx8MA%3D%3D"], totalLikes: 500, totalComments: 90),
    VendoredInstagramPostResponse(id: 5, user: vendoredInstagramUserData[0], caption: "Check out this cool video I made! 🎥", postType: 2, imageOrVideoUrl: ["https://player.vimeo.com/external/644279979.sd.mp4?s=c222aa8d0ffb0de11c057e3f805960a37616d03e&profile_id=165&oauth_token_id=57447761"], totalLikes: 600, totalComments: 120),
    VendoredInstagramPostResponse(id: 6, user: vendoredInstagramUserData[0], caption: "New recipe tried today! 🍲 #Foodie", postType: 1, imageOrVideoUrl: ["https://images.pexels.com/photos/7538074/pexels-photo-7538074.jpeg?auto=compress&cs=tinysrgb&w=600"], totalLikes: 320, totalComments: 45),
    VendoredInstagramPostResponse(id: 7, user: vendoredInstagramUserData[1], caption: "Nothing beats a good book on a rainy day 📚 #BookLover", postType: 1, imageOrVideoUrl: ["https://images.pexels.com/photos/6001171/pexels-photo-6001171.jpeg?auto=compress&cs=tinysrgb&w=600"], totalLikes: 275, totalComments: 65),
    VendoredInstagramPostResponse(id: 8, user: vendoredInstagramUserData[0], caption: "Let the music play! 🎶 #LiveConcert", postType: 2, imageOrVideoUrl: ["https://player.vimeo.com/external/521787962.hd.mp4?s=c886caa69e529026d24607bfca3709cb8a14dde4&profile_id=174&oauth2_token_id=57447761"], totalLikes: 400, totalComments: 85),
    VendoredInstagramPostResponse(id: 9, user: vendoredInstagramUserData[4], caption: "Back to nature 🌿 #HikingAdventures", postType: 1, imageOrVideoUrl: ["https://images.pexels.com/photos/7215477/pexels-photo-7215477.jpeg?auto=compress&cs=tinysrgb&w=600"], totalLikes: 520, totalComments: 98),
    VendoredInstagramPostResponse(id: 10, user: vendoredInstagramUserData[5], caption: "City lights and starry nights 🌃 #Cityscape", postType: 1, imageOrVideoUrl: ["https://images.pexels.com/photos/2787074/pexels-photo-2787074.jpeg?auto=compress&cs=tinysrgb&w=600"], totalLikes: 412, totalComments: 100),
]


