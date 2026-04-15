//
//  APIClient.swift
//  Tahudu
//
//  Created by Chandru R on 14/04/26.
//

import Foundation

protocol APIClientProtocol {
    func fetch<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

final class APIClient: APIClientProtocol {

    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
        decoder.dateDecodingStrategy = .iso8601
    }

    func fetch<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await session.data(from: endpoint.url)
        } catch let error as URLError where error.code == .notConnectedToInternet {
            throw NetworkError.noConnection
        }

        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            throw NetworkError.badStatusCode(statusCode)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}
