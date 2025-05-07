//
//  RestaurantTabBarView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 03/05/25.
//

import SwiftUI

struct RestaurantTabBarView: View {
    @Binding var selectedTab: RestaurantTab
    let tabs: [RestaurantTab]
    @Namespace private var underlineNamespace
    
    var body: some View {
        ScrollViewReader { tabProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(tabs) { tab in
                        tabButton(for: tab)
                            .id(tab)
                            .onTapGesture {
                                withAnimation {
                                    selectedTab = tab
                                }
                            }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
            .onChange(of: selectedTab) { newTab in
                withAnimation {
                    tabProxy.scrollTo(newTab, anchor: .center)
                }
            }
        }
    }
    
    private func tabButton(for tab: RestaurantTab) -> some View {
        VStack(spacing: 4) {
            Text(tab.rawValue)
                .font(.system(size: 15))
                .fontWeight(selectedTab == tab ? .semibold : .regular)
                .foregroundColor(selectedTab == tab ? .pink : .gray)
                .padding(.horizontal, 4)
            
            if selectedTab == tab {
                Capsule()
                    .fill(Color.pink)
                    .frame(height: 2)
                    .matchedGeometryEffect(id: "underline", in: underlineNamespace)
            } else {
                Color.clear
                    .frame(height: 2)
            }
        }
    }
}
//#Preview {
//    RestaurantTabBarView()
//}
