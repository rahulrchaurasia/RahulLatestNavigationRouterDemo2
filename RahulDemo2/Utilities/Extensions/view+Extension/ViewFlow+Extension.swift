//
//  View+Extension.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 02/05/25.
//

import Foundation
import SwiftUI

//Navigation flow 
extension OnboardingFlow {
    @ViewBuilder
    func destinationView() -> some View {
        switch self {
        case .welcome:
            WelcomeView()
        case .tutorial:
            WelcomeView2()
        case .onBoardings:
            OnBoardingsView()
        }
    }
    
    func asDestination() -> AppDestination {
            return .onboarding(self)
        }
}

extension LoginFlow {
    @ViewBuilder
    func destinationView() -> some View {
        switch self {
        case .login:
            LoginView()
        case .forgotPassword:
            ForgotPasswordView()
        case .signUp:
            CreateAccountView(name: "Rahul")
        }
    }
    
    func asDestination() -> AppDestination {
           return .login(self)
       }
}

extension HomeFlow {
    @ViewBuilder
    func destinationView() -> some View {
        switch self {
        case .home:
            HomeView()
        case .cartJourney:
           // CartJourneyDetailView()
            TransactionJourneyView()
        case .profile:
            ProfileView()
        case .dishDetails(let dishId):
            DishDetailView(dishId: dishId)
        case .product:
            ProductView()
        case .restaurants:
           // RestaurantDetailView()
            RestaurantView()
        case .scrollTabSample:
            ScrollviewTabSampleView()
       
        case let .collapsingToolbarSample(title, subtitle, rating, details, image, expandedHeight):
            CollapsingHeaderView1(
                title: title,
                subtitle: subtitle ?? "", // ✅ unwrap or default
                rating: rating,           // ✅ String (non-optional)
                details: details,         // ✅ Optional, passed as-is
                image: image,
                expandedHeight: expandedHeight
            )

            
        }
    }
    
    func asDestination() -> AppDestination {
           return .home(self)
       }
}

extension AppDestination {
    @ViewBuilder
    func destinationView() -> some View {
        switch self {
        case .onboarding(let flow):
            flow.destinationView()
        case .login(let flow):
            flow.destinationView()
        case .home(let flow):
            flow.destinationView()
        }
    }
}


