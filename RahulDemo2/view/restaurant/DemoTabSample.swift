//
//  DemoTabSample.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 03/05/25.
//

/*
 .matchedGeometryEffect(id: "underline", in: underlineNamespace)
 id: "underline" helps SwiftUI recognize matching elements between different views or states.

 Namespace: (underlineNamespace) is the animation space that connects these matched elements.

 What happens practically?
 When the user selects a tab:

 The underline moves smoothly between tabs.

 SwiftUI identifies underlines with the same id and animates the transition naturally.

*/
import SwiftUI

struct DemoTabSample: View {
    
    @Namespace private var underlineNamespace
    @State private var selectedTab = "Home"
    
    let tabs = ["Home", "Profile", "Product"]
    var body: some View {
        
        VStack{
            HStack {
                ForEach(tabs, id: \.self) { tab in
                    VStack {
                        Text(tab)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedTab = tab
                                }
                            }
                        
                        if selectedTab == tab {
                            Capsule()
                                .frame(height: 2)
                                .matchedGeometryEffect(id: "underline", in: underlineNamespace)
                        } else {
                            Color.clear.frame(height: 2)
                        }
                    }
                }
            }
            Divider()
               
            
            // Content View
            ZStack {
                switch selectedTab {
                case "Home":
                    HomeView()
                case "Profile":
                    ProfileView()
                case "Product":
                    ProductView()
                default:
                    EmptyView()
                }
            }
           
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding()
       
    }
}


#Preview {
    DemoTabSample()
}
