//
//  BlurEffect.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 15/07/25.
//

import Foundation
import SwiftUI

struct BlurEffect: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
