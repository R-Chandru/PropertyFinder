//
//  ListingCardView.swift
//  Tahudu
//
//  Created by Chandru R on 14/04/26.
//

import SwiftUI

struct ListingCardView: View {

    let listing: Listing
    let isFavourite: Bool
    let onFavouriteTap: () -> Void

    private static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()

    private static let relativeDateFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        return formatter
    }()

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()

    var body: some View {
        VStack(spacing: 0) {
            imageSection
            detailsSection
            Divider()
                .overlay(Color.secondary.opacity(0.3))
            footerSection

            if let last = listing.lastContactedAt {
                lastContactedBanner(date: last)
            }
        }
        .background(Color(.systemBackground))
        .cornerRadius(AppConstants.Radius.card)
        .overlay(
            RoundedRectangle(cornerRadius: AppConstants.Radius.card)
                .stroke(Color.secondary.opacity(0.3))
        )
    }

    // MARK: - Image Section

    private var imageSection: some View {
        ZStack(alignment: .topLeading) {
            ImageCarouselView(images: listing.images.map { $0.toAssetName })

            HStack(spacing: AppConstants.Spacing.small) {
                ForEach(listing.tags.compactMap({ $0.title }), id: \.self) { tag in
                    tagBadge(tag)
                }
            }
            .padding(AppConstants.Padding.section)

            Button(action: onFavouriteTap) {
                Image(systemName: isFavourite ? "heart.fill" : "heart")
                    .foregroundColor(.white)
                    .font(.system(size: AppConstants.IconSize.standard))
                    .padding(AppConstants.Padding.innerSmall)
                    .background(Color.black.opacity(0.4))
                    .clipShape(Circle())
            }
            .frame(maxWidth: .infinity, alignment: .topTrailing)
            .padding(AppConstants.Padding.section)
        }
    }

    // MARK: - Details Section

    private var detailsSection: some View {
        VStack(alignment: .leading, spacing: AppConstants.Spacing.small) {
            HStack(spacing: AppConstants.Spacing.small) {
                Text(listing.type)
                    .font(.caption)

                Text("Delivery: \(listing.deliveryYear, format: .number.grouping(.never))")
                    .font(.caption)
                    .foregroundColor(.cardText)
                    .padding(.horizontal, AppConstants.Padding.innerSmall)
                    .padding(.vertical, 4)
                    .background(Color.cardBackground)
                    .cornerRadius(AppConstants.Radius.badge)
            }

            Text(formattedPrice)
                .font(.headline)

            HStack(spacing: AppConstants.Spacing.small) {
                Image(systemName: "bed.double")
                    .font(.system(size: AppConstants.IconSize.standard))
                Text(bedroomText)
            }
            .font(.caption)
            .padding(.top, AppConstants.Spacing.medium)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(AppConstants.Padding.section)
    }

    // MARK: - Details Components

    private var footerSection: some View {
        HStack {
            Text(publishedText)
                .font(.caption)

            Spacer()

            contactButtons
        }
        .padding(AppConstants.Padding.section)
    }

    private func tagBadge(_ text: String) -> some View {
        Text(text)
            .font(.caption2)
            .fontWeight(.semibold)
            .padding(.horizontal, 4)
            .padding(.vertical, 4)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(AppConstants.Radius.badge)
    }

    private var contactButtons: some View {
        HStack(spacing: AppConstants.Spacing.small) {
            ForEach(listing.contactOptions, id: \.self) { option in
                ContactButton(option.contactType) {
                    print("Tapped \(option.rawValue) for listing \(listing.id)")
                }
            }
        }
    }

    private func lastContactedBanner(date: Date) -> some View {
        HStack(spacing: AppConstants.Spacing.small) {
            Image(systemName: "phone.fill")
                .font(.system(size: AppConstants.IconSize.standard))
            Text("Last contacted: \(Self.dateFormatter.string(from: date))")
        }
        .font(.caption)
        .padding(AppConstants.Padding.section)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.bannerBackground)
    }

    // MARK: - Formatting Helpers

    private var formattedPrice: String {
        let formatted = Self.priceFormatter.string(from: NSNumber(value: listing.price)) ?? "\(listing.price)"
        return "\(formatted) \(listing.currency)"
    }

    private var bedroomText: String {
        listing.bedrooms.map { "\($0) Beds" } ?? "Studio"
    }

    private var publishedText: String {
        "Published " + Self.relativeDateFormatter.localizedString(for: listing.publishedAt, relativeTo: Date())
    }
}
