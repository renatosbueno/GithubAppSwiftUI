//
//  MockFailingNetworker.swift
//  GitHubAppTests
//
//  Created by Renato Bueno on 28/05/23.
//

import Foundation
@testable import GitHubAppSwiftUI

final class MockFailingNetworker: NSObject, NetworkerProtocol {
    
    func request<DataType>(endpoint: NetworkEndpoint, type: DataType.Type) async throws -> DataType where DataType : Decodable, DataType : Encodable {
        throw NetworkErrorType.error(code: .badRequest)
    }
    
    func requestData(endpoint: NetworkEndpoint) async throws -> Data {
        throw NetworkErrorType.error(code: .badRequest)
    }
    
    func cancelRequest() {
    }
}
