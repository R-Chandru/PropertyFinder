//
//  ContactOption.swift
//  Tahudu
//
//  Created by Chandru R on 14/04/26.
//

import Foundation

enum ContactOption: String, Decodable {
    case phone
    case email
    case whatsapp

    var contactType: ContactType {
        switch self {
        case .phone: return .phone
        case .email: return .email
        case .whatsapp: return .whatsApp
        }
    }
}
