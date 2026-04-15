//
//  ListingRepositoryProtocol.swift
//  Tahudu
//
//  Created by Chandru R on 14/04/26.
//

import Foundation

protocol ListingRepositoryProtocol {
    func fetchListings() async throws -> [Listing]
}
