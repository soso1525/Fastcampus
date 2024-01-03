//
//  AppViewController.swift
//  AppStore
//
//  Created by 소현 on 1/2/24.
//

import UIKit
import SnapKit

/* UIScrollView > UIStackView > UICollectionView */

final class AppViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.0
        
        let featureSectionView = FeatureSectionView(frame: .zero)
        let rankingFeatureSectionView = RankingFeatureSectionView(frame: .zero)
        let exchangeCodeButtonView = ExchangeCodeButtonView(frame: .zero)
        
        let spacingView = UIView() // 하단의 코드 교환 버튼이 잘 보이도록 하단에 여백을 줌.
        spacingView.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        [featureSectionView, rankingFeatureSectionView, exchangeCodeButtonView, spacingView].forEach {
            stackView.addArrangedSubview($0) // addView가 아님!!!!
        }
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupLayout()
    }
    
}

private extension AppViewController {
    func setupNavigationController() {
        navigationItem.title = "앱"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true // 항상 large 스타일로 표시된다.
    }
    
    func setupLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top) // eqaulToSuperview()로 설정하면 NavigationBar와 겹치게 됨.
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
