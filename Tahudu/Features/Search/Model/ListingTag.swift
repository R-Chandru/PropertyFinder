//
//  ListingTag.swift
//  Tahudu
//
//  Created by Chandru R on 14/04/26.
//

import Foundation

enum ListingTag: Decodable, Hashable {
    case verified
    case newConstruction
    case liveViewing
    case unknown(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)

        switch value {
        case "verified":
            self = .verified
        case "new_construction":
            self = .newConstruction
        case "live_viewing":
            self = .liveViewing
        default:
            self = .unknown(value)
        }
    }

    var title: String? {
        switch self {
        case .verified: return "VERIFIED"
        case .newConstruction: return "NEW CONSTRUCTION"
        case .liveViewing: return "LIVE VIEWING"
        case .unknown: return nil
        }
    }
}
