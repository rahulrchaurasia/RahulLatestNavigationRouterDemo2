//
//  VisibilityTrackerView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 09/05/25.
//

import SwiftUI

struct IsVisibleKey: PreferenceKey {
    static var defaultValue: Bool = false
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

struct VisibilityTrackerView: View {
    @State private var isVisible: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: 50) {
                ForEach(0..<10) { i in
                    Text("Row \(i)").frame(height: 60)
                }

                Text("Target View")
                    .frame(height: 100)
                    .background(Color.yellow)
                    .overlay(
                        GeometryReader { geo in
                            Color.clear.preference(
                                key: IsVisibleKey.self,
                                value: UIScreen.main.bounds.intersects(geo.frame(in: .global))
                            )
                        }
                    )

                ForEach(11..<20) { i in
                    Text("Row \(i)").frame(height: 60)
                }
            }
        }
        .onPreferenceChange(IsVisibleKey.self) { isVisible = $0 }
        .overlay(Text("Is Visible: \(isVisible ? "Yes" : "No")")
            .padding()
            .background(Color.black.opacity(0.7))
            .foregroundColor(.white), alignment: .top)
    }
}


#Preview {
    VisibilityTrackerView()
}
