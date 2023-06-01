//
//  RepoViewThemes.swift
//  GitHubAppSwiftUI
//
//  Created by Renato Bueno on 31/05/23.
//

import SwiftUI

protocol RepoViewThemeProtocol: AnyObject {
    var vStackSpacing: CGFloat { get }
    var titleLabelFont: Font { get }
    var titleLabelTextColor: Color { get }
    var descriptionLabelFont: Font { get }
    var descriptionLabelTextColor: Color { get }
    var iconTintColor: Color { get }
}

final class RepoViewDefaultTheme: RepoViewThemeProtocol {
    
    var vStackSpacing: CGFloat {
        return 2
    }
    
    var titleLabelFont: Font {
        return .system(size: 16, weight: .bold)
    }
    
    var titleLabelTextColor: Color {
        return .black
    }
    
    var descriptionLabelFont: Font {
        return .system(size: 14, weight: .semibold)
    }
    
    var descriptionLabelTextColor: Color {
        return .black
    }
    
    var iconTintColor: Color {
        return .gray
    }
}
