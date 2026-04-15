//
//  SearchViewModel.swift
//  Tahudu
//
//  Created by Chandru R on 14/04/26.
//

import Foundation
import Combine

@MainActor
final class SearchViewModel: ObservableObject {

    @Published private(set) var state = SearchState()

    private let repository: ListingRepositoryProtocol
    private let favouritesStore: FavouritesStoreProtocol
    private var fetchTask: Task<Void, Never>?

    init(repository: ListingRepositoryProtocol,
         favouritesStore: FavouritesStoreProtocol) {

        self.repository = repository
        self.favouritesStore = favouritesStore
        self.state.favouriteIDs = favouritesStore.load()
    }

    // MARK: - Fetch

    func fetchListings() {
        fetchTask?.cancel()

        fetchTask = Task {
            state.setLoading()

            do {
                let listings = try await repository.fetchListings()
                guard !Task.isCancelled else { return }
                state.setLoaded(listings)

            } catch is CancellationError {
                state.isLoading = false

            } catch {
                guard !Task.isCancelled else { return }
                state.setError(error.localizedDescription)
            }
        }
    }

    // MARK: - Favourites

    func toggleFavourite(_ listing: Listing) {
        state.toggleFavourite(id: listing.id)
        persistFavourites()
    }

    private func persistFavourites() {
        favouritesStore.save(state.favouriteIDs)
    }

    // MARK: - Filter

    func toggleFavouritesFilter() {
        state.showFavouritesOnly.toggle()
    }
}
