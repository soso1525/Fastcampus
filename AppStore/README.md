# AppStore 앱 흉내내기
- 2개의 탭으로 구성된 TabViewController로 구현한다.
- 첫 번째 탭은 투데이, 두 번째 탭은 앱으로 구성되어 있다.
- 탭 내부는 각각 UICollectionView를 사용하며, 투데이 앱의 UICollectionViewCell을 터치하면 상세보기 화면이 나타난다.
- 상세보기 화면에서는 공유 버튼만 구현되어 있다.
- 코드로 UI를 구현하며 Snapkit과 Kingfisher를 이용하여 UI를 구현한다.

### Memo
- Snapkit에서 view와 view 사이의 간격을 조절할 떄는 offset, equalToSuperview()를 사용한 경우에는 inset으로 간격을 지정한다.
- UICollectionViewDelegate 이용 시, indexPath.item으로 각 셀에 접근한다. (TableView의 경우 indexPath.row)
- UICollectionView는 Layout이 반드시 필요한데 UICollectionViewLayout은 abstract class로 subclass를 사용하거나 직접 구현해야 한다.
- simple한 디자인일 떄는 UICollectionViewFlowLayout 사용.
- scroll 방향에 따라 데이터가 한쪽으로 흐르듯 정렬되며 하나의 행 또는 열에 최대한 많은 cell을 포함시킨다.
- 따라서 각 셀의 크기를 알아야 최대한 많이 넣든지 말든지 할 수 있음.
- UIStackView 내부에서 view를 추가할 때는 addSubview가 아닌 addArrangedSubview 함수를 호출한다.
