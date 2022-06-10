//
//  SettingsViewController.swift
//  NewsApp
//
//  Created by Кирилл on 10.06.2022.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var backBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(popSettingsScreen))
        return button
    }()
    
    lazy var addItemsBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemsToTableView))
        return button
    }()
    
    var viewModel: SettingsViewModelType!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
    }
    
    private func createView() {
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.rightBarButtonItem = addItemsBarButton
        title = "Settings"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.viewModel.savedNewsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeAction
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = viewModel.savedNewsArray[indexPath.row]
        return cell
    }
}


extension SettingsViewController {
    @objc func popSettingsScreen() {
        viewModel.saveArray()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addItemsToTableView() {
        let alert = UIAlertController(title: "Add phrase", message: "You can add new phrase to search", preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            guard let text = alert.textFields?.first?.text, text != "" else { return }
            self.viewModel.savedNewsArray.append(text)
            self.tableView.reloadData()
        }))
        present(alert, animated: true)
    }
}
