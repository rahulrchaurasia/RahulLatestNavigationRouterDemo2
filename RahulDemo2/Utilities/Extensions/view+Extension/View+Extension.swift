//
//  View2+Extension.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 07/05/25.
//

import Foundation
import SwiftUICore
import UIKit

extension View {
    
    func statusBarBackground(_ color: Color) -> some View {
        self.overlay(
            color
                .frame(height: .topInsets)
                .ignoresSafeArea(edges: .top),
            alignment: .top
        )
    }
    
    
}
