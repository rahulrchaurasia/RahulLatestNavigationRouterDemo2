//
//  RestaurantSectionView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 03/05/25.
//

import SwiftUI

struct RestaurantSectionView: View {
    let tab: RestaurantTab
    let restaurant: Restaurant
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(tab.rawValue)
                .font(.title2)
                .fontWeight(.bold)
            
            switch tab {
            case .preBookOffer:
                PreBookOfferSectionView(offers: restaurant.preBookOffers)
            case .walkInOffer:
                WalkInOfferSectionView(offers: restaurant.walkInOffers)
            case .menu:
                MenuSectionView(categories: restaurant.menuCategories)
            case .photos:
                PhotosSectionView(photos: restaurant.photos)
            case .vibes:
                VibesSectionView(features: restaurant.vibeFeatures)
            case .reviews:
                ReviewsSectionView(reviews: restaurant.reviews, rating: restaurant.rating)
            }
        }
    }
}

//#Preview {
//    RestaurantSectionView()
//}
