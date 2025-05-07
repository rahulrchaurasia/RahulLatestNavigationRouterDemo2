//
//  ShadowModifier.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 06/05/25.
//

import Foundation

import SwiftUI

struct ShadowModifier: ViewModifier {
    var color: Color = .black
    var radius: CGFloat = 4
    var x: CGFloat = 0
    var y: CGFloat = 2

    func body(content: Content) -> some View {
        content
            .shadow(color: color.opacity(0.15), radius: radius, x: x, y: y)
    }
}

extension View {
    func applyShadow(
        color: Color = .black,
        radius: CGFloat = 4,
        x: CGFloat = 0,
        y: CGFloat = 2
    ) -> some View {
        self.modifier(ShadowModifier(color: color, radius: radius, x: x, y: y))
    }
}




struct ShadowModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 30) {
            Text("Default Shadow")
                .padding()
                .frame(width: 200)
                .background(Color.blue)
                .cornerRadius(12)
                .applyShadow() // Default shadow

            Text("Custom Red Shadow")
                .padding()
                .frame(width: 200)
                .background(Color.white)
                .cornerRadius(12)
                .applyShadow(color: .red, radius: 10, x: 0, y: 5)

            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.yellow)
                .background(Color.white)
                .cornerRadius(30)
                .applyShadow(radius: 8)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .previewLayout(.sizeThatFits)
    }
}
