//
//  RenderStateType.swift
//  GitHubAppSwiftUI
//
//  Created by Renato Bueno on 30/05/23.
//

import Foundation

enum RenderStateType<T: Equatable> {
    case loading
    case failed(errorMessage: String)
    case success(dto: T)
    case none
}

enum HomeStateType {
    case loading
    case failed(errorMessage: String)
    case success
    case none
}
