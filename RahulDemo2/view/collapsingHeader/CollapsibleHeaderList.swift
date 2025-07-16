//
//  CollapsibleHeaderList.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 15/07/25.
//

import SwiftUI

import SwiftUI
/*
 For apps targeting iOS 17 and later, you should use the native .scrollPosition(id:)
 */
//Note: You do NOT need your own ScrollOffsetPreferenceKey, nor manual header animation, unless you want custom collapsible logic like:

/*
 LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders])
 And a Section(header: ...), SwiftUI automatically pins and animates headers like a native sticky header.
 */

import SwiftUI

// A simple PreferenceKey to pass the scroll offset up the view hierarchy.
//struct ScrollOffsetPreferenceKey: PreferenceKey {
//    static var defaultValue: CGFloat = 0
//    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
//        value = nextValue()
//    }
//}

public struct CollapsibleHeaderList: View {
    // MARK: - State Vars
    @State private var headerHeight: CGFloat = 40.0
    @State private var previousScrollOffset: CGFloat = 0
    
    // MARK: - Private Constants
    private let items = Array(0..<100)
    private let expandedHeight: CGFloat = 40.0
    private let collapsedHeight: CGFloat = 0.0

    // MARK: - View
    public var body: some View {
        VStack(spacing: 0) {
            // 1. The Collapsible Header
            Rectangle()
                .foregroundColor(.pink)
                .frame(height: headerHeight)
                .animation(.easeOut(duration: 0.25), value: headerHeight)

            // 2. The Scrollable List
            ScrollView {
                VStack {
                    // 3. The "Sensor" view using GeometryReader
                    // This invisible view tracks its position to determine the scroll offset.
                    GeometryReader { geo in
                        Color.clear
                            .preference(
                                key: ScrollOffsetPreferenceKey.self,
                                value: geo.frame(in: .named("scroll")).minY
                            )
                    }
                    .frame(height: 0) // It should not take up any space.

                    // Your actual list content
                    ForEach(items, id: \.self) { item in
                        Text("Item \(item)")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .coordinateSpace(name: "scroll") // 4. Define the coordinate space
            .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: handleScrollOffset)
            .listStyle(.plain)
        }
    }
    
    // MARK: - Private Methods
    private func handleScrollOffset(_ offset: CGFloat) {
        // Calculate the difference from the last known offset
        let offsetDifference = offset - previousScrollOffset

        // Only trigger animations if the scroll is significant
        if abs(offsetDifference) > 10 {
            if offsetDifference < 0 {
                // Scrolling Down: Collapse header if it's not already collapsed
                if headerHeight != collapsedHeight {
                    headerHeight = collapsedHeight
                }
            } else {
                // Scrolling Up: Expand header if it's not already expanded
                if headerHeight != expandedHeight {
                    headerHeight = expandedHeight
                }
            }
        }
        
        // Update the last known offset
        self.previousScrollOffset = offset
    }
}

#Preview {
    CollapsibleHeaderList()
}
