//
//  FeatureSectionCollectionViewCell.swift
//  AppStore
//
//  Created by 소현 on 1/2/24.
//

import UIKit
import SnapKit
import Kingfisher

final class FeatureSectionCollectionViewCell: UICollectionViewCell {
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        
        return label
    }()
    
    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 7
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.separator.cgColor
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    func setup(feature: Feature) {
        setupLayout()
        
        typeLabel.text = feature.type
        appNameLabel.text = feature.appName
        descriptionLabel.text = feature.description
        imageView.backgroundColor = .lightGray
        
        if let imageURL = URL(string: feature.imageURL) {
            imageView.kf.setImage(with: imageURL)
        }
    }
}

private extension FeatureSectionCollectionViewCell {
    func setupLayout() {
        [typeLabel, appNameLabel, descriptionLabel, imageView].forEach {
            addSubview($0)
        }
        
        typeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        appNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(typeLabel.snp.bottom)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(appNameLabel.snp.bottom).offset(4)
        }
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}
