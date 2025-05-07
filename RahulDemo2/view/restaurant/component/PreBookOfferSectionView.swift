//
//  PreBookOfferSectionView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 03/05/25.
//

import SwiftUI

struct PreBookOfferSectionView: View {
    let offers: [Offer]
      
      var body: some View {
          VStack(alignment: .leading, spacing: 16) {
              ForEach(offers) { offer in
                  OfferCardView(offer: offer)
              }
          }
      }
}

struct WalkInOfferSectionView: View {
    let offers: [Offer]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(offers) { offer in
                OfferCardView(offer: offer)
            }
        }
    }
}

struct MenuSectionView: View {
    let categories: [MenuCategory]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Last updated 5 months ago")
                .font(.subheadline)
                .foregroundColor(.yellow)
                .padding(.bottom, 8)
            
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 12),
                GridItem(.flexible(), spacing: 12)
            ], spacing: 12) {
                ForEach(categories) { category in
                    MenuCategoryCardView(category: category)
                }
            }
        }
    }
}

struct PhotosSectionView: View {
    let photos: [RestaurantPhoto]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 8),
                GridItem(.flexible(), spacing: 8)
            ], spacing: 8) {
                // First wide image
                if let widePhoto = photos.first(where: { $0.isWide }) {
                    PhotoCellView(photo: widePhoto, isWide: true)
                }
                
                // Regular photos
                ForEach(photos.filter { !$0.isWide }) { photo in
                    PhotoCellView(photo: photo, isWide: false)
                }
            }
            
            Button(action: {
                // Add photo action
            }) {
                HStack {
                    Image(systemName: "camera")
                    Text("Add photo")
                }
                .font(.headline)
                .foregroundColor(.pink)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.pink, lineWidth: 1)
                )
            }
            .padding(.top, 8)
        }
    }
}

struct VibesSectionView: View {
    let features: [VibeFeature]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Ambient mood")
                .font(.headline)
                .padding(.bottom, 4)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(1...5, id: \.self) { index in
                        VibeMoodCircleView(index: index)
                    }
                }
            }
            
            Text("Venue features")
                .font(.headline)
                .padding(.top, 12)
                .padding(.bottom, 4)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                ForEach(features) { feature in
                    VenueFeatureRowView(feature: feature)
                }
            }
        }
    }
}

struct ReviewsSectionView: View {
    let reviews: [Review]
    let rating: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading) {
                    Text(String(format: "%.1f", rating))
                        .font(.system(size: 40, weight: .bold))
                    
                    Text("out of 5")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Based on")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("\(reviews.count) reviews")
                        .font(.headline)
                }
            }
            .padding(.bottom, 8)
            
            ForEach(reviews) { review in
                ReviewCardView(review: review)
            }
            
            Button(action: {
                // Write a review action
            }) {
                HStack {
                    Image(systemName: "square.and.pencil")
                    Text("Write a review")
                }
                .font(.headline)
                .foregroundColor(.pink)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.pink, lineWidth: 1)
                )
            }
            .padding(.top, 8)
        }
    }
}

//#Preview {
//    PreBookOfferSectionView()
//}
