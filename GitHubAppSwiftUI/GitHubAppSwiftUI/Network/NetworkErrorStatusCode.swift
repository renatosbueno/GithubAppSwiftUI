//
//  NetworkErrorStatusCode.swift
//
//

import Foundation

enum NetworkErrorType: Error {
    case error(code: NetworkErrorStatusCode)
    case other(statusCode: Int)
}

enum NetworkErrorStatusCode: Int {
    
    case unkown = -998
    case decodingError = -999
    
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case internalServerError = 500
    
    var error: NetworkErrorType {
        return .error(code: self)
    }
}
