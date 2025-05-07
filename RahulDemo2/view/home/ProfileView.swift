//
//  ProfileView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 24/04/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var appState: AppState

    var body: some View {
        
        ZStack{
            
            Color(.bg)
            VStack {
                AppToolbar(
                    title: "Profile",
                    dismissAction: {
                        coordinator.navigateBack()
                    },
                    statusBarColor: .green
                )
               
                VStack{
                    Text("Profile")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Button {
                        appState.logout()
                    } label: {
                        Label("Logout", systemImage: "lock")
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 20)
                                .fill(Color.red)
                            )
                    }
                    
                    Spacer()
                }
                
            }
            .frame( maxHeight: .infinity, alignment: .top)

                .padding(.top, .topInsets)
                .padding(.bottom, .bottomInsets)
                .statusBarBackground(.statusBarColor) //extension of view
        }
        .ignoresSafeArea(.container, edges: .top)
        //.ignoresSafeArea()
     
    }
}

#Preview {
    ProfileView()
}


//DishDetailView()

