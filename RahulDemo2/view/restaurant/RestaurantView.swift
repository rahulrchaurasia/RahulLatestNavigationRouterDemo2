//
//  RestaurantView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 03/05/25.
//

import SwiftUI

struct RestaurantView: View {
    
    @EnvironmentObject var coordinator: AppCoordinator
    @StateObject private var viewModel: RestaurantDetailViewModel
        
        init(restaurantId: String = "123") {
            self._viewModel = StateObject(wrappedValue: RestaurantDetailViewModel(restaurantId: restaurantId))
        }
        
    var body: some View {
        ZStack {
                    VStack(spacing: 0) {
                        RestaurantNavigationBar(
                            title: viewModel.restaurant?.name ?? "Restaurant",
                            onBackTap: {
                                
                                coordinator.navigateBack()
                            },
                            onBookmarkTap: {
                                
                                coordinator.navigate(to: .home(.scrollTabSample))
                                
                            }, onShareTap: {
                                
                               
                                coordinator.navigate(to: .home(.collapsingToolbarSample(title: "Premium Coffees", subtitle: "Italian Espresso", rating: "4.2", details: "Premium Selection of Coffee", image: "food", expandedHeight: 260)))
                            }
                        )
                        
                        if let restaurant = viewModel.restaurant {
                            RestaurantTabBarView(
                                selectedTab: $viewModel.selectedTab,
                                tabs: RestaurantTab.allCases
                            )
                            
                            Divider()
                            
                            RestaurantContentView(
                                viewModel: viewModel,
                                restaurant: restaurant
                            )
                            
                            RestaurantActionBar(
                                onBookTable: { viewModel.bookTable() },
                                onPayBill: { viewModel.payBill() }
                            )
                        }
                    }
                    
                    if viewModel.isLoading {
                        LoadingOverlay()
                    }
                    
                    if let errorMessage = viewModel.errorMessage {
                        ErrorView(
                            message: errorMessage,
                            onRetry: {
                                Task { await viewModel.loadRestaurantDetails() }
                            }
                        )
                    }
                }
                .task {
                    await viewModel.loadRestaurantDetails()
                }
    }
}

#Preview {
    RestaurantView()
}
