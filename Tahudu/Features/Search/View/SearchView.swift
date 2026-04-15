//
//  SearchView.swift
//  Tahudu
//

import SwiftUI

struct SearchView: View {

    @ObservedObject var viewModel: SearchViewModel
    private let animation = Animation.easeInOut(duration: 0.25)

    var body: some View {
        VStack(spacing: AppConstants.Spacing.medium) {
            topBar
            searchBar
            contentView
        }
        .background(Color(.systemBackground))
        .task {
            viewModel.fetchListings()
        }
    }

    // MARK: - Top Bar

    private var topBar: some View {
        HStack {
            HStack(spacing: AppConstants.Spacing.extraLarge) {
                Image(systemName: "slider.horizontal.3")
                    .foregroundColor(.accentColor)
                    .font(.system(size: AppConstants.IconSize.standard, weight: .light))
                
                Image(systemName: "arrow.up.arrow.down")
                    .foregroundColor(.accentColor)
                    .font(.system(size: AppConstants.IconSize.standard, weight: .light))
            }

            Spacer()

            Button {
                withAnimation(animation) {
                    viewModel.toggleFavouritesFilter()
                }
            } label: {
                Image(systemName: viewModel.state.showFavouritesOnly ? "star.fill" : "star")
                    .foregroundColor(.accentColor)
                    .font(.system(size: AppConstants.IconSize.standard, weight: .light))
            }
        }
        .padding(.horizontal, AppConstants.Padding.screen)
        .padding(.vertical, AppConstants.Padding.vertical)
    }

    // MARK: - Search Bar

    private var searchBar: some View {
        HStack(spacing: AppConstants.Spacing.small) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: AppConstants.IconSize.standard))
                .foregroundColor(Color.secondary)
            
            Text("City, area or building")
                .font(.system(size: AppConstants.IconSize.standard))
                .foregroundColor(Color.secondary)
            
            Spacer()
        }
        .padding(.horizontal, AppConstants.Padding.screen)
        .padding(.vertical, AppConstants.Padding.section)
        .background(Color(.systemBackground))
        .cornerRadius(AppConstants.Radius.searchBar)
        .overlay(
            RoundedRectangle(cornerRadius: AppConstants.Radius.searchBar)
                .stroke(Color.secondary, lineWidth: 1)
        )
        .padding(.horizontal, AppConstants.Padding.screen)
    }

    // MARK: - Content

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state.viewState {
        case .loading:
            ProgressView()
                .frame(maxHeight: .infinity)

        case .error(let message):
            StateView(
                model: StateView.Model(
                    icon: "wifi.exclamationmark",
                    title: "Something went wrong",
                    message: message,
                    actionTitle: "Retry",
                    action: {
                        viewModel.fetchListings()
                    }
                )
            )

        case .empty:
            StateView(
                model: viewModel.state.emptyStateViewModel
            )

        case .loaded(let listings):
            listingsView(listings)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
        }
    }

    private func listingsView(_ listings: [Listing]) -> some View {
        VStack(spacing: AppConstants.Spacing.small) {
            
            if viewModel.state.showFavouritesOnly {
                HStack(spacing: AppConstants.Spacing.small) {
                    
                    Circle()
                        .fill(Color.accentColor.opacity(0.8))
                        .frame(width: 6, height: 6)
                    
                    Text("Favourites")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    Spacer()
                }
                .foregroundColor(.primary)
                .padding(.horizontal, AppConstants.Padding.screen)
                .padding(.vertical, AppConstants.Padding.innerSmall)
            }
            
            ScrollView {
                LazyVStack(spacing: AppConstants.Spacing.large) {
                    ForEach(listings) { listing in
                        ListingCardView(
                            listing: listing,
                            isFavourite: viewModel.state.isFavourite(id: listing.id),
                            onFavouriteTap: {
                                withAnimation(animation) {
                                    viewModel.toggleFavourite(listing)
                                }
                            }
                        )
                    }
                }
                .padding(.horizontal, AppConstants.Padding.screen)
                .padding(.top, AppConstants.Padding.vertical)
            }
        }
    }
}
