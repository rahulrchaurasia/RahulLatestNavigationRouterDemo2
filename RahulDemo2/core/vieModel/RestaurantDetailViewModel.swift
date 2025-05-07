//
//  RestaurantDetailViewModel.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 03/05/25.
//

import Foundation

class RestaurantDetailViewModel : ObservableObject {
    
    
    @Published var restaurant: Restaurant?
    @Published var selectedTab: RestaurantTab = .preBookOffer
    @Published var tabOffsets: [RestaurantTab: CGFloat] = [:]
    @Published var isDragging: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let repository: RestaurantRepository
    private let restaurantId: String
    
    init(repository: RestaurantRepository = MockRestaurantRepository(), restaurantId: String = "123") {
        self.repository = repository
        self.restaurantId = restaurantId
    }
    
    
    @MainActor
    func loadRestaurantDetails() async {
        isLoading = true
        errorMessage = nil
        
        do {
            restaurant = try await repository.getRestaurantDetails(id: restaurantId)
        } catch {
            errorMessage = "Failed to load restaurant details: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    
    
    
    // ✅ SCROLL TO TAB: Core logic that determines which tab to select based on scroll position
    func updateSelectedTabOld(scrollOffset: CGFloat) {
        guard !tabOffsets.isEmpty else { return }
        
        // Find the tab section closest to the current scroll position
        let sortedTabs = tabOffsets.sorted {
            abs($0.value - scrollOffset) < abs($1.value - scrollOffset)
        }
        
        // Update selected tab if it's changed
        if let closest = sortedTabs.first?.key {
            if selectedTab != closest {
                selectedTab = closest
            }
        }
    }
    
    // CHANGE THIS FUNCTION
    func updateSelectedTab(scrollOffset: CGFloat) {
        guard !tabOffsets.isEmpty else { return }
        
        // ⭐️ CHANGE THIS: Improve the sorting logic
        let sortedTabs = tabOffsets.sorted { first, second in
            // Give preference to sections at or just below the top of the screen
            if first.value <= 20 && second.value <= 20 {
                // Both are near the top - choose the one closest to the top
                return abs(first.value) < abs(second.value)
            } else if first.value <= 20 {
                // First is near the top, second is below - prefer first
                return true
            } else if second.value <= 20 {
                // Second is near the top, first is below - prefer second
                return false
            } else {
                // Both are below the top - choose the one closest to the top
                return first.value < second.value
            }
        }
        
        // Update selected tab if it's changed
        if let closest = sortedTabs.first?.key {
            if selectedTab != closest {
                // ⭐️ ADD THIS: Use withAnimation for smoother tab switching
               // withAnimation {
                    selectedTab = closest
              //  }
            }
        }
    }
    
    func bookTable() {
            // In a real app, this would handle the booking logic
            print("Booking a table at \(restaurant?.name ?? "")")
        }
        
        func payBill() {
            // In a real app, this would handle the payment logic
            print("Opening payment screen for \(restaurant?.name ?? "")")
        }
}
