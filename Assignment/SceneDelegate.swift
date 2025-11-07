//
//  SceneDelegate.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: CardDetailCoordinatorType?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let navigationController = UINavigationController()
        
        let coordinator = CardDetailCoordinator(
            navigationController: navigationController,
            di: .init(
                requestManager: RequestManager(server: .production),
                cacheManager: CacheManager(card: .sample())
            )
        )
        self.coordinator = coordinator
                
        navigationController.viewControllers = [coordinator.start()]
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
    
}
