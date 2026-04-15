//
//  FavouritesStore.swift
//  Tahudu
//
//  Created by Chandru R on 14/04/26.
//

import Foundation

protocol FavouritesStoreProtocol {
    func load() -> Set<String>
    func save(_ ids: Set<String>)
}

final class FavouritesStore: FavouritesStoreProtocol {

    private let key = "favourite_listings"

    func load() -> Set<String> {
        let ids = UserDefaults.standard.array(forKey: key) as? [String] ?? []
        return Set(ids)
    }

    func save(_ ids: Set<String>) {
        UserDefaults.standard.set(Array(ids), forKey: key)
    }
}
