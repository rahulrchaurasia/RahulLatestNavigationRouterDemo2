//
//  ImageCollapsingHeaderView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 15/07/25.
//

import SwiftUI


//
//  ImageCollapsingHeaderView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 15/07/25.
//

import SwiftUI



struct ImageCollapsingHeaderView: View {
    // --- Configuration ---
    private let expandedHeight: CGFloat = 300
    private let collapsedHeight: CGFloat = 90 // Standard nav bar + status bar
    private let safeAreaTop: CGFloat = 44 // Approximate safe area top
    
    // --- State ---
    @State private var scrollOffset: CGFloat = 0
    
    // --- Computed Properties for Animation ---
    
    /// The overall progress of the collapse, from 0.0 (fully expanded) to 1.0 (fully collapsed).
    private var scrollProgress: CGFloat {
        let progress = min(1.0, max(0.0, scrollOffset / (expandedHeight - collapsedHeight)))
        return progress
    }
    
    /// Current height of the header with proper bounds
    private var currentHeaderHeight: CGFloat {
        let height = expandedHeight - scrollOffset
        return max(collapsedHeight, height)
    }
    
    /// Opacity for the collapsed header - starts earlier for smoother transition
    private var collapsedHeaderOpacity: Double {
        // Start fading in when 60% collapsed for smoother transition
        guard scrollProgress > 0.6 else { return 0 }
        let fadeProgress = (scrollProgress - 0.6) / 0.4
        return Double(min(1.0, fadeProgress))
    }
    
    /// Opacity for the image overlay to create depth
    private var imageOverlayOpacity: Double {
        // Add a subtle overlay as we scroll to create depth
        return Double(scrollProgress * 0.3)
    }
    
    /// Scale factor for the image to create parallax effect
    private var imageScale: CGFloat {
        if scrollOffset < 0 {
            // When pulling down, scale up the image
            return 1.0 + abs(scrollOffset) / expandedHeight * 0.5
        }
        return 1.0
    }
    
    /// Offset for the image to create parallax scrolling
    private var imageOffset: CGFloat {
        return scrollOffset * 0.5 // Parallax factor
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            // --- Background ScrollView ---
            ScrollView {
                // 1. GeometryReader to capture scroll offset
                GeometryReader { proxy in
                    Color.clear.preference(
                        key: ScrollOffsetPreferenceKey.self,
                        value: -proxy.frame(in: .global).minY
                    )
                }
                .frame(height: 0)
                
                // 2. Main content
                LazyVStack(spacing: 16) {
                    ForEach(1...20, id: \.self) { index in
                        Text("Row \(index)")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                .padding(.top, expandedHeight + 10) // Push content below header
            }
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                withAnimation(.easeOut(duration: 0.1)) {
                    self.scrollOffset = value
                }
            }
            
            // --- The Enhanced Header ---
            headerView
        }
        .ignoresSafeArea(.all)
        .navigationBarHidden(true)
    }
    
    // --- The Enhanced Header View ---
    private var headerView: some View {
        ZStack(alignment: .top) {
            // Layer 1: The Image with parallax effect
            GeometryReader { geometry in
                Image("a1") // Replace with your image asset
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geometry.size.width,
                        height: currentHeaderHeight
                    )
                    .scaleEffect(imageScale)
                    .offset(y: imageOffset)
                    .clipped()
                
                // Overlay for depth effect
                Rectangle()
                    .fill(Color.black.opacity(imageOverlayOpacity))
                    .frame(height: currentHeaderHeight)
            }
            .frame(height: currentHeaderHeight)
            
            // Layer 2: Safe area background for collapsed state
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: safeAreaTop)
                    .opacity(collapsedHeaderOpacity)
                
                Spacer()
            }
            .frame(height: currentHeaderHeight)
            
            // Layer 3: The Collapsed Header Content
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: safeAreaTop)
                
                HStack {
                    Text("Collapsed Header")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .frame(height: 44)
                .background(
                    Rectangle()
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                )
                .opacity(collapsedHeaderOpacity)
                
                Spacer()
            }
            .frame(height: currentHeaderHeight)
        }
        .frame(height: currentHeaderHeight)
        .clipped()
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    NavigationView {
        ImageCollapsingHeaderView()
    }
}
