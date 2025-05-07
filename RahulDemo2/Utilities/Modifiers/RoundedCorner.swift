//
//  RoundedCorner.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 06/05/25.
//

import Foundation


import SwiftUI

// MARK: - Custom Shape for Specific Rounded Corners
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - ViewModifier Wrapper
struct RoundedCornerModifier: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    func body(content: Content) -> some View {
        content
            .clipShape(
                RoundedCorner(radius: radius, corners: corners)
            )
    }
}

// MARK: - Extension for Easier Use
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        self.modifier(RoundedCornerModifier(radius: radius, corners: corners))
    }
}

// MARK: - Preview Demo
struct RoundedCornerModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            
            Text("Top Corners Rounded")
                .padding()
                .frame(width: 250, height: 100)
                .background(Color.blue)
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .foregroundColor(.white)

            Text("Bottom Corners Rounded")
                .padding()
                .frame(width: 250, height: 100)
                .background(Color.green)
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                .foregroundColor(.white)

            Text("Top-Left and Bottom-Right Only")
                .padding()
                .frame(width: 250, height: 100)
                .background(Color.pink)
                .cornerRadius(20, corners: [.topLeft, .bottomRight])
                .foregroundColor(.white)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
