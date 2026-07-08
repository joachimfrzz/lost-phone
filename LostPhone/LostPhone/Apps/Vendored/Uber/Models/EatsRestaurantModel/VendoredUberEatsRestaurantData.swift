//
//  EatsRestaurantData.swift
//  Youtube_uber_clone
//
//  Created by Sopheamen VAN on 13/11/24.
//

import Foundation


// featured
let eatsRestaurantsFeaturedData = [
    VendoredUberEatsRestaurantResponse(name: "Sushi House", imageUrl: "https://cn-geo1.uber.com/image-proc/resize/eats/format=webp/width=550/height=440/quality=70/srcb64=aHR0cHM6Ly90Yi1zdGF0aWMudWJlci5jb20vcHJvZC9pbWFnZS1wcm9jL3Byb2Nlc3NlZF9pbWFnZXMvNmE3NjBhZmFiYTcwZGZhNTE0NDU4ZWY0Zjc4NDY4MzAvYTcwZjVjOWRmNDQwZDEwMjEzZTkzMjQ0ZTllYjdjYWQuanBlZw==", deliveryFee: "$0.49", duration: "25-35 min", totalRate: "4.8", isOffer: true, isFavorite: true),
    VendoredUberEatsRestaurantResponse(name: "Burger Palace", imageUrl: "https://cn-geo1.uber.com/image-proc/resize/eats/format=webp/width=550/height=440/quality=70/srcb64=aHR0cHM6Ly90Yi1zdGF0aWMudWJlci5jb20vcHJvZC9pbWFnZS1wcm9jL3Byb2Nlc3NlZF9pbWFnZXMvMWYwNGYxZmJkNjhmY2ZiZDU2NmI1NTkxMjIzMzFhMzgvZjg0MDNjNDIxYmVmNjY4YWQzODFiNWU4MmU1NDYwNjAuanBlZw==", deliveryFee: "$1.20", duration: "20-30 min", totalRate: "4.5", isOffer: false, isFavorite: true),
    VendoredUberEatsRestaurantResponse(name: "Italiano Pizza", imageUrl: "https://cn-geo1.uber.com/image-proc/resize/eats/format=webp/width=550/height=440/quality=70/srcb64=aHR0cHM6Ly90Yi1zdGF0aWMudWJlci5jb20vcHJvZC9pbWFnZS1wcm9jL3Byb2Nlc3NlZF9pbWFnZXMvNDY0MTk0MDdiMDc1MzA2OTY3MjY2OGUxMTkyODk4OGUvOWIzYWFlNGNmOTBmODk3Nzk5YTVlZDM1N2Q2MGUwOWQuanBlZw==", deliveryFee: "$0.78", duration: "30-40 min", totalRate: "4.7", isOffer: true, isFavorite: false),
    VendoredUberEatsRestaurantResponse(name: "Healthy Greens", imageUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/d728c9c3f3f11db4d521001feb1a870b/fb86662148be855d931b37d6c1e5fcbe.webp", deliveryFee: "$1.00", duration: "20-25 min", totalRate: "4.9", isOffer: false, isFavorite: true),
    VendoredUberEatsRestaurantResponse(name: "Taco Fiesta", imageUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/694f146557a63d5ebd4c40075a41ff61/fb86662148be855d931b37d6c1e5fcbe.jpeg", deliveryFee: "$0.99", duration: "15-20 min", totalRate: "4.6", isOffer: true, isFavorite: false),
    VendoredUberEatsRestaurantResponse(name: "Pasta Delight", imageUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/055bc107942300583e506deeb372c4fc/0e8f477e8f858732b95bd74b5e07a538.jpeg", deliveryFee: "$1.40", duration: "35-45 min", totalRate: "4.3", isOffer: false, isFavorite: true)
]

// place you might like
let placesYouMightLikeData = [
    VendoredUberEatsRestaurantResponse(name: "Steakhouse Grill", imageUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/a613066447b368bc8808d86a42015905/3ac2b39ad528f8c8c5dc77c59abb683d.jpeg", deliveryFee: "$1.50", duration: "30-40 min", totalRate: "4.8", isOffer: true, isFavorite: false),
    VendoredUberEatsRestaurantResponse(name: "Veggie Delight", imageUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/5d32e72103376986f1961c1581779876/fb86662148be855d931b37d6c1e5fcbe.jpeg", deliveryFee: "$0.89", duration: "20-30 min", totalRate: "4.6", isOffer: false, isFavorite: true),
    VendoredUberEatsRestaurantResponse(name: "Noodle Express", imageUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/b3af2a1567d94145e825d6d2c13fd853/fb86662148be855d931b37d6c1e5fcbe.jpeg", deliveryFee: "$0.99", duration: "15-25 min", totalRate: "4.4", isOffer: true, isFavorite: true),
    VendoredUberEatsRestaurantResponse(name: "BBQ Joint", imageUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/e05c8a0b80ebd8c35698c832ed7c60cf/9e31c708e4cf73b6e3ea1bd4a9b6e16b.jpeg", deliveryFee: "$1.20", duration: "25-35 min", totalRate: "4.7", isOffer: true, isFavorite: false),
    VendoredUberEatsRestaurantResponse(name: "Café Bliss", imageUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/9d4df2c08052638ad56aa34eee2114d9/fb86662148be855d931b37d6c1e5fcbe.jpeg", deliveryFee: "$0.75", duration: "20-30 min", totalRate: "4.5", isOffer: false, isFavorite: true),
    VendoredUberEatsRestaurantResponse(name: "Seafood Market", imageUrl: "https://tb-static.uber.com/prod/image-proc/processed_images/151b034db1e81e4a27be4e9994153498/fb86662148be855d931b37d6c1e5fcbe.jpeg", deliveryFee: "$1.30", duration: "30-45 min", totalRate: "4.9", isOffer: true, isFavorite: false)
]

