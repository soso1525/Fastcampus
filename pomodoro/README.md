# pomodoro app

- DatePicker로 타이머 시간을 설정 할 수 있다.
- 타이머가 작동되면 토마토 이미지가 360도로 회전하며 progress bar로 진행도를 표시한다.
- 타이머를 일시중지 할 수 있고, 재개하거나 취소할 수도 있다.
</br>

### Memo 
1. visibility 속성으로 보였다가 안보였다가 애니메이션 효과를 줄 수 있지만 부드러운 전환효과를 위해 alpha 값을 이용할 수 있다.
2. DispatchSourceTimer의 동작을 취소하고 혹시 모를 memory leak을 방지하기 위해 참조값을 nil로 만들어 메모리를 해제한다.
   메모리를 해제할 때 주의할 점은 suspend 상태인지 확인 필요. [suspend 상태의 object는 메모리를 해제할 수 없다.](https://endless-paper.tistory.com/29)
