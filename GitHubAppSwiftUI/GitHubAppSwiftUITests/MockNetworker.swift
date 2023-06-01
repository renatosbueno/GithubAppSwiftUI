//
//  MockNetworker.swift
//  GitHubAppTests
//
//  Created by Renato Bueno on 28/05/23.
//

import Foundation
@testable import GitHubAppSwiftUI

final class MockNetworker: NSObject, NetworkerProtocol {
    
    private lazy var session: URLSession = {
        return URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
    }()
    
    func request<DataType>(endpoint: NetworkEndpoint, type: DataType.Type) async throws -> DataType where DataType : Decodable, DataType : Encodable {
        guard let urlRequest = setupUrlRequest(endpoint: endpoint) else {
            throw NetworkErrorType.error(code: .unkown)
        }
        let (data, _) = try await session.data(for: urlRequest, delegate: nil)
    
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let object = try decoder.decode(DataType.self, from: data)
            return object
        } catch {
            throw NetworkErrorType.error(code: .decodingError)
        }
    }
    
    func requestData(endpoint: NetworkEndpoint) async throws -> Data {
        guard let urlRequest = setupUrlRequest(endpoint: endpoint) else {
            throw NetworkErrorType.error(code: .unkown)
        }
        let (data, _) = try await session.data(for: urlRequest, delegate: nil)
        
        return data
    }
    
    func cancelRequest() {
        session.invalidateAndCancel()
    }
    
    private func handleErrorResponse(response: HTTPURLResponse) -> NetworkErrorType {
        let errorType = NetworkErrorStatusCode(rawValue: response.statusCode)
        let error: NetworkErrorType = {
            guard let errorCode = errorType else {
                return .other(statusCode: response.statusCode)
            }
            return .error(code: errorCode)
        }()
        return error
    }
    
    private func setupUrlRequest(endpoint: NetworkEndpoint) -> URLRequest? {
        let baseUrl = Bundle.main.bundleURL.absoluteString
        let endpointPath = baseUrl + endpoint.path.replacingOccurrences(of: "/", with: "-")
        let path = endpointPath + ".json"
        guard let url = URL(string: path) else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.allHTTPHeaderFields = endpoint.headers
        
        return urlRequest
    }
}
