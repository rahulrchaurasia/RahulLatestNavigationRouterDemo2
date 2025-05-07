//
//  CollapsingHeaderView1.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 06/05/25.
//

import SwiftUI

class ScrollOffsetViewModel: ObservableObject {
    @Published var offset: CGFloat = 0
}
struct CollapsingHeaderView1: View {
    var title: String
    var subtitle: String?
    var rating: String?
    var details: String?
    var image: String
    var expandedHeight: CGFloat = 250
    
    @StateObject private var scrollModel = ScrollOffsetViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var scheme
    
    private var backgroundColor: Color {
        scheme == .dark ? .black : .white
    }
    
    private var safeAreaTop: CGFloat {
        UIApplication.shared.windows.first?.safeAreaInsets.top ?? 44
    }
    
    private var headerCollapsed: Bool {
        scrollModel.offset > 180
    }

    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    
                    // Collapsing Image Header with Gradient and Back Button
                    GeometryReader { geo in
                        let offset = geo.frame(in: .global).minY
                        Color.clear
                            .preference(key: ScrollOffsetPreferenceKey.self, value: -offset)
                            .frame(width: 0, height: 0)
                        
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width,
                                   height: expandedHeight + (offset > 0 ? offset : 0))
                            .offset(y: (offset > 0 ? -offset : 0))
                            .clipped()
                            .overlay(LinearGradient(
                                gradient: Gradient(colors: [.black.opacity(0.6), .clear]),
                                startPoint: .top, endPoint: .bottom))
                            .overlay(expandedBackButton, alignment: .topLeading)
                    }
                    .frame(height: expandedHeight)
                    
                    // Sticky Header Content (shown below image)
                    Section(header: expandedHeaderContent) {
                        contentList
                    }
                }
            }
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { scrollModel.offset = $0 }

            // Compact top app bar when scrolled
            topAppBar
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    // MARK: - Expanded Header View
    private var expandedHeaderContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            
           
            VStack(alignment: .leading, spacing: 6) {
                
                
                Text(title )
                    .font(.title3.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)

                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                if let rating = rating, let details = details {
                    HStack(spacing: 6) {
                        Image(systemName: "star.fill").foregroundColor(.yellow)
                        Text(rating)
                        Text("•")
                            .foregroundColor(.gray)
                        Text(details)
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.top, safeAreaTop + 12)
            .padding(.bottom, 16)
            .padding(.horizontal)
        }
        .background(backgroundColor)
        .opacity(headerCollapsed ? 0 : 1)
        .animation(.easeInOut(duration: 0.3), value: headerCollapsed)
    }


    // MARK: - Top Compact Toolbar
   
    
    private var topAppBar: some View {
        VStack(spacing: 0) {
            if headerCollapsed {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(backgroundColor)
                        .frame(height: safeAreaTop + 60)
                        .ignoresSafeArea(edges: .top)

                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 8) {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(scheme == .dark ? .white : .black)
                            }

                            Text(title)
                                .font(.headline)
                                .lineLimit(1)
                            
                        }

                        if let subtitle = subtitle {
                            Text(subtitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }

                        if let rating = rating {
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.caption)
                                Text(rating)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.top, safeAreaTop + 8)
                    .padding(.horizontal)
                }
                .transition(.move(edge: .top).combined(with: .opacity))
                .animation(.easeInOut(duration: 0.25), value: headerCollapsed)
            }
        }
    }


   

    // MARK: - Back Button (Image Overlay)
    private var expandedBackButton: some View {
        Group {
            if !headerCollapsed {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color.black.opacity(0.3))
                        .clipShape(Circle())
                }
                .padding(.leading)
                .padding(.top, safeAreaTop)
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.3), value: headerCollapsed)
            }
        }
    }


    // MARK: - Content List
    private var contentList: some View {
        ForEach(0..<20, id: \.self) { index in
            VStack(alignment: .leading, spacing: 6) {
                Text("Item \(index)")
                    .font(.headline)
                Text("Description for item \(index). This is a detailed description that shows information about this particular item.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Divider()
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
    }
}
struct ScrollOffsetPreferenceKey1: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}



#Preview {
   // CollapsingHeaderView1()
    
    CollapsingHeaderView1(
                    title: "Premium Coffees",
                    subtitle: "Italian Espresso",
                    rating: "4.9",
                    details: "Premium Selection",
                    image: "food",
                    expandedHeight: 260
                )
}
