//
//  AppContainer.swift
//  Tahudu
//
//  Created by Chandru R on 14/04/26.
//

import Foundation

@MainActor
final class AppContainer: ObservableObject {

    let searchViewModel: SearchViewModel
    let settingsViewModel: SettingsViewModel

    init(
        apiClient: APIClientProtocol = APIClient(),
        favouritesStore: FavouritesStoreProtocol = FavouritesStore()
    ) {
        let repository = ListingRepository(apiClient: apiClient)

        self.searchViewModel = SearchViewModel(
            repository: repository,
            favouritesStore: favouritesStore
        )
        
        self.settingsViewModel = SettingsViewModel()
    }
}
