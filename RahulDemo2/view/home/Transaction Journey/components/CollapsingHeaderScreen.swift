//
//  CollapsingHeaderScreen.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 15/07/25.
//

import SwiftUI

struct CollapsingHeaderScreen: View {
    @StateObject private var viewModel = CollapsingHeaderDataViewModel()

    var body: some View {
        ZStack(alignment: .top) {
            // The content scrolls underneath the header.
            ScrollView(showsIndicators: false) {
                // This GeometryReader is the key to getting the scroll offset.
                GeometryReader { proxy in
                    Color.clear.preference(
                        key: ScrollOffsetPreferenceKey.self,
                        value: proxy.frame(in: .global).minY
                    )
                }
                .frame(height: 0) // It takes up no space.

                // The main content of the list.
                VStack(spacing: 16) {
                    TransactionJourney1Card()
                    ForEach(1...20, id: \.self) { i in
                        Transaction1ListItem(
                            title: "Transaction \(i)",
                            amount: String(format: "$%.2f", Double(i) * 25.0)
                        )
                    }
                }
                .padding(.horizontal)
                // Critical: This padding pushes the content down so it starts
                // exactly below the fully expanded header.
                .padding(.top, viewModel.expandedHeight)
            }
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                // Update the view model with the latest scroll position.
                viewModel.scrollOffset = value
            }

            // The header is overlaid on top of the ScrollView.
            ProgressiveHeaderView(viewModel: viewModel)
        }
        .ignoresSafeArea()
        .background(Color(.systemGroupedBackground))
    }
}


#Preview {
    CollapsingHeaderScreen()
}
