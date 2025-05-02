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
        
        VStack{
            Text("Profile")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            
            Spacer()
            Button {
               
                
                appState.logout()
               // coordinator.logout()
            } label: {
               
                Label("Logout", systemImage: "lock")
                    .font(.title)
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
    ProfileView()
}


//DishDetailView()

