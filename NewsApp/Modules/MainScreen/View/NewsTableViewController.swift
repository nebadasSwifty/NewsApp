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
    var viewModel: NewsViewModelType!
    var finishFlow: CompletionBlock?
    
    init(viewModel: NewsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
        viewModel.fetchData()
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
            if !error.isEmpty {
                DispatchQueue.main.async {
                    self?.showErrorAlert(message: error)
                }
            }
        }
    }
}


