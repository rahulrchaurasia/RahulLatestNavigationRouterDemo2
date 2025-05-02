//
//  HomeFlowView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 30/04/25.
//

import SwiftUI

struct HomeFlowView: View {
    //@StateObject private var router = HomeFlowRouter()
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var appState: AppState
    
    //    var body: some View {
    //        NavigationStack(path: $router.navPaths) {
    //            HomeView()
    //                .environmentObject(router)
    //                .navigationDestination(for: HomeFlow.self) { $0.destinationView }
    //            
    //            
    //        }
    //        .environmentObject(router)
    //        
    
    
    var body: some View {
        HomeView()
    }
}


#Preview {
    HomeFlowView()
}
