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
        
        addSubview(elementsStackView)
        elementsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
        }
        
        newsStackView.snp.makeConstraints { make in
            make.left.equalTo(newsImageView).inset(100)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.width.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(10)
        }
    }
    
    //MARK: - Methods configure cell
    func setupCell(with viewModel: NewsViewModelType, for indexPath: IndexPath) {
        let article = viewModel.getArticle(for: indexPath)
        newsNameLabel.text = article.title
        sourceLabel.text = article.author
        
        if article.newsDescription?.isEmpty == false {
            descriptionLabel.text = article.newsDescription
        } else {
            descriptionLabel.text = "Tap on news to see description"
        }
        
        
        guard let date = article.publishedAt else {
            return
        }
        
        dateLabel.text = Date().dateFormatter(date: date)
        
        if let urlImage = URL(string: article.urlToImage ?? "") {
            newsImageView.kf.indicatorType = .activity
            newsImageView.kf.setImage(with: urlImage, options: [.transition(.fade(0.4)),
                                                                .processor(DownsamplingImageProcessor(size: newsImageView.frame.size)),
                                                                .cacheOriginalImage])
        }
    }
    
    override func prepareForReuse() {
        newsImageView.image = nil
    }
}
