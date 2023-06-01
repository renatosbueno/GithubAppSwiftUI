//
//  UserViewThemes.swift
//  GitHubAppSwiftUI
//
//  Created by Renato Bueno on 31/05/23.
//

import SwiftUI

// MARK: - UserViewThemeProtocol
protocol UserViewThemeProtocol: AnyObject {
    var stackSpacing: CGFloat { get }
    var titleLabelFont: Font { get }
    var titleLabelTextColor: Color { get }
    var imageContentMode: ContentMode { get }
    var spacing: CGFloat { get }
    var borderColor: Color { get }
}

// MARK: - UserViewDefaultTheme
final class UserViewDefaultTheme: UserViewThemeProtocol {
    
    var stackSpacing: CGFloat {
        return 8
    }
    
    var titleLabelFont: Font {
        return .system(size: 18, weight: .semibold)
    }
    
    var titleLabelTextColor: Color {
        return .black
    }
    
    var imageContentMode: ContentMode {
        return .fit
    }
    
    var spacing: CGFloat {
        return 16
    }
    
    var borderColor: Color {
        return .black
    }
    
}
