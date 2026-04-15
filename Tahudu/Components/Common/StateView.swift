//
//  StateView.swift
//  Tahudu
//
//  Created by Chandru R on 15/04/26.
//


import SwiftUI

struct StateView: View {

    let model: Model

    var body: some View {
        VStack(spacing: AppConstants.Padding.section) {

            Spacer()

            Image(systemName: model.icon)
                .font(.system(size: 28, weight: .light))
                .foregroundColor(.secondary)

            VStack(spacing: 4) {
                Text(model.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)

                if let message = model.message {
                    Text(message)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
            }

            if let actionTitle = model.actionTitle,
               let action = model.action {

                Button(action: action) {
                    Text(actionTitle)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.horizontal, AppConstants.Padding.screen)
                        .padding(.vertical, AppConstants.Padding.vertical)
                }
                .foregroundColor(.accentColor)
                .overlay(
                    Capsule()
                        .stroke(Color.accentColor.opacity(0.3), lineWidth: 1)
                )
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, AppConstants.Padding.screen)
    }
}

extension StateView {

    struct Model {
        let icon: String
        let title: String
        let message: String?
        let actionTitle: String?
        let action: (() -> Void)?

        init(
            icon: String,
            title: String,
            message: String? = nil,
            actionTitle: String? = nil,
            action: (() -> Void)? = nil
        ) {
            self.icon = icon
            self.title = title
            self.message = message
            self.actionTitle = actionTitle
            self.action = action
        }
    }
}
