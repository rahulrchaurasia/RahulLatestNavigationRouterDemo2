//
//  TabBarButton.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 07/05/25.
//

import SwiftUICore
import SwiftUI

struct TabBarButton: View {
    let imageName: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: imageName)
                    .font(.system(size: 22))
                
                Text(title)
                    .font(.caption)
            }
            .foregroundColor(isSelected ? .red : .gray)
            .frame(maxWidth: .infinity)
        }
    }
}
