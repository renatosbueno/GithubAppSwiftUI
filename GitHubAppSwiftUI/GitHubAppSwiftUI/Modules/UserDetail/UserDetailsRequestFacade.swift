//
//  UserDetailsRequestFacade.swift
//  GitHubApp
//
//  Created by Renato Bueno on 27/05/23.
//

import Foundation

final class UserDetailsRequestFacade {
    
    // MARK: - Private Properties
    private let requestable: NetworkerProtocol
    private let username: String
    
    init(requestable: NetworkerProtocol, username: String) {
        self.requestable = requestable
        self.username = username
    }
    
    func fetch() async throws -> AgroupedUserDetailData? {
        let userEndpoint = UserDetailedInfoEndpoint(username: username)
        let reposEndpoint = UserReposEndpoint(username: username)
        do {
            let userDetailInfo = try await requestable.request(endpoint: userEndpoint, type: UserDetailInfo.self)
            let userReposInfo = (try? await requestable.request(endpoint: reposEndpoint, type: [UserRepoData].self)) ?? []
            return AgroupedUserDetailData(userDetail: userDetailInfo, userRepos: userReposInfo)
        }
    }
    
}
// MARK: - UserDetailedInfoEndpoint
struct UserDetailedInfoEndpoint: NetworkEndpoint {
    
    let username: String
    
    var path: String {
        return "users/\(username)"
    }
    
}

// MARK: - UserReposEndpoint
struct UserReposEndpoint: NetworkEndpoint {
    
    let username: String
    
    var path: String {
        return "users/\(username)/repos"
    }
    
}
