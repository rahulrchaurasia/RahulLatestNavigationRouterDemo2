//
//  CustomTabBar.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 07/05/25.
//

import SwiftUICore
import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(
                imageName: "house.fill",
                title: "Home",
                isSelected: selectedTab == 0,
                action: { selectedTab = 0 }
            )
            
            TabBarButton(
                imageName: "calendar",
                title: "Transaction",
                isSelected: selectedTab == 1,
                action: { selectedTab = 1 }
            )
            
            TabBarButton(
                imageName: "car.fill",
                title: "Car Journey",
                isSelected: selectedTab == 2,
                action: { selectedTab = 2 }
            )
            
            TabBarButton(
                imageName: "bell.fill",
                title: "Notification",
                isSelected: selectedTab == 3,
                action: { selectedTab = 3 }
            )
        }
        .frame(height: 70)
        .background(Color.tabBar)
    }
}

#Preview {
     

    
      var selectedTab = 0
     
    VStack {
        Spacer()
        CustomTabBar(selectedTab: .constant(selectedTab))
    }
       
}


