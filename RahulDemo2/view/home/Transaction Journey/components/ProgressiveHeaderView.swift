//
//  ProgressiveHeaderView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 15/07/25.
//

import SwiftUI

struct ProgressiveHeaderView: View {
    @ObservedObject var viewModel: CollapsingHeaderDataViewModel

    var body: some View {
        ZStack(alignment: .bottom) {
            // Layer 1: The animated background
            viewModel.backgroundColor

            // Layer 2: The expanded content (large title, search bar)
            VStack(spacing: 16) {
                Text("Find Amazing events\nhappening around you.")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                HStack {
                    TextField("Search for an event...", text: .constant(""))
                        .padding(12)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(24)

                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color.black.opacity(0.3))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 20)
            .opacity(viewModel.expandedContentOpacity)
            .scaleEffect(1 - (viewModel.scrollProgress * 0.1), anchor: .bottom)

            // Layer 3: The collapsed toolbar (back button, small title, search icon)
            HStack {
                Image(systemName: "arrow.left")
                Spacer()
                Text("Transactions")
                    .opacity(viewModel.collapsedTitleOpacity)
                Spacer()
                Image(systemName: "magnifyingglass")
            }
            .font(.title2.weight(.medium))
            .foregroundColor(viewModel.iconAndTitleColor)
            .padding(.horizontal, 20)
            .padding(.bottom, 12) // Position it correctly at the bottom
        }
        .frame(height: viewModel.currentHeaderHeight)
        .frame(maxHeight: .infinity, alignment: .top) // Stick to the top
        .shadow(color: .black.opacity(viewModel.scrollProgress * 0.2), radius: 5, y: 2)
        .animation(.easeOut(duration: 0.1), value: viewModel.scrollOffset)
    }
}


#Preview {
    ProgressiveHeaderView(viewModel: CollapsingHeaderDataViewModel())
}
