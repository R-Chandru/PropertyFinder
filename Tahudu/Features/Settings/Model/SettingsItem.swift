//
//  SettingsItem.swift
//  Tahudu
//
//  Created by Chandru R on 15/04/26.
//

import Foundation

struct SettingsItem {
    let icon: String
    let title: String
    let detail: String?
    let accessibilityID: String
    let action: () -> Void
}
