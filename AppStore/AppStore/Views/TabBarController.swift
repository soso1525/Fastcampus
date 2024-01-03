//
//  TabBarController.swift
//  AppStore
//
//  Created by 소현 on 12/31/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    private lazy var todayViewController: UIViewController = {
        let viewController = TodayViewController()
        let tabBarItem = UITabBarItem(title: "투데이",
                                      image: UIImage(systemName: "mail"),
                                      tag: 0) // 첫번째 탭이라는 의미로 0
        viewController.tabBarItem = tabBarItem
        return viewController
    }()
    
    private lazy var appViewController: UIViewController = {
        let viewController = UINavigationController(rootViewController: AppViewController())
        let tabBarItem = UITabBarItem(title: "앱",
                                      image: UIImage(systemName: "square.stack.3d.up"),
                                      tag: 1)
        viewController.tabBarItem = tabBarItem
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [todayViewController, appViewController]
        
    }


}

