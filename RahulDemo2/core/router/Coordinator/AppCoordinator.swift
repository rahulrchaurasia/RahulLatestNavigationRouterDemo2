//
//  AppCoordinator.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 02/05/25.
//

import Foundation
import Combine

//Note :
/*
    .dropFirst() skips the initial value that publishers emit when you subscribe to them
//This prevents navigation actions from being triggered immediately on initialization

 .sink { ... } :  creates a subscriber that executes the closure when a new value is published
 We use [weak self] to avoid retain cycles
*/

enum AppFlow {
    case onboarding
    case login
    case home
}
class AppCoordinator: ObservableObject {
    @Published var navigationPath: [AppDestination] = []
    @Published var currentFlow: AppFlow = .onboarding
    
    private var cancellables = Set<AnyCancellable>()
    private let appState: AppState // Keep a strong reference to prevent early deallocation
    
    // Observer Pattern with Closures
    
    init(appState: AppState) {
        self.appState = appState // Store reference to appState
        // Set initial flow based on app state
        
        updateCurrentFlow(basedOn: appState)
        
        // Observe changes to onboarding state
        appState.$hasCompletedOnboarding
            .dropFirst() // Skip initial value is fine for onboarding
            .sink { [weak self] completed in
                if completed && self?.currentFlow == .onboarding {
                    self?.completeOnboarding()
                }
            }
            .store(in: &cancellables)
        
        // Observe changes to login state - more consistent handling
        appState.$isLoggedIn
            .dropFirst() // Skip initial value
            .sink { [weak self] isLoggedIn in
                self?.handleLoginStateChange(isLoggedIn)
            }
            .store(in: &cancellables)
    }
    
    
    // Helper method to encapsulate flow determination logic
    private func updateCurrentFlow(basedOn appState: AppState) {
        if appState.isLoggedIn {
            currentFlow = .home
        } else if appState.hasCompletedOnboarding {
            currentFlow = .login
        } else {
            currentFlow = .onboarding
        }
    }
    
    // Centralized handler for login state changes
    private func handleLoginStateChange(_ isLoggedIn: Bool) {
        if isLoggedIn {
            // If logging in from login flow, proceed to home
            if currentFlow == .login {
                completeLogin()
            }
        } else {
            // If logging out from any flow, go to login
            // This is crucial - don't check current flow for logout
            logout()
        }
    }
        
    // Single navigation method
    func navigate(to destination: AppDestination) {
        navigationPath.append(destination)
    }
    
    // Major flow transitions
    func completeOnboarding() {
        navigationPath.removeAll()
        currentFlow = .login
    }
    
    func completeLogin() {
        navigationPath.removeAll() // This clears the entire navigation path
        currentFlow = .home
    }
    
    func logout() {
        navigationPath.removeAll()
        currentFlow = .login
    }
    
    // Standard navigation controls
    func navigateBack() {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast()
    }
    
    func navigateToRoot() {
        navigationPath.removeAll()
    }
    
    // Pop to a specific depth
    func popToDepth(_ depth: Int) {
        guard depth >= 0 && depth < navigationPath.count else { return }
        navigationPath = Array(navigationPath.prefix(depth))
    }
    
    func navigateBack(to destination: AppDestination) {
        
        // First check if the destination exists in the navigation path
        guard navigationPath.contains(destination) else {
            // The destination doesn't exist in the current path
            print("Warning: Attempted to navigate back to a destination that's not in the navigation path")
            return
        }
        
        // Find the index and navigate back
        if let index = navigationPath.firstIndex(of: destination) {
            navigationPath = Array(navigationPath.prefix(through: index))
        }
    }
}



