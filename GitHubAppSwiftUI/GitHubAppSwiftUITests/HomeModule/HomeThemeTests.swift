//
//  HomeThemeTests.swift
//  GitHubAppTests
//
//  Created by Renato Bueno on 28/05/23.
//

import XCTest
@testable import GitHubAppSwiftUI

final class HomeThemeTests: XCTestCase {

    func testDefaultTheme() {
        let theme = UserViewDefaultTheme()
        XCTAssertEqual(theme.stackSpacing, 8)
        XCTAssertEqual(theme.titleLabelFont, .system(size: 18, weight: .semibold))
        XCTAssertEqual(theme.titleLabelTextColor, .black)
        XCTAssertEqual(theme.imageContentMode, .fit)
        XCTAssertEqual(theme.spacing, 16)
        XCTAssertEqual(theme.borderColor, .black)
    }
}
