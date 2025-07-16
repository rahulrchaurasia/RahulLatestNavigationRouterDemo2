//
//  CarJourneyView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 15/07/25.
//

import SwiftUI

struct CarJourneyCollapseView: View {
    // --- Configuration ---
    private let expandedHeight: CGFloat = 280
    private let collapsedHeight: CGFloat = 90

    // --- State ---
    @State private var scrollOffset: CGFloat = 0

    // --- Computed Properties for Animation ---
    
    /// The overall progress of the collapse [0.0 -> 1.0]. This is the single source of truth.
    private var scrollProgress: CGFloat {
        min(1.0, max(0.0, scrollOffset / (expandedHeight - collapsedHeight)))
    }
    
    /// The current height of the header, which shrinks on scroll.
    private var headerHeight: CGFloat {
        expandedHeight - (scrollProgress * (expandedHeight - collapsedHeight))
    }

    /// Opacity for the collapsed title. Fades in at the end.
    private var titleAlpha: Double {
        guard scrollProgress > 0.9 else { return 0 }
        return Double((scrollProgress - 0.9) / 0.1)
    }
    
    /// Opacity for the expanded content (search bar, buttons). Fades out on scroll.
    private var searchContentAlpha: Double {
        Double(1.0 - (scrollProgress * 1.5))
    }
    
    /// Opacity for the collapsed search icon. Fades in at the end.
    private var searchIconAlpha: Double {
        guard scrollProgress > 0.95 else { return 0 }
        return Double((scrollProgress - 0.95) / 0.05)
    }

    var body: some View {
        ZStack(alignment: .top) {
            // --- Background ScrollView ---
            ScrollView {
                // 1. GeometryReader to capture the scroll offset.
                GeometryReader { proxy in
                    Color.clear.preference(
                        key: ScrollOffsetPreferenceKey.self,
                        value: -proxy.frame(in: .global).minY
                    )
                }
                .frame(height: 0)

                // 2. The list content, pushed down by the header's height.
                VStack(spacing: 16) {
                    ForEach(1...20, id: \.self) { index in
                        Text("List Item \(index)")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                .padding(.top, expandedHeight)
            }
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                self.scrollOffset = value
            }

            // --- The Unified, Transforming Header ---
            ProgressiveCollapsingHeader(
                height: headerHeight,
                scrollProgress: scrollProgress,
                titleAlpha: titleAlpha,
                searchContentAlpha: searchContentAlpha,
                backgroundProgress: scrollProgress,
                searchIconAlpha: searchIconAlpha,
                onBackClick: {
                    // Handle back action
                },
                onSearchClick: {
                    // Handle search action
                }
            )
        }
       // .ignoresSafeArea(.top)
        .navigationBarHidden(true)
    }
}


#Preview {
    CarJourneyCollapseView()
}
