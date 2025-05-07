//
//  RestaurantTab.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 03/05/25.
//

import Foundation

import SwiftUI
import Combine



// More specific enum name
enum RestaurantTab: String, CaseIterable, Identifiable {
    case preBookOffer = "Pre-book Offer"
    case walkInOffer = "Walk-in Offer"
    case menu = "Menu"
    case photos = "Photos"
    case vibes = "Vibes"
    case reviews = "Reviews"
    
    var id: String { self.rawValue }
    
    var icon: String {
        switch self {
        case .preBookOffer: return "calendar.badge.clock"
        case .walkInOffer: return "figure.walk"
        case .menu: return "list.bullet"
        case .photos: return "photo"
        case .vibes: return "music.note"
        case .reviews: return "star"
        }
    }
}

// Data models representing database entities
struct Restaurant: Identifiable {
    let id: String
    let name: String
    let preBookOffers: [Offer]
    let walkInOffers: [Offer]
    let menuCategories: [MenuCategory]
    let photos: [RestaurantPhoto]
    let vibeFeatures: [VibeFeature]
    let reviews: [Review]
    let rating: Double
}

struct Offer: Identifiable {
    let id: String
    let title: String
    let description: String
    let validUntil: String
    let discountText: String
}

struct MenuCategory: Identifiable {
    let id: String
    let title: String
    let pages: Int
    let imageUrl: String
}

struct RestaurantPhoto: Identifiable {
    let id: String
    let imageUrl: String
    let isWide: Bool
}

struct VibeFeature: Identifiable {
    let id: String
    let icon: String
    let text: String
}

struct Review: Identifiable {
    let id: String
    let authorName: String
    let date: Date
    let comment: String
    let overallRating: Int
    let foodRating: Int
    let serviceRating: Int
}
