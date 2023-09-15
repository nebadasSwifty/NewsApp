//
//  NewsTableViewController+Ext.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import UIKit

extension NewsTableViewController {
    //MARK: - Table view configure
    func createTableView() -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        
        tableView.estimatedSectionHeaderHeight = 64
        tableView.register(NewsCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(refreshControl)
        
        return tableView
    }
    
    func setupRefreshControl() -> UIRefreshControl {
        let refresh = UIRefreshControl()
        
        refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresh.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        
        return refresh
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
    
    func createActionItem(title: String, category: Category) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: .default) { [weak self] _ in
            UserDefaults.standard.set(category.rawValue, forKey: "categories")
            
            self?.viewModel.getData()
        }
        
        return action
    }
    
    func createSheet() -> UIAlertController {
        let alert = UIAlertController(title: "Categories", message: nil, preferredStyle: .actionSheet)
        
        Category.allCases.forEach({ alert.addAction(createActionItem(title: $0.rawValue, category: $0)) })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        return alert
    }
    
    func createCategoryButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "newspaper"), style: .plain, target: self, action: #selector(presentSheet))
        
        return button
    }
    
    //MARK: - Configure settings bar button
    func createSettingsBarButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "gearshape"), style: .plain, target: self, action: #selector(settingsBarButtonPressed))
        
        return button
    }
    
    @objc func settingsBarButtonPressed() {
//        coordinator.showSettings()
    }
    
    @objc func refreshNews() {
        viewModel.getData()
        refreshControl.endRefreshing()
    }
    
    @objc func presentSheet() {
        if let presenter = menuCatergories.popoverPresentationController {
            presenter.barButtonItem = categoryBarButton
        }
        
        present(menuCatergories, animated: true)
    }
    
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okButton)
        
        present(alertController, animated: true)
    }
}
