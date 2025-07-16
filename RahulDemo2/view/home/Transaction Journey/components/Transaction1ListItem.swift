//
//  TransactionListItem\.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 15/07/25.
//

import SwiftUI

struct Transaction1ListItem: View {
    let title: String
    let amount: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title).font(.headline)
                Text("Lorem ipsum dolor sit amet").font(.subheadline).foregroundColor(.secondary)
            }
            Spacer()
            Text(amount)
                .font(.headline)
                .foregroundColor(.teal)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}
#Preview {
    Transaction1ListItem(title: "data", amount: "3400")
}
