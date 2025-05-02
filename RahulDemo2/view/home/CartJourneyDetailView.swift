//
//  CarJourneyDetailView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 24/04/25.
//

import SwiftUI

struct CartJourneyDetailView: View {
    
    
    @EnvironmentObject var coordinator: AppCoordinator
       @EnvironmentObject var appState: AppState
   
    var body: some View {
        VStack(alignment:.center, spacing:20){
            Text("Cart Journey Detail")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            Spacer()
            
            Button("Go to Product") {
                
                coordinator.navigateBack(to: .home(.product))
             
            }
            .buttonStyle(PrimaryButtonStyle(backgroundColor: .blue.opacity(0.8)))
            .padding(.horizontal,40)
            
            Button {
               
                coordinator.navigationPath.removeLast()
            } label: {
               
                Label("back", systemImage: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.white)
                 
                    .padding()
                    .background(RoundedRectangle(cornerRadius:  20)
                        .fill(Color.red)
                    )
            }
            
            Button {
               
                coordinator.navigateToRoot()
            } label: {
               
                Label("back", systemImage: "house")
                    .font(.title2)
                    .foregroundStyle(.white)
                 
                    .padding()
                    .background(RoundedRectangle(cornerRadius:  20)
                        .fill(Color.red)
                    )
            }
            
            Spacer()
        }
    }
}

#Preview {
    CartJourneyDetailView()
}
