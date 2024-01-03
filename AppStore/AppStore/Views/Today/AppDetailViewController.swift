//
//  AppDetailViewController.swift
//  AppStore
//
//  Created by 소현 on 1/3/24.
//

import UIKit
import SnapKit
import Kingfisher

class AppDetailViewController: UIViewController {
    
    private let today: Today
    
    init(today: Today) {
        self.today = today
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("받기", for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setLayout()
        
        titleLabel.text = today.title
        subTitleLabel.text = today.subTitle
        
        if let imageURL = URL(string: today.imageURL) {
            imageView.kf.setImage(with: imageURL)
        }
    }
    
}

private extension AppDetailViewController {
    func setLayout() {
        [imageView, titleLabel, subTitleLabel, downloadButton, shareButton].forEach { view.addSubview($0) }
        
        view.backgroundColor = .systemBackground
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(100)
            $0.width.equalTo(imageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        downloadButton.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(24)
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
            $0.bottom.equalTo(imageView.snp.bottom)
        }
        
        shareButton.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(32)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(imageView.snp.bottom)
        }
    }
    
    @objc func didTapShareButton() {
        let activityItems: [Any] = [today.title]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        present(activityViewController, animated: true)
    }
}
