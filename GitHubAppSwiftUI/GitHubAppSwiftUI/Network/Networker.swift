//
//  Networker.swift
//
//

import Foundation

enum HttpMethod: String, CaseIterable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

protocol NetworkerProtocol: AnyObject {
    func request<DataType: Codable>(endpoint: NetworkEndpoint, type: DataType.Type) async throws -> DataType
    func requestData(endpoint: NetworkEndpoint) async throws -> Data
    func cancelRequest()
}

final class Networker: NSObject, NetworkerProtocol {
    
    private lazy var session: URLSession = {
        return URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }()
    
    func request<DataType>(endpoint: NetworkEndpoint, type: DataType.Type) async throws -> DataType where DataType : Decodable, DataType : Encodable {
        guard let urlRequest = setupUrlRequest(endpoint: endpoint) else {
            throw NetworkErrorType.error(code: .unkown)
        }
        let (data, response) = try await session.data(for: urlRequest, delegate: self)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkErrorType.error(code: .badRequest)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let object = try? decoder.decode(DataType.self, from: data) else {
            throw handleErrorResponse(response: response)
        }
        return object
    }
    
    func requestData(endpoint: NetworkEndpoint) async throws -> Data {
        guard let urlRequest = setupUrlRequest(endpoint: endpoint) else {
            throw NetworkErrorType.error(code: .unkown)
        }
        let (data, _) = try await session.data(for: urlRequest, delegate: self)
        
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
        let endpointPath = endpoint.baseUrl + endpoint.path
        let path = endpoint.shouldMockRequest ? endpointPath + ".json" : endpointPath
        guard let url = URL(string: path) else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.allHTTPHeaderFields = endpoint.headers
        
        return urlRequest
    }
}
// MARK: - URLSessionDelegate
extension Networker: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.performDefaultHandling, nil)
            return
        }
        let urlCredential = URLCredential(trust: serverTrust)
        completionHandler(.useCredential, urlCredential)
    }
    
}
extension Networker: URLSessionTaskDelegate {
}
