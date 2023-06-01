//
//  UserRepoData.swift
//  GitHubApp
//
//  Created by Renato Bueno on 27/05/23.
//

import Foundation

struct UserRepoData: Codable, Equatable, Hashable {
    let id, forksCount, stargazersCount: Int
    let name: String
    var language: String?
}
