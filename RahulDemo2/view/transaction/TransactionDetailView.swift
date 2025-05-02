//
//  TransactionDetailView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 24/04/25.
//

import SwiftUI

struct TransactionDetailView: View {
    
    let id : String
    var body: some View {
        VStack{
            Text("Transaction")
            
            Button("Submit") {
                
                print("Transaction")
            }
        }
    }
}

#Preview {
    TransactionDetailView(id: "455")
}
