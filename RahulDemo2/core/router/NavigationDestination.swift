//
//  NavigationDestination.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 24/04/25.
//

import Foundation

import SwiftUI

//// MARK: - 3. Navigation Destinations Protocol
//protocol NavigationDestination: Hashable {
//    associatedtype View: SwiftUI.View
//    
//    @ViewBuilder
//    func makeView(coordinator: AppCoordinator) -> View
//}

protocol NavigationDestination: Hashable {
    associatedtype Destination: View
    @ViewBuilder var destinationView: Destination { get }
}

