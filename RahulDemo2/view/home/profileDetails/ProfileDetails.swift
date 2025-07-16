//
//  ProfileDetails.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 15/07/25.
//

import SwiftUI

struct ProfileDetails: View {
    var body: some View {
        CollapsingHeaderContainer(
            title: "Profile",
            headerColor: .purple,
            maxHeaderHeight: 240,
            minHeaderHeight: 88,
            onBackClick: {
                print("Back from profile")
            },
            onSearchClick: {
                print("Search profile")
            }
        ) {
            LazyVStack(spacing: 12) {
                ForEach(1..<21) { index in
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Profile Item \(index)")
                            .font(.headline)
                            .fontWeight(.medium)
                        Text("This is a sample profile item")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                    .padding(.horizontal, 16)
                }
            }
        }
    }
}

#Preview {
    ProfileDetails()
}
