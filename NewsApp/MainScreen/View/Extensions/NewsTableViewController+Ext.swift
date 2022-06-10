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
        let action = UIAction(title: "Business") { _ in
            self.viewModel.selectedCategory = .business
            self.viewModel.fetchingData(page: 1) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        return action
    }
    
    var generalItem: UIAction {
        let action = UIAction(title: "General") { _ in
            self.viewModel.selectedCategory = .general
            self.viewModel.fetchingData(page: 1) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        return action
    }
    
    var technologyItem: UIAction {
        let action = UIAction(title: "Technology") { _ in
            self.viewModel.selectedCategory = .technology
            self.viewModel.fetchingData(page: 1) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        return action
    }
    
    var entertainmentItem: UIAction {
        let action = UIAction(title: "Entertainment") { _ in
            self.viewModel.selectedCategory = .entertainment
            self.viewModel.fetchingData(page: 1) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        return action
    }
    
    var healthItem: UIAction {
        let action = UIAction(title: "Health") { _ in
            self.viewModel.selectedCategory = .health
            self.viewModel.fetchingData(page: 1) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        return action
    }
    var sportsItem: UIAction {
        let action = UIAction(title: "Sports") { _ in
            self.viewModel.selectedCategory = .sports
            self.viewModel.fetchingData(page: 1) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        return action
    }
    
    var scienceItem: UIAction {
        let action = UIAction(title: "Science") { _ in
            self.viewModel.selectedCategory = .science
            self.viewModel.fetchingData(page: 1) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        return action
    }
    
    
}

extension NewsTableViewController: SFSafariViewControllerDelegate {}
