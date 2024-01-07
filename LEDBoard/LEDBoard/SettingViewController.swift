//
//  SettingViewController.swift
//  LEDBoard
//
//  Created by 소현 on 12/21/23.
//

import UIKit

protocol SettingDelegate: AnyObject {
    func onChanged(text: String?,
                   textColor: UIColor,
                   backgroundColor: UIColor)
}

class SettingViewController: UIViewController {
    
    weak var delegate: SettingDelegate?

    @IBOutlet weak var textField: UITextField!
    
    /* Text Color Button */
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    
    /* Background Color Button */
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var pinkButton: UIButton!
    
    var text: String?
    var textColor: UIColor = .orange
    var backgroundColor: UIColor = .purple
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureLayout()
    }
    
    private func configureLayout() {
        textField.text = text
        
        switch textColor {
        case .orange:
            orangeButton.alpha = 1.0
            greenButton.alpha = 0.2
            blueButton.alpha = 0.2
        case .green:
            orangeButton.alpha = 0.2
            greenButton.alpha = 1.0
            blueButton.alpha = 0.2
        case .systemBlue:
            orangeButton.alpha = 0.2
            greenButton.alpha = 0.2
            blueButton.alpha = 1.0
        default: break
        }
        
        switch backgroundColor {
        case .purple:
            purpleButton.alpha = 1.0
            yellowButton.alpha = 0.2
            pinkButton.alpha = 0.2
        case .yellow:
            purpleButton.alpha = 0.2
            yellowButton.alpha = 1.0
            pinkButton.alpha = 0.2
        case .systemPink:
            purpleButton.alpha = 0.2
            yellowButton.alpha = 0.2
            pinkButton.alpha = 1.0
        default: break
        }
    }
    
    @IBAction func tapTextColorButton(_ sender: UIButton) {
        switch sender {
        case orangeButton:
            textColor = .orange
            orangeButton.alpha = 1.0
            greenButton.alpha = 0.2
            blueButton.alpha = 0.2
        case greenButton:
            textColor = .green
            orangeButton.alpha = 0.2
            greenButton.alpha = 1.0
            blueButton.alpha = 0.2
        case blueButton:
            textColor = .systemBlue
            orangeButton.alpha = 0.2
            greenButton.alpha = 0.2
            blueButton.alpha = 1.0
        default:
            break
        }
    }
    
    @IBAction func tapBackgroundColorButton(_ sender: UIButton) {
        switch sender {
        case purpleButton:
            backgroundColor = .purple
            purpleButton.alpha = 1.0
            yellowButton.alpha = 0.2
            pinkButton.alpha = 0.2
        case yellowButton:
            backgroundColor = .yellow
            purpleButton.alpha = 0.2
            yellowButton.alpha = 1.0
            pinkButton.alpha = 0.2
        case pinkButton:
            backgroundColor = .systemPink
            purpleButton.alpha = 0.2
            yellowButton.alpha = 0.2
            pinkButton.alpha = 1.0
        default:
            break
        }
    }
    
    @IBAction func tapDoneButton(_ sender: UIBarButtonItem) {
        delegate?.onChanged(text: textField.text,
                            textColor: textColor,
                            backgroundColor: backgroundColor)
        self.navigationController?.popViewController(animated: true)
    }
    
}
