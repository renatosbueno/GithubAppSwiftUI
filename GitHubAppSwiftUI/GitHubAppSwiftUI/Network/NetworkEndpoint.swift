//
//  NetworkEndpoint.swift
// 
//
//  Created by Renato Bueno on 29/03/23.
//

import Foundation

protocol NetworkEndpoint {
    var baseUrl: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [String: String] { get }
    var shouldMockRequest: Bool { get }
}
extension NetworkEndpoint {
    
    var baseUrl: String {
        return shouldMockRequest ? Bundle.main.bundleURL.absoluteString : "https://api.github.com/"
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    var path: String {
        return ""
    }
    
    var method: HttpMethod {
        return .get
    }
    
    var shouldMockRequest: Bool {
        return false
    }
    
}
