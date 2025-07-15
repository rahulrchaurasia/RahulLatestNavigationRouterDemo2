//
//  UniformRow.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 09/05/25.
//

import SwiftUI

struct MaxWidthKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct UniformRow: View {
    @State private var maxWidth: CGFloat = 0

    var body: some View {
        VStack(alignment: .leading) {
            Text("Dynamic Short").modifier(TrackWidth())
            Text("Much Longer Text Here").modifier(TrackWidth())
            Text("Mid Length").modifier(TrackWidth())
        }
        .frame(width: maxWidth)
        .onPreferenceChange(MaxWidthKey.self) { value in
            maxWidth = value
        }
    }
}

struct TrackWidth: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(GeometryReader { geo in
                Color.clear
                    .preference(key: MaxWidthKey.self, value: geo.size.width)
            })
    }
}

#Preview {
    UniformRow()
}
