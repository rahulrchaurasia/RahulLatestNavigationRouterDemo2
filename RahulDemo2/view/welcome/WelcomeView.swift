//
//  WelcomeView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 29/04/25.
//

import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack{
            Text("Welcome1")
            
            Button("Go to Tutorial") {
               
                
                coordinator.navigate(to: OnboardingFlow.tutorial.asDestination())
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Button("Skip to Login") {
                coordinator.completeOnboarding()
            }.buttonStyle(PrimaryButtonStyle())
                .padding()
        }
    }
}

#Preview {
    WelcomeView()
}
