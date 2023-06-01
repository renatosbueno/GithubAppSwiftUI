//
//  AgroupedUserDetailData.swift
//  GitHubApp
//
//  Created by Renato Bueno on 27/05/23.
//

import Foundation

struct AgroupedUserDetailData: Codable, Equatable {
    let userDetail: UserDetailInfo
    var userRepos: [UserRepoData] = []
}
