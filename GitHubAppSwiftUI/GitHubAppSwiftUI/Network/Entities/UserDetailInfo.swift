//
//  UserDetailInfo.swift
//  GitHubApp
//
//  Created by Renato Bueno on 27/05/23.
//

import Foundation

struct UserDetailInfo: Codable, Equatable, Hashable {
    
    var avatarUrl, login: String
    var location, name: String?
    let id: Int
    var followers: Int?
}
