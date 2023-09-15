//
//  NewsTableViewController+UITableViewDataSource.swift
//  NewsApp
//
//  Created by Кирилл Сутормин on 15.09.2023.
//

import UIKit

extension NewsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
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
        if viewModel.numberOfRowsInSection(section) == 0 {
            let view = NewsTableHeaderView(frame: .zero)
            view.setText("News not found")
            
            return view
        }
        
        return nil
    }
}
