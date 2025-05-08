//
//  ScrollOffsetPreferenceKey.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 08/05/25.
//
import SwiftUICore


struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
