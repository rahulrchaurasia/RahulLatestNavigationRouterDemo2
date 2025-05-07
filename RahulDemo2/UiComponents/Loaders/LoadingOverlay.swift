//
//  LoadingOverlay.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 03/05/25.
//

import SwiftUI

struct LoadingOverlay: View {
    var body: some View {
        ProgressView()
            .scaleEffect(1.5)
            .background(Color.white.opacity(0.7))
    }
}

struct ErrorView: View {
    let message: String
    let onRetry: () -> Void
    
    var body: some View {
        VStack {
            Text("Error")
                .font(.headline)
            Text(message)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            Button("Retry", action: onRetry)
                .padding()
                .foregroundColor(.white)
                .background(Color.pink)
                .cornerRadius(8)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
        .shadow(radius: 5)
        .transition(.opacity)
    }
}



#Preview {
    LoadingOverlay()
}
