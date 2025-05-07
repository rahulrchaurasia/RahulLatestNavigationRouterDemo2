//
//  MockRestaurantRepository.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 03/05/25.
//

import Foundation


class MockRestaurantRepository : RestaurantRepository {
    
    func getRestaurantDetails(id: String) async throws -> Restaurant {
        
        // Simulate network delay
        try await Task.sleep(nanoseconds: 500_000_000)
        
        
        // Return mock data
        return Restaurant(
            id: id,
            name: "Novaara",
            preBookOffers: [
                Offer(id: "1", title: "Weekend Special", description: "Book in advance and get 15% off on your total bill", validUntil: "Valid until May 30, 2025", discountText: "15% OFF"),
                Offer(id: "2", title: "Happy Hour Deal", description: "2 for 1 on all cocktails when you book before 6PM", validUntil: "Valid all week from 4-6PM", discountText: "2 for 1")
            ],
            walkInOffers: [
                Offer(id: "3", title: "Monday Madness", description: "Walk in on any Monday and get 10% off your food bill", validUntil: "Valid every Monday", discountText: "10% OFF"),
                Offer(id: "4", title: "Lunch Special", description: "Get a free dessert with any main course", validUntil: "Valid weekdays 12-3PM", discountText: "Free Dessert")
            ],
            menuCategories: [
                MenuCategory(id: "1", title: "Club food menu", pages: 15, imageUrl: "food_menu_image"),
                MenuCategory(id: "2", title: "Club beverages menu", pages: 11, imageUrl: "drinks_menu_image")
            ],
            photos: [
                RestaurantPhoto(id: "1", imageUrl: "restaurant_blue", isWide: true),
                RestaurantPhoto(id: "2", imageUrl: "restaurant_red", isWide: false),
                RestaurantPhoto(id: "3", imageUrl: "restaurant_teal", isWide: false),
                RestaurantPhoto(id: "4", imageUrl: "restaurant_bar", isWide: false)
            ],
            vibeFeatures: [
                VibeFeature(id: "1", icon: "music.note", text: "Live DJ"),
                VibeFeature(id: "2", icon: "creditcard", text: "Card payments"),
                VibeFeature(id: "3", icon: "wifi", text: "Free WiFi"),
                VibeFeature(id: "4", icon: "parkingsign", text: "Parking available"),
                VibeFeature(id: "5", icon: "wheelchair", text: "Wheelchair access"),
                VibeFeature(id: "6", icon: "airplayaudio", text: "TV Screens")
            ],
            reviews: [
                Review(id: "1", authorName: "John Smith", date: Date(), comment: "Amazing ambiance and delicious food! The cocktails were creative and the service was top-notch. Will definitely be coming back soon.", overallRating: 4, foodRating: 5, serviceRating: 4),
                Review(id: "2", authorName: "Sarah Johnson", date: Date().addingTimeInterval(-86400 * 7), comment: "Great place for a special occasion. Food was excellent but service was a bit slow during our visit.", overallRating: 4, foodRating: 5, serviceRating: 3)
            ],
            rating: 4.7
        )
    }
   
}
