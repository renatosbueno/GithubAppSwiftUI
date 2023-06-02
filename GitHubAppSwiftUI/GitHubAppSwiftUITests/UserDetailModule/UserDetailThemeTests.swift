//
//  UserDetailThemeTests.swift
//  GitHubAppTests
//
//  Created by Renato Bueno on 28/05/23.
//

import XCTest
@testable import GitHubAppSwiftUI

final class UserDetailThemeTests: XCTestCase {

  func testUserInfoDefaultTheme() {
         let theme = UserDetailInfoViewDefaultTheme()
        XCTAssertEqual(theme.spacing, 4)
        XCTAssertEqual(theme.rightLabelTextColor, .gray)
        XCTAssertEqual(theme.rightLabelFont, .system(size: 14, weight: .regular))
        XCTAssertEqual(theme.leftLabelTextColor, .gray)
        XCTAssertEqual(theme.leftLabelFont, .system(size: 14, weight: .regular))
  
  }
 
     func testRepoViewDefaultTheme() {
         let theme = RepoViewDefaultTheme()
        XCTAssertEqual(theme.titleLabelFont, .system(size: 16, weight: .bold))
        XCTAssertEqual(theme.titleLabelTextColor, .black)
        XCTAssertEqual(theme.vStackSpacing, 2)
        XCTAssertEqual(theme.descriptionLabelFont, .system(size: 14, weight: .semibold))
        XCTAssertEqual(theme.descriptionLabelTextColor, .black)
        XCTAssertEqual(theme.iconTintColor, .gray)
  
  }
  
}
