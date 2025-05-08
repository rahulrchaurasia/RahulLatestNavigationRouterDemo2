//
//  CollapsingHeaderView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 06/05/25.
//

import SwiftUI

// Preference key to track scroll offset

struct CollapsingHeaderView: View {
    // MARK: - Properties
    var title: String
    var subtitle: String?
    var rating: String?
    var details: String?
    var image: String
    var expandedHeight: CGFloat = 250
    
    // MARK: - State
    @StateObject private var scrollModel = ScrollViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Thresholds
    private let collapsedThreshold: CGFloat = 120
    private let fullCollapsedThreshold: CGFloat = 180
    
    // MARK: - Computed Properties
    private var backgroundColor: Color {
        colorScheme == .dark ? .black : .white
    }
    
    private var textColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    private var safeAreaTop: CGFloat {
        UIApplication.shared.windows.first?.safeAreaInsets.top ?? 44
    }
    
    private var safeAreaBottom: CGFloat {
        UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    }
    
    private var headerCollapsed: Bool {
        scrollModel.offset > collapsedThreshold
    }
    
    private var fullyCollapsed: Bool {
        scrollModel.offset > fullCollapsedThreshold
    }
    
    private var headerOpacity: Double {
        if scrollModel.offset <= collapsedThreshold { return 0 }
        let opacity = (scrollModel.offset - collapsedThreshold) / (fullCollapsedThreshold - collapsedThreshold)
        return min(1, max(0, opacity))
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .top) {
            // Main content with parallax image
            ScrollView {
                VStack(spacing: 0) {
                    // Parallax header image
                    GeometryReader { geo in
                        let offset = geo.frame(in: .global).minY
                        
                        // Track scroll position
                        Color.clear
                            .preference(key: ScrollOffsetPreferenceKey.self, value: -offset)
                            .frame(width: 0, height: 0)
                        
                        // Image with parallax effect
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width,
                                   height: expandedHeight + (offset > 0 ? offset : 0))
                            .offset(y: (offset > 0 ? -offset : 0))
                            .clipped()
                            .overlay(
                                // Gradient for better text contrast
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        .black.opacity(0.7),
                                        .black.opacity(0.4),
                                        .clear
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .overlay(
                                // Expanded state title overlay
                                VStack(alignment: .leading) {
                                    Spacer()
                                    Text(title)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
                                    if let subtitle = subtitle {
                                        Text(subtitle)
                                            .font(.title3)
                                            .foregroundColor(.white.opacity(0.9))
                                    }
                                    
                                    if let rating = rating {
                                        HStack(spacing: 6) {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                            Text(rating)
                                                .foregroundColor(.white)
                                            
                                            if let details = details {
                                                Text("•")
                                                    .foregroundColor(.white.opacity(0.7))
                                                Text(details)
                                                    .foregroundColor(.white.opacity(0.9))
                                            }
                                        }
                                        .font(.subheadline)
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 20)
                                .opacity(1 - headerOpacity * 1.5)
                            )
                    }
                    .frame(height: expandedHeight)
                    
                    // Content section
                    contentList
                }
            }
            .edgesIgnoringSafeArea(.top)
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) {
                scrollModel.offset = $0
            }
            
            // Top navigation bar overlay (collapsed state)
            VStack(spacing: 0) {
                // Status bar color
                Rectangle()
                    .fill(backgroundColor)
                    .frame(height: safeAreaTop)
                    .opacity(headerOpacity)
                
                // Navigation bar
                HStack {
                    // Back button
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(headerCollapsed ? textColor : .white)
                            .padding(headerCollapsed ? 0 : 10)
                            .background(headerCollapsed ? Color.clear : Color.black.opacity(0.4))
                            .clipShape(Circle())
                    }
                    .padding(.leading, headerCollapsed ? 16 : 20)
                    .padding(.top, headerCollapsed ? 0 : safeAreaTop + 8)
                    
                    // Title (appears when collapsed)
                    if headerCollapsed {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(title)
                                .font(.headline)
                                .lineLimit(1)
                                .foregroundColor(textColor)
                                .opacity(headerOpacity)
                            
                            if let subtitle = subtitle {
                                Text(subtitle)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                                    .opacity(headerOpacity)
                            }
                            
                            if let rating = rating {
                                HStack(spacing: 4) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                        .font(.caption2)
                                    Text(rating)
                                        .font(.caption2)
                                    if let details = details {
                                        Text("•")
                                            .font(.caption2)
                                        Text(details)
                                            .font(.caption2)
                                            .lineLimit(1)
                                    }
                                }
                                .foregroundColor(.gray)
                                .opacity(headerOpacity)
                            }
                        }
                        .padding(.leading, 8)
                    }
                    
                    Spacer()
                }
                .frame(height: 44)
                .background(backgroundColor.opacity(headerOpacity))
                
                // Bottom divider
                Divider()
                    .opacity(headerOpacity)
            }
            .edgesIgnoringSafeArea(.top)
            .animation(.easeInOut(duration: 0.2), value: headerCollapsed)
            .animation(.easeInOut(duration: 0.2), value: headerOpacity)
            
            // Expanded state back button
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.black.opacity(0.3))
                    .clipShape(Circle())
            }
            .padding(.leading, 20)
            .padding(.top, safeAreaTop + 8)
            .opacity(headerCollapsed ? 0 : 1)
            .animation(.easeInOut(duration: 0.2), value: headerCollapsed)
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Content List
    private var contentList: some View {
        VStack(spacing: 0) {
            ForEach(0..<20, id: \.self) { index in
                VStack(alignment: .leading, spacing: 8) {
                    Text("Item \(index)")
                        .font(.headline)
                        .padding(.top, 12)
                        .padding(.horizontal)
                    
                    Text("Description for item \(index). This is a detailed description that shows information about this particular item.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .padding(.bottom, 12)
                    
                    Divider()
                        .padding(.leading)
                }
                .background(backgroundColor)
            }
            .padding(.bottom, safeAreaBottom)
        }
        .background(backgroundColor)
    }
}

#Preview {
    CollapsingHeaderView(
                    title: "Premium Coffee",
                    subtitle: "Italian Espresso",
                    rating: "4.9",
                    details: "Premium Selection",
                    image: "food",
                    expandedHeight: 260
                )
}
