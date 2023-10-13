//
//  NetworkRequest.swift
//  FoodRepository
//
//  Created by Lawrence on 10/11/23.
//

import Foundation

enum RequestType: String {
    case GET
    case POST
}

struct NetworkRequest: Requestable {
    var baseUrl: String
    var path: String
    var params: [URLQueryItem]
    var type: RequestType
    var headers: [String: String]
}

protocol Requestable {
    var baseUrl: String {get set}
    var path: String {get set}
    var type: RequestType {get set}
    var params: [URLQueryItem] {get set}
    var headers: [String: String] {get set}
}

extension Requestable {
    var baseUrl: String {
        return ""
    }
    var path: String {
        return ""
    }
    var type: RequestType {
        return RequestType.GET
    }
    var params: [URLQueryItem] {
        return []
    }
    var headers: [String: String] {
        return [:]
    }
}

extension Requestable {
    func getURLRequest() throws -> URLRequest {
        guard var url = URL(string: baseUrl.appending(path)) else {
            throw NetworkError.invalidUrl
        }
        url.append(queryItems: params)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = type.rawValue
        urlRequest.allHTTPHeaderFields = headers
        return urlRequest
    }
}
