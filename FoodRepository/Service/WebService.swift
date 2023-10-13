//
//  WebService.swift
//  FoodRepository
//
//  Created by Lawrence on 10/11/23.
//

import Foundation

protocol APIImplement {
    func fetchData<T: Decodable>(request: Requestable, modelType: T.Type) async throws -> T?
}
struct WebService: APIImplement {
    func fetchData<T: Decodable>(request: Requestable, modelType: T.Type) async throws -> T? {
        do {
            let urlRequest = try request.getURLRequest()
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let urlResponse = response as? HTTPURLResponse else { throw NetworkError.invalidResponseError }
            guard urlResponse.statusCode >= 200 && urlResponse.statusCode < 300 else { throw NetworkError.invalidResponseError }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let result = try? jsonDecoder.decode(T.self, from: data) else { throw NetworkError.failedToDecodeResponse }
            return result
        } catch NetworkError.invalidUrl {
            throw NetworkError.invalidUrl
        } catch NetworkError.invalidRequest {
            throw NetworkError.invalidRequest
        }
    }
}
