//
//  ScrollviewTabSampleView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 05/05/25.
//

import SwiftUI


 /*
  
  ScrollViewReader : Scroll to a specific view
  Listen to or trigger scroll-related logic.

  Combine it with .id(...) modifiers to jump to views inside the scroll area.
  
  GeometryReader :
  geo.frame(...) gives you the frame (position and size) of the view.

  in: .global means it’s measuring against the entire screen, not just the local container.

  .minY is the top edge of the view.

  .maxY would be the bottom edge of the view.
  */

//05 temp not working
// PREFERENCE KEY FOR SCROLL TRACKING
struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


struct ScrollviewTabSampleView: View {
    
    @EnvironmentObject var coordinator: AppCoordinator
    @StateObject private var viewModel = RestaurantDetailViewModel()
    
    
    var body: some View {
       
        VStack(spacing : 0){
            
            
            RestaurantNavigationBar(
                title: viewModel.restaurant?.name ?? "Restaurant",
                onBackTap: {
                    
                    coordinator.navigateBack()
                },
                onBookmarkTap: {
                    
                    coordinator.navigateToRoot()
                    
                }, onShareTap: {
                    
                   
                }
            )
           
            
            //  // Horizontal tab bar
            
            ScrollView(.horizontal,showsIndicators: false){
                
                HStack(spacing:20){
                    
                    ForEach(RestaurantTab.allCases){ tab in
                        
                        Button {
                            
                            withAnimation {
                                viewModel.selectedTab = tab
                            }
                        } label: {
                            
                            VStack(spacing: 4) {
                                
                                Text(tab.rawValue)
                                    .font(.system(size: 15))
                                    .fontWeight( viewModel.selectedTab == tab ? .semibold : .regular)
                                    .foregroundStyle(viewModel.selectedTab == tab ? .blue : .gray)
                                
                                // Underline indicator
                                
                                if viewModel.selectedTab == tab {
                                    
                                    Rectangle()
                                        .frame(height: 2)
                                        .foregroundColor(.blue)
                                }else{
                                    
                                    Rectangle()
                                        .fill(Color.clear)
                                        .frame(height: 2)
                                }
                            }
                            
                        }
                        
                        
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 8)
            
            Divider()
            
            if viewModel.isLoading {
                Spacer()
                ProgressView()
                    .scaleEffect(1.5)
                Spacer()
            }
            else if let restaurant = viewModel.restaurant {
                
                // Content sections
                
                ScrollViewReader{  proxy in
                    
                    
                    ScrollView{
                        
                        VStack(spacing: 40) {
                            
                            // Pre-book Offers
                            
                            TabSectionView(tab: .preBookOffer,
                                           title: "Pre-book Offers",
                                           description: "Special offers when you book in advance")
                            .id(RestaurantTab.preBookOffer)  //vip
                            
                            .background (
                                
                                /*
                                 geo.frame(in: .named("scrollView")).minY
                                 This gets the vertical Y-position of the current section relative to the coordinate space named "scrollView".
                                 
                                 minY tells us how far this section is from the top of the ScrollView.
                                 
                                 ✅ .onChange(of: ...)
                                 This modifier watches for any change in the Y-offset of this section.
                                 
                                 Every time the position changes (due to scroll), it triggers the block with the new Y value (newY).
                                 
                                 ✅ if !viewModel.isDragging { return }
                                 This line ignores scroll offset changes when the user is not actively dragging.
                                 
                                 It ensures tab sync is done only when the user scrolls manually, not programmatically (like when tapping a tab).
                                 
                                 ✅ viewModel.tabOffsets[.preBookOffer] = newY
                                 Saves the current offset of this section (e.g., Pre-book Offer) into the view model.
                                 
                                 These offsets are used to determine which tab is closest to the top during scroll.
                                 
                                 ✅ viewModel.updateSelectedTab(scrollOffset: newY)
                                 Calls a method to check which tab's section is closest to the current scroll position, and updates the selected tab accordingly.
                                 */
                                GeometryReader{ geo in
                                    
                                    Color.clear
                                        .onAppear{
                                            //It stores the initial vertical position (top Y) of the .preBookOffer section relative to the entire screen.
                                            viewModel.tabOffsets[.preBookOffer] = geo.frame(in: .global).minY
                                        }
                                        .onChange(of: geo.frame(in: .named("scrollView")).minY) { newY in
                                            if !viewModel.isDragging { return }
                                            viewModel.tabOffsets[.preBookOffer] = newY
                                            viewModel.updateSelectedTab(scrollOffset: newY)
                                        }
                                    
                                    
                                }
                            )
                            
                            
                            
                            // Walk-in Offers
                            TabSectionView(
                                tab: .walkInOffer,
                                title: "Walk-in Offers",
                                description: "Special offers available when you visit"
                            )
                            .id(RestaurantTab.walkInOffer)
                            .background(
                                GeometryReader { geo in
                                    Color.clear
                                        .onAppear {
                                            viewModel.tabOffsets[.walkInOffer] = geo.frame(in: .named("scrollView")).minY
                                        }
                                        .onChange(of: geo.frame(in: .named("scrollView")).minY) { newY in
                                            if !viewModel.isDragging { return }
                                            viewModel.tabOffsets[.walkInOffer] = newY
                                            viewModel.updateSelectedTab(scrollOffset: newY)
                                        }
                                }
                            )
                            
                            
                            
                            // Menu
                            TabSectionView(
                                tab: .menu,
                                title: "Menu",
                                description: "Our food and drink selections"
                            )
                            .id(RestaurantTab.menu)
                            .background(
                                GeometryReader { geo in
                                    Color.clear
                                        .onAppear {
                                            viewModel.tabOffsets[.menu] = geo.frame(in: .named("scrollView")).minY
                                        }
                                        .onChange(of: geo.frame(in: .named("scrollView")).minY) { newY in
                                            if !viewModel.isDragging { return }
                                            viewModel.tabOffsets[.menu] = newY
                                            viewModel.updateSelectedTab(scrollOffset: newY)
                                        }
                                }
                            )
                            
                            // Photos
                            TabSectionView(
                                tab: .photos,
                                title: "Photos",
                                description: "Browse our gallery of photos"
                            )
                            .id(RestaurantTab.photos)
                            .background(
                                GeometryReader { geo in
                                    Color.clear
                                        .onAppear {
                                            viewModel.tabOffsets[.photos] = geo.frame(in: .named("scrollView")).minY
                                        }
                                        .onChange(of: geo.frame(in: .named("scrollView")).minY) { newY in
                                            if !viewModel.isDragging { return }
                                            viewModel.tabOffsets[.photos] = newY
                                            viewModel.updateSelectedTab(scrollOffset: newY)
                                        }
                                }
                            )
                            
                            // Vibes
                            TabSectionView(
                                tab: .vibes,
                                title: "Vibes",
                                description: "The atmosphere and experience"
                            )
                            .id(RestaurantTab.vibes)
                            .background(
                                GeometryReader { geo in
                                    Color.clear
                                        .onAppear {
                                            viewModel.tabOffsets[.vibes] = geo.frame(in: .named("scrollView")).minY
                                        }
                                        .onChange(of: geo.frame(in: .named("scrollView")).minY) { newY in
                                            if !viewModel.isDragging { return }
                                            viewModel.tabOffsets[.vibes] = newY
                                                                                     viewModel.updateSelectedTab(scrollOffset: newY)
                                                                                 }
                                }
                            )
                            
                            // Reviews
                            TabSectionView(
                                tab: .reviews,
                                title: "Reviews",
                                description: "Customer feedback and ratings"
                            )
                            .id(RestaurantTab.reviews)
                            .background(
                                GeometryReader { geo in
                                    Color.clear
                                        .onAppear {
                                            viewModel.tabOffsets[.reviews] = geo.frame(in: .named("scrollView")).minY
                                        }
                                        .onChange(of: geo.frame(in: .named("scrollView")).minY) { newY in
                                            if !viewModel.isDragging { return }
                                            viewModel.tabOffsets[.reviews] = newY
                                            viewModel.updateSelectedTab(scrollOffset: newY)
                                        }
                                }
                            )
                            
                        }
                        
                    }
                    
                    
                    /*
                     This sets a named coordinate space on the ScrollView.
                     
                     It's used so that inner GeometryReader views can measure their position (minY, maxY, etc.) relative to this ScrollView — not to the screen or global space.
                     */
                    
                    //// ✅ IMPORTANT: Named coordinate space for position tracking
                    .coordinateSpace(name: "scrollView")
                    
                    //05 temp not working
                    // ADDED: Update tabs based on overall scroll position
                    .onPreferenceChange(ScrollOffsetKey.self) { scrollOffset in
                        if viewModel.isDragging {
                            viewModel.updateSelectedTab(scrollOffset: scrollOffset)
                        }
                    }
                    
                    // ✅ TAB TO SCROLL: Scroll to section when tab change
                    .onChange(of: viewModel.selectedTab) { tab in
                        
                        withAnimation {
                            proxy.scrollTo(tab, anchor: .top)
                        }
                    }
                    
                    /*
                     the .coordinateSpace(name: "scrollView") modifier creates a named coordinate space that's used for tracking the positions of views within the scroll view.
                     */
                    // ✅ IMPORTANT: Track when user is actively scrolling
                    
                    .gesture(
                        DragGesture()
                            .onChanged { _ in
                                viewModel.isDragging = true
                            }
                            .onEnded { _ in
                                viewModel.isDragging = false
                            }
                    )
                }
                

            }
            
            else if let error = viewModel.errorMessage {
                
                // Error state
                VStack{
                    
                    Text("Error")
                        .font(.headline)
                    Text(error)
                        .font(.body)
                        .multilineTextAlignment(.center)
                    
                    Button("Retry") {
                        Task {
                            await viewModel.loadRestaurantDetails()
                        }
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.top)
                }
                .padding()
            }
        }
        
        .task {
            
            await viewModel.loadRestaurantDetails()
        }
        
    }
}

#Preview {
    ScrollviewTabSampleView()
}
