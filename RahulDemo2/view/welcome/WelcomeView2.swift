//
//  WelcomeView2.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 29/04/25.
//

import SwiftUI

struct WelcomeView2: View {
    
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack{
            Text("Welcome to Onboarding!")
            
            Button("Next Step") {
                
                // coordinator.
                
                coordinator.navigate(to: .onboarding(.onBoardings))
            }.buttonStyle(PrimaryButtonStyle())
                .padding(.horizontal,40)
            
            Button("Back") {
                coordinator.navigateBack()
            }
            .padding(.top, 12)
        }
    }
    
}

#Preview {
    WelcomeView2()
}
