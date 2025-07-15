//
//  ScrollTrackingView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 09/05/25.
//

import SwiftUI

struct MinYKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
struct ScrollTrackingView: View {
    
    @State private var minY: CGFloat = 0
    var body: some View {
         ScrollView {
             VStack {
                 Color.red
                     .frame(height: 300)
                     .overlay(
                         GeometryReader { geo in
                             Color.clear
                                 .preference(key: MinYKey.self, value: geo.frame(in: .global).minY)
                         }
                     )

                 ForEach(0..<30) { index in
                     Text("Item \(index)").padding()
                 }
             }
         }
         .onPreferenceChange(MinYKey.self) { value in
             minY = value
         }
         .overlay(Text("minY: \(Int(minY))").padding().background(Color.white), alignment: .top)
     }
}

#Preview {
    ScrollTrackingView()
}
