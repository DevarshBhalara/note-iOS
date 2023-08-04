//
//  SignupCoordinator.swift
//  Notes
//
//  Created by Devarsh Bhalara on 04/08/23.
//

import UIKit

class SignupCoordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let signupVC = FBCreateUserVC.instantiate(from: .storyboard)
        signupVC.signupCoordinator = self
        navigationController.pushViewController(signupVC, animated: true)
    }
    
    func gotologin() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.appCoordinator?.goToAuth()
        }
    }

}
