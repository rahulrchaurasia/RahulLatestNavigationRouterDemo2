//
//  TransactionHistoryView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 24/04/25.
//

import SwiftUI

struct TransactionHistoryView: View {
    var body: some View {
        VStack{
            Text("Transaction History")
            
            Button("Submit") {
                
                print("Transaction History")
            }
        }
    }
}

#Preview {
    TransactionHistoryView()
}
