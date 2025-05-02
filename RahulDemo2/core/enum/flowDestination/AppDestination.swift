//
//  AppDestination.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 02/05/25.
//

import Foundation


// Unified destination enum
enum AppDestination: Hashable {
    case onboarding(OnboardingFlow)
    case login(LoginFlow)
    case home(HomeFlow)
}


enum OnboardingFlow: Hashable {
    case welcome, tutorial,onBoardings

}


enum LoginFlow: Hashable{
    case login, forgotPassword, signUp

    
}


enum HomeFlow: Hashable {
    case home
    case cartJourney
    case profile
    case dishDetails(dishId: String) // ✅ parameter added
    case product
    
}
