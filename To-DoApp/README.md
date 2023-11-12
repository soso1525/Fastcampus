# TO-DO App

- 할 일 목록은 TableView로 보여진다.
- 할 일 추가는 오른쪽 상단의 + BarButton를 눌러서 UIAlertController를 통해 할 수 있다.
- 할 일 수정은 왼쪽 상단의 edit BarButton을 눌러서 할 수 있다. 삭제 또는 위치 변경이 가능하다.
<br><br>
#### Memo
1. Edit 버튼을 눌러 편집모드가 시작되면 왼쪽 BarButtonItem을 Done 버튼으로 바꾸는데<br>
   이 때 기존의 Edit 버튼을 weak 로 참조하면 메모리에서 제거될 수 있으니 유의.
2. 버튼을 눌렀을 때 아무런 동작을 하지 않는 것보다 버튼을 비활성화 시키는 것이 직관적.
3. 구조체 타입인 Task 배열을 UserDefaults에 저장하려고 하면 런타임 에러 발생하여
   Dictionary 타입으로 만들어서 저장.<br>
   Attempt to set a non-property-list object ("To_DoApp.Task(title: \"Task1\", done: false)")<br>
   as an NSUserDefaults/CFPreferences value for key tasks
4. 컴파일 타임에 메서드를 바인딩하는 Swift와는 다르게 Objective-C는 런타임에 메서드를 바인딩하기 때문에<br>
   @objc로 Objective-C와 유사한 방식으로 컴파일 되어야함을 컴파일러에게 알려주어야 한다.
   #selector에서 objc 함수를 사용할 때는 function notation 방법으로 표기.
5. UIAlertAction의 completionHandler 안에 순환참조 방지를 하였는데 찾아보니 필요하지 않아 보임.<br>
   [UIAlertController가 어디에 종속되어 있는지가 중요한데](https://itecnote.com/tecnote/ios-should-self-be-captured-as-strong-in-a-uialertactions-handler/) 함수 내에서 생성하여 호출하므로 순환참조가 발생하지 않는다고 함.
6. 특정 IndexPath에서 셀의 이동을 제한하려면 tableView(_:targetIndexPathForMoveFromRowAt:toProposedIndexPath:) 사용.
7. 특정 IndexPath에서 편집 모드를 설정하려면 tableView(_:editingStyleForRowAt:) 사용.
