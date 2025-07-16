//
//  HomeView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 24/04/25.
//

import SwiftUI

struct HomeView: View {
    
   
    @State private var selectedTab = 0 // Default to Home tab
    private let tabBarHeight: CGFloat = 80 
    var body: some View {
        
        ZStack(alignment: .bottom) {
            // Content based on selected tab
            TabContentView(selectedTab: selectedTab)
            // 1. Add padding to the entire content view.
                           // This pushes the content of EACH tab up by the tab bar's height.
                           .padding(.bottom, tabBarHeight)

            
            // Tab bar
            CustomTabBar(selectedTab: $selectedTab)
                //.ignoresSafeArea(.keyboard)
               // .frame(height: tabBarHeight) // Give the tab bar an explicit height
        }
        // 2. Ignore the safe area for the ZStack so the tab bar can sit at the very bottom.
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
                //CarJourneyView()
                //CollapsingHeaderScreen()
               // ImageCollapsingHeaderView()
               // CarJourneyCollapseView()
                CollapsibleHeaderList()
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
