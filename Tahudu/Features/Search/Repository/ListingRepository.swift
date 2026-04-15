//
//  ListingRepository.swift
//  Tahudu
//
//  Created by Chandru R on 14/04/26.
//

import Foundation

final class ListingRepository: ListingRepositoryProtocol {

    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func fetchListings() async throws -> [Listing] {
        let response: ListingsResponse = try await apiClient.fetch(.listings)
        return response.listings
    }
}
