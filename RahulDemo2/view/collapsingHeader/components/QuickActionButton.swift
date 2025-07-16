//
//  QuickActionButton.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 15/07/25.
//

import SwiftUI

struct QuickActionButton: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
                  Image(systemName: icon)
                      .font(.system(size: 24))
                      .foregroundColor(.white)
                      .frame(width: 50, height: 50)
                      .background(color)
                      .cornerRadius(12)
       
            
            Text(title)
                .font(.caption)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
}
#Preview {
    QuickActionButton(icon: "a1", title: "data", color: Color.blue)
}
