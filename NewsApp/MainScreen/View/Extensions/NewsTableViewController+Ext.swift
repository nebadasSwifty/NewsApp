//
//  NewsTableViewController+Ext.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import Foundation
import UIKit
import SafariServices

extension NewsTableViewController {
    func createTableView() -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.register(NewsCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }
    
    func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    var businessItem: UIAction {
        return createActionItem(title: "Business", category: .business)
    }
    
    var generalItem: UIAction {
        return createActionItem(title: "General", category: .general)
    }
    
    var technologyItem: UIAction {
        return createActionItem(title: "Technology", category: .technology)
    }
    
    var entertainmentItem: UIAction {
        return createActionItem(title: "Entertainment", category: .entertainment)
    }
    
    var healthItem: UIAction {
        return createActionItem(title: "Health", category: .health)
    }
    var sportsItem: UIAction {
        return createActionItem(title: "Sports", category: .sports)
    }
    
    var scienceItem: UIAction {
        return createActionItem(title: "Science", category: .science)
    }
    
    func createActionItem(title: String, category: Category) -> UIAction {
        let action = UIAction(title: title) { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.selectedCategory = category
            self.viewModel.fetchingData(page: 1, query: self.viewModel.query) {
                DispatchQueue.main.async {
                    if self.viewModel.numberRows() == 0 {
                        self.emptyNewsLabel.isHidden = false
                    }
                    self.tableView.reloadData()
                }
            }
        }
        return action
    }
    
    var settingsItem: UIAction {
        let action = UIAction(title: "Settings", image: UIImage(systemName: "gearshape")) { _ in
            self.coordinator.showSettings()
        }
        return action
    }
    func createCategoryButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(image: UIImage(systemName: "newspaper"), menu: menuCatergories)
        return button
    }
    
    func createMenuCategory() -> UIMenu {
        let menu = UIMenu(title: "Category", children: [generalItem, businessItem, technologyItem, entertainmentItem, healthItem, sportsItem, scienceItem, settingsItem])
        return menu
    }
    
    func createEmptyNewsLabel() -> UILabel {
        let label = UILabel()
        label.frame = view.bounds
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "No news found for keywords."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }
    
    
}

extension NewsTableViewController: SFSafariViewControllerDelegate {}
