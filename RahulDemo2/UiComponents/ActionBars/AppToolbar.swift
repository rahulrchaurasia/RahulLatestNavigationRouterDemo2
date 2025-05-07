//
//  AppToolbar.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 06/05/25.
//

import SwiftUI





struct AppToolbar: View {
    // MARK: - Properties
    let title: String
    let dismissAction: (() -> Void)?
    let menuAction: (() -> Void)?
    let homeAction: (() -> Void)?
    var backgroundColor: Color? // Main toolbar background
    var statusBarColor: Color? // Optional separate status bar color
    
    // MARK: - Constants
    private let iconSize: CGFloat = 20
    private let horizontalPadding: CGFloat = 8
    private let backButtonTrailingPadding: CGFloat = 20
    private let trailingIconSpacing: CGFloat = 16
    
    // MARK: - Initializers
    init(
        title: String,
        dismissAction: (() -> Void)? = nil,
        menuAction: (() -> Void)? = nil,
        homeAction: (() -> Void)? = nil,
        backgroundColor: Color? = nil,
        statusBarColor: Color? = nil
    ) {
        self.title = title
        self.dismissAction = dismissAction
        self.menuAction = menuAction
        self.homeAction = homeAction
        self.backgroundColor = backgroundColor
        self.statusBarColor = statusBarColor
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            
           
            // Toolbar content
            HStack(alignment: .center, spacing: 0) {
                // Back Button
                if let dismissAction = dismissAction {
                    Button(action: dismissAction) {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: iconSize, height: iconSize)
                    }
                    .padding(.leading, horizontalPadding)
                    .padding(.trailing, backButtonTrailingPadding)
                    .accessibilityLabel("Back")
                } else {
                    // Placeholder for consistent layout when no back button
                    Spacer()
                        .frame(width: iconSize + horizontalPadding + backButtonTrailingPadding)
                }
                
                // Title
                Text(title)
                    .font(.title2.weight(.semibold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                
                Spacer()
                
                // Trailing buttons with standardized spacing
                HStack(spacing: trailingIconSpacing) {
                    // Menu Button (if provided)
                    if let menuAction = menuAction {
                        Button(action: menuAction) {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .scaledToFit()
                                .frame(width: iconSize, height: iconSize)
                                .accessibilityLabel("Share")
                        }
                    }
                    
                    // Home Button (if provided)
                    if let homeAction = homeAction {
                        Button(action: homeAction) {
                            Image(systemName: "house")
                                .resizable()
                                .scaledToFit()
                                .frame(width: iconSize, height: iconSize)
                                .accessibilityLabel("Home")
                        }
                    }
                }
                .padding(.trailing, horizontalPadding)
            }
            .frame(height: 50)
            .background(backgroundColor ?? Color.toolBar)
        }
        .foregroundColor(.white)
      
    }
}

#Preview {
   
    
    VStack {
        AppToolbar(title: "Preview Title", dismissAction: {
            
        },menuAction: {}, homeAction : {}
        
        ) // No dismiss action provided
                Spacer()
    }
    .background(Color.gray)
}
