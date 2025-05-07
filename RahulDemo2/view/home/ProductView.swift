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
        
        ZStack{
            
            Color(.bg)
               
               VStack{
                AppToolbar(
                    title: "Product",
                    dismissAction: {
                        coordinator.navigateBack()
                    },
                    homeAction: {
                        
                        coordinator.navigateToRoot()
                    }
                )
                
                
                ScrollView {
                    LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                        
                        // ✅ Buttons section (non-pinned)
                       
                        VStack(alignment: .center, spacing: 12) {
                            Button("View Pasta Dish") {
                                coordinator.navigate(to: HomeFlow.dishDetails(dishId: "PASTA123").asDestination())
                            }
                            .buttonStyle(PrimaryButtonStyle())
                            .padding(.horizontal,60)
                            
                            Button("View Pizza") {
                                coordinator.navigate(to: HomeFlow.dishDetails(dishId: "PIZZA456").asDestination())
                            }
                            .buttonStyle(PrimaryButtonStyle())
                            .padding(.horizontal,60)
                        }
                        
                        .padding(.top)
                        Section(header: HeaderView()) {
                            ForEach(1...30, id: \.self) { index in
                                Text("Row \(index)")
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
              }
               .frame( maxHeight: .infinity, alignment: .top)

                   .padding(.top, .topInsets)
                   .padding(.bottom, .bottomInsets)
                   .statusBarBackground(.statusBarColor) //extension of view
        }
        .ignoresSafeArea()
    }
}

struct HeaderView: View {
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea(edges: .horizontal)
            Text("📌 Pinned Header")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
        }
        .frame(height: 60)
    }
}
#Preview {
    ProductView()
}
