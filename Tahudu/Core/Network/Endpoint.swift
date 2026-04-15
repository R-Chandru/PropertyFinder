//
//  Endpoint.swift
//  Tahudu
//
//  Created by Chandru R on 14/04/26.
//

import Foundation

enum Endpoint {
    case listings

    var url: URL {
        switch self {
        case .listings:
            guard let url = URL(string: "https://simplejsoncms.com/api/m6nfoc4jlw") else {
                fatalError("Invalid URL for endpoint: \(self)")
            }
            return url
        }
    }
}
