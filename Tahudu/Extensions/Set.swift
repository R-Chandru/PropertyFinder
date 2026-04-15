//
//  Set.swift
//  Tahudu
//
//  Created by Chandru R on 15/04/26.
//

import Foundation

extension Set {
    
    mutating func toggle(_ member: Element) {
        if contains(member) {
            remove(member)
        } else {
            insert(member)
        }
    }
    
}
