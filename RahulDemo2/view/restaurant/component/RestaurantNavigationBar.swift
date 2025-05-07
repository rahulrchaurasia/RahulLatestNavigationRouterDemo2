//
//  RestaurantNavigationBar.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 03/05/25.
//

import SwiftUI

struct RestaurantNavigationBar: View {
    let title: String
    let onBackTap: () -> Void
    var onBookmarkTap: (() -> Void)? = nil
    var onShareTap: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Button(action: onBackTap) {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
            
            Spacer()
            
            HStack(spacing: 16) {
                if let onBookmarkTap = onBookmarkTap {
                    
                    Button(action: { onBookmarkTap() }) {
                        Image(systemName: "bookmark")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                }
               
                
                Button(action: { onShareTap?() }) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title3)
                        .foregroundColor(.black)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

//#Preview {
//    RestaurantNavigationBar()
//}
