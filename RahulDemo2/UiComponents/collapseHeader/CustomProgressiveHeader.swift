//
//  CustomProgressiveHeader.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 15/07/25.
//

import SwiftUI

struct CustomProgressiveHeader: View {
    let title: String
    let headerColor: Color
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
            // Custom background with different color
            ZStack {
                LinearGradient(
                    colors: [
                        headerColor.opacity(1.0 - backgroundProgress),
                        headerColor.opacity(0.8 * (1.0 - backgroundProgress))
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .opacity(1.0 - backgroundProgress * 0.3)
                
                Rectangle()
                    .fill(Color.white)
                    .opacity(backgroundProgress * 0.9)
            }
            
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 44)
                
                HStack {
                    Button(action: onBackClick) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(
                                backgroundProgress > 0.5 ? .black : .white
                            )
                    }
                    
                    Spacer()
                    
                    Text(title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .opacity(titleAlpha)
                    
                    Spacer()
                    
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
                
                VStack(spacing: 16) {
                    SearchBar()
                        .opacity(searchContentAlpha)
                        .scaleEffect(0.8 + (searchContentAlpha * 0.2))
                    
                    // Custom quick actions based on title
                    quickActionsForTitle(title)
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
    
    @ViewBuilder
    private func quickActionsForTitle(_ title: String) -> some View {
        HStack(spacing: 12) {
            if title.contains("Transaction") {
                QuickActionButton(icon: "creditcard", title: "Pay Bills", color: .blue)
                QuickActionButton(icon: "arrow.up.arrow.down", title: "Transfer", color: .green)
                QuickActionButton(icon: "plus.circle", title: "Add Money", color: .orange)
                QuickActionButton(icon: "chart.bar", title: "Analytics", color: .purple)
            } else if title.contains("Journey") {
                QuickActionButton(icon: "car.fill", title: "New Trip", color: .blue)
                QuickActionButton(icon: "location.fill", title: "Track", color: .green)
                QuickActionButton(icon: "fuelpump.fill", title: "Fuel", color: .orange)
                QuickActionButton(icon: "wrench.fill", title: "Service", color: .purple)
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
//    CustomProgressiveHeader()
//}
