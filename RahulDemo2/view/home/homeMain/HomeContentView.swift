//
//  HomeContentView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 07/05/25.
//

import SwiftUICore
import SwiftUI

enum TabHomeItem: String, CaseIterable,Identifiable {
    
    var id: String { self.rawValue }
    
    case sellers = "Sellers"
    case brands = "Brands"
    case top = "Top"
}
struct HomeContentView: View {
   
    
    @State private var selectedTab: TabHomeItem = .sellers
    
    var body: some View {
        VStack(spacing : 0){
            
            // Tab Header
            tabHeader
            
            Divider()
            
            // TabView with paging style for swipe functionality
           
            TabView(selection: $selectedTab) {
                
                SellersView()
                    .tag(TabHomeItem.sellers)
                
                BrandView()
                    .tag(TabHomeItem.brands)
                
                TopView()
                    .tag(TabHomeItem.top)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut, value: selectedTab)
        }
    }
    
    private var tabHeader: some View {
            HStack {
                ForEach(TabHomeItem.allCases, id: \.self) { tab in
                    Button(action: {
                        
                        withAnimation(.easeInOut(duration: 0.3)) {
                            selectedTab = tab
                        }
                    }) {
                        VStack(spacing: 8) {
                            Text(tab.rawValue)
                                .font(.subheadline)
                                .fontWeight(selectedTab == tab ? .semibold : .regular)
                                .foregroundColor(selectedTab == tab ? .blue : .gray)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                            
                            // Indicator
                            Rectangle()
                                .fill(selectedTab == tab ? Color.blue : Color.clear)
                                .frame(height: 3)
                                .animation(.spring(), value: selectedTab)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
        }
    
    
}


#Preview {
    HomeContentView()
}


