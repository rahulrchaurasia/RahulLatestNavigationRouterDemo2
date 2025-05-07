//
//  RestaurantDetailView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 03/05/25.
//

import SwiftUI

struct RestaurantDetailView: View {
    @StateObject private var viewModel: RestaurantDetailViewModel
    @Namespace private var underlineNamespace
    
    init(restaurantId: String = "123") {
        self._viewModel = StateObject(wrappedValue: RestaurantDetailViewModel(restaurantId: restaurantId))
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Top navigation bar
                topNavigationBar
                
                if let restaurant = viewModel.restaurant {
                    // Tab bar
                    tabBarView
                    
                    Divider()
                    
                    // Main content with sections
                    contentSectionsView
                    
                    // Bottom action buttons
                    bottomActionButtons
                }
            }
            
            // Loading state
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .background(Color.white.opacity(0.7))
            }
            
            // Error state
            if let errorMessage = viewModel.errorMessage {
                VStack {
                    Text("Error")
                        .font(.headline)
                    Text(errorMessage)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                    Button("Retry") {
                        Task {
                            await viewModel.loadRestaurantDetails()
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.pink)
                    .cornerRadius(8)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
                .shadow(radius: 5)
                .transition(.opacity)
            }
        }
        .task {
            await viewModel.loadRestaurantDetails()
        }
    }
    
    // MARK: - UI Components
    
    private var topNavigationBar: some View {
        HStack {
            Button(action: {
                // Back action
            }) {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            Text(viewModel.restaurant?.name ?? "Restaurant")
                .font(.headline)
                .fontWeight(.bold)
            
            Spacer()
            
            HStack(spacing: 16) {
                Button(action: {
                    // Bookmark action
                }) {
                    Image(systemName: "bookmark")
                        .font(.title3)
                        .foregroundColor(.black)
                }
                
                Button(action: {
                    // Share action
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title3)
                        .foregroundColor(.black)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    private var tabBarView: some View {
        ScrollViewReader { tabProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(RestaurantTab.allCases) { tab in
                        tabView(for: tab)
                            .id(tab)
                            .onTapGesture {
                                withAnimation {
                                    viewModel.selectedTab = tab
                                }
                            }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
            .onChange(of: viewModel.selectedTab) { newTab in
                withAnimation {
                    tabProxy.scrollTo(newTab, anchor: .center)
                }
            }
        }
    }
    
    private var contentSectionsView: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(RestaurantTab.allCases) { tab in
                        sectionView(for: tab)
                            .background(
                                GeometryReader { geo in
                                    Color.clear
                                        .onAppear {
                                            viewModel.tabOffsets[tab] = geo.frame(in: .named("scrollView")).minY
                                        }
                                        .onChange(of: geo.frame(in: .named("scrollView")).minY) { newY in
                                            if !viewModel.isDragging {
                                                return
                                            }
                                            
                                            viewModel.tabOffsets[tab] = newY
                                            viewModel.updateSelectedTab(scrollOffset: newY)
                                        }
                                }
                            )
                            .id(tab)
                    }
                }
                .padding()
            }
            .coordinateSpace(name: "scrollView")
            .onChange(of: viewModel.selectedTab) { tab in
                withAnimation {
                    proxy.scrollTo(tab, anchor: .top)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { _ in
                        viewModel.isDragging = true
                    }
                    .onEnded { _ in
                        viewModel.isDragging = false
                    }
            )
        }
    }
    
    private var bottomActionButtons: some View {
        HStack(spacing: 10) {
            Button(action: {
                viewModel.bookTable()
            }) {
                Text("Book a table")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.pink)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.pink, lineWidth: 1)
                    )
            }
            
            Button(action: {
                viewModel.payBill()
            }) {
                VStack(spacing: 2) {
                    Text("Pay bill")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    
                    Text("Tap to view offers")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.9))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.pink)
                )
            }
        }
        .padding()
    }
    
    // Tab view with underline effect
    private func tabView(for tab: RestaurantTab) -> some View {
        VStack(spacing: 4) {
            Text(tab.rawValue)
                .font(.system(size: 15))
                .fontWeight(viewModel.selectedTab == tab ? .semibold : .regular)
                .foregroundColor(viewModel.selectedTab == tab ? .pink : .gray)
                .padding(.horizontal, 4)
            
            if viewModel.selectedTab == tab {
                Capsule()
                    .fill(Color.pink)
                    .frame(height: 2)
                    .matchedGeometryEffect(id: "underline", in: underlineNamespace)
            } else {
                Color.clear
                    .frame(height: 2)
            }
        }
    }
    
    // Section view for each tab with data from ViewModel
    private func sectionView(for tab: RestaurantTab) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(tab.rawValue)
                .font(.title2)
                .fontWeight(.bold)
            
            if let restaurant = viewModel.restaurant {
                switch tab {
                case .preBookOffer:
                    preBookOfferContent(offers: restaurant.preBookOffers)
                case .walkInOffer:
                    walkInOfferContent(offers: restaurant.walkInOffers)
                case .menu:
                    menuContent(categories: restaurant.menuCategories)
                case .photos:
                    photosContent(photos: restaurant.photos)
                case .vibes:
                    vibesContent(features: restaurant.vibeFeatures)
                case .reviews:
                    reviewsContent(reviews: restaurant.reviews, rating: restaurant.rating)
                }
            } else {
                // Placeholder content if data is not yet loaded
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 200)
                    .cornerRadius(8)
            }
        }
    }
    
    // Content views for each tab using data from ViewModel
    private func preBookOfferContent(offers: [Offer]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(offers) { offer in
                offerCard(offer: offer)
            }
        }
    }
    
    private func walkInOfferContent(offers: [Offer]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(offers) { offer in
                offerCard(offer: offer)
            }
        }
    }
    
    private func menuContent(categories: [MenuCategory]) -> some View {
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
                    menuCategoryCard(category: category)
                }
            }
        }
    }
    
    private func photosContent(photos: [RestaurantPhoto]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 8),
                GridItem(.flexible(), spacing: 8)
            ], spacing: 8) {
                // First wide image
                if let widePhoto = photos.first(where: { $0.isWide }) {
                    photoCellView(photo: widePhoto, isWide: true)
                }
                
                // Regular photos
                ForEach(photos.filter { !$0.isWide }) { photo in
                    photoCellView(photo: photo, isWide: false)
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
    
    private func vibesContent(features: [VibeFeature]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Ambient mood")
                .font(.headline)
                .padding(.bottom, 4)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(1...5, id: \.self) { index in
                        vibeMoodCircle(index: index)
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
                    venueFeatureRow(feature: feature)
                }
            }
        }
    }
    
    private func reviewsContent(reviews: [Review], rating: Double) -> some View {
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
                reviewCard(review: review)
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
    
    // Component views
    private func offerCard(offer: Offer) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(offer.title)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text(offer.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(offer.validUntil)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                }
                
                Spacer()
                
                Text(offer.discountText)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding(10)
                    .background(
                        Circle()
                            .fill(Color.pink)
                    )
            }
            
            Button(action: {
                viewModel.bookTable()
            }) {
                Text("Book now")
                    .font(.headline)
                    .foregroundColor(.pink)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.pink, lineWidth: 1)
                    )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
    
    private func menuCategoryCard(category: MenuCategory) -> some View {
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
    
    private func photoCellView(photo: RestaurantPhoto, isWide: Bool) -> some View {
        Image(photo.imageUrl)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: isWide ? 200 : 150)
            .cornerRadius(8)
            .gridCellColumns(isWide ? 2 : 1)
    }
    
    private func vibeMoodCircle(index: Int) -> some View {
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
    
    private func venueFeatureRow(feature: VibeFeature) -> some View {
        HStack(spacing: 8) {
            Image(systemName: feature.icon)
                .foregroundColor(.pink)
            
            Text(feature.text)
                .font(.subheadline)
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
    
    private func reviewCard(review: Review) -> some View {
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
                        
                        // Format date
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
    
    // Utility functions
    private func formatReviewDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: date)
    }
}


#Preview {
    RestaurantDetailView()
}
