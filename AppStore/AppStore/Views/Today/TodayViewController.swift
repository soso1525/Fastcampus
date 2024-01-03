//
//  TodayViewController.swift
//  AppStore
//
//  Created by 소현 on 12/31/23.
//

import UIKit
import SnapKit

final class TodayViewController: UIViewController { // 계승 필요 없음 -> final

    private var todayList: [Today] = []
    
    private lazy var collectionView: UICollectionView = {
        
        // UICollectionView는 layout이 반드시 필요.
        // UICollectionViewLayout은 abstract class -> subclass를 사용하거나 내가 직접 만들어야 한다.
        // simple한 디자인일 경우 UICollectionViewFlowLayout을 사용.
        // scroll 방향에 따라 데이터가 한쪽으로 흐르듯 정렬되며 하나의 행 또는 열에 최대한 많은 cell을 포함시킨다.
        // 따라서 각 셀의 크기를 알아야 최대한 많이 넣든지 말든지 할 수 있음.
        // UICollectionViewCompositionalLayout?
        
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .white
        
        collectionView.register(TodayCollectionViewCell.self, 
                                forCellWithReuseIdentifier: "TodayCell")
        collectionView.register(TodayCollectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "TodayCollectionHeaderView")
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        fetchData()
    
    }
}

private extension TodayViewController {
    func fetchData() {
        guard let url = Bundle.main.url(forResource: "Today", withExtension: "plist") else { return }
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Today].self, from: data)
            todayList = result
        } catch {
            
        }
    }
}

extension TodayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        todayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayCell", for: indexPath) as? TodayCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setup(today: todayList[indexPath.item]) // CollectionView에서는 item, TableView에서는 row 사용.
        return cell
    }
    
    // supplementary view를 위한 delegate function으로 header/footer를 구분해야 함.
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TodayCollectionHeaderView", for: indexPath) as? TodayCollectionHeaderView else {
            return UICollectionReusableView()
        }
        
        header.setupViews()
        return header
    }
}

extension TodayViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width - 32
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width - 32, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let value: CGFloat = 16
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = AppDetailViewController(today: todayList[indexPath.item])
        self.present(detailViewController, animated: true)
    }
}
