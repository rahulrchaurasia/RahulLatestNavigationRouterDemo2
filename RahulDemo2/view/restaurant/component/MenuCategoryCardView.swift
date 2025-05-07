//
//  MenuCategoryCardView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 03/05/25.
//

import SwiftUI

struct MenuCategoryCardView: View {
    let category: MenuCategory
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Image(category.imageUrl)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 180)
                .cornerRadius(8)
            
            Text(category.title)
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Text("\(category.pages) pages")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct PhotoCellView: View {
    let photo: RestaurantPhoto
    let isWide: Bool
    
    var body: some View {
        Image(photo.imageUrl)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: isWide ? 200 : 150)
            .cornerRadius(8)
            .gridCellColumns(isWide ? 2 : 1)
    }
}

struct VibeMoodCircleView: View {
    let index: Int
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.pink, lineWidth: 2)
                .frame(width: 70, height: 70)
            
            Image("mood_\(index)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 65, height: 65)
                .clipShape(Circle())
        }
    }
}

struct VenueFeatureRowView: View {
    let feature: VibeFeature
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: feature.icon)
                .foregroundColor(.pink)
            
            Text(feature.text)
                .font(.subheadline)
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

struct ReviewCardView: View {
    let review: Review
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(review.authorName)
                        .font(.headline)
                    
                    HStack {
                        ForEach(1...5, id: \.self) { i in
                            Image(systemName: i <= review.overallRating ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                        
                        Text("• \(formatReviewDate(review.date))")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
            }
            
            Text(review.comment)
                .font(.subheadline)
            
            HStack {
                Text("Food quality")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                ForEach(1...5, id: \.self) { i in
                    Image(systemName: i <= review.foodRating ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .font(.caption)
                }
            }
            
            HStack {
                Text("Service")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                ForEach(1...5, id: \.self) { i in
                    Image(systemName: i <= review.serviceRating ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
    
    // Utility function
    private func formatReviewDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: date)
    }
}

//#Preview {
//    MenuCategoryCardView()
//}
