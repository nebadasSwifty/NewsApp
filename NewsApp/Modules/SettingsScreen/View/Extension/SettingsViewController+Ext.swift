//
//  SettingsViewController+Ext.swift
//  NewsApp
//
//  Created by Кирилл on 10.06.2022.
//

import UIKit

extension SettingsViewController {
    func createTableView() -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }
    
    @objc func popSettingsScreen() {
        viewModel.saveArray()
        finishFlow?()
    }
    
    @objc func addItemsToTableView() {
        let alert = UIAlertController(title: "Add phrase", message: "You can add new phrase to search", preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            guard let text = alert.textFields?.first?.text, text != "" else {
                return
            }
            
            self?.viewModel.savedNewsArray.append(text)
            self?.tableView.reloadData()
        }))
        present(alert, animated: true)
    }
}
