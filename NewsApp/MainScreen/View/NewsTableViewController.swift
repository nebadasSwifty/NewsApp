//
//  ViewController.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import UIKit
import SnapKit
import SafariServices

class NewsTableViewController: UIViewController {
    // MARK: - Outlets
    lazy var tableView: UITableView = createTableView()
    lazy var menuCatergories: UIMenu = createMenuCategory()
    lazy var categoryBarButton: UIBarButtonItem = createCategoryButton()
    lazy var emptyNewsLabel: UILabel = createEmptyNewsLabel()
    
    //MARK: - Variables
    var coordinator: AppCoordinatorType!
    var viewModel: NewsViewModelType!
    var networkService: NetworkServiceType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        configureEmptyNewsLabel()
        setupTableViewConstraints()
        navigationItem.rightBarButtonItem = categoryBarButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel = nil
        viewModel = NewsViewModel(networkService: networkService)
        viewModel.fetchingData(page: 1, query: viewModel.query) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func configureEmptyNewsLabel() {
        tableView.addSubview(emptyNewsLabel)
        if viewModel.numberRows() == 0 {
            emptyNewsLabel.isHidden = false
        }
        emptyNewsLabel.center = tableView.center
    }
}

//MARK: - Table view delegate
extension NewsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let urlString = viewModel.getArticle(for: indexPath).url else { return }
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            present(vc, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
}


//MARK: - Table view data source
extension NewsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? NewsCell else { return UITableViewCell() }
        if viewModel.numberRows() != 0 {
            cell.setupCell(with: viewModel, for: indexPath)
            emptyNewsLabel.isHidden = true
        }
        return cell
    }
}


