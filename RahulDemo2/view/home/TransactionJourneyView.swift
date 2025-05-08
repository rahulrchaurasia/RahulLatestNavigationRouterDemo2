//
//  CollapsingHeaderView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 07/05/25.
//


import SwiftUI

// MARK: - Model
struct JourneyItem: Identifiable {
    let id = UUID()
    let title: String
    let content: String
}

// MARK: - Collapsible Header View Model

class CollapsingHeaderViewModel: ObservableObject {
    @Published var scrollOffset: CGFloat = 0

    var progress: CGFloat {
        let p = scrollOffset / 120
        return min(max(p, 0), 1)
    }

    var showCompactHeader: Bool {
        progress >= 0.9
    }

    var expandedOpacity: Double { Double(1 - progress) }
    var collapsedOpacity: Double { Double(progress) }
}

struct TransactionJourneyView: View {
    @StateObject private var viewModel = CollapsingHeaderViewModel()
       @Environment(\.presentationMode) var presentationMode


    
    var body: some View {
         ZStack(alignment: .top) {
             ScrollView(showsIndicators: false) {
                 VStack(spacing: 0) {
                     GeometryReader { proxy in
                         Color.clear.preference(
                             key: ScrollOffsetPreferenceKey.self,
                             value: proxy.frame(in: .named("scrollView")).minY
                         )
                     }
                     .frame(height: 0)

                     expandedHeader

                     contentBody
                 }
                 .padding(.top, 60)
             }
             .coordinateSpace(name: "scrollView")
             .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                 withAnimation(.easeInOut(duration: 0.25)) {
                     viewModel.scrollOffset = -value
                 }
             }

             collapsedHeader
         }
         .ignoresSafeArea(edges: .top)
     }
      
    
    
    private var expandedHeader: some View {
          VStack(alignment: .leading, spacing: 16) {
              Text("Find Amazing events\nhappening around you.")
                  .font(.title2.bold())
                  .foregroundColor(.white)
                  .padding(.top, 60)

              HStack {
                  TextField("Search for an event...", text: .constant(""))
                      .padding()
                      .background(Color.white)
                      .cornerRadius(24)

                  Image(systemName: "magnifyingglass")
                      .foregroundColor(.white)
                      .padding(10)
                      .background(Color.black.opacity(0.7))
                      .clipShape(Circle())
              }
          }
          .padding()
          .background(Color.teal)
          .opacity(viewModel.expandedOpacity)
          .scaleEffect(1 - 0.05 * viewModel.progress, anchor: .top)
      }
    
    private var collapsedHeader: some View {
         VStack(spacing: 0) {
             Color.white
                 .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.top ?? 20)
                 .opacity(viewModel.collapsedOpacity)

             HStack {
                 Button(action: {
                     presentationMode.wrappedValue.dismiss()
                 }) {
                     Image(systemName: "chevron.left")
                         .foregroundColor(.black)
                         .padding(8)
                 }

                 Spacer()

                 Text("Transactions")
                     .font(.headline)
                     .foregroundColor(.black)
                     .opacity(viewModel.collapsedOpacity)

                 Spacer()

                 Color.clear.frame(width: 44)
             }
             .frame(height: 60)
             .background(Color.white.opacity(viewModel.collapsedOpacity))
         }
         .animation(.easeInOut(duration: 0.25), value: viewModel.collapsedOpacity)
         .shadow(color: .black.opacity(viewModel.showCompactHeader ? 0.1 : 0), radius: 4, y: 2)
     }
    
    private var contentBody: some View {
           VStack(alignment: .leading, spacing: 20) {
               Text("Transaction Journey")
                   .font(.title)
                   .bold()

               Button(action: {}) {
                   Text("START JOURNEY")
                       .foregroundColor(.white)
                       .frame(maxWidth: .infinity)
                       .padding()
                       .background(Color.black)
                       .cornerRadius(28)
               }

               Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...")
                   .foregroundColor(.gray)

               ForEach(0..<20) { i in
                   Text("Additional content block \(i + 1)")
                       .padding(.vertical, 8)
                       .frame(maxWidth: .infinity, alignment: .leading)
                       .background(Color.white)
                       .cornerRadius(8)
                       .shadow(radius: 1)
               }
           }
           .padding()
       }
}



#Preview {
    TransactionJourneyView()
}
