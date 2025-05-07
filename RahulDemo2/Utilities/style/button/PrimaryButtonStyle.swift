//
//  PrimaryButtonStyle.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 01/05/25.
//

import Foundation
import SwiftUI


struct PrimaryButtonStyle: ButtonStyle {
    var backgroundColor: Color = .red
    var foregroundColor: Color = .white
    var cornerRadius: CGFloat = 20
    var font: Font = .title2

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(font)
            .foregroundStyle(foregroundColor)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor.opacity(configuration.isPressed ? 0.7 : 1))
            )
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
