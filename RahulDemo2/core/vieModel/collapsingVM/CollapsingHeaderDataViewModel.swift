//
//  CollapsingHeaderViewModel.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 15/07/25.
//

import Foundation
import SwiftUICore




class CollapsingHeaderDataViewModel: ObservableObject {
    // --- Configuration ---
    let expandedHeight: CGFloat = 280
    let collapsedHeight: CGFloat = 80 // Includes safe area

    // --- Input ---
    @Published var scrollOffset: CGFloat = 0

    // --- Output (Derived Animated Properties) ---

    /// The overall progress of the collapse, from 0.0 (fully expanded) to 1.0 (fully collapsed).
    /// This is the single source of truth for all animations.
    var scrollProgress: CGFloat {
        let scrollRange = expandedHeight - collapsedHeight
        guard scrollRange > 0 else { return 0 }
        // We use max(0, scrollOffset) to prevent progress from becoming negative on "bounce"
        return min(max(0, scrollOffset) / scrollRange, 1)
    }

    /// The header's current height, shrinking as the user scrolls.
    var currentHeaderHeight: CGFloat {
        expandedHeight - (scrollProgress * (expandedHeight - collapsedHeight))
    }

    /// Opacity for the large title and search bar. Fades out quickly.
    var expandedContentOpacity: Double {
        // Fades out completely by the time the scroll is 50% complete.
        Double(1 - (scrollProgress * 2))
    }

    /// Opacity for the small, collapsed title. Fades in only at the very end.
    var collapsedTitleOpacity: Double {
        // Starts fading in only when the collapse is 90% complete.
        guard scrollProgress > 0.9 else { return 0 }
        return Double((scrollProgress - 0.9) * 10) // Animate from 0 to 1 over the last 10%
    }
    
    /// The background color, transitioning smoothly from teal to white.
    var backgroundColor: Color {
        Color.teal.interpolate(to: .white, fraction: scrollProgress)
    }

    /// The icon color (back button, search), transitioning from white to black.
    var iconAndTitleColor: Color {
        Color.white.interpolate(to: .black, fraction: scrollProgress)
    }
}
