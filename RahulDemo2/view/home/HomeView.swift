//
//  HomeView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 24/04/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack{
            Text("Home")
                .font(.largeTitle)
                .padding()
            
            
            Button("Show Restaurant") {
                // Direct approach
                coordinator.navigate(to: .home(.restaurants))
            }
            .buttonStyle(PrimaryButtonStyle(backgroundColor: .orange))
            .padding(.horizontal, 40)
            Spacer()
            
            Button("Go to Products") {
                // Using the extension method approach
                coordinator.navigate(to: HomeFlow.product.asDestination())
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(.horizontal, 40)
            
            
            Button("View Profile") {
                // Direct approach
                coordinator.navigate(to: .home(.profile))
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(.horizontal, 40)
            .padding(.top, 10)
            
            
            Button("Logout") {
                appState.logout()
                //coordinator.logout()
            }
            .padding(.top, 20)
            Spacer()
        }
        
        
    }
}

#Preview {
    HomeView()
}
