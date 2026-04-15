//
//  SettingsViewController.swift
//  Tahudu
//
//  Created by Chandru R on 15/04/26.
//

import UIKit

final class SettingsViewController: UITableViewController {

    private let viewModel: SettingsViewModel
    
    init(style: UITableView.Style, viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        tableView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = UIView()
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in _: UITableView) -> Int {
        viewModel.sections.count
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].count
    }

    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.item(at: indexPath)
        let style: UITableViewCell.CellStyle = item.detail != nil ? .value1 : .default
        let cell = UITableViewCell(style: style, reuseIdentifier: nil)

        cell.accessibilityIdentifier = item.accessibilityID
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(systemName: item.icon)
        cell.textLabel?.text = item.title

        if let detail = item.detail {
            cell.detailTextLabel?.text = detail
            cell.detailTextLabel?.textColor = .secondaryLabel
        }

        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.item(at: indexPath).action()
    }
}
