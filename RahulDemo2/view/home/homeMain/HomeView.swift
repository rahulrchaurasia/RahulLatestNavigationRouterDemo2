//
//  HomeView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 24/04/25.
//

import SwiftUI

struct HomeView: View {
    
   
    @State private var selectedTab = 0 // Default to Home tab
    var body: some View {
        
        ZStack(alignment: .bottom) {
            // Content based on selected tab
            TabContentView(selectedTab: selectedTab)
            
            
            // Tab bar
            CustomTabBar(selectedTab: $selectedTab)
                //.ignoresSafeArea(.keyboard)
        }
        .ignoresSafeArea(.keyboard)
       
       
        
        
    }
    
    
   
}


// New component to handle tab content
struct TabContentView: View {
    let selectedTab: Int
    
    var body: some View {
        Group {
            switch selectedTab {
            case 0:
                HomeContentView()
            case 1:
                TransactionJourneyView()
            case 2:
                CarJourneyView()
            case 3:
                NotificationView()
            default:
                Text("Invalid Tab")
            }
        }
    }
}




#Preview {
    HomeView()
}
