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
    //MARK: - Table view configure
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
    //MARK: - Configure categories menu
    var businessItem: UIAlertAction {
        return createActionItem(title: "Business", category: .business)
    }
    
    var generalItem: UIAlertAction {
        return createActionItem(title: "General", category: .general)
    }
    
    var technologyItem: UIAlertAction {
        return createActionItem(title: "Technology", category: .technology)
    }
    
    var entertainmentItem: UIAlertAction {
        return createActionItem(title: "Entertainment", category: .entertainment)
    }
    
    var healthItem: UIAlertAction {
        return createActionItem(title: "Health", category: .health)
    }
    var sportsItem: UIAlertAction {
        return createActionItem(title: "Sports", category: .sports)
    }
    
    var scienceItem: UIAlertAction {
        return createActionItem(title: "Science", category: .science)
    }
    
    func createActionItem(title: String, category: Category) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.selectedCategory = category
            UserDefaults.standard.set(category.rawValue, forKey: "categories")
            self.networkService.fetch(from: self.viewModel.selectedCategory, page: 1, query: self.viewModel.query)
            self.viewModel.getData {
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
    
    func createSheet() -> UIAlertController {
        let alert = UIAlertController(title: "Categories", message: nil, preferredStyle: .actionSheet)
        alert.addAction(generalItem)
        alert.addAction(businessItem)
        alert.addAction(technologyItem)
        alert.addAction(entertainmentItem)
        alert.addAction(healthItem)
        alert.addAction(sportsItem)
        alert.addAction(scienceItem)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        return alert
    }
    
    func createCategoryButton() -> UIBarButtonItem {
        let button = UIButton()
        button.addTarget(self, action: #selector(presentSheet), for: .touchUpInside)
        button.setImage(UIImage(named: "newspaper"), for: .normal)
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }
    //MARK: - Empty news label
    func createEmptyNewsLabel() -> UILabel {
        let label = UILabel()
        label.frame = view.bounds
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "No news found for keywords."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }
    
    func configureConstraintsEmptyNewsLabel() {
        tableView.addSubview(emptyNewsLabel)
        emptyNewsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    //MARK: - Configure settings bar button
    func createSettingsBarButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(image: UIImage(named: "gearshape"), style: .plain, target: self, action: #selector(settingsBarButtonPressed))
        return button
    }
    
    @objc func settingsBarButtonPressed() {
        coordinator.showSettings()
    }
    
    @objc func refreshNews() {
        viewModel.getData {
            self.tableView.reloadData()
        }
        refreshControl.endRefreshing()
    }
    @objc func presentSheet() {
        self.present(menuCatergories, animated: true)
    }
}

extension NewsTableViewController: SFSafariViewControllerDelegate {}
