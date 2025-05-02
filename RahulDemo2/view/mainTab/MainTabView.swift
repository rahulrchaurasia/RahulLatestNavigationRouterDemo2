//
//  MainTabView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 24/04/25.
//

import SwiftUI

//struct MainTabView: View {
//    @EnvironmentObject var coordinator: AppCoordinator
//    
//    let selectedTab: MainTab
//    
//    var body: some View {
//        TabView(selection: $coordinator.selectedTab) {
//            // Home Tab
//            NavigationStack(path: $coordinator.homeRouter.path) {
//               
//                HomeView()
//                    .navigationDestination(for: HomeDestination.self) { destination in
//                        destination.makeView(coordinator: coordinator)
//                    }
//            }
//            .tabItem { Label("Home", systemImage: "house.fill") }
//            .tag(MainTab.home)
//            
//            // Transaction Tab
//            NavigationStack(path: $coordinator.transactionRouter.path) {
//                TransactionDetailView(id: "2")
//                    .navigationDestination(for: TransactionDestination.self) { destination in
//                        destination.makeView(coordinator: coordinator)
//                    }
//            }
//            .tabItem { Label("Transaction", systemImage: "creditcard") }
//            .tag(MainTab.transaction)
//            
//            // Car Journey Tab
//            NavigationStack(path: $coordinator.carJourneyRouter.path) {
//                CarJourneyDetailView()
//                    .navigationDestination(for: CarJourneyDestination.self) { destination in
//                        destination.makeView(coordinator: coordinator)
//                    }
//            }
//            .tabItem { Label("Car Journey", systemImage: "car.fill") }
//            .tag(MainTab.carJourney)
//            
//            
//        }
//        .onAppear {
//            coordinator.switchTab(to: selectedTab)
//        }
//    }
//}

//#Preview {
//    MainTabView()
//}
