//
//  AppCoordinatorOld.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 02/05/25.
//

import Foundation


class AppCoordinatorOld : ObservableObject {
    @Published var navigationPath: [AppDestination] = []
    @Published var currentFlow: AppFlow = .onboarding
    
    private var appState: AppStateOld
    
   // Observer Pattern with Closures

    init(appState: AppStateOld) {
        self.appState = appState
        
        // Set up observers for state changes
        appState.onboardingStateChanged = { [weak self] completed in
            if completed {
                self?.completeOnboarding()
            }
        }
        
        appState.loginStateChanged = { [weak self] loggedIn in
            if loggedIn {
                self?.completeLogin()
            } else {
                self?.logout()
            }
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
        navigationPath.removeAll()
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
