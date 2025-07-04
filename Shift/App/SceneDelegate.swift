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
