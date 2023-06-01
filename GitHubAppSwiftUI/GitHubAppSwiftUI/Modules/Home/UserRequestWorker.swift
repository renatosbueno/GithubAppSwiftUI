//
//  UserRequestWorker.swift
//  GitHubAppSwiftUI
//
//  Created by Renato Bueno on 30/05/23.
//

import Foundation

// MARK: - UserRequestProtocol
protocol UserRequestProtocol: AnyObject {
    init(requestable: NetworkerProtocol)
    func fetchData() async throws -> [User]
}

// MARK: - UserRequestWorker
final class UserRequestWorker: UserRequestProtocol {
    
    private var requestable: NetworkerProtocol
    private var endpoint: NetworkEndpoint = UserEndpoint()
    
    required init(requestable: NetworkerProtocol) {
        self.requestable = requestable
    }
    
    func fetchData() async throws -> [User] {
        do {
            return try await requestable.request(endpoint: endpoint, type: [User].self)
        }
    }
}
// MARK: - UserEndpoint
struct UserEndpoint: NetworkEndpoint {
    
    var path: String {
        return "users"
    }
}
