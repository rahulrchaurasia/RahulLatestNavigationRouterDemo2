//
//  Router.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 24/04/25.
//

import Foundation

// MARK: - 6. Generic Router
final class Router<Destination: NavigationDestination>: ObservableObject {
    @Published var navPaths: [Destination] = []

    func navigate(to destination: Destination) {
        navPaths.append(destination)
    }

    func navigateBack() {
        guard !navPaths.isEmpty else { return }
        navPaths.removeLast()
    }

    func navigateToRoot() {
        navPaths.removeAll()
    }
    
    func navigateBack(to target: Destination) {
           guard let index = navPaths.lastIndex(of: target) else { return }
           navPaths = Array(navPaths.prefix(upTo: index + 1))
    }
}
