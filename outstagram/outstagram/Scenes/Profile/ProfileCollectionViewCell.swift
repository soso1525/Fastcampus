//
//  ProfileCollectionViewCell.swift
//  outstagram
//
//  Created by 소현 on 1/6/24.
//

import UIKit
import SnapKit

class ProfileCollectionViewCell: UICollectionViewCell {
    private lazy var imageView = UIImageView()
    
    func setup(with image: UIImage) {
        addSubview(imageView)
        imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        imageView.backgroundColor = .tertiaryLabel
    }
}
