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
    
    lazy var menuCatergories: UIMenu = {
        let menu = UIMenu(title: "Category", children: [generalItem, businessItem, technologyItem, entertainmentItem, healthItem, sportsItem, scienceItem])
        return menu
    }()
    
    lazy var barButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "newspaper"), menu: menuCatergories)
        return button
    }()
    
    //MARK: - Variables
    var coordinator: AppCoordinatorType!
    var viewModel: NewsViewModelType!
    var networkService: NetworkServiceType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        setupTableViewConstraints()
        navigationItem.rightBarButtonItem = barButton
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


