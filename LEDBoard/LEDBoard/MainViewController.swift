//
//  ViewController.swift
//  LEDBoard
//
//  Created by 소현 on 12/21/23.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    var text: String?
    var textColor: UIColor = .orange
    var backgroundColor: UIColor = .purple
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.textLabel.text = text ?? "Label"
        self.textLabel.textColor = textColor
        self.view.backgroundColor = backgroundColor
    }
}

extension MainViewController: SettingDelegate {
    func onChanged(text: String?, textColor: UIColor, backgroundColor: UIColor) {
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingViewController = segue.destination as? SettingViewController {
            settingViewController.delegate = self
            settingViewController.text = text
            settingViewController.textColor = textColor
            settingViewController.backgroundColor = backgroundColor
            
        }
    }
}
