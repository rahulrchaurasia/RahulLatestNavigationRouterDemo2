//
//  OnboardingFlowView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 29/04/25.
//

import SwiftUI

struct OnboardingFlowView: View {
   
    @EnvironmentObject var coordinator: AppCoordinator
        @EnvironmentObject var appState: AppState
    
    var body: some View {
            WelcomeView()
        }
}

#Preview {
    OnboardingFlowView()
}
