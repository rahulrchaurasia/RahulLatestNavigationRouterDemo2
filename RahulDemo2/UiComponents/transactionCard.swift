//
//  transactionCard.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 15/07/25.
//

import SwiftUI

struct TransactionJourney1Card: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Transaction Journey")
                .font(.title2.bold())
            
            Button(action: {}) {
                Text("START JOURNEY")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(28)
            }
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(24)
        .background(Color.white)
        .cornerRadius(20)
    }
}

#Preview {
    TransactionJourney1Card()
}
