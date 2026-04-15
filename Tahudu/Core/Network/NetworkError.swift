//
//  NetworkError.swift
//  Tahudu
//
//  Created by Chandru R on 14/04/26.
//

import Foundation

enum NetworkError: LocalizedError {
    case badStatusCode(Int)
    case decodingFailed(Error)
    case noConnection

    var errorDescription: String? {
        switch self {
        case .badStatusCode(let code):
            return "Server returned status code \(code)"
        case .decodingFailed:
            return "Failed to parse server response"
        case .noConnection:
            return "No internet connection. Please try again."
        }
    }
}
