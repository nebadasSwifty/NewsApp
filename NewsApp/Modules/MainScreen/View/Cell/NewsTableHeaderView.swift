//
//  NewsTableHeaderView.swift
//  NewsApp
//
//  Created by Кирилл on 22.09.2022.
//

import UIKit
import SnapKit

class NewsTableHeaderView: UIView {
    private var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel()
    }
    
    private func setupLabel() {
        titleLabel = UILabel()
        addSubview(titleLabel)
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
        }
    }
    
    func setText(_ text: String) {
        if !text.isEmpty {
            titleLabel.text = text
        }
    }
}
