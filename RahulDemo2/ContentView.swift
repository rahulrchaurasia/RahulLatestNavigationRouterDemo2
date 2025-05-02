//
//  ContentView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 24/04/25.
//

import SwiftUI

struct ContentView: View {
   
    @StateObject private var appState = AppState()
      
    var body: some View {
            // Create CoordinatorView and pass appState as a parameter
            CoordinatorView(appState: appState)
                .environmentObject(appState)
        }
}


// Separate coordinator view to avoid initialization issues
struct CoordinatorView: View {
    // Accept AppState as a parameter
    let appState: AppState
    
    // Create coordinator with the passed AppState
    @StateObject private var coordinator: AppCoordinator
    
    // Make sure all properties are initialized
    init(appState: AppState) {
        self.appState = appState
        let coordinator = AppCoordinator(appState: appState)
        self._coordinator = StateObject(wrappedValue: coordinator)
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            Group {
                switch coordinator.currentFlow {
                case .onboarding:
                    OnboardingFlowView()
                case .login:
                  //  LoginFlowView()
                    LoginView()
                      
                case .home:
                    //HomeFlowView()
                    HomeView()
                }
            }
            .navigationDestination(for: AppDestination.self) { destination in
                destination.destinationView()
                    .environmentObject(appState)
                    .environmentObject(coordinator)
            }
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    ContentView()
}
