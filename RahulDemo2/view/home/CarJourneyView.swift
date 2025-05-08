//
//  CarJourneyView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 07/05/25.
//

import SwiftUI

struct CarJourneyView: View {
  
    var body: some View {

        ZStack{
            
            Color(.bg)
            VStack {
             
               
                VStack{
                    Text("Car Journey")
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
    CarJourneyView()
}
