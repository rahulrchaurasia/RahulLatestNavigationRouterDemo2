//
//  UIExtension.swift
//  SwiftUIDemo
//
//  Created by Rahul Chaurasia on 14/11/23.
//

import Foundation

//
//  UIExtension.swift
//  Trackizer
//
//  Created by CodeForAny on 11/07/23.
//

import SwiftUI

enum Inter: String {
    case regular = "Inter-Regular"
    case medium = "Inter-Medium"
    case semibold = "Inter-SemiBold"
    case bold = "Inter-Bold"
}

enum Gilroy: String {
    case regular = "Gilroy-Regular"
    case medium = "Gilroy-Medium"
    case semibold = "Gilroy-SemiBold"
    case bold = "Gilroy-Bold"
    
   
    
}

enum NunitoSans: String {
    case regular = "NunitoSans10pt-Regular"
    case medium = "NunitoSans10pt-Medium"
    case semibold = "NunitoSans10pt-SemiBold"
    case bold = "NunitoSans10pt-Bold"
    case extraBold = "NunitoSans10pt-ExtraBold"
}


//extension Font {
//    
//    static func customfont(_ font: NunitoSans, fontSize: CGFloat) -> Font {
//        custom(font.rawValue, size: fontSize)
//    }
//    static func customfont1(_ font: Gilroy, fontSize: CGFloat) -> Font {
//        custom(font.rawValue, size: fontSize)
//    }
//    
//    static func customfont2(_ font: Inter, fontSize: CGFloat) -> Font {
//        custom(font.rawValue, size: fontSize)
//    }
//}

extension CGFloat {
    
    static var screenWidth: Double {
        return UIScreen.main.bounds.size.width
    }
    
    static var screenHeight: Double {
        return UIScreen.main.bounds.size.height
    }
    
    static func widthPer(per: Double) -> Double {
        return screenWidth * per
    }
    
    static func heightPer(per: Double) -> Double {
        return screenHeight * per
    }
    
    
    static func getSafeArea() -> UIEdgeInsets {
        
        guard let screen = UIApplication.shared.connectedScenes.first as?
                UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
        
    }
   
    static var topInsets: Double {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return Double(scene.windows.first?.safeAreaInsets.top ?? 50)
        }
        return 0.0
        
    }
    
    
    static var bottomInsets: Double {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return Double(scene.windows.first?.safeAreaInsets.bottom ?? 50)
        }
        return 0.0
    }
    
    static var horizontalInsets: Double {
        
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return Double(scene.windows.first?.safeAreaInsets.left ?? 8 + (scene.windows.first?.safeAreaInsets.right ?? 8) )
        }
        return 0.0
    }
    
    static var verticalInsets: Double {
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return Double(scene.windows.first?.safeAreaInsets.top ?? 10 + (scene.windows.first?.safeAreaInsets.bottom ?? 10) )
        }
        return 0.0
    }
    
}





