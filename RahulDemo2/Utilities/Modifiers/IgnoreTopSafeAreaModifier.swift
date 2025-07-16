//
//  IgnoreTopSafeAreaModifier.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 15/07/25.
//

import Foundation
import SwiftUICore
struct IgnoreTopSafeAreaModifier: ViewModifier {
    var ignore: Bool

    func body(content: Content) -> some View {
        if ignore {
            return AnyView(content.edgesIgnoringSafeArea(.top))
        } else {
            return AnyView(content)
        }
    }
}
