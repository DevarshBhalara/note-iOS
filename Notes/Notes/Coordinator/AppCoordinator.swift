//
//  File.swift
//  My Spotify
//
//  Created by Krunal Patel on 04/07/23.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    var window: UIWindow
    
    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }
    
    func start() {
        UserDefaults.standard.bool(forKey: "isLogin") ? goToCombineScreen() : goToAuth()
    }
    
    func goToCombineScreen() {
        let combineCoordinator = HomeCoordinator(navigationController: navigationController)
        self.window.rootViewController = navigationController
        combineCoordinator.start()
    }
    
    func goToAuth() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        self.window.rootViewController = navigationController
        authCoordinator.start()
    }
}
