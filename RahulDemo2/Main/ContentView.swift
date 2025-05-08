//
//  ContentView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 24/04/25.
//

import SwiftUI

struct ContentView: View {
   
  //  @StateObject private var appState = AppState()
    
    
      
    var body: some View {
            // Create CoordinatorView and pass appState as a parameter
//            CoordinatorView(appState: appState)
//                .environmentObject(appState)
        
           CoordinatorView()
        }
}


// Separate coordinator view to avoid initialization issues
struct CoordinatorView: View {
    // Accept AppState as a parameter
    //let appState: AppState
    @StateObject private var appState: AppState
    
    // Create coordinator with the passed AppState
    @StateObject private var coordinator: AppCoordinator
    
    @StateObject private var loginViewModel: LoginViewModel
    
    // Make sure all properties are initialized
    init() {
        
        let appTempState = AppState()
        self._appState = StateObject(wrappedValue: appTempState)
        
        
        // Create coordinator using local variable
        let tempCoordinator = AppCoordinator(appState:  appTempState)
        self._coordinator = StateObject(wrappedValue: tempCoordinator)
        
        
        let loginviewModel = LoginViewModel()
        self._loginViewModel = StateObject(wrappedValue: loginviewModel)
    }
    /*********************** vip *******************************/
    //Mark : Take decsion which module we have to entered
    /******************************************************/
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            ZStack {
                switch coordinator.currentFlow {
                case .onboarding:
                    OnboardingFlowView()
                        .opacity(coordinator.currentFlow == .onboarding ? 1 : 0)
                        .zIndex(coordinator.currentFlow == .onboarding ? 1 : 0)
                case .login:
                    //  LoginFlowView()
                    LoginView()
                        .opacity(coordinator.currentFlow == .login ? 1 : 0)
                        .zIndex(coordinator.currentFlow == .login ? 1 : 0)
                    
                case .home:
                    //HomeFlowView()
                    HomeView()
                        .opacity(coordinator.currentFlow == .home ? 1 : 0)
                        .zIndex(coordinator.currentFlow == .home ? 1 : 0)
                }
            }
            .animation(.easeInOut(duration: 0.3), value: coordinator.currentFlow)
            .navigationDestination(for: AppDestination.self) { destination in
                destination.destinationView()
                
                    .navigationBarBackButtonHidden(true) // Hide back button for all destinations
            }
        }
        .environmentObject(appState)
        .environmentObject(coordinator)
        .environmentObject(loginViewModel)
    }
}

#Preview {
    ContentView()
}
