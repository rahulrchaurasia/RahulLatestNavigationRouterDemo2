//
//  CollapsingHeaderViewDemo.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 09/05/25.
//

import SwiftUI

//struct ScrollOffsetKey: PreferenceKey {
//    static var defaultValue: CGFloat = 0
//    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
//        value = nextValue()
//    }
//}

struct CollapsingHeaderViewDemo: View {
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
                    GeometryReader { geometry in
                        VStack {
                            Text("Large Title")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .opacity(calculateOpacity(geometry: geometry))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 100)
                    }
                    .frame(height: 200)
                    
                    // Rest of your content
                    ForEach(0..<20) { index in
                        Text("Item \(index)")
                            .frame(height: 50)
                    }
                }
    }
    
    func calculateOpacity(geometry: GeometryProxy) -> Double {
           // Calculate scroll offset
           let offset = geometry.frame(in: .global).minY
           
           // Default position when not scrolled
           let defaultOffset: CGFloat = 0
           
           // Calculate opacity based on scroll position
           let opacity = 1.0 - min(1.0, max(0.0, abs(offset - defaultOffset) / 100.0))
           
           return opacity
       }
}

#Preview {
    CollapsingHeaderViewDemo()
}
