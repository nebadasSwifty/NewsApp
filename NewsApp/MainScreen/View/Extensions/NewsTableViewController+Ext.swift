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
}

extension NewsTableViewController: SFSafariViewControllerDelegate {}
