//
//  TahuduTabView.swift
//  Tahudu
//

import SwiftUI

struct TahuduTabView: View {
    
    @EnvironmentObject var container: AppContainer
    @State private var selectedTab = Tabs.search.rawValue

    var body: some View {
        TabView(selection: $selectedTab) {
            SearchView(viewModel: container.searchViewModel)
                .tag(Tabs.search.rawValue)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            SettingsView(viewModel: container.settingsViewModel)
                .tag(Tabs.settings.rawValue)
                .tabItem {
                    Label("My Account", systemImage: selectedTab == Tabs.settings.rawValue ? "person.fill" : "person")
                }
                .edgesIgnoringSafeArea(.all)
        }
    }
}

enum Tabs: Int, CaseIterable {
    case search = 0
    case settings

    var name: String {
        switch self {
        case .search:
            return "Search"
        case .settings:
            return "Settings"
        }
    }
}

struct TahuduTabView_Previews: PreviewProvider {
    static var previews: some View {
        TahuduTabView()
    }
}
