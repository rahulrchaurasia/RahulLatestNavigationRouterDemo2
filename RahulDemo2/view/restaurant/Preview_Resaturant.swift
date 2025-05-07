//
//  Preview_Resaturant.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 03/05/25.
//

import Foundation
import SwiftUI


// Mock data for previews
extension RestaurantTab {
    static var sampleTab: RestaurantTab { .menu }
}

extension Offer {
    static var sampleOffers: [Offer] {
        [
            Offer(id: "1", title: "Weekend Special", description: "Book in advance and get 15% off on your total bill", validUntil: "Valid until May 30, 2025", discountText: "15% OFF"),
            Offer(id: "2", title: "Happy Hour Deal", description: "2 for 1 on all cocktails when you book before 6PM", validUntil: "Valid all week from 4-6PM", discountText: "2 for 1")
        ]
    }
}

extension MenuCategory {
    static var sampleCategories: [MenuCategory] {
        [
            MenuCategory(id: "1", title: "Club food menu", pages: 15, imageUrl: "food_menu_image"),
            MenuCategory(id: "2", title: "Club beverages menu", pages: 11, imageUrl: "drinks_menu_image")
        ]
    }
}

extension RestaurantPhoto {
    static var samplePhotos: [RestaurantPhoto] {
        [
            RestaurantPhoto(id: "1", imageUrl: "restaurant_blue", isWide: true),
            RestaurantPhoto(id: "2", imageUrl: "restaurant_red", isWide: false),
            RestaurantPhoto(id: "3", imageUrl: "restaurant_teal", isWide: false)
        ]
    }
}

extension VibeFeature {
    static var sampleFeatures: [VibeFeature] {
        [
            VibeFeature(id: "1", icon: "music.note", text: "Live DJ"),
            VibeFeature(id: "2", icon: "creditcard", text: "Card payments"),
            VibeFeature(id: "3", icon: "wifi", text: "Free WiFi"),
            VibeFeature(id: "4", icon: "parkingsign", text: "Parking available")
        ]
    }
}

extension Review {
    static var sampleReviews: [Review] {
        [
            Review(id: "1", authorName: "John Smith", date: Date(), comment: "Amazing ambiance and delicious food! The cocktails were creative and the service was top-notch.", overallRating: 4, foodRating: 5, serviceRating: 4),
            Review(id: "2", authorName: "Sarah Johnson", date: Date().addingTimeInterval(-86400 * 7), comment: "Great place for a special occasion. Food was excellent but service was a bit slow.", overallRating: 4, foodRating: 5, serviceRating: 3)
        ]
    }
}

extension Restaurant {
    static var sample: Restaurant {
        Restaurant(
            id: "123",
            name: "Novaara",
            preBookOffers: Offer.sampleOffers,
            walkInOffers: Offer.sampleOffers,
            menuCategories: MenuCategory.sampleCategories,
            photos: RestaurantPhoto.samplePhotos,
            vibeFeatures: VibeFeature.sampleFeatures,
            reviews: Review.sampleReviews,
            rating: 4.7
        )
    }
}

// Preview providers
struct RestaurantNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantNavigationBar(
            title: "Novaara",
            onBackTap: {}
        )
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.white)
    }
}

struct RestaurantTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantTabBarView(
            selectedTab: .constant(.menu),
            tabs: RestaurantTab.allCases
        )
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.white)
    }
}

struct PreBookOfferSectionView_Previews: PreviewProvider {
    static var previews: some View {
        PreBookOfferSectionView(offers: Offer.sampleOffers)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray.opacity(0.1))
    }
}

struct WalkInOfferSectionView_Previews: PreviewProvider {
    static var previews: some View {
        WalkInOfferSectionView(offers: Offer.sampleOffers)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray.opacity(0.1))
    }
}

struct MenuSectionView_Previews: PreviewProvider {
    static var previews: some View {
        MenuSectionView(categories: MenuCategory.sampleCategories)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray.opacity(0.1))
    }
}

struct PhotosSectionView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosSectionView(photos: RestaurantPhoto.samplePhotos)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray.opacity(0.1))
    }
}

struct VibesSectionView_Previews: PreviewProvider {
    static var previews: some View {
        VibesSectionView(features: VibeFeature.sampleFeatures)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray.opacity(0.1))
    }
}

struct ReviewsSectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsSectionView(reviews: Review.sampleReviews, rating: 4.7)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray.opacity(0.1))
    }
}

struct OfferCardView_Previews: PreviewProvider {
    static var previews: some View {
        OfferCardView(offer: Offer.sampleOffers[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

struct MenuCategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        MenuCategoryCardView(category: MenuCategory.sampleCategories[0])
            .previewLayout(.sizeThatFits)
            .frame(width: 200)
            .padding()
    }
}

struct PhotoCellView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PhotoCellView(photo: RestaurantPhoto.samplePhotos[0], isWide: true)
                .frame(width: 350)
            
            PhotoCellView(photo: RestaurantPhoto.samplePhotos[1], isWide: false)
                .frame(width: 160)
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

struct VibeMoodCircleView_Previews: PreviewProvider {
    static var previews: some View {
        VibeMoodCircleView(index: 1)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

struct VenueFeatureRowView_Previews: PreviewProvider {
    static var previews: some View {
        VenueFeatureRowView(feature: VibeFeature.sampleFeatures[0])
            .previewLayout(.sizeThatFits)
            .padding()
            .frame(width: 200)
    }
}

struct ReviewCardView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCardView(review: Review.sampleReviews[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

struct RestaurantActionBar_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantActionBar(
            onBookTable: {},
            onPayBill: {}
        )
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.white)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(
            message: "Failed to load restaurant details",
            onRetry: {}
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

//struct RestaurantDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        // Create a mock view model for preview
//        let viewModel = RestaurantDetailViewModel(restaurantId: "123")
//        // Set sample data directly for preview
//        viewModel.restaurant = Restaurant.sample
//        viewModel.isLoading = false
//        
//        return Group {
//            // Normal state
//            RestaurantDetailView(restaurantId: "123")
//            
//            // Loading state
//            let loadingVM = RestaurantDetailViewModel(restaurantId: "123")
//            loadingVM.isLoading = true
//            RestaurantDetailView(restaurantId: "123")
//                .environmentObject(loadingVM)
//                .previewDisplayName("Loading State")
//            
//            // Error state
//            let errorVM = RestaurantDetailViewModel(restaurantId: "123")
//            errorVM.errorMessage = "Could not connect to server"
//            RestaurantDetailView(restaurantId: "123")
//                .environmentObject(errorVM)
//                .previewDisplayName("Error State")
//        }
//    }
//}
