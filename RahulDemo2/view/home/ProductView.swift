//
//  ProductView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 01/05/25.
//

import SwiftUI

struct ProductView: View {
    
    
    @EnvironmentObject var coordinator: AppCoordinator
       @EnvironmentObject var appState: AppState
   
    var body: some View {
        VStack{
            Text("Product")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            
            Spacer()
            
            List {
                Button("View Pasta Dish") {
                    // Using parameter with extension method
                    coordinator.navigate(to: HomeFlow.dishDetails(dishId: "PASTA123").asDestination())
                }
                .padding()
                
                Button("View Pizza") {
                    // Direct approach with parameter
                    coordinator.navigate(to: HomeFlow.dishDetails(dishId: "PIZZA456").asDestination())
                }
                .padding()
            }
        
            Spacer()

        }
    }
}

#Preview {
    ProductView()
}
