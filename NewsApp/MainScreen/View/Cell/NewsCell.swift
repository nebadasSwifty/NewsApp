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
    lazy var newsImageView: UIImageView = createImageView()
    lazy var newsNameLabel: UILabel = createNameLabel()
    lazy var descriptionLabel: UILabel = createDescriptionLabel()
    lazy var dateLabel: UILabel = createDateLabel()
    lazy var sourceLabel: UILabel = createSourceLabel()
    lazy var newsStackView: UIStackView = createNewsStackView()
    lazy var elementsStackView: UIStackView = createStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViewCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureViewCell() {
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
    
    func setupCell(with viewModel: NewsViewModelType, for indexPath: IndexPath) {
        guard let urlImage = URL(string: viewModel.articles[indexPath.row].urlToImage ?? "") else { return }
        guard let date = viewModel.articles[indexPath.row].publishedAt else { return }
        newsNameLabel.text = viewModel.articles[indexPath.row].title
        descriptionLabel.text = viewModel.articles[indexPath.row].description
        sourceLabel.text = viewModel.articles[indexPath.row].author
        dateLabel.text = dateFormatter(date: date)
        newsImageView.kf.indicatorType = .activity
        newsImageView.kf.setImage(with: urlImage, options: [.transition(.fade(0.4))])
    }
    
}