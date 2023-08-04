//
//  AuthCoordinator.swift
//  My Spotify
//
//  Created by Krunal Patel on 05/07/23.
//

import UIKit

class AuthCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let authVc = FBLoginVC.instantiate(from: .storyboard)
        authVc.authCoordinator = self
        navigationController.viewControllers = [authVc]
    }
    
    func goToCombineScreen() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.appCoordinator?.goToCombineScreen()
        }
    }
    
    func goToSignup() {
        let signUp = SignupCoordinator(navigationController: navigationController)
        signUp.start()
    }
}
