//
//  NewsTableViewController+UITableViewDelegate.swift
//  NewsApp
//
//  Created by Кирилл Сутормин on 15.09.2023.
//

import UIKit
import SafariServices

extension NewsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let urlString = viewModel.getArticle(for: indexPath)?.url,
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
