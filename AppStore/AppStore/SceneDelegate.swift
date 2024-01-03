//
//  SceneDelegate.swift
//  AppStore
//
//  Created by 소현 on 12/31/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // UIWindow란 UIView들을 담는 컨테이너로
    // 사용자 인터페이스에 배경을 제공하고 이벤트를 처리.
    // UIWindow는 UIView의 서브클래스.
    // UIWindow < UIView < UIResponder
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // guard let _ = (scene as? UIWindowScene) else { return }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .white
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible() // 이 UIWindow를 key window로 지정. UIWindow가 여러 개 있을 때 가장 앞에 있는 window를 key window라고 한다.
    }
}

