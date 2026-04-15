//
//  Listing.swift
//  Tahudu
//
//  Created by Chandru R on 14/04/26.
//

import Foundation

struct ListingsResponse: Decodable {
    let listings: [Listing]
}

struct Listing: Decodable, Identifiable {
    let id: String
    let type: String
    let deliveryYear: Int
    let price: Int
    let currency: String
    let priceInclusive: Bool
    let location: String
    let bedrooms: Int?
    let bathrooms: Int
    let areaSqft: Int
    let publishedAt: Date
    let lastContactedAt: Date?
    let tags: [ListingTag]
    let images: [String]
    let contactOptions: [ContactOption]
}
