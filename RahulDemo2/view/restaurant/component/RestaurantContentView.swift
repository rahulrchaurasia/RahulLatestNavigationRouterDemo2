//
//  RestaurantContentView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 03/05/25.
//

import SwiftUI

struct RestaurantContentView: View {
    @ObservedObject var viewModel: RestaurantDetailViewModel
    let restaurant: Restaurant
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(RestaurantTab.allCases) { tab in
                        RestaurantSectionView(
                            tab: tab,
                            restaurant: restaurant
                        )
                        .background(
                            GeometryReader { geo in
                                Color.clear
                                    .onAppear {
                                        viewModel.tabOffsets[tab] = geo.frame(in: .named("scrollView")).minY
                                    }
                                    .onChange(of: geo.frame(in: .named("scrollView")).minY) { newY in
                                        if !viewModel.isDragging {
                                            return
                                        }
                                        
                                        viewModel.tabOffsets[tab] = newY
                                        viewModel.updateSelectedTab(scrollOffset: newY)
                                    }
                            }
                        )
                        .id(tab)
                    }
                }
                .padding()
            }
            .coordinateSpace(name: "scrollView")
            .onChange(of: viewModel.selectedTab) { tab in
                withAnimation {
                    proxy.scrollTo(tab, anchor: .top)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { _ in
                        viewModel.isDragging = true
                    }
                    .onEnded { _ in
                        viewModel.isDragging = false
                    }
            )
        }
    }
}

//#Preview {
//    RestaurantContentView()
//}
