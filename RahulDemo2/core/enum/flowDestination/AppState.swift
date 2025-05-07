//
//  AppState.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 24/04/25.
//




import SwiftUI
import Combine

final class AppState: ObservableObject {
    // Simple published properties without callbacks
    @Published var hasCompletedOnboarding: Bool = false
    @Published var isLoggedIn: Bool = false
    
    // State transition methods
    func resetToOnboarding() {
        hasCompletedOnboarding = false
        isLoggedIn = false
    }

    func completeOnboarding() {
        hasCompletedOnboarding = true
    }

    func login() {
        isLoggedIn = true
    }

    func logout() {
        isLoggedIn = false
    }
}

