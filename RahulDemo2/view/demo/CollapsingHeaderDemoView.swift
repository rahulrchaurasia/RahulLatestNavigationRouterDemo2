//
//  CollapsingHeaderView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 15/07/25.
//

import SwiftUI


struct CollapsingHeaderDemoView: View {
    @State private var titleVisible = false

    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                GeometryReader { geometry in
                    let minY = geometry.frame(in: .global).minY
                    let height = geometry.size.height + (minY > 0 ? minY : 0)

                    Image("a1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: height)
                        .clipped()
                        .offset(y: minY > 0 ? -minY : 0)
                        .onChange(of: minY) { newValue in
                            titleVisible = newValue < -180
                        }
                }
                .frame(height: 250)

                VStack(spacing: 16) {
                    ForEach(1...20, id: \.self) { index in
                        Text("Row \(index)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(8)
                    }
                }
                .padding()
            }

            // Sticky Collapsed Header
            if titleVisible {
                HStack {
                    Text("Collapsed Header")
                        .font(.headline)
                        .foregroundColor(.black)
                }
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0) // Add safe area top padding
                .background(Color.white.shadow(radius: 2))
                .transition(.opacity)
                .animation(.easeInOut, value: titleVisible)
            }
        }
        // Only ignore top safe area when header is not collapsed
        .modifier(IgnoreTopSafeAreaModifier(ignore: !titleVisible))
        .navigationBarHidden(true)
    }
}


#Preview {
    NavigationView {
        CollapsingHeaderDemoView()
    }
}


