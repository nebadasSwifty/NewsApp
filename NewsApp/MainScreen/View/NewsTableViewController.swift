//
//  ViewController.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import UIKit
import SnapKit
import SafariServices
import CoreData

class NewsTableViewController: UIViewController {
    // MARK: - Outlets
    var tableView: UITableView!
    var menuCatergories: UIAlertController!
    var settingsBarButton: UIBarButtonItem!
    var categoryBarButton: UIBarButtonItem!
    var refreshControl: UIRefreshControl!
    
    //MARK: - Variables
    var coordinator: AppCoordinatorType!
    var viewModel: NewsViewModelType!
    
    //MARK: - View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getData { [weak self] in
            self?.tableView.reloadData()
        }
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
}

//MARK: - Table view delegate
extension NewsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let urlString = viewModel.getArticle(for: indexPath).url,
              let url = URL(string: urlString) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: - Table view data source
extension NewsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? NewsCell else {
            fatalError("Can't create cell: NewsCell")
        }
        
        cell.setupCell(with: viewModel, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if viewModel.numberRows() == 0 {
            let view = NewsTableHeaderView(frame: .zero)
            view.setText("News not found")
            
            return view
        }
        
        return nil
    }
}

extension NewsTableViewController: SFSafariViewControllerDelegate {}

