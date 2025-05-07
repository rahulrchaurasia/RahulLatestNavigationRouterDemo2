//
//  RestaurantActionBar.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 03/05/25.
//

import SwiftUI

struct RestaurantActionBar: View {
    let onBookTable: () -> Void
    let onPayBill: () -> Void
    
    var body: some View {
        HStack(spacing: 10) {
            Button(action: onBookTable) {
                Text("Book a table")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.pink)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.pink, lineWidth: 1)
                    )
            }
            
            Button(action: onPayBill) {
                VStack(spacing: 2) {
                    Text("Pay bill")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    
                    Text("Tap to view offers")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.9))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.pink)
                )
            }
        }
        .padding()
    }
}

#Preview {
    RestaurantActionBar(onBookTable: {
       
        print("onBookTable")
    },
    onPayBill: {
        print("onPayBill")
    })
}
