//
//  OnBoardingsView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 02/05/25.
//

import SwiftUI

struct OnBoardingsView: View {
   
    @EnvironmentObject var coordinator: AppCoordinator
       @EnvironmentObject var appState: AppState
   
    var body: some View {
        VStack{
            Text("Welcome to Onboarding!")
            
            Button("Finish Onboarding") {
                
                appState.completeOnboarding()
//                // Update both state objects
//                appState.completeOnboarding() // Set hasCompletedOnboarding = true
//                coordinator.completeOnboarding() // Update currentFlow = .login
            }.buttonStyle(PrimaryButtonStyle())
            .padding(.horizontal,40)
        }
    }
}

#Preview {
    OnBoardingsView()
}
