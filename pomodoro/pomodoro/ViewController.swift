//
//  ViewController.swift
//  pomodoro
//
//  Created by 소현 on 12/20/23.
//

/*
 
 처음에는 DatePicker 보이고, cancel(비활성화) / start(활성화) 버튼.
 타이머가 동작 중일 때는 DatePicker 숨기고, cancel(활성화) / start -> pause(활성화) 버튼.
 pause 버튼을 누르면 cancel / start 버튼.
 cancel 버튼을 눌러 취소가 되면 원상복귀.
 
 뷰를 isHidden 프로퍼티로 숨길 수도 있지만
 자연스럽게 fade out 되는 효과를 위해 alpha 값을 조절하여 숨길 수도 있음.
 
 UIView.animate(withDuration: 0.5, animations: {
    // alpha 값 조절.
 })
 
 */

import UIKit

enum TimerStatus {
    case start
    case pause
    case end
}

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var toggleButton: UIButton!
    
    var duration = 60
    var timerStatus: TimerStatus = .end
    var timer: DispatchSourceTimer?
    
    // GCD: 작업을 병렬적으로 처리하기 위한 API
    // 스레드를 만들거나 관리해야하는 작업을 대신 해준다.
    
    var currentSeconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureToggleButton()
    }
    
    func startTimer() {
        if timer == nil {
            timer = DispatchSource.makeTimerSource(queue: .main)
            
            // deadline은 타이머가 시작된지 몇 초 후에 작업을 시작할 건지
            // repeating은 반복 주기로 단위는 sec
            
            timer?.schedule(deadline: .now(), repeating: 1)
            timer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                self.currentSeconds -= 1
                self.timerLabel.text = self.formattedTimeString()
                self.progressView.progress = Float(self.currentSeconds) / Float(self.duration)
                
                startAnimation()
                
                if self.currentSeconds <= 0 { // 타이머 종료
                    self.stopTimer()
                }
            })
            
            self.timer?.resume() // 타이머 시작
        }
    }
    
    func formattedTimeString() -> String {
        let hour = currentSeconds / 3600
        let minute = currentSeconds % 3600 / 60
        let second = currentSeconds % 3600 % 60
    
        return "\(String(format: "%02d", hour)):\(String(format: "%02d", minute)):\(String(format: "%02d", second))"
    }
    
    func startAnimation() {
        
        // An affine transformation matrix for use in drawing 2D graphics.
        // It is used to  rotatle, scale, translate, or skew the objects.
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
        }
        UIView.animate(withDuration: 0.5, delay: 0.5) {
            self.imageView.transform = CGAffineTransform(rotationAngle: .pi * 2)
        }
    }
    
    func stopAnimation() {
        
        // 변환했던 CGAffineTransform 값을 원래대로 돌리기.
        self.imageView.transform = .identity
    }
    
    func stopTimer() {
        if timerStatus == .pause {
            timer?.resume()
        }
    
        // suspend 상태의 object의 메모리를 해제할 수 없음.
        // timer가 suspend 상태인 경우 resume() -> cancel() -> nil.
        
        timer?.cancel()
        timer = nil // 메모리 해제
        
        
        timerStatus = .end
        toggleButton.isSelected = false
        cancelButton.isEnabled = false
        datePicker.isHidden = false
        setTimerInfoViewVisible(isHidden: true)
    }
    
    func configureToggleButton() {
        toggleButton.setTitle("start", for: .normal)
        toggleButton.setTitle("pause", for: .selected)
    }

    @IBAction func tapCancelButton(_ sender: UIButton) {
        stopAnimation()
        stopTimer()
    }
    
    @IBAction func tapToggleButton(_ sender: UIButton) {
        duration = Int(datePicker.countDownDuration)
        
        switch timerStatus {
        case .start:
            timerStatus = .pause
            stopAnimation()
            toggleButton.isSelected = false
            timer?.suspend()
        case .end:
            currentSeconds = duration
            timerStatus = .start
            setTimerInfoViewVisible(isHidden: false)
            datePicker.isHidden = true
            toggleButton.isSelected = true
            cancelButton.isEnabled = true
            startTimer()
        case .pause:
            timerStatus = .start
            toggleButton.isSelected = true
            timer?.resume()
        }
    }
    
    func setTimerInfoViewVisible(isHidden: Bool) {
        timerLabel.isHidden = isHidden
        progressView.isHidden = isHidden
    }
}

  
