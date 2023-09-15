//
//  NewsCell.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import UIKit
import Kingfisher

class NewsCell: UITableViewCell {
    //MARK: - Outlets
    var newsImageView: UIImageView!
    var newsNameLabel: UILabel!
    var descriptionLabel: UILabel!
    var dateLabel: UILabel!
    var sourceLabel: UILabel!
    var newsStackView: UIStackView!
    var elementsStackView: UIStackView!
    
    //MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViewCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Private methods
    private func configureViewCell() {
        newsImageView = createImageView()
        newsNameLabel = createNameLabel()
        descriptionLabel = createDescriptionLabel()
        dateLabel = createDateLabel()
        sourceLabel = createSourceLabel()
        newsStackView = createNewsStackView()
        elementsStackView = createStackView()
        
        configureConstraints()
    }
    
    //MARK: - Methods configure cell
    func setupCell(with viewModel: NewsViewModel, for indexPath: IndexPath) {
        guard let article = viewModel.getArticle(for: indexPath) else { return }
        newsNameLabel.text = article.title
        sourceLabel.text = article.author
        
        if article.newsDescription?.isEmpty == false {
            descriptionLabel.text = article.newsDescription
        } else {
            descriptionLabel.text = "Tap on news to see description"
        }
        
        
        if let date = article.publishedAt {
            dateLabel.text = Date().dateFormatter(date: date)
        }

        if let urlImage = URL(string: article.urlToImage ?? "") {
            newsImageView.isHidden = false
            newsImageView.kf.indicatorType = .activity
            newsImageView.kf.setImage(with: urlImage, options: [.transition(.fade(0.4)),
                                                                .cacheOriginalImage])
        } else {
            newsImageView.isHidden = true
        }
    }
    
    func configureConstraints() {
        elementsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        newsImageView.snp.makeConstraints { make in
            make.width.equalTo(70)
        }
    }
    
    override func prepareForReuse() {
        newsImageView.image = nil
    }
}
