//
//  SettingsView.swift
//  Tahudu
//
//  Created by Chandru R on 15/04/26.
//

import SwiftUI

struct SettingsView: UIViewControllerRepresentable {
    
    let viewModel: SettingsViewModel
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let settingsViewController = SettingsViewController(style: .insetGrouped, viewModel: viewModel)
        settingsViewController.title = "My Account"

        let navigationController = UINavigationController(rootViewController: settingsViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // Nothing here
    }
}
