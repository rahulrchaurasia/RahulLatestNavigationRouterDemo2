//
//  OfferCardView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 03/05/25.
//

import SwiftUI

struct OfferCardView: View {
    let offer: Offer
    var onBookNow: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(offer.title)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text(offer.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(offer.validUntil)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                }
                
                Spacer()
                
                Text(offer.discountText)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding(10)
                    .background(
                        Circle()
                            .fill(Color.pink)
                    )
            }
            
            Button(action: { onBookNow?() }) {
                Text("Book now")
                    .font(.headline)
                    .foregroundColor(.pink)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.pink, lineWidth: 1)
                    )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
}

// Similar implementations for other card components

//#Preview {
//    OfferCardView()
//}
