//
//  String.swift
//  Tahudu
//
//  Created by Chandru R on 14/04/26.
//

import Foundation

extension String {
    
    var toAssetName: String {
        self
            .split(separator: "_")
            .map { $0.capitalized }
            .joined()
    }
    
}
