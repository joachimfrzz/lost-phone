//
//  PostData.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 23/4/24.
//

import Foundation

let postData: [PostResponse] = [
    PostResponse(
        id: UUID(),
        user: userLinkedInData[2],
        userLikesThisPost: userLinkedInData[3],
        caption: "Exploring the intersection of AI and healthcare at the Annual MedTech Symposium.",
        type: 2, // Link
        imageUrl: "https://images.unsplash.com/photo-1576765608535-5f04d1e3f289?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzF8fGhlYWx0aCUyMGNhcmV8ZW58MHx8MHx8fDA%3D",
        title: "AI in Healthcare",
        readTimeAgo: "5 min",
        totalLikes: 33098,
        totalComments: 2435,
        totalReposts: 550
    ),
    PostResponse(
        id: UUID(),
        user: userLinkedInData[0],
        userLikesThisPost: userLinkedInData[1],
        caption: "Honored to be a keynote speaker at this year's Global Tech Conference. Sharing some insights from the event.",
        type: 2, // Link
        imageUrl: "https://images.unsplash.com/photo-1576085898323-218337e3e43c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8SG9ub3JlZCUyMHRvJTIwYmUlMjBhJTIwa2V5bm90ZSUyMHNwZWFrZXJ8ZW58MHx8MHx8fDA%3D",
        title: "Keynote Speech at Global Tech",
        readTimeAgo: "12 min",
        totalLikes: 25400,
        totalComments: 1523,
        totalReposts: 340
    ),
    PostResponse(
        id: UUID(),
        user: userLinkedInData[1],
        userLikesThisPost: userLinkedInData[2],
        caption: "Our startup has just secured Series B funding! Thank you to our dedicated team and visionary investors.",
        type: 1, // Photo
        imageUrl: "https://images.pexels.com/photos/7413915/pexels-photo-7413915.jpeg?auto=compress&cs=tinysrgb&w=600",
        title: "Series B Funding Announcement",
        readTimeAgo: "2 min",
        totalLikes: 18672,
        totalComments: 891,
        totalReposts: 207
    ),
    PostResponse(
        id: UUID(),
        user: userLinkedInData[3],
        userLikesThisPost: userLinkedInData[4],
        caption: "Our latest whitepaper on sustainable business practices is out. We'd love your thoughts and feedback!",
        type: 2, // Link
        imageUrl: "https://images.pexels.com/photos/6990425/pexels-photo-6990425.jpeg?auto=compress&cs=tinysrgb&w=600",
        title: "Sustainable Business Whitepaper",
        readTimeAgo: "3 min",
        totalLikes: 21567,
        totalComments: 1327,
        totalReposts: 427
    ),
    PostResponse(
        id: UUID(),
        user: userLinkedInData[4],
        userLikesThisPost: userLinkedInData[0],
        caption: "Proud to mentor the next generation of entrepreneurs. Here's a look at our recent workshop!",
        type: 1, // Photo
        imageUrl: "https://images.pexels.com/photos/3184291/pexels-photo-3184291.jpeg?auto=compress&cs=tinysrgb&w=600",
        title: "Entrepreneur Workshop",
        readTimeAgo: "8 min",
        totalLikes: 25400,
        totalComments: 1000,
        totalReposts: 132
        ),
    PostResponse(
           id: UUID(),
           user: userLinkedInData[0],
           userLikesThisPost: userLinkedInData[4],
           caption: "Delighted to have been part of the panel discussion on the future of renewable energy. Incredible dialogue and insights.",
           type: 1, // Photo
           imageUrl: "https://images.pexels.com/photos/2678468/pexels-photo-2678468.jpeg?auto=compress&cs=tinysrgb&w=600",
           title: "Panel on Renewable Energy",
           readTimeAgo: "15 min",
           totalLikes: 22000,
           totalComments: 1850,
           totalReposts: 460
       ),
       PostResponse(
           id: UUID(),
           user: userLinkedInData[1],
           userLikesThisPost: userLinkedInData[3],
           caption: "Our latest quarterly results are in, and it's been a record-breaking season for us! #TeamWork #Success",
           type: 1, // Photo
           imageUrl: "https://plus.unsplash.com/premium_photo-1714229505201-072ef1c6edcd?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8",
           title: "Quarterly Results",
           readTimeAgo: "10 min",
           totalLikes: 19750,
           totalComments: 1600,
           totalReposts: 410
       ),
       PostResponse(
           id: UUID(),
           user: userLinkedInData[2],
           userLikesThisPost: userLinkedInData[0],
           caption: "Thrilled to announce that I've been named among the Top 100 Influencers in FinTech this year. Thank you for the support!",
           type: 1, // Photo
           imageUrl: "https://images.pexels.com/photos/3184299/pexels-photo-3184299.jpeg?auto=compress&cs=tinysrgb&w=600",
           title: "Top 100 FinTech Influencers",
           readTimeAgo: "1 min",
           totalLikes: 28900,
           totalComments: 3200,
           totalReposts: 680
       ),
       PostResponse(
           id: UUID(),
           user: userLinkedInData[3],
           userLikesThisPost: userLinkedInData[1],
           caption: "Reflecting on a successful merger and the exciting path ahead for our company. #Growth #Merger",
           type: 1, // Photo
           imageUrl: "https://images.pexels.com/photos/1595385/pexels-photo-1595385.jpeg?auto=compress&cs=tinysrgb&w=600",
           title: "Company Merger Reflection",
           readTimeAgo: "5 min",
           totalLikes: 30200,
           totalComments: 2500,
           totalReposts: 720
       )
    ]
