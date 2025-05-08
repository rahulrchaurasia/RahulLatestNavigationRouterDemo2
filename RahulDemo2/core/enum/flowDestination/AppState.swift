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
    @Published var hasCompletedOnboarding: Bool
    @Published var isLoggedIn: Bool
    
    //Set here base on UserDefault Data Set
    init() {
        
        self.hasCompletedOnboarding = UserDefaultsManager.shared.hasCompletedOnboarding
        self.isLoggedIn = UserDefaultsManager.shared.isLoggedIn
    }
    

    func completeOnboarding() {
        hasCompletedOnboarding = true
        UserDefaultsManager.shared.hasCompletedOnboarding = true
    }

    func login() {
        isLoggedIn = true
        UserDefaultsManager.shared.isLoggedIn = true
    }

    func logout() {
        isLoggedIn = false
        UserDefaultsManager.shared.isLoggedIn = false // Set explicitly to false
        UserDefaultsManager.shared.logoutUser() // Clear other user data
    }
    
    //No used State transition methods
    func resetToOnboarding() {
        hasCompletedOnboarding = false
              isLoggedIn = false
              
              UserDefaultsManager.shared.hasCompletedOnboarding = false
              UserDefaultsManager.shared.isLoggedIn = false
    }
}

