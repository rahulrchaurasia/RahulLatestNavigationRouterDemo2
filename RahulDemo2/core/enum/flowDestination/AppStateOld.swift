//
//  AppStateOld.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 02/05/25.
//

import Foundation


final class AppStateOld: ObservableObject {
    //@Published var hasCompletedOnboarding: Bool = false
    //@Published var isLoggedIn: Bool = false
    
    
    @Published var hasCompletedOnboarding: Bool = false {
           didSet {
               // Notify any observers when this changes
               onboardingStateChanged?(hasCompletedOnboarding)
           }
       }
    
    
    @Published var isLoggedIn: Bool = false {
            didSet {
                // Notify any observers when this changes
                loginStateChanged?(isLoggedIn)
            }
        }

    // Callback closures to notify of state changes
      var onboardingStateChanged: ((Bool) -> Void)?
      var loginStateChanged: ((Bool) -> Void)?

    
    // Optional: for logout or onboarding reset
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
