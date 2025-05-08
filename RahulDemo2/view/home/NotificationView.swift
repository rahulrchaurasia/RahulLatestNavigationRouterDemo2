//
//  NotificationView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 07/05/25.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        

        ZStack{
            
            Color(.bg)
            VStack {
             
               
                VStack{
                    Text("Notification")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.top,.topInsets)
                    
                    Spacer()
 
                   
                }
                
            }
            .frame( maxHeight: .infinity, alignment: .top)
            .frame( maxWidth: .infinity)
                .padding(.top, .topInsets)
                .padding(.bottom, .bottomInsets)
                .statusBarBackground(.statusBarColor) //extension of view
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    NotificationView()
}
