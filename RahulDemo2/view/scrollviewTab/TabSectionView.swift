//
//  TabSectionView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 05/05/25.
//

import SwiftUI

struct TabSectionView: View {
    
    let tab : RestaurantTab
    let title : String
    let description : String
    
    var body: some View {
       
        VStack(alignment: .leading,spacing: 12) {
            
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
                .padding(.bottom, 300)
        }
        .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    TabSectionView(tab: .photos, title: "Photos", description: "dswdwe ewdlwendwe ekwdekwndekwde edwed")
}
