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
    
    //MARK: - Variables
    var coordinator: AppCoordinatorType!
    var viewModel: NewsViewModelType!
    let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        setupTableViewConstraints()
    }
}

//MARK: - Table view delegate
extension NewsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let urlString = viewModel.articles[indexPath.row].url else { return }
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var page = 1
        if indexPath.row == viewModel.numberRows() - 1 && viewModel.numberRows() != 100 { // ограничение 100 из-за
            page += 1                                                                     // бесплатного аккаунта
            viewModel.fetchingData(page: page) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}


//MARK: - Table view data source
extension NewsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? NewsCell else { return UITableViewCell() }
        cell.setupCell(with: viewModel, for: indexPath)
        return cell
    }
}


