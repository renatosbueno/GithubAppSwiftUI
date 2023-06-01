//
//  User.swift
//  GitHubApp
//
//  Created by Renato Bueno on 27/05/23.
//

import Foundation

struct User: Codable {
    let id: Int
    let login, avatarUrl, url, reposUrl: String
}
