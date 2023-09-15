//
//  ViewController.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import UIKit
import SnapKit

class NewsTableViewController: UIViewController {
    // MARK: - Outlets
    var tableView: UITableView!
    var menuCatergories: UIAlertController!
    var settingsBarButton: UIBarButtonItem!
    var categoryBarButton: UIBarButtonItem!
    var refreshControl: UIRefreshControl!
    
    //MARK: - Variables
    var viewModel: NewsViewModel!
    var finishFlow: CompletionBlock?
    
    //MARK: - View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    // MARK: - methods
    private func setupUI() {
        title = "News"
        
        refreshControl = setupRefreshControl()
        settingsBarButton = createSettingsBarButton()
        categoryBarButton = createCategoryButton()
        menuCatergories = createSheet()
        tableView = createTableView()
        
        navigationItem.rightBarButtonItems = [settingsBarButton, categoryBarButton]
        setupTableViewConstraints()
    }
    
    private func bindViewModel() {
        viewModel.articles.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.errorString.bind { [weak self] error in
            DispatchQueue.main.async {
                self?.showErrorAlert(message: error)
            }
        }
    }
}


