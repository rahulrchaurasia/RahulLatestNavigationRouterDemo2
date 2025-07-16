//
//  CollapsingHeaderContainer.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 15/07/25.
//

import SwiftUI

struct CollapsingHeaderContainer<Content: View>: View {
    let title: String
    let headerColor: Color
    let maxHeaderHeight: CGFloat
    let minHeaderHeight: CGFloat
    let onBackClick: () -> Void
    let onSearchClick: () -> Void
    let content: Content
    
    @State private var scrollOffset: CGFloat = 0
    
    init(
        title: String,
        headerColor: Color = .teal,
        maxHeaderHeight: CGFloat = 240,
        minHeaderHeight: CGFloat = 88,
        onBackClick: @escaping () -> Void,
        onSearchClick: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.headerColor = headerColor
        self.maxHeaderHeight = maxHeaderHeight
        self.minHeaderHeight = minHeaderHeight
        self.onBackClick = onBackClick
        self.onSearchClick = onSearchClick
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            // Main scrollable content with proper offset tracking
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 0) {
                        // Spacer for the collapsing header
                        Color.clear
                            .frame(height: maxHeaderHeight)
                            .id("header")
                        
                        // Main content with offset tracking
                        LazyVStack(spacing: 0) {
                            content
                                .padding(.top, 16)
                                .padding(.bottom, 100)
                                .background(Color(.systemGroupedBackground))
                        }
                        .background(
                            GeometryReader { geometry in
                                Color.clear
                                    .preference(
                                        key: ScrollOffsetPreferenceKey.self,
                                        value: geometry.frame(in: .named("scrollView")).minY - maxHeaderHeight
                                    )
                            }
                        )
                    }
                }
                .coordinateSpace(name: "scrollView")
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.8)) {
                        scrollOffset = max(0, -value)
                    }
                }
            }
            
            // Collapsing header overlay
            VStack(spacing: 0) {
                // Status bar area
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 44)
                
                // Navigation bar area in expanded header
                HStack {
                    Button(action: onBackClick) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Button(action: onSearchClick) {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    .opacity(searchContentAlpha)
                }
                .padding(.horizontal, 16)
                .frame(height: 44)
                
                // Collapsing search content
                VStack(spacing: 16) {
                    SearchBar()
                        .opacity(searchContentAlpha)
                        .scaleEffect(searchContentScale)
                    
                    quickActionsForTitle(title)
                        .opacity(searchContentAlpha)
                        .scaleEffect(searchContentScale)
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
            }
            .frame(height: currentHeaderHeight)
            .background(
                LinearGradient(
                    colors: [
                        headerColor.opacity(backgroundOpacity),
                        headerColor.opacity(backgroundOpacity * 0.8)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .clipped()
            .ignoresSafeArea(edges: .top)
            
            // Sticky collapsed header - appears as original header fades
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 44)
                
                HStack {
                    Button(action: onBackClick) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    Text(title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .opacity(titleAlpha)
                    
                    Spacer()
                    
                    Button(action: onSearchClick) {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                    }
                    .opacity(searchIconAlpha)
                }
                .padding(.horizontal, 16)
                .frame(height: 44)
            }
            .background(
                Color(.systemBackground)
                    .opacity(stickyHeaderOpacity)
                    .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
            )
            .opacity(stickyHeaderVisible ? 1 : 0)
            .offset(y: stickyHeaderVisible ? 0 : -20)
            .ignoresSafeArea(edges: .top)
        }
    }
    
    // MARK: - Computed Properties
    
    private var scrollProgress: CGFloat {
        let scrollRange = maxHeaderHeight - minHeaderHeight
        let progress = min(max(scrollOffset / scrollRange, 0), 1)
        return progress
    }
    
    private var currentHeaderHeight: CGFloat {
        let height = maxHeaderHeight - (scrollProgress * (maxHeaderHeight - minHeaderHeight))
        return max(height, minHeaderHeight)
    }
    
    // Sticky header becomes visible when scroll progress > 0.8 (80% collapsed)
    private var stickyHeaderVisible: Bool {
        return scrollProgress > 0.8
    }
    
    // Sticky header opacity increases as we approach full collapse
    private var stickyHeaderOpacity: Double {
        let threshold: CGFloat = 0.8
        if scrollProgress >= threshold {
            return Double(min((scrollProgress - threshold) / (1.0 - threshold), 1.0))
        }
        return 0
    }
    
    // Title appears when sticky header is nearly fully visible (90% collapsed)
    private var titleAlpha: Double {
        let threshold: CGFloat = 0.9
        if scrollProgress >= threshold {
            return Double(min((scrollProgress - threshold) / (1.0 - threshold), 1.0))
        }
        return 0
    }
    
    // Search content fades out progressively but faster than scroll progress
    private var searchContentAlpha: Double {
        return Double(max(1.0 - (scrollProgress * 1.5), 0))
    }
    
    // Search content scales down slightly as it fades
    private var searchContentScale: CGFloat {
        return max(0.85 + (searchContentAlpha * 0.15), 0.85)
    }
    
    // Background fades out as header collapses
    private var backgroundOpacity: Double {
        return Double(max(1.0 - (scrollProgress * 1.2), 0))
    }
    
    // Search icon in sticky header appears when title is visible
    private var searchIconAlpha: Double {
        let threshold: CGFloat = 0.9
        if scrollProgress >= threshold {
            return Double(min((scrollProgress - threshold) / (1.0 - threshold), 1.0))
        }
        return 0
    }
    
    @ViewBuilder
    private func quickActionsForTitle(_ title: String) -> some View {
        HStack(spacing: 12) {
            if title.contains("Journey") {
                QuickActionButton(icon: "car.fill", title: "New Trip", color: .blue)
                QuickActionButton(icon: "location.fill", title: "Track", color: .green)
                QuickActionButton(icon: "fuelpump.fill", title: "Fuel", color: .orange)
                QuickActionButton(icon: "wrench.fill", title: "Service", color: .purple)
            } else if title.contains("Transaction") {
                QuickActionButton(icon: "creditcard", title: "Pay Bills", color: .blue)
                QuickActionButton(icon: "arrow.up.arrow.down", title: "Transfer", color: .green)
                QuickActionButton(icon: "plus.circle", title: "Add Money", color: .orange)
                QuickActionButton(icon: "chart.bar", title: "Analytics", color: .purple)
            } else {
                QuickActionButton(icon: "house.fill", title: "Home", color: .blue)
                QuickActionButton(icon: "person.fill", title: "Profile", color: .green)
                QuickActionButton(icon: "gear", title: "Settings", color: .orange)
                QuickActionButton(icon: "heart.fill", title: "Favorites", color: .purple)
            }
        }
    }
}


//#Preview {
//    CollapsingHeaderContainer()
//}
