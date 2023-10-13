//
//  NetworkError.swift
//  FoodRepository
//
//  Created by Lawrence on 10/11/23.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidRequest
    case invalidResponseError
    case failedToDecodeResponse
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return NSLocalizedString("There is a problem with a URL, such as an invalid URL or a timeout.", comment: "Invalid URL")
            
        case .invalidRequest:
            return NSLocalizedString("There is an issue with an HTTP request or response.", comment: "HTTP Error")
            
        case .failedToDecodeResponse:
            return NSLocalizedString("The data received from the server is unable to be decoded as the expected type.", comment: "Decoding Error")
            
        case .invalidResponseError:
            return NSLocalizedString("The server responds with an unexpected format or status code.", comment: "Invalid Response Error")
        }
    }
}
