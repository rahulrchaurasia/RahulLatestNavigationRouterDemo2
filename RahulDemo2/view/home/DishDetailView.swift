//
//  DishDetailView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 01/05/25.
//

import SwiftUI

struct DishDetailView: View {
    
    let dishId: String
       
       @EnvironmentObject var coordinator: AppCoordinator
       @EnvironmentObject var appState: AppState
       
    var body: some View {
        
        VStack(spacing:20){
            Text("DishDetailView")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding(.top,20)
            
            Text("Viewing dish ID: \(dishId)")
                .padding()
            
            Spacer()
            
            Button(action: {
                coordinator.navigateToRoot()
            }) {
                Label("Home", systemImage: "arrow.backward.circle.fill")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.red)
                    )
                    .shadow(color: .red.opacity(0.4), radius: 5, x: 0, y: 4)
                    .contentShape(Rectangle())
            }
           
            .padding(.horizontal,40)
            
            
            
            Button("Back to Products") {
                coordinator.navigateBack()
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(.horizontal, 40)
            
            Button("Add To Cart") {
                coordinator.navigate(to: .home(.cartJourney))
            }
            .buttonStyle(PrimaryButtonStyle(backgroundColor: .orange))
            .padding(.horizontal, 40)
            Spacer()
        }
       
        
        
    }
}
#Preview {
    DishDetailView(dishId: "1222")
}

