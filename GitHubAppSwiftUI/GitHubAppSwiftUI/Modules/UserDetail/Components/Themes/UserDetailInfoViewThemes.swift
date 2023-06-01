//
//  UserDetailInfoViewThemes.swift
//  GitHubAppSwiftUI
//
//  Created by Renato Bueno on 31/05/23.
//

import SwiftUI

protocol UserDetailInfoViewThemeProtocol: AnyObject {
    var spacing: CGFloat { get }
    var leftLabelFont: Font { get }
    var rightLabelFont: Font { get }
    var leftLabelTextColor: Color { get }
    var rightLabelTextColor: Color { get }
}

final class UserDetailInfoViewDefaultTheme: UserDetailInfoViewThemeProtocol {
    
    var spacing: CGFloat {
        return 4
    }
    
    var leftLabelFont: Font {
        return .system(size: 14, weight: .regular)
    }
    
    var rightLabelFont: Font {
        return .system(size: 14, weight: .regular)
    }
    
    var leftLabelTextColor: Color {
        return .gray
    }
    
    var rightLabelTextColor: Color {
        return .gray
    }
    
}
