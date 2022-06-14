//
//  NewsTableViewController+Ext.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import Foundation
import UIKit
import SafariServices
import Popovers

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
    var businessItem: Templates.MenuButton {
        return createActionItem(title: "Business", category: .business)
    }
    
    var generalItem: Templates.MenuButton {
        return createActionItem(title: "General", category: .general)
    }
    
    var technologyItem: Templates.MenuButton {
        return createActionItem(title: "Technology", category: .technology)
    }
    
    var entertainmentItem: Templates.MenuButton {
        return createActionItem(title: "Entertainment", category: .entertainment)
    }
    
    var healthItem: Templates.MenuButton {
        return createActionItem(title: "Health", category: .health)
    }
    var sportsItem: Templates.MenuButton {
        return createActionItem(title: "Sports", category: .sports)
    }
    
    var scienceItem: Templates.MenuButton {
        return createActionItem(title: "Science", category: .science)
    }
    
//    func createActionItem(title: String, category: Category) -> UIAction {
//        let action = UIAction(title: title) { [weak self] _ in
//            guard let self = self else { return }
//            UserDefaults.standard.set(category.rawValue, forKey: "category")
//            self.viewModel.selectedCategory = category
//            self.viewModel.fetchingData(page: 1, query: self.viewModel.query) {
//                DispatchQueue.main.async {
//                    if self.viewModel.numberRows() == 0 {
//                        self.emptyNewsLabel.isHidden = false
//                    }
//                    self.tableView.reloadData()
//                }
//            }
//        }
//        return action
//    }
    
    func createActionItem(title: String, category: Category) -> Templates.MenuButton {
        let button = Templates.MenuButton(title: title) { [weak self] in
            guard let self = self else { return }
            UserDefaults.standard.set(category.rawValue, forKey: "category")
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
        return button
    }
    
    
    
    func createCategoryButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(customView: categoryButton)
        categoryButton.setImage(UIImage(systemName: "newspaper"), for: .normal)
        categoryButton.addTarget(self, action: #selector(presentationMenu), for: .touchUpInside)
        return button
    }
    
    func createMenuCategory() -> Templates.UIKitMenu {
        let menu = Templates.UIKitMenu(sourceView: categoryButton) { [unowned self] in
            self.sportsItem
            self.scienceItem
            self.businessItem
            self.generalItem
            self.entertainmentItem
            self.healthItem
            self.technologyItem
        }
        return menu
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
        let button = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingsBarButtonPressed))
        return button
    }
    
    @objc func settingsBarButtonPressed() {
        coordinator.showSettings()
    }
    
    @objc func refreshNews() {
        viewModel.fetchingData(page: 1, query: viewModel.query) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        refreshControl.endRefreshing()
    }
    
    @objc func presentationMenu() {
        if menuCatergories.isPresented {
            menuCatergories.dismiss()
        } else {
            menuCatergories.present()
        }
    }
}


extension NewsTableViewController: SFSafariViewControllerDelegate {}
