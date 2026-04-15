//
//  SettingsViewModel.swift
//  Tahudu
//
//  Created by Chandru R on 15/04/26.
//

import Foundation
import UIKit

final class SettingsViewModel {

    let sections: [[SettingsItem]]

    init() {
        self.sections = [
            [
                SettingsItem(
                    icon: "textformat",
                    title: "Language",
                    detail: Self.currentLanguage,
                    accessibilityID: "SettingsCell_language",
                    action: { Self.openSystemSettings() }
                ),
                SettingsItem(
                    icon: "globe",
                    title: "Country",
                    detail: "United Arab Emirates",
                    accessibilityID: "SettingsCell_country",
                    action: { Self.showCountrySelectionScreen() }
                ),
                SettingsItem(
                    icon: "app.badge",
                    title: "Notifications",
                    detail: nil,
                    accessibilityID: "SettingsCell_notifications",
                    action: { Self.showNotificationScreen() }
                ),
            ],
            [
                SettingsItem(
                    icon: "info.circle",
                    title: "About",
                    detail: nil,
                    accessibilityID: "SettingsCell_about",
                    action: { Self.showAboutScreen() }
                ),
                SettingsItem(
                    icon: "text.bubble",
                    title: "Feedback",
                    detail: nil,
                    accessibilityID: "SettingsCell_feedback",
                    action: { Self.showFeedbackScreen() }
                ),
            ],
        ]
    }

    func item(at indexPath: IndexPath) -> SettingsItem {
        sections[indexPath.section][indexPath.row]
    }

    // MARK: - Helpers

    private static var currentLanguage: String? {
        guard let code = Bundle.main.preferredLocalizations.first else { return nil }
        return Locale.current.localizedString(forLanguageCode: code)
    }

    // MARK: - Actions

    private static func openSystemSettings() {
        print(#function)
    }

    private static func showCountrySelectionScreen() {
        print(#function)
    }

    private static func showNotificationScreen() {
        print(#function)
    }

    private static func showAboutScreen() {
        print(#function)
    }

    private static func showFeedbackScreen() {
        print(#function)
    }
}
