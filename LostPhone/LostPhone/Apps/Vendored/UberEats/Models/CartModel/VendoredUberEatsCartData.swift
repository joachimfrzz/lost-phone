//
//  CartData.swift
//  food-delivery-ui-kit-v1
//
//  Created by Sopheamen VAN on 28/4/25.
//

import Foundation

// cart data
let cartData: [VendoredUberEatsCartResponse] = [
    VendoredUberEatsCartResponse(
        restaurant: VendoredUberEatsRestaurantResponse(
            name: "Sunset Grill",
            imageUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/a9ac884f10fe613520cf1fc5140a5bc3/e00617ce8176680d1c4c1a6fb65963e2.png",
            coverUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/d0d7af31da4752c9928adcbe0cf73baa/fb86662148be855d931b37d6c1e5fcbe.jpeg",
            deliveryFee: "$0.79",
            duration: "20-30 min",
            totalRate: "320+",
            rating: "4.8",
            badgeName: "Popular Grill",
            distance: "1.2 km",
            menu: [
                VendoredUberEatsMenuResponse(id: UUID(), name: "Grilled Chicken", imageUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/4be48b83b637457022b86210a06bf267/58f691da9eaef86b0b51f9b2c483fe63.jpeg", description: "Juicy grilled chicken", price: "$8.99", isPriceAddOns: 0, rate: 96, totalRate: 310, isPopular: 1),
                VendoredUberEatsMenuResponse(id: UUID(), name: "BBQ Ribs", imageUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/0589babfe2cb376088657bb654daf222/58f691da9eaef86b0b51f9b2c483fe63.jpeg", description: "Tender BBQ pork ribs", price: "$12.49", isPriceAddOns: 1, rate: 95, totalRate: 300, isPopular: 1),
            ],
            isOffer: true,
            isFavorite: false
        ),
        itemCount: 2,
        totalPrice: "$15.48",
        deliveryTo: "Home"
    ),
    
    VendoredUberEatsCartResponse(
        restaurant: VendoredUberEatsRestaurantResponse(
            name: "Sakura Sushi",
            imageUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/54934ab4506cceb6f18972bcf3210358/9b3aae4cf90f897799a5ed357d60e09d.jpeg",
            coverUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/54934ab4506cceb6f18972bcf3210358/fb86662148be855d931b37d6c1e5fcbe.jpeg",
            deliveryFee: "$0.89",
            duration: "15-25 min",
            totalRate: "250+",
            rating: "4.9",
            badgeName: "Best Sushi",
            distance: "1.5 km",
            menu: [
                VendoredUberEatsMenuResponse(id: UUID(), name: "Salmon Nigiri", imageUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/4e498621ff6325b2d165bdb54a4889fe/58f691da9eaef86b0b51f9b2c483fe63.jpeg", description: "Fresh salmon on rice", price: "$7.49", isPriceAddOns: 0, rate: 97, totalRate: 260, isPopular: 1),
                VendoredUberEatsMenuResponse(id: UUID(), name: "Tuna Sashimi", imageUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/043c86b6a7965c9f3feed1d2c6cba41a/58f691da9eaef86b0b51f9b2c483fe63.jpeg", description: "Thin sliced tuna", price: "$8.49", isPriceAddOns: 0, rate: 96, totalRate: 250, isPopular: 1),
                VendoredUberEatsMenuResponse(id: UUID(), name: "Dragon Roll", imageUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/1ee48b0fd23ecb8538840833a5c280a0/58f691da9eaef86b0b51f9b2c483fe63.jpeg", description: "Eel and avocado roll", price: "$9.99", isPriceAddOns: 1, rate: 95, totalRate: 240, isPopular: 1),
            ],
            isOffer: true,
            isFavorite: false
        ),
        itemCount: 3,
        totalPrice: "$16.97",
        deliveryTo: "Office"
    ),
    
    VendoredUberEatsCartResponse(
        restaurant: VendoredUberEatsRestaurantResponse(
            name: "Taco Fiesta",
            imageUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/ca45554b992e1039f755d1b787eaa22d/885ba8620d45ab36746a0e8c7b85ee66.webp",
            coverUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/1d49e84790ea373fd55038daac217f03/db809eadd12d21eb61044e0f3bf7c9b7.jpeg",
            deliveryFee: "$0.69",
            duration: "18-28 min",
            totalRate: "200+",
            rating: "4.7",
            badgeName: "Hot Deals",
            distance: "1.7 km",
            menu: [
                VendoredUberEatsMenuResponse(id: UUID(), name: "Beef Taco", imageUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/1cd4c65ab125e60a3c6c1e2015504ab6/0fb376d1da56c05644450062d25c5c84.jpeg", description: "Spicy beef taco", price: "$3.99", isPriceAddOns: 0, rate: 94, totalRate: 210, isPopular: 1),
            ],
            isOffer: true,
            isFavorite: false
        ),
        itemCount: 1,
        totalPrice: "$4.99",
        deliveryTo: "Hotel"
    )
]
