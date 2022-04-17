//
//  SceneDelegate.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
   private var coordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = createRootViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
    
    private func createRootViewController() -> UIViewController {
        let navigationController = NavigationController()
        coordinator = MainAppCoordinator(navigationController: navigationController)
        coordinator?.start()
        return navigationController
    }

}

