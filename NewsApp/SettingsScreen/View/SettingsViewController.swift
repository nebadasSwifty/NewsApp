//
//  SettingsViewController.swift
//  NewsApp
//
//  Created by Кирилл on 10.06.2022.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    //MARK: - Outlets
    var tableView: UITableView!
    var backBarButton: UIBarButtonItem!
    var addItemsBarButton: UIBarButtonItem!
    
    var viewModel: SettingsViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createView()
        configureNavigationView()
    }
 //MARK: - Private methods
    private func createView() {
        tableView = createTableView()
        backBarButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(popSettingsScreen))
        addItemsBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemsToTableView))
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }
    }
    
    private func configureNavigationView() {
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.rightBarButtonItem = addItemsBarButton
        title = "Search keywords"
    }
}

// MARK: - Table view delegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _ in
            self?.viewModel.savedNewsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeAction
    }
}
// MARK: - Table view data source
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
