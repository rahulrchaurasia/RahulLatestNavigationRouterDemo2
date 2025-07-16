//
//  ProgressiveCollapsingHeader.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 15/07/25.
//

import SwiftUI

// MARK: - Progressive Collapsing Header Component
struct ProgressiveCollapsingHeader: View {
    let height: CGFloat
    let scrollProgress: CGFloat
    let titleAlpha: Double
    let searchContentAlpha: Double
    let backgroundProgress: CGFloat
    let searchIconAlpha: Double
    let onBackClick: () -> Void
    let onSearchClick: () -> Void
    
    var body: some View {
        ZStack {
            // Background - transitions from gradient to white
            // ✅ FIXED: Use computed property instead of complex inline expression
            
            headerBackground
            
            VStack(spacing: 0) {
                // Status bar area
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 44)
                
                // Header content
                HStack {
                    // Back button
                    Button(action: onBackClick) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(
                                backgroundProgress > 0.5 ? .black : .white
                            )
                    }
                    
                    Spacer()
                    
                    // Title (appears when 90% collapsed)
                    Text("Transaction")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .opacity(titleAlpha)
                    
                    Spacer()
                    
                    // Search icon (appears when fully collapsed)
                    Button(action: onSearchClick) {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                    }
                    .opacity(searchIconAlpha)
                }
                .padding(.horizontal, 16)
                .frame(height: 44)
                
                // Search content area (fades out during collapse)
                VStack(spacing: 16) {
                    // Search bar
                    SearchBar()
                        .opacity(searchContentAlpha)
                        .scaleEffect(0.8 + (searchContentAlpha * 0.2))
                    
                    // Quick action buttons
                    HStack(spacing: 12) {
                        QuickActionButton(
                            icon: "creditcard",
                            title: "Pay Bills",
                            color: .blue
                        )
                        QuickActionButton(
                            icon: "arrow.up.arrow.down",
                            title: "Transfer",
                            color: .green
                        )
                        QuickActionButton(
                            icon: "plus.circle",
                            title: "Add Money",
                            color: .orange
                        )
                        QuickActionButton(
                            icon: "chart.bar",
                            title: "Analytics",
                            color: .purple
                        )
                    }
                    .opacity(searchContentAlpha)
                    .scaleEffect(0.9 + (searchContentAlpha * 0.1))
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
            }
        }
        .frame(height: height)
        .clipped()
        .animation(.easeOut(duration: 0.1), value: scrollProgress)
    }
    
    
    // ✅ FIXED: Computed property for background to avoid complex expressions
       private var headerBackground: some View {
           ZStack {
               // Base gradient background
               LinearGradient(
                   colors: [
                       Color.teal.opacity(1.0 - backgroundProgress),
                       Color.teal.opacity(0.8 * (1.0 - backgroundProgress))
                   ],
                   startPoint: .topLeading,
                   endPoint: .bottomTrailing
               )
               .opacity(1.0 - backgroundProgress * 0.3)
               
               // White overlay for smooth transition
               Rectangle()
                   .fill(Color.white)
                   .opacity(backgroundProgress * 0.9)
           }
       }
}
//#Preview {
//    ProgressiveCollapsingHeader()
//}
