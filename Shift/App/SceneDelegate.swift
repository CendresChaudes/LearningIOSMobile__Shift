//
//  SceneDelegate.swift
//  Shift
//
//  Created by Роман on 01.07.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = SignUpViewController()
        window?.makeKeyAndVisible()

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = window!.bounds
        gradientLayer.colors = [
            UIColor.customOrange.cgColor,
            UIColor.customPink.cgColor,
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)

        window?.layer.insertSublayer(gradientLayer, at: 0)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        do {
            try (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        } catch {
            let nserror = error as NSError
            print("[NS] - Error: \(nserror), \(nserror.userInfo)")
        }
    }
}
