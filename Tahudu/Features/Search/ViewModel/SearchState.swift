//
//   SearchState.swift
//  Tahudu
//
//  Created by Chandru R on 14/04/26.
//

import Foundation

struct SearchState {
    var listings: [Listing] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil
    var showFavouritesOnly: Bool = false
    var favouriteIDs: Set<String> = []

    // MARK: - View State

    enum ViewState {
        case loading
        case error(String)
        case empty(StateView.Model)
        case loaded([Listing])
    }

    // MARK: - Derived Data

    var visibleListings: [Listing] {
        showFavouritesOnly
        ? listings.filter { favouriteIDs.contains($0.id) }
        : listings
    }

    var emptyStateViewModel: StateView.Model {
        if showFavouritesOnly {
            return .init(
                icon: "star",
                title: "No favourites yet",
                message: "Properties you favourite will appear here"
            )
        } else {
            return .init(
                icon: "tray",
                title: "No listings found",
                message: "Try adjusting your search or filters"
            )
        }
    }

    var viewState: ViewState {
        if isLoading {
            return .loading
        } else if let error = errorMessage {
            return .error(error)
        } else if visibleListings.isEmpty {
            return .empty(emptyStateViewModel)
        } else {
            return .loaded(visibleListings)
        }
    }

    mutating func setLoading() {
        isLoading = true
        errorMessage = nil
    }

    mutating func setLoaded(_ listings: [Listing]) {
        isLoading = false
        errorMessage = nil
        self.listings = listings
    }

    mutating func setError(_ message: String) {
        isLoading = false
        errorMessage = message
    }

    mutating func toggleFavourite(id: String) {
        favouriteIDs.toggle(id)
    }

    func isFavourite(id: String) -> Bool {
        favouriteIDs.contains(id)
    }
}
